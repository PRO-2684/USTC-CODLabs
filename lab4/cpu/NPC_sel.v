`timescale 1ns / 1ps

module NPC_sel (
    input [31:0] pc_add4,
    input [31:0] pc_jal_br,
    input [31:0] pc_jalr,
    input jal, jalr, br,
    output reg [31:0] pc_next
);
    always @(*) begin
        if (jal || br) pc_next = pc_jal_br;
        else if (jalr) pc_next = pc_jalr;
        else pc_next = pc_add4;
    end
endmodule