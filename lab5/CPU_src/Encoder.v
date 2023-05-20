`timescale 1ns / 1ps

module Encoder (
    input jal, jalr, br,
    output reg [1:0] pc_sel
);
    always @(*) begin
        if (jal) pc_sel = 2;
        else if (jalr) pc_sel = 1;
        else if (br) pc_sel = 3;
        else pc_sel = 0;
    end
endmodule