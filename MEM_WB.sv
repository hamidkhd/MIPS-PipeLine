`timescale 1ns/1ns
module MEM_WB(
    input [31:0] read_data_in, reg_data_in,
    input [4:0] rd_in,
    input [1:0] mem_to_reg_in,
    input reg_write_in,
    input clk, rst,
    output reg [31:0] read_data_out, reg_data_out,
    output reg [4:0] rd_out,
    output reg [1:0] mem_to_reg_out,
    output reg reg_write_out
);

    always@(posedge clk) begin
        if (rst) begin
            read_data_out <= 32'b0;
            reg_data_out <= 32'b0;
            rd_out <= 5'b0;
            reg_write_out <= 1'b0;
            mem_to_reg_out <= 2'b0;
        end
        else begin
            read_data_out <= read_data_in;
            reg_data_out <= reg_data_in;
            rd_out <= rd_in;
            reg_write_out <= reg_write_in;
            mem_to_reg_out <= mem_to_reg_in;
        end
    end

endmodule