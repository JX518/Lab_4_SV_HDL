/*
 * a modulo 13 up/down counter
 * (i..e. when going up, counts 0,1,2...12, 0, 1, 2, 3)
 *
 */

module counter
  #(
    parameter int m=10,  // Maximum
    parameter int b=$clog2(m)  // Bitwidth 
    )
   (
    input  logic         inc,
    input  logic         dec,
   
    input  logic         clk,
    input  logic         rst,
    output logic [b-1:0] cnt 
    );
	
	logic [31:0] d;
	logic [31:0] add;
	logic [31:0] sub;

	assign add = (cnt == (m-1))?('0) :(cnt + 1'b1);
	assign sub = (cnt == '0)   ?(m-1):(cnt - 1'b1);

	assign d = (inc & ~dec)?add:((dec & ~ inc)?sub:cnt);	
	dflipflop #(b) ff1(.d(d[b-1:0]), .clk(clk), .rst(rst), .en(1'b1), .q(cnt));	

endmodule 
