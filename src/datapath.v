// File datapath.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// Create Date: 07.05.2026 23:18:02
// Design Name: 
// Module Name: datapath - Behavioral
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

module datapath(
input wire reset,
input wire key_press,
input wire [3:0] key_code,
input wire reference_clk,
input wire dtmf_en,
input wire dial_en,
inout wire Fh,
inout wire Fl
);




// clocks
wire clk_1khz;
wire clk_2mhz;  // FIFO
wire fifo_empty_s;
wire [3:0] fifo_data_s;  // ROM
wire [11:0] toneH_s;
wire [11:0] toneL_s;  // timers
wire tone_done_s;
wire pause_done_s;
wire [7:0] tone_cnt_s;
wire [7:0] pause_cnt_s;  // control unit outputs
wire write_fifo_s;
wire read_fifo_s;
wire gen_tone_s;
wire start_tone_s;
wire rom_out_s;
wire tone_pause_s;
wire start_pause_s;
wire start_toneTime_s;  // programmable divider outputs
wire fh_raw_s;
wire fl_raw_s;

  frequency_divider cop1(
    .clk(reference_clk),
    .reset(reset),
    .clock1(clk_1khz),
    .clock2(clk_2mhz));

  control_unit cop2(
    .ref_clk(reference_clk),
    .reset(reset),
    .dtmf_enable(dtmf_en),
    .dial_enable(dial_en),
    .number_entrered(key_press),
    .fifo_empty(fifo_empty_s),
    .PauseTime_done(pause_done_s),
    .ToneTime_done(tone_done_s),
    .write_fifo(write_fifo_s),
    .read_fifo(read_fifo_s),
    .gen_tone(gen_tone_s),
    .start_tone(start_tone_s),
    .rom_out(rom_out_s),
    .tone_pause(tone_pause_s),
    .start_PauseTime(start_pause_s),
    .start_ToneTime(start_toneTime_s));

  fifo_adrr_queue cop3(
    .key_code(key_code),
    .reset(reset),
    .read(read_fifo_s),
    .write(write_fifo_s),
    .clk(reference_clk),
    .emp(fifo_empty_s),
    .data_out(fifo_data_s));

  rom cop4(
    .data_in(fifo_data_s),
    .oe(rom_out_s),
    .ToneH_val(toneH_s),
    .ToneL_val(toneL_s));

  prog_freq_div cop5(
    .Dh(toneH_s),
    .Dl(toneL_s),
    .reset(reset),
    .clk(clk_2mhz),
    .load(start_tone_s),
    .enable(gen_tone_s),
    .fH(fh_raw_s),
    .fL(fl_raw_s));

  mod86_timer cop6(
    .clk(clk_1khz),
    .reset(reset),
    .ce(start_toneTime_s),
    .dataout(tone_cnt_s),
    .tc(tone_done_s));

  mod201_timer cop7(
    .clk(clk_1khz),
    .reset(reset),
    .ce(start_pause_s),
    .dataout(pause_cnt_s),
    .tc(pause_done_s));

  mux2to1 cop8(
    .w0(1'b0),
    .w1(fh_raw_s),
    .s(tone_pause_s),
    .f(Fh));

  mux2to1 cop9(
    .w0(1'b0),
    .w1(fl_raw_s),
    .s(tone_pause_s),
    .f(Fl));


endmodule
