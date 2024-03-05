//ALU should handle the calculations of 
	// next PC
	// addition
	// multiplication
	// comparison
	// nop
	// loading from mem

	// selecting immediate

module ALU(
	input logic [2:0]  op,
	input logic [2:0]  RA,
	input logic [2:0]  RB,
	input logic [2:0]  RD,
	input logic [5:0]  A,
	input logic [5:0]  B,
	input logic [5:0]  PC,
	output logic [5:0] d	  
);

   	/* 000(0)	HALT	halt program execution
	 * 001(1)	LDI	load immediate
	 * 010(2)	ADD	add
	 * 011(3)	ADI	add immediate
	 * 100(4)	MUL 	multiply
	 * 101(5)	CMPJ	compare jump
	 * 110(6)	JMP	jump
	 * 111(7)	NOP	no op
	 */
	always_comb begin	   	
		unique case(op)
			3'd0: d = PC;
			3'd1: d = {RA,RB}
			3'd2: d = A + B
			3'd3: d = A + RB
			3'd4: d = A * B
			3'd5: d = (A >= B) ? 
				(PC + RD) : 
				(PC + 1'b1);
			3'd6: d = {RA,RB}
			3'd7: d = PC + 1'b1;
		end
	endcase
		
