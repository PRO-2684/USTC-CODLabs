`timescale 1ns / 1ps
/* 
 *   Author: wintermelon
 *   Last update: 2023.05.03
 */

// This is a simple 4-1 Mux.
/* Ports
    Mux4 #(32) my_mux (
        .sr0(),
        .sr1(),
        .sr2(),
        .sr3(),
        .mux_ctrl(),

        .mux_out()
    );
*/

module MUX2 #(WIDTH = 32) (
    input [WIDTH-1: 0]          sr0,
    input [WIDTH-1: 0]          sr1,
    input [WIDTH-1: 0]          sr2,
    input [WIDTH-1: 0]          sr3,
    input [1:0]                 mux_ctrl,

    output reg [WIDTH-1: 0]     mux_out
);  

    always @(*) begin
        case (mux_ctrl)
            2'b00: mux_out = sr0;
            2'b01: mux_out = sr1;
            2'b10: mux_out = sr2;
            2'b11: mux_out = sr3;
        endcase // We don't need default here
    end

endmodule