

module counter
  #(
    parameter int m=52,  // Maximum
    parameter int b=$clog2(m)  // Bitwidth 
    )
   (
    input  logic         inc,
    input  logic         dec,
   
    input  logic         clk,
    input  logic         rst,

    output logic [b-1:0] cnt 
    );
   
   logic [b-1:0] 	 cnt_nxt ;
   
   dff #(b) myDff( .d(cnt_nxt), .clk, .rst, .en(1'b1), .q(cnt));

   always_comb begin 
     unique case ({inc,dec})
	2'b01: cnt_nxt = cnt==0   ? m-1 :cnt-8'd1 ; 
	2'b10: cnt_nxt = cnt==m-1 ? 0   :cnt+8'd1 ;
	default:      cnt_nxt = cnt ;
      endcase 
   end //always_comb
   
endmodule 
