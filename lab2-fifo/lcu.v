// 队列控制单元 LCU (List Control Unit) - 处理出/入队操作，显示队列空/满状态，读出数据
module lcu (
    input clk,
    input rst,
    input [3:0] in,
    input enq,
    input deq,
    input [3:0] rd0,
    output reg [2:0] wa,
    output reg [3:0] out,
    output full,
    output empty,
    output [2:0] ra0,
    output [3:0] wd,
    output reg we,
    output reg [7:0] valid
);
    parameter S_IDLE = 2'b00;
    parameter S_ENQU = 2'b01;
    parameter S_DEQU = 2'b10;

    reg [2:0] RP = 0;   // Read pointer
    reg [2:0] WP = 0;   // Write pointer
    reg [1:0] curr = 0; // Current state
    reg [1:0] next;
    assign ra0 = RP;
    assign wd = in;
    assign full = &valid;
    assign empty = ~|valid;

    initial begin
        wa = 0;
        out = 0;
        valid = 0;
        we = 0;
    end

    // Signal pre-process
    wire enq_sig;
    wire deq_sig;
    sedg sedg_enq(.clk(clk), .a(enq), .p(enq_sig));
    sedg sedg_deq(.clk(clk), .a(deq), .p(deq_sig));

    // State transition
    always @(posedge clk) begin
        curr <= next;
    end

    // Next state logic
    always @(*) begin
        if (!rst) begin
            if (enq_sig) next = S_ENQU;
            else if (deq_sig) next = S_DEQU;
            else next = S_IDLE;
        end else begin
            next = S_IDLE;
        end
    end

    // Data logic
    always @(posedge clk) begin
        if (rst) begin
            RP <= 0;
            WP <= 0;
            wa <= 0;
            out <= 0;
            valid <= 0;
            we <= 0;
        end else case (curr)
            S_ENQU: begin
                if (!full) begin
                    wa <= WP;
                    we <= 1;
                    valid[WP] <= 1;
                    WP <= WP + 1;
                end
            end
            S_DEQU: begin
                if (!empty) begin
                    out <= rd0;
                    we <= 0;
                    valid[RP] <= 0;
                    RP <= RP + 1;
                end
            end
            default: we <= 0;
        endcase
    end

endmodule