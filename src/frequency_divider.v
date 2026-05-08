// File frequency_divider.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001-2023 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2023 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// no timescale needed

module frequency_divider(
input wire clk,
input wire reset,
output reg clock1,
output reg clock2
);





  // =========================
  // clk_akHz divider
  // =========================
  always @(posedge clk, posedge reset) begin : P2
    reg [31:0] a1 = 2;

    if(reset == 1'b1) begin
      a1 = 2;
      clock1 <= 1'b0;
    end else begin
      if(a1 == 0) begin
        a1 = 2;
        clock1 <=  ~clock1;
      end
      else begin
        a1 = a1 - 1;
      end
    end
  end

  // =========================
  // clk_bHz divider
  // =========================
  always @(posedge clk, posedge reset) begin : P1
    reg [31:0] a2 = 4000000;

    if(reset == 1'b1) begin
      a2 = 4000000;
      clock2 <= 1'b0;
    end else begin
      if(a2 == 0) begin
        a2 = 4000000;
        clock2 <=  ~clock2;
      end
      else begin
        a2 = a2 - 1;
      end
    end
  end


endmodule
