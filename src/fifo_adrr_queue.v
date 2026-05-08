// File fifo_adrr_queue.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// Create Date: 06.05.2026 00:20:20
// Design Name: 
// Module Name: fifo_adrr_queue - Behavioral
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
//use IEEE.NUMERIC_STD.ALL;
// Uncomment the following library declaration if instantiating
// any Xilinx leaf cells in this code.
//library UNISIM;
//use UNISIM.VComponents.all;
// no timescale needed

module fifo_adrr_queue(
input wire [3:0] key_code,
input wire reset,
input wire read,
input wire write,
input wire clk,
inout wire emp,
inout wire [3:0] data_out
);





reg [2:0] rd_ptr = 1'b0;
reg [2:0] write_ptr = 1'b0;
reg [3:0] count = 1'b0;
reg [3:0] mem[7:0] = 1'b0;
reg [3:0] dout_reg = 1'b0;

  assign data_out = dout_reg;
  assign emp = count == 0 ? 1'b1 : 1'b0;
  always @(posedge clk, posedge reset) begin
    if(reset == 1'b1) begin
      rd_ptr <= {3{1'b0}};
      write_ptr <= {3{1'b0}};
      count <= {4{1'b0}};
      dout_reg <= {4{1'b0}};
    end else begin
      // WRITE
      if(write == 1'b1) begin
        if(count < 8) begin
          mem[write_ptr] <= key_code;
          if(write_ptr == 3'b111) begin
            write_ptr <= {3{1'b0}};
          end
          else begin
            write_ptr <= write_ptr + 1;
          end
          count <= count + 1;
        end
      end
      else if(read == 1'b1) begin
        if(count > 0) begin
          dout_reg <= mem[rd_ptr];
          if(rd_ptr == 3'b111) begin
            rd_ptr <= {3{1'b0}};
          end
          else begin
            rd_ptr <= rd_ptr + 1;
          end
          count <= count - 1;
        end
      end
    end
  end


endmodule
