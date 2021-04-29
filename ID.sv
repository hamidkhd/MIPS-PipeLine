`timescale 1ns/1ns
module ID(
    input [31:0] instruction, pc, write_data_reg,
    input [4:0] reg_write_address,
    input reg_write_in, clk,
    output [31:0] reg_read1, reg_read2, immediate, j_address, branch_address,
    output [5:0] opcode_out,
    output [4:0] rt, rd, rs,
    output [2:0] alu_op,
    output [1:0] reg_dst, pc_src, mem_to_reg,
    output alu_src, mem_write, mem_read, reg_write, flush
);

    parameter [5:0] BEQ = 6'b000100;
    parameter [5:0] BNE = 6'b000101;

    reg [31:0] shifted_im;
    reg zero;

    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign rs = instruction[25:21];

    Controller controller(instruction[31:26], instruction[5:0], zero, mem_read, mem_write, alu_src, reg_write, reg_dst,
        pc_src, mem_to_reg, alu_op);
    RegFile regFile(rs, rt, reg_write_address, write_data_reg, clk, reg_write_in, reg_read1, reg_read2);
    SE sign_ex(instruction[15:0], immediate);
    Shift2 shift2(immediate, shifted_im);
    Adder32 adder32(pc, shifted_im, branch_address);

    assign j_address = {pc[31:28], instruction[25:0], pc[1:0]};

    assign zero = reg_read1 == reg_read2 ? 1'b1 : 1'b0;
    assign flush = ((instruction[31:26] == BEQ) && zero) || ((instruction[31:26] == BNE) && ~zero) ? 1'b1 : 1'b0;
    assign opcode_out = instruction[31:26];

endmodule