/* Inputs 
 * 	SW0 		Async, high reset
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
	
	logic output [10:0] LED,
	logic output [3:0]
);
	logic [11:0] instruction;	// 12 but instruction 	
	logic [5:0]	address; 	// 2^6 = 64
	
	(* ram_init_file = "Lab4.mif" *) logic [11:0] mem[63:0];
	
	assign instruction = mem[address];   
	d_flipflop_array()
  	

	register_file(	.data_in(), 
			.RA(), 
			.RB(), 
			.RD(), 
			.A(),
			.B()
	);
   
	  
	ALU(	.op(),
		.RA(),
		.RB(),
		.A(),
		.B(),
		.data_out()
	);
   
	 
	PC(	.clk()
		.jump()
		.inc()
		.count()
	);
   
	
   
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
			3'd0: LED = '0;
			3'd1: LED = '0;
			3'd2: LED = address;
			3'd3: LED = '0;
			3'd4: LED = '0;
			3'd5: LED = '0;
			3'd6: LED = '0;
			3'd7: LED = '0;
		endcase 
	end
	
endmodule
