`timescale 1ns / 1ps
/* 
 *   Author: wintermelon
 *   Last update: 2023.05.03
 */

// This is a simple 2-1 Mux.
/* Ports
    Mux2 #(32) my_mux (
        .sr0(),
        .sr1(),
        .sel(),

        .res()
    );
*/

module MUX1 #(WIDTH = 32) (
    input [WIDTH-1: 0]          sr0,
    input [WIDTH-1: 0]          sr1,
    input                       sel,

    output reg [WIDTH-1: 0]     res
);  

    always @(*) begin
        case (sel)
            1'b0: res = sr0;
            1'b1: res = sr1;
        endcase // We don't need default here
    end

endmodule