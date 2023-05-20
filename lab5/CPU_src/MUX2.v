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
        .sel(),

        .res()
    );
*/

module MUX2 #(WIDTH = 32) (
    input [WIDTH-1: 0]          sr0,
    input [WIDTH-1: 0]          sr1,
    input [WIDTH-1: 0]          sr2,
    input [WIDTH-1: 0]          sr3,
    input [1:0]                 sel,

    output reg [WIDTH-1: 0]     res
);  

    always @(*) begin
        case (sel)
            2'b00: res = sr0;
            2'b01: res = sr1;
            2'b10: res = sr2;
            2'b11: res = sr3;
        endcase // We don't need default here
    end

endmodule