/* Inputs 
 * 	SW0 		Async, high reset
 * 	SW1 		Single step mode
 * 	SW2,SW3,SW4 	Debug output, refer to lab manual
 * 	SW5,SW6,SW7 	display register file, register number {SW7,SW6,SW5}
 * 	
 * 	KEY0 		Single step advance
 * Outputs
 * 	LED[7:0] 	Default, indicates address of instruction
 */

module Lab4
(
	 input logic clk,
	 input logic SW0, 
	 input logic SW1, 
	 input logic SW2, 
	 input logic SW3, 
	 input logic SW4, 
	 input logic SW5, 
	 input logic SW6, 
	 input logic SW7,
	 input logic KEY0,	    
	 output logic [7:0] LED,
	 output logic [6:0] HEX00,
	 output logic [6:0] HEX01,
	 output logic [6:0] HEX02,
	 output logic [6:0] HEX03
);
   
   logic [11:0] instruction;	// 12 but instruction 	
   logic [5:0]  address; 	// 2^6 = 64
   logic [2:0]  op_code;
   logic [2:0]  RA;
   logic [2:0]  RB;
   logic [2:0]  RD;
   logic [5:0]  A; 
   logic [5:0]  B;
   logic [5:0]  ALU_out;
   logic enable_clock;	
	
   logic [5:0]  registers [7:0]; // 2^3 = 8
	
   logic [25:0] single_clock_counter;
   logic [11:0] display;	
   logic [11:0] display_register;
	
	(* ram_init_file = "Lab4.mif" *) logic [11:0] mem[63:0];

	assign instruction = mem[address];
 	assign enable_clock = SW1 ? 
		(~KEY0 & (single_clock_counter == '0)) : 1'b1;

	assign LED = address;
	
	always_comb begin 
		unique case ({SW7,SW6,SW5})
			3'd0: display_register = registers[0];
			3'd1: display_register = registers[1];
			3'd2: display_register = registers[2];
			3'd3: display_register = registers[3];
			3'd4: display_register = registers[4];
			3'd5: display_register = registers[5];
			3'd6: display_register = registers[6];
			3'd7: display_register = registers[7];
		endcase 
	end	
	  
	/* Handles debugging switches
	 * 0	Register #{SW7,SW6,SW5}
	 * 1	Instruction Register
	 * 2	Program Counter
	 * 3	opcode
	 * 4	ALU output
	 * 5	Debug
	 * 6	Debug
	 * 7	Debug
	 */   
	always_comb begin 
		unique case ({SW4,SW3,SW2})
			3'd0: display = display_register; //registers [{SW7,SW6,SW5}]; 
			3'd1: display = instruction;
			3'd2: display = address;
			3'd3: display = op_code;
			3'd4: display = ALU_out;
			3'd5: display = '0;
			3'd6: display = '0;
			3'd7: display = '0;
		endcase 
	end
	
	IR instruction_register(
   	//this counter is for when in single clock mode the fastest it will clock is once per second
		.instruction(instruction),
		.opcode(op_code),
		.RA(RA),
		.RB(RB),
		.RD(RD)
	);	

	counter #(50_000_000) single_clock(
		.inc(1'b1),
		.dec(1'b0),
		.clk(clk),
		.rst(~SW0),
		.cnt(single_clock_counter) 
	 );
   
	register_file reg_file(
		.op(op_code),
		.RA(RA),
		.RB(RB),
		.RD(RD),
		.d(ALU_out),
		.rst(~SW0),
		.clk(clk),
		.debug_en(enable_clock),
		.A(A),
		.B(B),
		.Z(registers)
	);	
   
	  
	ALU ALU_unit(	
		.op(op_code),
		.RA(RA),
		.RB(RB),
		.RD(RD),
		.A(A),
		.B(B), 
		.PC(address),
		.d(ALU_out)	  
	);
   
	 
	program_counter PC(	
		.op(op_code),
		.jump_addr(ALU_out),
		.clk(clk),
		.rst(~SW0),
		.en(enable_clock),
		.address(address) 
	);

	//IR will need to use 4 hex displays		
	hexDisp hex_display0(
		.sw(display[2:0]), 
		.hex(HEX00)
	);	

	hexDisp hex_display1(
		.sw(display[5:3]), 
		.hex(HEX01)
	);	

	hexDisp hex_display2(
		.sw(display[8:6]), 
		.hex(HEX02)
	);	
   
	hexDisp hex_display3(
		.sw(display[11:9]), 
		.hex(HEX03)
	);	
	
endmodule
