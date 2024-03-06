/* 	SW0 		Async, high reset
 * Inputs 
 * 	SW1 		Single step mode
 * 	SW2,SW3,SW4 	Debug output, refer to lab manual
 * 	SW5,SW6,SW7 	display register file, register number {SW7,SW6,SW5}
 * 	
 * 	KEY0 		Single step advance
 * Outputs
 * 	LED[7:0] 	Default, indicates address of instruction
 * 	
 */

module Lab4(
	logic input clk,
	logic input SW0, 
	logic input SW1, 
	logic input SW2, 
	logic input SW3, 
	logic input SW4, 
	logic input SW5, 
	logic input SW6, 
	logic input SW7,
	logic input KEY0,	    
	logic output [7:0] LED,
	logic output [3:0] HEX [6:0]
);
   
	logic [11:0] instruction;	// 12 but instruction 	
	logic [5:0]  address; 	// 2^6 = 64
   	logic [2:0]  opcode;
	logic [2:0]  RA;
   	logic [2:0]  RB;
   	logic [2:0]  RD;
   	logic [5:0]  A; 
   	logic [5:0]  B;
	logic [5:0]  ALU_out;
	logic enable_clock;	
	
   	logic [5:0]  registers [2:0]; // 2^3 = 8
	
	logic [25:0] single_clock_counter;
	logic [11:0] display;	
	
	(* ram_init_file = "Lab4.mif" *) logic [11:0] mem[63:0];

	assign instruction = mem[address];
	assign op_code = instruction[11:9];
	assign RA = instruction[8:6];
	assign RB = instruction[5:3];
	assign RD = instruction[2:0];
 	assign enable_clock = SW0 ? 
		KEY0 & (single_clock_counter == '0) : 1'b1;	

	assign LED = address;
		 
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
			3'd0: display = registers [{SW7,SW6,SW5}];
			3'd1: display = instruction;
			3'd2: display = address;
			3'd3: display = op_code;
			3'd4: display = ALU_out;
			3'd5: display = '0;
			3'd6: display = '0;
			3'd7: display = '0;
		endcase 
	end
	  
   	//this counter is for when in single clock mode the fastest it will clock is once per second
	counter #(5_000_000) single_clock(
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
		.rst(~SW0),
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
		.PC(address)
		.d(ALU_out)	  
	);
   
	 
	program_counter PC(	
		.op(op_code),
		.jump_addr(ALU_out),
		.clk(clk),
		.rst(rst),
		.en(enable_clock),
		.address(address) 
	);

	//IR will need to use 4 hex displays		
	hexDisp hex_display0(
		.sw(display[0:2]), 
		.hex(HEX[0])
	);	

	hexDisp hex_display1(
		.sw(display[3:5]), 
		.hex(HEX[1])
	);	

	hexDisp hex_display2(
		.sw(display[6:8]), 
		.hex(HEX[2])
	);	
   
	hexDisp hex_display3(
		.sw(display[9:11]), 
		.hex(HEX[3])
	);	
	
endmodule
