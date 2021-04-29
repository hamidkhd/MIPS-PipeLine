`timescale 1ns/1ns
module ID_EX(
    input [31:0] reg_read1_in, reg_read2_in, immediate_in,
    input [4:0] rt_in, rd_in, rs_in,
    input [2:0] alu_op_in,
    input [1:0] reg_dst_in, mem_to_reg_in,
    input alu_src_in, mem_write_in, mem_read_in, reg_write_in, clk, rst,
    output reg [31:0] reg_read1_out, reg_read2_out, immediate_out,
    output reg [4:0] rt_out, rd_out, rs_out,
    output reg [2:0] alu_op_out,
    output reg [1:0] reg_dst_out, mem_to_reg_out,
    output reg alu_src_out, mem_write_out, mem_read_out, reg_write_out
);

    always @(posedge clk) begin
        if (rst) begin
            reg_read1_out <= 32'b0;
            reg_read2_out <= 32'b0;
            immediate_out <= 32'b0;
            rt_out <= 5'b0;
            rd_out <= 5'b0;
            rs_out <= 5'b0;
            alu_src_out <= 1'b0;
            alu_op_out <= 3'b0;
            reg_dst_out <= 2'b0;
            mem_write_out <= 1'b0;
            mem_read_out <= 1'b0;
            reg_write_out <= 1'b0;
            mem_to_reg_out <= 2'b0;
        end
        else begin
            reg_read1_out <= reg_read1_in;
            reg_read2_out <= reg_read2_in;
            immediate_out <= immediate_in;
            rt_out <= rt_in;
            rd_out <= rd_in;
            rs_out <= rs_in;
            alu_src_out <= alu_src_in;
            alu_op_out <= alu_op_in;
            reg_dst_out <= reg_dst_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
        end
    end

endmodule