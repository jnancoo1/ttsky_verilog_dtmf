module mux2to1(
    input wire w0,
    input wire w1,
    input wire s,
    output reg f
);

always @(*) begin
    if (s == 1'b0)
        f = w0;
    else
        f = w1;
end

endmodule
