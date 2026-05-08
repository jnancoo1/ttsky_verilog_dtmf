module fifo_adrr_queue(
input wire [3:0] key_code,
input wire reset,
input wire read,
input wire write,
input wire clk,
inout wire emp,
inout wire [3:0] data_out
);

reg [2:0] rd_ptr;
reg [2:0] write_ptr;
reg [3:0] count;
reg [3:0] mem[7:0];
reg [3:0] dout_reg;

integer i;

assign data_out = dout_reg;
assign emp = (count == 0);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    rd_ptr     <= 3'b0;
    write_ptr  <= 3'b0;
    count      <= 4'b0;
    dout_reg   <= 4'b0;

    for (i = 0; i < 8; i = i + 1)
      mem[i] <= 4'b0;

  end else begin

    // WRITE
    if (write && (count < 8)) begin
      mem[write_ptr] <= key_code;
      write_ptr <= write_ptr + 1;
      count <= count + 1;
    end

    // READ
    if (read && (count > 0)) begin
      dout_reg <= mem[rd_ptr];
      rd_ptr <= rd_ptr + 1;
      count <= count - 1;
    end

  end
end

endmodule
