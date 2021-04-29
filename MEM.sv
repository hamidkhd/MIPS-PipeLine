`timescale 1ns/1ns
module MEM(
    input [31:0] address, write_data, 
    input mem_read, mem_write, clk, 
    output reg [31:0] read_data, address_out
);

    DataMem memory(address, write_data, mem_read, mem_write, clk, read_data);

    assign address_out = address;

endmodule