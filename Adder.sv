`timescale 1ns/1ns
module Adder32(
    input [31:0] a, b, 
    output reg [31:0] w
);

    assign w = a + b;

endmodule