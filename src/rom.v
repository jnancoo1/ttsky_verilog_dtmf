// File rom.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// Create Date: 06.05.2026 14:01:08
// Design Name: 
// Module Name: rom - Behavioral
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
// Uncomment the following library declaration if using
// arithmetic functions with Signed or Unsigned values
// Uncomment the following library declaration if instantiating
// any Xilinx leaf cells in this code.
//library UNISIM;
//use UNISIM.VComponents.all;
// no timescale needed

module rom(
input wire [3:0] data_in,
input wire oe,
output reg [11:0] ToneH_val,
output reg [11:0] ToneL_val
);





  always @(oe, data_in) begin
    if(oe == 1'b1) begin
      case(data_in)
            // Key 1: 697 Hz, 1209 Hz
      4'b0001 : begin
        ToneL_val <= 3006;
        ToneH_val <= 1734;
        // Key 2: 697 Hz, 1336 Hz
      end
      4'b0010 : begin
        ToneL_val <= 3006;
        ToneH_val <= 1569;
        // Key 3: 697 Hz, 1477 Hz
      end
      4'b0011 : begin
        ToneL_val <= 3006;
        ToneH_val <= 1419;
        // Key 4: 770 Hz, 1209 Hz
      end
      4'b0100 : begin
        ToneL_val <= 2722;
        ToneH_val <= 1734;
        // Key 5: 770 Hz, 1336 Hz
      end
      4'b0101 : begin
        ToneL_val <= 2722;
        ToneH_val <= 1569;
        // Key 6: 770 Hz, 1477 Hz
      end
      4'b0110 : begin
        ToneL_val <= 2722;
        ToneH_val <= 1419;
        // Key 7: 852 Hz, 1209 Hz
      end
      4'b0111 : begin
        ToneL_val <= 2460;
        ToneH_val <= 1734;
        // Key 8: 852 Hz, 1336 Hz
      end
      4'b1000 : begin
        ToneL_val <= 2460;
        ToneH_val <= 1569;
        // Key 9: 852 Hz, 1477 Hz
      end
      4'b1001 : begin
        ToneL_val <= 2460;
        ToneH_val <= 1419;
        // Key 0: 941 Hz, 1336 Hz
      end
      4'b0000 : begin
        ToneL_val <= 2228;
        ToneH_val <= 1569;
      end
      default : begin
        ToneL_val <= {12{1'b0}};
        ToneH_val <= {12{1'b0}};
      end
      endcase
    end
    else if(oe == 1'b0) begin
      ToneL_val <= {12{1'b0}};
      ToneH_val <= {12{1'b0}};
    end
  end


endmodule
