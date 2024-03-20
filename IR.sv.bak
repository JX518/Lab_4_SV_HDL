
module IR(
	input logic [11:0] instruction,
	output logic [2:0] opcode,	  
	output logic [2:0] RA,
	output logic [2:0] RB,
	output logic [2:0] RD	  
);
	assign opcode = instruction[11:9];
	assign RA = instruction[8:6];
	assign RB = instruction[5:3];
	assign RD = instruction[2:0];
