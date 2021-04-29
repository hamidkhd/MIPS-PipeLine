`timescale 1ns/1ns
module IF_ID(
    input [31:0] instruction_in, next_pc_in,
    input flush, clk, rst, IF_ID_write,
    output reg [31:0] instruction_out, pc_out
);
    
    always @(posedge clk) begin
        if (rst) begin
            instruction_out <= 32'b0;
            pc_out <= 32'b0;
        end
        else begin
            if (IF_ID_write) begin
                instruction_out <= instruction_in;
                pc_out <= next_pc_in;
            end

            if (flush && IF_ID_write) begin
                instruction_out <= 32'b0;
                pc_out <= 32'b0;
            end
        end
    end

endmodule