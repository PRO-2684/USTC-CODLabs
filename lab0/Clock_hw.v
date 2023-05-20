module Counter #(
    parameter RADIX = 20,
    parameter WIDTH = 5
) (
    input clk,
    input enable,
    input rst,
    output reg [WIDTH-1:0] value,
    output reg carry
);
    initial begin
        value <= 0;
    end
    always @(posedge clk) begin
        if (rst)
            ;
        else if (enable) begin
            if (value == RADIX - 1) begin
                carry <= 1;
                value <= 0;
            end else begin
                carry <= 0;
                value <= value + 1;
            end
        end else begin
            carry <= 0;
            value <= value;
        end
    end
    always @(posedge rst) begin
        if (rst)
            value <= 0;
    end
endmodule

module Clock (
    input clk,
    input rst, // asynchronous reset
    output [2:0] hour,
    output [3:0] min,
    output [4:0] sec
); 
    wire carry1;
    wire carry2;
    Counter second (
        clk,
        1,
        rst,
        sec,
        carry1
    );
    Counter #(10, 4) minute (
        clk,
        carry1,
        rst,
        min,
        carry2
    );
    Counter #(5, 3) hour_ (
        clk,
        carry2,
        rst,
        hour
    );
endmodule