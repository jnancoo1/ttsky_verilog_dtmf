
# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Smoke test start")

    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Running for a few cycles")

    # Apply some stimulus
    dut.ui_in.value = 20
    dut.uio_in.value = 30

    # Let system run
    await ClockCycles(dut.clk, 20)

    # ONLY sanity checks (no functional assertions)
    dut._log.info(f"uo_out = {dut.uo_out.value}")
    dut._log.info("Smoke test completed successfully")
