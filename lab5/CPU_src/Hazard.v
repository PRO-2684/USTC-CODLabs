`timescale 1ns / 1ps

module Hazard(
    input [4:0] rf_ra0_ex,
    input [4:0] rf_ra1_ex,
    input rf_re0_ex,
    input rf_re1_ex,
    input [4:0] rf_wa_mem,
    input rf_we_mem,
    input [1:0] rf_wd_sel_mem,
    input [31:0] alu_ans_mem,
    input [31:0] pc_add4_mem,
    input [31:0] imm_mem,
    input [4:0] rf_wa_wb,
    input rf_we_wb,
    input [31:0] rf_wd_wb,
    input [1:0] pc_sel_ex,
    output rf_rd0_fe,
    output rf_rd1_fe,
    output [31:0] rf_rd0_fd,
    output [31:0] rf_rd1_fd,
    output stall_if,
    output stall_id,
    output stall_ex,
    output flush_if,
    output flush_id,
    output flush_ex,
    output flush_mem
);
    assign rf_rd0_fe = 0;
    assign rf_rd1_fe = 0;
    assign rf_rd0_fd = 0;
    assign rf_rd1_fd = 0;
    assign stall_if = 0;
    assign stall_id = 0;
    assign stall_ex = 0;
    assign flush_if = 0;
    assign flush_id = 0;
    assign flush_ex = 0;
    assign flush_mem = 0;
endmodule