module HazardUnit(
    input [5:0] opcode,
    input [4:0] ID_EX_rt, ID_rs, ID_rt, ID_EX_rd, EX_MEM_rd,
    input [1:0] ID_EX_reg_dst, EX_MEM_reg_dst,
    input ID_EX_mem_read, EX_MEM_mem_read,
    output reg pc_write, IF_ID_write, hazard_mux_signal
);

    parameter [5:0] BEQ = 6'b000100;
    parameter [5:0] BNE = 6'b000101;

    initial begin
        pc_write = 1'b1;
        IF_ID_write = 1'b1;
        hazard_mux_signal = 1'b0;
    end

    always@(*) begin
        if (
            (ID_EX_mem_read && (ID_EX_rt == ID_rs || ID_EX_rt == ID_rt )) || 
            (
                (opcode == BEQ || opcode == BNE) && 
                (ID_EX_reg_dst[0] == 1'b1 || EX_MEM_reg_dst[0] == 1'b1 || ID_EX_mem_read == 1'b1 || EX_MEM_mem_read == 1'b1) &&
                (ID_rs == ID_EX_rd || ID_rs == EX_MEM_rd || ID_rt == ID_EX_rd || ID_rt == EX_MEM_rd)
            )
        ) begin
            pc_write = 1'b0;
            IF_ID_write = 1'b0;
            hazard_mux_signal = 1'b1;
        end
        else begin
            pc_write = 1'b1;
            IF_ID_write = 1'b1;
            hazard_mux_signal = 1'b0;
        end
    end

endmodule