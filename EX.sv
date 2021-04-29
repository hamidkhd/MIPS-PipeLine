`timescale 1ns/1ns
module EX(
    input [31:0] reg_read1, reg_read2, immediate, WB_write_data, MEM_alu_result,
    input [4:0] rt, rd,
    input [2:0] alu_op,
    input [1:0] forward_A, forward_B, reg_dst,
    input alu_src,
    output [31:0] alu_result, write_data_out,
    output [4:0] rd_out
);
    reg [31:0] mux_B_src_out, mux_A_out, mux_B_out;
    reg dummy_zero;

    MUX2_5 reg_dst_mux(rt, rd, reg_dst[0], rd_out);
    
    MUX3_32 mux_A(reg_read1, WB_write_data, MEM_alu_result, forward_A, mux_A_out);
    MUX3_32 mux_B(mux_B_src_out, WB_write_data, MEM_alu_result, forward_B, mux_B_out);
    MUX2_32 mux_B_src(reg_read2, immediate, alu_src, mux_B_src_out);

    ALU alu(mux_A_out, mux_B_out, alu_op, alu_result, dummy_zero);

    assign write_data_out = reg_read2;
    
endmodule