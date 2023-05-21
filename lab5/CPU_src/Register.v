`timescale 1ns / 1ps
/* 
 *   Author: wintermelon
 *   Last update: 2023.04.30
 */

module Register #(WIDTH = 32)(
    input                       clk,
    input                       rst,

    // Control part
    input                       reg_en,     // Register writing enable  

    // Data part
    input [WIDTH-1: 0]          reg_din,
    output reg [WIDTH-1 : 0]    reg_dout    // Value current inside the register
);
    initial begin
        reg_dout = 0;
    end
    always @(posedge clk) begin
        if (rst)
            reg_dout <= 0;
        else if (reg_en)
            reg_dout <= reg_din;
    end

endmodule