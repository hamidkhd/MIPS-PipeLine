module ForwardingUnit(
    input [4:0] EX_MEM_rd, ID_EX_rs, ID_EX_rt, MEM_WB_rd,
    input MEM_WB_reg_write, EX_MEM_reg_write,
    output reg [1:0] FW_A_src, FW_B_src
);

    always @(EX_MEM_reg_write, MEM_WB_reg_write, EX_MEM_rd, ID_EX_rs, ID_EX_rt) begin
        {FW_A_src, FW_B_src} = 4'b0;


        if (MEM_WB_reg_write == 1'b1 && MEM_WB_rd != 5'b0) begin
            if (MEM_WB_rd == ID_EX_rs)
                FW_A_src = 2'b01;

            if (MEM_WB_rd == ID_EX_rt)
                FW_B_src = 2'b01;
        end

        if (EX_MEM_reg_write == 1'b1 && EX_MEM_rd != 5'b0) begin
            if (EX_MEM_rd == ID_EX_rs)
                FW_A_src = 2'b10;
            
            if (EX_MEM_rd == ID_EX_rt)
                FW_B_src = 2'b10;

        end          

    end

endmodule