module fls (
    input clk,
    input rst,
    input en,
    input [6:0] d,
    output reg [6:0] f
);
    parameter S_LFUNC = 2'b00; // Load func
    parameter S_LF0 = 2'b01; // Load f(0)
    parameter S_LF1 = 2'b10; // Load f(1)
    parameter S_WAIT = 2'b11; // Waiting for button

    reg [1:0] cur; // Current state
    reg [1:0] next; // Next state
    reg [6:0] a; // f(n-1)
    reg [6:0] b; // f(n)
    reg [3:0] func;

    // Button input signal process
    reg btn1;
    reg btn2;
    wire btn;
    always @(posedge clk) begin
        btn1 <= en;
        btn2 <= btn1;
    end
    assign btn = btn1 & ~btn2;
    // Next state logic (combinational)
    always @(*) begin
        case (cur)
            S_LFUNC: next = btn ? S_LF0 : S_LFUNC;
            S_LF0: next = btn? S_LF1 : S_LF0;
            S_LF1: next = btn? S_WAIT : S_LF1;
            S_WAIT: next = S_WAIT;
            default: next = S_LFUNC;
        endcase
    end
    // Current state logic (sequential)
    always @(posedge clk) begin
        cur <= rst ? S_LFUNC : next;
    end
    // Output logic (combinational)
    always @(*) begin
        case (cur)
            S_LF1: f = a;
            S_WAIT: f = b;
            default: f = 0;
        endcase
    end

    // Load & add logic (sequential)
    wire [6:0] res; // a plus b
    alu #(.WIDTH(7)) alu1(.a(a), .b(b), .func(func), .y(res));
    always @(posedge clk) begin
        if (btn) begin
            case (cur)
                S_LFUNC: func <= d[3:0];
                S_LF0: a <= d;
                S_LF1: b <= d;
                S_WAIT: begin
                    a <= b;
                    b <= res;
                end
            endcase
        end
    end

endmodule
