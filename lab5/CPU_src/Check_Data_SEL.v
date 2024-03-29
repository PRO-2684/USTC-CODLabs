`timescale 1ns / 1ps
/* 
 *   Author: wintermelon
 *   Last update: 2023.05.05
 */

// This is the debug mux written for you.
/* Ports
    Check_Data_SEL check_data_sel (
        .pc_cur(),
        .instruction(),
        .rf_ra0(),
        .rf_ra1(),
        .rf_re0(),
        .rf_re1(),
        .rf_rd0_raw(),
        .rf_rd1_raw(),
        .rf_rd0(),
        .rf_rd1(),
        .rf_wa(),
        .rf_wd_sel(),
        .rf_wd(),
        .rf_we(),
        .immediate(),
        .alu_src1(),
        .alu_src2(),
        .alu_func(),
        .alu_ans(),
        .pc_add4(),
        .pc_br(),
        .pc_jal(),
        .pc_jalr(),
        .pc_sel(),
        .pc_next(),
        .dm_addr(),
        .dm_din(),
        .dm_dout(),
        .dm_we(),   

        .check_addr(),
        .check_data()
    ); 
*/

module Check_Data_SEL (
    input [31:0]                pc_cur,
    input [31:0]                instruction,
    input [4:0]                 rf_ra0,
    input [4:0]                 rf_ra1,
    input                       rf_re0,
    input                       rf_re1,
    input [31:0]                rf_rd0_raw,
    input [31:0]                rf_rd1_raw,
    input [31:0]                rf_rd0,
    input [31:0]                rf_rd1,
    input [4:0]                 rf_wa,
    input [1:0]                 rf_wd_sel,
    input [31:0]                rf_wd,
    input                       rf_we,
    input [31:0]                immediate,
    input [31:0]                alu_src1,
    input [31:0]                alu_src2,
    input [3:0]                 alu_func,
    input [31:0]                alu_ans,
    input [31:0]                pc_add4,
    input [31:0]                pc_br,
    input [31:0]                pc_jal,
    input [31:0]                pc_jalr,
    input [1:0]                 pc_sel,
    input [31:0]                pc_next,
    input [31:0]                dm_addr,
    input [31:0]                dm_din,
    input [31:0]                dm_dout,
    input                       dm_we,

    input [4:0]                 check_addr,
    output reg [31:0]           check_data
);

    always @(*) begin
        case (check_addr)
            5'd0: check_data = pc_cur;
            5'd1: check_data = instruction;
            5'd2: check_data = rf_ra0;
            5'd3: check_data = rf_ra1;
            5'd4: check_data = rf_re0;
            5'd5: check_data = rf_re1;
            5'd6: check_data = rf_rd0_raw;
            5'd7: check_data = rf_rd1_raw;
            5'd8: check_data = rf_rd0;
            5'd9: check_data = rf_rd1;
            5'd10: check_data = rf_wa; // 0xa
            5'd11: check_data = rf_wd_sel; // 0xb
            5'd12: check_data = rf_wd; // 0xc
            5'd13: check_data = rf_we; // 0xd
            5'd14: check_data = immediate; // 0xe
            5'd15: check_data = alu_src1; // 0xf
            5'd16: check_data = alu_src2; // 0x10
            5'd17: check_data = alu_func; // 0x11
            5'd18: check_data = alu_ans; // 0x12
            5'd19: check_data = pc_add4; // 0x13
            5'd20: check_data = pc_br; // 0x14
            5'd21: check_data = pc_jal; // 0x15
            5'd22: check_data = pc_jalr; // 0x16
            5'd23: check_data = pc_sel; // 0x17
            5'd24: check_data = pc_next; // 0x18
            5'd25: check_data = dm_addr; // 0x19
            5'd26: check_data = dm_din; // 0x1a
            5'd27: check_data = dm_dout; // 0x1b
            5'd28: check_data = dm_we; // 0x1c
            default: check_data = 0;
        endcase
    end

endmodule