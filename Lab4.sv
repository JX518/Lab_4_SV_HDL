module Lab4(	    
output logic y
);
logic [11:0] memmory_instruction;

(* ram_init_file = "Lab4.mif" *) logic [11:0] mem[63:0];
assign memory_instruction = mem[0];

assign y = 2'd2;
endmodule
