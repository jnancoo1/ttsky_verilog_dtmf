// File control_unit.vhd translated with vhd2vl 3.0 VHDL to Verilog RTL translator
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
// no timescale needed

module control_unit(
input wire ref_clk,
input wire reset,
input wire dtmf_enable,
input wire dial_enable,
input wire number_entrered,
input wire fifo_empty,
input wire PauseTime_done,
input wire ToneTime_done,
inout reg write_fifo,
inout reg read_fifo,
inout reg gen_tone,
inout reg start_tone,
inout reg rom_out,
inout reg tone_pause,
inout reg start_PauseTime,
inout reg start_ToneTime
);




parameter [2:0]
  idle_state = 0,
  write_fifo_state = 1,
  read_fifo_state = 2,
  read_rom_state = 3,
  load_div_state = 4,
  count_state = 5,
  pause_state = 6;

reg [2:0] current_state; reg [2:0] next_state;

  always @(posedge ref_clk, posedge reset) begin
    if(reset == 1'b1) begin
      current_state <= idle_state;
    end else begin
      current_state <= next_state;
    end
  end

  always @(current_state, dtmf_enable, number_entrered, dial_enable, ToneTime_done, PauseTime_done, fifo_empty) begin
    // default
    next_state <= current_state;
    case(current_state)
        //------------------------------------------------------
    idle_state : begin
      if((dtmf_enable == 1'b1 && number_entrered == 1'b1)) begin
        next_state <= write_fifo_state;
      end
      else begin
        next_state <= idle_state;
      end
      //------------------------------------------------------
    end
    write_fifo_state : begin
      if(dial_enable == 1'b1) begin
        next_state <= read_fifo_state;
      end
      else begin
        next_state <= idle_state;
      end
      //------------------------------------------------------
    end
    read_fifo_state : begin
      if(fifo_empty == 1'b0) begin
        next_state <= read_rom_state;
      end
      else begin
        next_state <= idle_state;
      end
    end
    read_rom_state : begin
      next_state <= load_div_state;
    end
    load_div_state : begin
      next_state <= count_state;
    end
    count_state : begin
      if(ToneTime_done == 1'b1) begin
        next_state <= pause_state;
      end
      else begin
        next_state <= count_state;
      end
    end
    pause_state : begin
      if(PauseTime_done == 1'b1) begin
        if(dial_enable == 1'b1) begin
          next_state <= read_fifo_state;
        end
        else begin
          next_state <= idle_state;
        end
      end
      else begin
        next_state <= pause_state;
      end
    end
    default : begin
      next_state <= idle_state;
    end
    endcase
  end

  always @(current_state) begin
    write_fifo <= 1'b0;
    read_fifo <= 1'b0;
    gen_tone <= 1'b0;
    start_tone <= 1'b0;
    rom_out <= 1'b0;
    tone_pause <= 1'b0;
    start_PauseTime <= 1'b0;
    start_ToneTime <= 1'b0;
    case(current_state)
    idle_state : begin
    end
    write_fifo_state : begin
      write_fifo <= 1'b1;
    end
    read_fifo_state : begin
      read_fifo <= 1'b1;
    end
    read_rom_state : begin
      rom_out <= 1'b1;
    end
    load_div_state : begin
      start_tone <= 1'b1;
    end
    count_state : begin
      gen_tone <= 1'b1;
      start_ToneTime <= 1'b1;
    end
    pause_state : begin
      tone_pause <= 1'b1;
      start_PauseTime <= 1'b1;
    end
    default : begin
    end
    endcase
  end


endmodule
