`timescale 1ns/1ns
module InstMem(
	input [31:0] address, 
	output reg [31:0] instruction
); 

	reg [31:0] instructions [0:511];

	initial begin 
		$readmemb("instructions.data", instructions);
	end
	
	assign instruction = instructions[address/4];
	
endmodule