`timescale 1ns/1ns
module EX_MEM(
    input [31:0] alu_result_in, write_data_in,
    input [4:0] rd_in,
    input [1:0] mem_to_reg_in, reg_dst_in,
    input mem_write_in, mem_read_in, reg_write_in, clk, rst,
    output reg [31:0] alu_result_out, write_data_out,
    output reg [4:0] rd_out,
    output reg [1:0] mem_to_reg_out, reg_dst_out,
    output reg mem_write_out, mem_read_out, reg_write_out
);

    always @(posedge clk) begin
        if (rst) begin
            write_data_out <= 32'b0;
            alu_result_out <= 32'b0;
            rd_out <= 5'b0;
            mem_write_out <= 1'b0;
            mem_read_out <= 1'b0;
            reg_write_out <= 1'b0;
            mem_to_reg_out <= 2'b0;
            reg_dst_out <= 2'b0;
        end
        else begin
            write_data_out <= write_data_in;
            alu_result_out <= alu_result_in;
            rd_out <= rd_in;
            mem_write_out <= mem_write_in;
            mem_read_out <= mem_read_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            reg_dst_out <= reg_dst_in;
        end
    end

endmodule
