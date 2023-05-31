`timescale 1ns / 1ps

/*
    SEG_REG seg_reg (
        .clk(clk),
        .flush(flush),
        .stall(stall),
        .pc_cur_in(32'h0),
        .inst_in(32'h0),
        .rf_ra0_in(5'h0),
        .rf_ra1_in(5'h0),
        .rf_re0_in(1'h0),
        .rf_re1_in(1'h0),
        .rf_rd0_raw_in(32'h0),
        .rf_rd1_raw_in(32'h0),
        .rf_rd0_in(32'h0),
        .rf_rd1_in(32'h0),
        .rf_wa_in(5'h0),
        .rf_wd_sel_in(2'h0),
        .rf_we_in(1'h0),
        .imm_type_in(3'h0),
        .imm_in(32'h0),
        .alu_src1_sel_in(1'h0),
        .alu_src2_sel_in(1'h0),
        .alu_src1_in(32'h0),
        .alu_src2_in(32'h0),
        .alu_func_in(4'h0),
        .alu_ans_in(32'h0),
        .pc_add4_in(32'h0),
        .pc_br_in(32'h0),
        .pc_jal_in(32'h0),
        .pc_jalr_in(32'h0),
        .jal_in(1'h0),
        .jalr_in(1'h0),
        .br_type_in(2'h0),
        .br_in(1'h0),
        .pc_sel_in(2'h0),
        .pc_next_in(32'h0),
        .dm_addr_in(32'h0),
        .dm_din_in(32'h0),
        .dm_dout_in(32'h0),
        .dm_we_in(1'h0),
        .pc_cur_out(32'h0),
        .inst_out(32'h0),
        .rf_ra0_out(5'h0),
        .rf_ra1_out(5'h0),
        .rf_re0_out(1'h0),
        .rf_re1_out(1'h0),
        .rf_rd0_raw_out(32'h0),
        .rf_rd1_raw_out(32'h0),
        .rf_rd0_out(32'h0),
        .rf_rd1_out(32'h0),
        .rf_wa_out(5'h0),
        .rf_wd_sel_out(2'h0),
        .rf_we_out(1'h0),
        .imm_type_out(3'h0),
        .imm_out(32'h0),
        .alu_src1_sel_out(1'h0),
        .alu_src2_sel_out(1'h0),
        .alu_src1_out(32'h0),
        .alu_src2_out(32'h0),
        .alu_func_out(4'h0),
        .alu_ans_out(32'h0),
        .pc_add4_out(32'h0),
        .pc_br_out(32'h0),
        .pc_jal_out(32'h0),
        .pc_jalr_out(32'h0),
        .jal_out(1'h0),
        .jalr_out(1'h0),
        .br_type_out(2'h0),
        .br_out(1'h0),
        .pc_sel_out(2'h0),
        .pc_next_out(32'h0),
        .dm_addr_out(32'h0),
        .dm_din_out(32'h0),
        .dm_dout_out(32'h0),
        .dm_we_out(1'h0)
    );
*/

module SEG_REG (
    input clk,
    input flush,
    input stall,
    input [31:0] pc_cur_in,
    input [31:0] inst_in,
    input [4:0] rf_ra0_in,
    input [4:0] rf_ra1_in,
    input rf_re0_in,
    input rf_re1_in,
    input [31:0] rf_rd0_raw_in,
    input [31:0] rf_rd1_raw_in,
    input [31:0] rf_rd0_in,
    input [31:0] rf_rd1_in,
    input [4:0] rf_wa_in,
    input [1:0] rf_wd_sel_in,
    input rf_we_in,
    input [2:0] imm_type_in,
    input [31:0] imm_in,
    input alu_src1_sel_in,
    input alu_src2_sel_in,
    input [31:0] alu_src1_in,
    input [31:0] alu_src2_in,
    input [3:0] alu_func_in,
    input [31:0] alu_ans_in,
    input [31:0] pc_add4_in,
    input [31:0] pc_br_in,
    input [31:0] pc_jal_in,
    input [31:0] pc_jalr_in,
    input jal_in,
    input jalr_in,
    input [2:0] br_type_in,
    input br_in,
    input [1:0] pc_sel_in,
    input [31:0] pc_next_in,
    input [31:0] dm_addr_in,
    input [31:0] dm_din_in,
    input [31:0] dm_dout_in,
    input dm_we_in,
    output [31:0] pc_cur_out,
    output [31:0] inst_out,
    output [4:0] rf_ra0_out,
    output [4:0] rf_ra1_out,
    output rf_re0_out,
    output rf_re1_out,
    output [31:0] rf_rd0_raw_out,
    output [31:0] rf_rd1_raw_out,
    output [31:0] rf_rd0_out,
    output [31:0] rf_rd1_out,
    output [4:0] rf_wa_out,
    output [1:0] rf_wd_sel_out,
    output rf_we_out,
    output [2:0] imm_type_out,
    output [31:0] imm_out,
    output alu_src1_sel_out,
    output alu_src2_sel_out,
    output [31:0] alu_src1_out,
    output [31:0] alu_src2_out,
    output [3:0] alu_func_out,
    output [31:0] alu_ans_out,
    output [31:0] pc_add4_out,
    output [31:0] pc_br_out,
    output [31:0] pc_jal_out,
    output [31:0] pc_jalr_out,
    output jal_out,
    output jalr_out,
    output [2:0] br_type_out,
    output br_out,
    output [1:0] pc_sel_out,
    output [31:0] pc_next_out,
    output [31:0] dm_addr_out,
    output [31:0] dm_din_out,
    output [31:0] dm_dout_out,
    output dm_we_out
);
    Register #(614) my_reg (
        .clk(clk),
        .rst(flush),

        .reg_en(~stall),
        .reg_din({pc_cur_in, inst_in, rf_ra0_in, rf_ra1_in, rf_re0_in, rf_re1_in, rf_rd0_raw_in, rf_rd1_raw_in, rf_rd0_in, rf_rd1_in, rf_wa_in, rf_wd_sel_in, rf_we_in, imm_type_in, imm_in, alu_src1_sel_in, alu_src2_sel_in, alu_src1_in, alu_src2_in, alu_func_in, alu_ans_in, pc_add4_in, pc_br_in, pc_jal_in, pc_jalr_in, jal_in, jalr_in, br_type_in, br_in, pc_sel_in, pc_next_in, dm_addr_in, dm_din_in, dm_dout_in, dm_we_in}),
        .reg_dout({pc_cur_out, inst_out, rf_ra0_out, rf_ra1_out, rf_re0_out, rf_re1_out, rf_rd0_raw_out, rf_rd1_raw_out, rf_rd0_out, rf_rd1_out, rf_wa_out, rf_wd_sel_out, rf_we_out, imm_type_out, imm_out, alu_src1_sel_out, alu_src2_sel_out, alu_src1_out, alu_src2_out, alu_func_out, alu_ans_out, pc_add4_out, pc_br_out, pc_jal_out, pc_jalr_out, jal_out, jalr_out, br_type_out, br_out, pc_sel_out, pc_next_out, dm_addr_out, dm_din_out, dm_dout_out, dm_we_out})
    );
endmodule