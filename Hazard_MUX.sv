`timescale 1ns/1ns
module Hazard_MUX(
    input [2:0] alu_op_in,
    input [1:0] reg_dst_in, mem_to_reg_in,
    input alu_src_in, mem_write_in, mem_read_in, reg_write_in, hazard_signal_mux,
    output [2:0] alu_op_out,
    output [1:0] reg_dst_out, mem_to_reg_out,
    output alu_src_out, mem_read_out, mem_write_out, reg_write_out
);
    assign alu_op_out = ~hazard_signal_mux ? alu_op_in : 3'b0;
    assign reg_dst_out = ~hazard_signal_mux ? reg_dst_in : 2'b0;
    assign mem_to_reg_out = ~hazard_signal_mux ? mem_to_reg_in : 2'b0;
    assign alu_src_out = ~hazard_signal_mux ? alu_src_in : 1'b0;
    assign mem_read_out = ~hazard_signal_mux ? mem_read_in : 1'b0;
    assign mem_write_out = ~hazard_signal_mux ? mem_write_in : 1'b0;
    assign reg_write_out = ~hazard_signal_mux ? reg_write_in : 1'b0;


endmodule