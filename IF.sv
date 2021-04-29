`timescale 1ns/1ns
module IF(
    input [31:0] jump_address, branch_address,
    input [1:0] pc_src,
    input pc_write, clk, rst,
    output [31:0] instruction, next_pc
);

    reg [31:0] pc_in, pc_out;

    PC pc(pc_in, pc_write, clk, rst, pc_out);
    InstMem instMem(pc_out, instruction);
    Adder32 adder32(pc_out, 32'd4, next_pc);
    MUX3_32 mux32(next_pc, branch_address, jump_address, pc_src, pc_in);

endmodule