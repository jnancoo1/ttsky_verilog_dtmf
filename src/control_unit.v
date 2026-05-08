module control_unit(
input wire ref_clk,
input wire reset,
input wire dtmf_enable,
input wire dial_enable,
input wire number_entrered,
input wire fifo_empty,
input wire PauseTime_done,
input wire ToneTime_done,

output reg write_fifo,
output reg read_fifo,
output reg gen_tone,
output reg start_tone,
output reg rom_out,
output reg tone_pause,
output reg start_PauseTime,
output reg start_ToneTime
);

parameter [2:0]
  idle_state = 0,
  write_fifo_state = 1,
  read_fifo_state = 2,
  read_rom_state = 3,
  load_div_state = 4,
  count_state = 5,
  pause_state = 6;

reg [2:0] current_state;
reg [2:0] next_state;

//------------------------------------------------------
// State register
//------------------------------------------------------
always @(posedge ref_clk or posedge reset) begin
    if (reset)
        current_state <= idle_state;
    else
        current_state <= next_state;
end

//------------------------------------------------------
// Next state logic
//------------------------------------------------------
always @(*) begin
    next_state = current_state;

    case(current_state)

    idle_state: begin
        if (dtmf_enable && number_entrered)
            next_state = write_fifo_state;
    end

    write_fifo_state: begin
        if (dial_enable)
            next_state = read_fifo_state;
        else
            next_state = idle_state;
    end

    read_fifo_state: begin
        if (!fifo_empty)
            next_state = read_rom_state;
        else
            next_state = idle_state;
    end

    read_rom_state:
        next_state = load_div_state;

    load_div_state:
        next_state = count_state;

    count_state: begin
        if (ToneTime_done)
            next_state = pause_state;
    end

    pause_state: begin
        if (PauseTime_done) begin
            if (dial_enable)
                next_state = read_fifo_state;
            else
                next_state = idle_state;
        end
    end

    default:
        next_state = idle_state;

    endcase
end

//------------------------------------------------------
// Output logic
//------------------------------------------------------
always @(*) begin
    write_fifo = 0;
    read_fifo = 0;
    gen_tone = 0;
    start_tone = 0;
    rom_out = 0;
    tone_pause = 0;
    start_PauseTime = 0;
    start_ToneTime = 0;

    case(current_state)

    write_fifo_state:
        write_fifo = 1;

    read_fifo_state:
        read_fifo = 1;

    read_rom_state:
        rom_out = 1;

    load_div_state:
        start_tone = 1;

    count_state: begin
        gen_tone = 1;
        start_ToneTime = 1;
    end

    pause_state: begin
        tone_pause = 1;
        start_PauseTime = 1;
    end

    endcase
end

endmodule
