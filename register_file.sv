/* register file stores
 * information in the registers
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
	output logic [5:0] Z [7:0];
);	
   	logic [7:0] en;
   	logic [5:0] d;
   	logic	    write;
   
    
   	assign write = debug_en & (op < 3'b101); //debug enable allows for set clocking speeds

	always_comb begin
	   	unique case(RD)
	     		3'd0: en[0] = write & debug_en; 
	     		3'd1: en[1] = write & debug_en; 
	     		3'd2: en[2] = write & debug_en; 
	     		3'd3: en[3] = write & debug_en; 
	     		3'd4: en[4] = write & debug_en; 
	     		3'd5: en[5] = write & debug_en; 
	     		3'd6: en[6] = write & debug_en; 
	     		3'd7: en[7] = write & debug_en; 	     
	   	endcase
	 always
   	
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
		.en(en[0]), 
		.clk(clk), 
		.q(Z[0]), 
		.rst(rst)
	);

	d_flipflop #(6) register1(
		.d(d), 
		.en(en[1]), 
		.clk(clk), 
		.q(Z[1]), 
		.rst(rst)
	);

	d_flipflop #(6) register2(
		.d(d), 
		.en(en[2]), 
		.clk(clk), 
		.q(Z[2]), 
		.rst(rst)
	);

	d_flipflop #(6) register3(
		.d(d), 
		.en(en[3]), 
		.clk(clk), 
		.q(Z[3]), 
		.rst(rst)
	);

	d_flipflop #(6) register4(
		.d(d), 
		.en(en[4]), 
		.clk(clk), 
		.q(Z[4]), 
		.rst(rst)
	);

	d_flipflop #(6) register5(
		.d(d), 
		.en(en[5]), 
		.clk(clk), 
		.q(Z[5]), 
		.rst(rst)
	);

	d_flipflop #(6) register6(
		.d(d), 
		.en(en[6]), 
		.clk(clk), 
		.q(Z[6]), 
		.rst(rst)
	);

	d_flipflop #(6) register7(
		.d(d), 
		.en(en[7]), 
		.clk(clk), 
		.q(Z[7]), 
		.rst(rst)
	);






  
