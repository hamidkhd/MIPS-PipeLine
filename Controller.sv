`timescale 1ns/1ns
module Controller(
        input [5:0] opcode, func, input zero,
        output reg mem_read, mem_write, alu_src, reg_write, 
        output reg [1:0] reg_dst, pc_src, mem_to_reg,
        output reg [2:0] alu_op
    );

    parameter [5:0] R_TYPE = 6'b000000;
    parameter [5:0] ANDI = 6'b001100;
    parameter [5:0] ADDI = 6'b001000;
    parameter [5:0] LW = 6'b100011;
    parameter [5:0] SW = 6'b101011;
    parameter [5:0] BEQ = 6'b000100;
    parameter [5:0] BNE = 6'b000101;
    parameter [5:0] J = 6'b000010;

    reg branch_eq, branch_ne;
    reg [1:0] alu_case;
    
    always @(opcode) begin
        {reg_dst, mem_read, mem_write, mem_to_reg, alu_src, alu_case, reg_write, pc_src, branch_eq, branch_ne} = 14'b0;
        
        case(opcode)
            R_TYPE : {alu_case, reg_dst, reg_write} = 5'b10_01_1;
            LW : {alu_src, reg_write, mem_read, mem_to_reg} = 5'b111_01;
            SW : {alu_src, mem_write} = 2'b11;
            ADDI : {alu_src, reg_write} = 2'b11;
            ANDI : {alu_case, alu_src, reg_write} = 4'b11_11;
            BEQ : {alu_case, branch_eq} = 3'b01_1; 
            BNE : {alu_case, branch_ne} = 3'b01_1;  
            J : pc_src = 2'b10;
        endcase
    end

    always @(zero, branch_ne, branch_eq) begin
        pc_src = (zero && branch_eq) | (~zero  && branch_ne) ? 2'b01 :  branch_eq || branch_ne ? 2'b00 : pc_src;
    end

    ALU_Controller alu_controller(func, alu_case, alu_op);
endmodule