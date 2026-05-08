module frequency_divider(
    input wire clk,
    input wire reset,
    output reg clock1,
    output reg clock2
);

reg [31:0] a1;
reg [31:0] a2;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        a1 <= 32'd2;
        clock1 <= 1'b0;
    end else begin
        if (a1 == 0) begin
            a1 <= 32'd2;
            clock1 <= ~clock1;
        end else begin
            a1 <= a1 - 1;
        end
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        a2 <= 32'd4000000;
        clock2 <= 1'b0;
    end else begin
        if (a2 == 0) begin
            a2 <= 32'd4000000;
            clock2 <= ~clock2;
        end else begin
            a2 <= a2 - 1;
        end
    end
end

endmodule
