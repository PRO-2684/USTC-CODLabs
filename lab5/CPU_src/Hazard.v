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
    output reg rf_rd0_fe,
    output reg rf_rd1_fe,
    output reg [31:0] rf_rd0_fd,
    output reg [31:0] rf_rd1_fd,
    output stall_if,
    output stall_id,
    output stall_ex,
    output flush_if,
    output flush_id,
    output flush_ex,
    output flush_mem
);
    // Data hazard
    reg [31:0] wb_fd;
    wire src0_mem_fwd; // src0 寄存器 MEM 阶段前递
    wire src1_mem_fwd; // src1 寄存器 MEM 阶段前递
    wire src0_wb_fwd; // src0 寄存器 WB 阶段前递
    wire src1_wb_fwd; // src1 寄存器 WB 阶段前递
    assign src0_mem_fwd = rf_re0_ex && (rf_ra0_ex == rf_wa_mem); // EX 段 src0 寄存器读使能非零，且上述寄存器读地址等于 MEM 段的写地址
    assign src1_mem_fwd = rf_re1_ex && (rf_ra1_ex == rf_wa_mem); // EX 段 src1 寄存器读使能非零，且上述寄存器读地址等于 MEM 段的写地址
    assign src0_wb_fwd = rf_re0_ex && (rf_ra0_ex == rf_wa_wb); // EX 段 src0 寄存器读使能非零，且上述寄存器读地址等于 WB 段的写地址
    assign src1_wb_fwd = rf_re1_ex && (rf_ra1_ex == rf_wa_wb); // EX 段 src1 寄存器读使能非零，且上述寄存器读地址等于 WB 段的写地址
    // Forwarding data
    always @(*) begin
        case (rf_wd_sel_mem)
            0: wb_fd = alu_ans_mem;
            1: wb_fd = pc_add4_mem;
            3: wb_fd = imm_mem;
            default: wb_fd = 0;
        endcase
    end
    // Src0
    always @(*) begin
        if (rf_we_mem && src0_mem_fwd && rf_wd_sel_mem != 2'd2) begin
            rf_rd0_fe = 1;
            rf_rd0_fd = wb_fd;
        end else if (rf_we_wb && src0_wb_fwd) begin
            rf_rd0_fe = 1;
            rf_rd0_fd = rf_wd_wb;
        end else begin
            rf_rd0_fe = 0;
            rf_rd0_fd = 0;
        end
    end
    // Src1
    always @(*) begin
        if (rf_we_mem && src1_mem_fwd && rf_wd_sel_mem != 2'd2) begin
            rf_rd1_fe = 1;
            rf_rd1_fd = wb_fd;
        end else if (rf_we_wb && src1_wb_fwd) begin
            rf_rd1_fe = 1;
            rf_rd1_fd = rf_wd_wb;
        end else begin
            rf_rd1_fe = 0;
            rf_rd1_fd = 0;
        end
    end
    // Bubble
    wire bubble;
    assign bubble = rf_we_mem && rf_wd_sel_mem == 2'd2 && (src0_mem_fwd || src1_mem_fwd);
    assign flush_mem = bubble;
    assign stall_ex = bubble;
    assign stall_id = bubble;
    assign stall_if = bubble;
    // Control hazard
    wire jumped = |pc_sel_ex;
    assign flush_if = jumped;
    assign flush_id = jumped;
    assign flush_ex = jumped;
endmodule