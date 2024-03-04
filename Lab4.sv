module Lab4(
	input logic  clk, //clock
	    
	input logic  SW1, // single step mode
	    
 	input logic  SW2, // used to select output of LEDs
 	input logic  SW3,
	input logic  SW4,
	    
	input logic  SW7, // register file //
	    // (2^3 = 8), there are 8 registers
	input logic  SW6,
	input logic  SW5,
	    
	input logic  KEY0, // advance in single step mode
	output logic LED[7:0] // display output according to switches 2, 3, 4.
);
logic [11:0] memmory_instruction;

(* ram_init_file = "Lab4.mif" *) logic [11:0] mem[63:0];
assign memory_instruction = mem[0];


endmodule
