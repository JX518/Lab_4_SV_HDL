//THIS WORKS
module program_counter
   (
    input logic [2:0]	op,
    input logic [5:0]	jump_addr,
   
    input logic		clk,
    input logic		rst,
    input logic 		en,

    output logic [63:0]	address 
    );
   logic 	jump;
   logic [6:0] cnt_nxt;

   assign jump = (op == 3'd6) | (op == 3'd5) | (op == 3'd0); // handles jump (jump, compj, halt)
   assign cnt_nxt = (address == 6'd63) ? 6'd63 : address + 1'b1; // handles count + 1

   d_flipflop #(6) myDff( 
	.d( jump ? jump_addr : cnt_nxt ), 
	.clk(clk), 
	.rst(rst), 
	.en(en), 
	.q(address)
   );

endmodule 
