module mod86_timer(
input wire clk,
input wire reset,
input wire ce,
output wire [7:0] dataout,
output wire tc
);

reg [7:0] cnt;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    cnt <= 8'b01010110;
  end else if (ce) begin
    if (cnt == 8'b01010110)
      cnt <= 8'b00000000;
    else
      cnt <= cnt + 1;
  end
end

assign dataout = cnt;
assign tc = (cnt == 8'b01010110);

endmodule
