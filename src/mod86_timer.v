// File mod86_timer.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// Create Date: 06.05.2026 18:43:27
// Design Name: 
// Module Name: mod86_timer - Behavioral
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//--------------------------------------------------------------------------------
//-- Uncomment the following library declaration if instantiating
//-- any Xilinx primitives in this code.
//library UNISIM;
//use UNISIM.VComponents.all;
// no timescale needed

module mod86_timer(
input wire clk,
input wire reset,
input wire ce,
output wire [7:0] dataout,
output wire tc
);




reg [7:0] cnt;

  always @(posedge clk, posedge reset, posedge ce, posedge cnt) begin
    if((reset == 1'b1)) begin
      cnt <= 8'b01010110;
    end else begin
      if((ce == 1'b1)) begin
        if((cnt == 8'b01010110)) begin
          cnt <= 8'b00000000;
        end
        else begin
          cnt <= cnt + 1;
        end
      end
    end
  end

  assign dataout = cnt;
  assign tc = cnt == 8'b01010110 ? 1'b1 : 1'b0;

endmodule
