module programCounter(
	logic input aluAddr [5:0],
	logic output nextAddr [5:0], //2^6 = 64
);
//this module selects between the next address of the program counter or the jump/branch address
	counter   
   
endmodule
