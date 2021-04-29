`timescale 1ns/1ns
module PC(
    input [31:0] next_pc, 
    input write, clk, rst, 
    output reg [31:0] pc
);

    always @(posedge clk or posedge rst) begin
        if (rst)
	        pc <= 32'b0;
	    else begin
            if (write)
                pc <= next_pc;
        end
    end

endmodule
