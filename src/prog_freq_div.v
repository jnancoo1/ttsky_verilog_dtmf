// File prog_freq_div.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

//--------------------------------------------------------------------------------
// Company:
// Engineer:
//
// Create Date: 06.05.2026
// Design Name:
// Module Name: prog_freq_div
// Project Name: DTMF Generator
// Description:
// Programmable dual frequency divider for DTMF generation
//
//--------------------------------------------------------------------------------
// no timescale needed

module prog_freq_div(
input wire [11:0] Dh,
input wire [11:0] Dl,
input wire reset,
input wire clk,
input wire load,
input wire enable,
inout wire fH,
inout wire fL
);

// 2.096 MHz clock



reg [11:0] countH = 1'b0;
reg [11:0] countL = 1'b0;
reg [11:0] Dh_reg = 1'b0;
reg [11:0] Dl_reg = 1'b0;
reg fh_reg = 1'b0;
reg fl_reg = 1'b0;

  always @(posedge clk, posedge reset) begin
    if(reset == 1'b1) begin
      countH <= {12{1'b0}};
      countL <= {12{1'b0}};
      Dh_reg <= {12{1'b0}};
      Dl_reg <= {12{1'b0}};
      fh_reg <= 1'b0;
      fl_reg <= 1'b0;
    end else begin
      if(load == 1'b1) begin
        Dh_reg <= Dh;
        Dl_reg <= Dl;
        countH <= {12{1'b0}};
        countL <= {12{1'b0}};
        fh_reg <= 1'b0;
        fl_reg <= 1'b0;
      end
      else if(enable == 1'b1) begin
        if(Dh_reg != 0) begin
          if(countH == (Dh_reg - 1)) begin
            countH <= {12{1'b0}};
            fh_reg <=  ~fh_reg;
          end
          else begin
            countH <= countH + 1;
          end
        end
        if(Dl_reg != 0) begin
          if(countL == (Dl_reg - 1)) begin
            countL <= {12{1'b0}};
            fl_reg <=  ~fl_reg;
          end
          else begin
            countL <= countL + 1;
          end
        end
      end
      else begin
        countH <= {12{1'b0}};
        countL <= {12{1'b0}};
        fh_reg <= 1'b0;
        fl_reg <= 1'b0;
      end
    end
  end

  assign fH = fh_reg;
  assign fL = fl_reg;

endmodule
