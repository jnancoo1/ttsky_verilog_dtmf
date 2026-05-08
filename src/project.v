// File project.vhdl translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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

module tt_um_dtmf_gen(
input wire [7:0] ui_in,
output wire [7:0] uo_out,
input wire [7:0] uio_in,
output wire [7:0] uio_out,
output wire [7:0] uio_oe,
input wire ena,
input wire clk,
input wire rst_n
);




wire reset_s;
wire key_press_s;
wire dtmf_en_s;
wire dial_en_s;
wire [3:0] key_code_s;
wire fh_s;
wire fl_s;

  // TinyTapeout reset is ACTIVE LOW
  assign reset_s =  ~rst_n;
  // Example pin mapping
  assign key_press_s = ui_in[0];
  assign key_code_s = ui_in[4:1];
  assign dtmf_en_s = ui_in[5];
  assign dial_en_s = ui_in[6];
  // DATAPATH INSTANCE
  datapath UUT(
    .reset(reset_s),
    .key_press(key_press_s),
    .key_code(key_code_s),
    .reference_clk(clk),
    .dtmf_en(dtmf_en_s),
    .dial_en(dial_en_s),
    .Fh(fh_s),
    .Fl(fl_s));

  assign uo_out[0] = fh_s;
  assign uo_out[1] = fl_s;
  assign uo_out[7:2] = {6{1'b0}};
  assign uio_out = {8{1'b0}};
  assign uio_oe = {8{1'b0}};

endmodule
