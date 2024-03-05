 * information in the registers
/* register file stores
 * 
 * Inputs 
 * 	op		opcode, assigns enable based on this
 * 	RA 		register A
 * 	RB 		register B
 * 	RD		register D
 * 	debug_en	enable for register clock
 * 	d 		data
 * 	rst		reset
 * Outputs
 * 	A 	contents of register A
 * 	B 	contents of register B
 * 	Z	contents of all registers
 */
module register_file(
	input logic [2:0]  op,
	input logic [2:0]  RA,
	input logic [2:0]  RB,
	input logic [2:0]  RD,
	input logic	   rst,
	input logic	   debug_en,

	output logic [5:0] A,
	output logic [5:0] B,
	output logic [5:0] Z [7:0]
);	
   	logic [7:0] write_to;
   	logic [7:0] enable;
   	logic [5:0] d;
   	logic	    write;
   
    
   	assign write = debug_en & (op < 3'b101); //debug enable allows for set clocking speeds
   	assign enable = {write, write, write, write, write, write, write, write} && write_to; //and it so that we can make sure its only writing on write en
   
   	// decoder for write enable
	always_comb begin
	   	unique case(RD)
	     	  3'd0: write_to [7:0] = 8'b0000_0001;
	     	  3'd1: write_to [7:0] = 8'b0000_0010;
	     	  3'd2: write_to [7:0] = 8'b0000_0100;
	     	  3'd3: write_to [7:0] = 8'b0000_1000;
	     	  3'd4: write_to [7:0] = 8'b0001_0000;
	     	  3'd5: write_to [7:0] = 8'b0010_0000;
	     	  3'd6: write_to [7:0] = 8'b0100_0000;
	     	  3'd7: write_to [7:0] = 8'b1000_0000;
	   	endcase
	always

	// read register A
	always_comb begin
	   	unique case(RA)
		  	3'd0:A = Z[0];		  
		  	3'd1:A = Z[1];		  
		  	3'd2:A = Z[2];		  
		  	3'd3:A = Z[3];		  
		  	3'd4:A = Z[4];		  
		  	3'd5:A = Z[5];		  
		  	3'd6:A = Z[6];		  
		  	3'd7:A = Z[7];		  
		endcase
	end

	// read register B
	always_comb begin
		unique case(RB)
		  	3'd0:B = Z[0];
		  	3'd1:B = Z[1];
		  	3'd2:B = Z[2];
		  	3'd3:B = Z[3];
		  	3'd4:B = Z[4];
		  	3'd5:B = Z[5];
		  	3'd6:B = Z[6];
		  	3'd7:B = z[7];
		endcase
	end
   
   	
	d_flipflop #(6) register0(
		.d(d), 
		.en(write_to[0]), 
		.clk(clk), 
		.q(Z[0]), 
		.rst(rst)
	);

	d_flipflop #(6) register1(
		.d(d), 
		.en(write_to[1]), 
		.clk(clk), 
		.q(Z[1]), 
		.rst(rst)
	);

	d_flipflop #(6) register2(
		.d(d), 
		.en(write_to[2]), 
		.clk(clk), 
		.q(Z[2]), 
		.rst(rst)
	);

	d_flipflop #(6) register3(
		.d(d), 
		.en(write_to[3]), 
		.clk(clk), 
		.q(Z[3]), 
		.rst(rst)
	);

	d_flipflop #(6) register4(
		.d(d), 
		.en(write_to[4]), 
		.clk(clk), 
		.q(Z[4]), 
		.rst(rst)
	);

	d_flipflop #(6) register5(
		.d(d), 
		.en(write_to[5]), 
		.clk(clk), 
		.q(Z[5]), 
		.rst(rst)
	);

	d_flipflop #(6) register6(
		.d(d), 
		.en(write_to[6]), 
		.clk(clk), 
		.q(Z[6]), 
		.rst(rst)
	);

	d_flipflop #(6) register7(
		.d(d), 
		.en(write_to[7]), 
		.clk(clk), 
		.q(Z[7]), 
		.rst(rst)
	);






  
