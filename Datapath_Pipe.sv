`timescale 1ns/1ns
module Datapath(
    input clk, rst
);

    reg [31:0] jump_address, branch_address, IF_inst, IF_pc, IF_ID_inst, IF_ID_pc, WB_data_out,
        ID_reg_read1, ID_reg_read_2, ID_immediate_out, MEM_read_data, EX_alu_result,
        ID_EX_reg_read1, ID_EX_reg_read2, MEM_address,
        ID_EX_immediate, EX_write_data, EX_MEM_alu_result, EX_MEM_write_data, MEM_WB_read_data, MEM_WB_reg_data;

    reg [5:0] ID_opcode;

    reg [4:0] ID_rt_out, ID_rd_out, ID_rs_out, ID_EX_rt, ID_EX_rd, ID_EX_rs, EX_rd, EX_MEM_rd, MEM_WB_rd;

    reg [2:0] ID_alu_op_out, ID_EX_alu_op, HAZ_alu_op;

    reg [1:0] ID_reg_dst, ID_mem_to_reg, ID_EX_reg_dst, EX_MEM_reg_dst, ID_EX_mem_to_reg, EX_MEM_mem_to_reg, MEM_WB_mem_to_reg, HAZ_reg_dst,
        HAZ_mem_to_reg, forward_A, forward_B, pc_src;
    
    reg pc_write, flush, IF_ID_write, ID_alu_src_out, ID_mem_write_out, ID_mem_read_out, ID_reg_write_out,
        ID_EX_alu_src, ID_EX_mem_write, ID_EX_mem_read, ID_EX_reg_write, EX_MEM_mem_write, EX_MEM_mem_read,
        EX_MEM_reg_write, MEM_WB_reg_write, hazard_mux_signal, HAZ_alu_src, HAZ_mem_read, HAZ_mem_write, HAZ_reg_write;

    IF If(jump_address, branch_address, pc_src, pc_write, clk, rst, IF_inst, IF_pc);

    IF_ID if_id(IF_inst, IF_pc, flush, clk, rst, IF_ID_write, IF_ID_inst, IF_ID_pc);

    ID id(IF_ID_inst, IF_ID_pc, WB_data_out, MEM_WB_rd, MEM_WB_reg_write, clk, ID_reg_read1, ID_reg_read_2,
        ID_immediate_out, jump_address, branch_address, ID_opcode, ID_rt_out, ID_rd_out, ID_rs_out, ID_alu_op_out,
        ID_reg_dst, pc_src, ID_mem_to_reg ,ID_alu_src_out, ID_mem_write_out, ID_mem_read_out, ID_reg_write_out, flush);

    ID_EX id_ex(ID_reg_read1, ID_reg_read_2, ID_immediate_out, ID_rt_out, ID_rd_out, ID_rs_out, HAZ_alu_op,
        HAZ_reg_dst, HAZ_mem_to_reg, HAZ_alu_src, HAZ_mem_write, HAZ_mem_read, HAZ_reg_write, clk, rst,
        ID_EX_reg_read1, ID_EX_reg_read2, ID_EX_immediate, ID_EX_rt, ID_EX_rd, ID_EX_rs, ID_EX_alu_op, ID_EX_reg_dst,
        ID_EX_mem_to_reg, ID_EX_alu_src, ID_EX_mem_write, ID_EX_mem_read, ID_EX_reg_write);

    EX ex(ID_EX_reg_read1, ID_EX_reg_read2, ID_EX_immediate, WB_data_out, EX_MEM_alu_result, ID_EX_rt, ID_EX_rd,
        ID_EX_alu_op, forward_A, forward_B, ID_EX_reg_dst, ID_EX_alu_src, EX_alu_result, EX_write_data, EX_rd);

    EX_MEM ex_mem(EX_alu_result, EX_write_data, EX_rd, ID_EX_mem_to_reg, ID_EX_reg_dst, ID_EX_mem_write, ID_EX_mem_read,
        ID_EX_reg_write, clk, rst, EX_MEM_alu_result, EX_MEM_write_data, EX_MEM_rd, EX_MEM_mem_to_reg, EX_MEM_reg_dst, EX_MEM_mem_write,
        EX_MEM_mem_read, EX_MEM_reg_write);

    MEM mem(EX_MEM_alu_result, EX_MEM_write_data, EX_MEM_mem_read, EX_MEM_mem_write, clk, MEM_read_data, MEM_address);

    MEM_WB mem_wb(MEM_read_data, MEM_address, EX_MEM_rd, EX_MEM_mem_to_reg, EX_MEM_reg_write, clk, rst, MEM_WB_read_data,
        MEM_WB_reg_data, MEM_WB_rd, MEM_WB_mem_to_reg, MEM_WB_reg_write);

    MUX2_32 wb_mux(MEM_WB_reg_data, MEM_WB_read_data, MEM_WB_mem_to_reg[0], WB_data_out);

    ForwardingUnit forward(EX_MEM_rd, ID_EX_rs, ID_EX_rt, MEM_WB_rd, MEM_WB_reg_write, EX_MEM_reg_write,  forward_A, forward_B);
    HazardUnit hazard(ID_opcode, ID_EX_rt, ID_rs_out, ID_rt_out, ID_EX_rd, EX_MEM_rd, ID_EX_reg_dst, EX_MEM_reg_dst, ID_EX_mem_read, EX_MEM_mem_read, pc_write, IF_ID_write, hazard_mux_signal);
    Hazard_MUX hazard_mux(ID_alu_op_out, ID_reg_dst, ID_mem_to_reg, ID_alu_src_out, ID_mem_write_out, ID_mem_read_out, ID_reg_write_out, hazard_mux_signal,
        HAZ_alu_op, HAZ_reg_dst, HAZ_mem_to_reg, HAZ_alu_src, HAZ_mem_read, HAZ_mem_write, HAZ_reg_write);


endmodule