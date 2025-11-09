# RISC-V CPU

This repository contains two RISC-V RV32I CPU implementations in Verilog:
- single-cycle CPU (simple, every instruction in one cycle)
- pipelined CPU (5-stage pipeline with hazard control and forwarding)

Both variants include RTL sources, testbenches, build/run scripts, and example test programs.

---

## Top-level layout

- singlecycle_cpu/
  - rtl/            — Verilog RTL for the single-cycle CPU
  - tb/             — testbench scripts, test vectors, logs and build artifacts
  - tb/build/       — generated simulation artifacts (cpu_tb.vcd, etc.)
  - tb/logs/        — runtime logs (cpu_tb_run.log)
  - tb/test/        — grouped test programs (rtype, itype, stype, sbtype, ...)
- pipelined_cpu/
  - rtl/            — Verilog RTL for the pipelined CPU and pipeline registers
  - tb/             — testbench scripts, test vectors, logs and build artifacts
  - tb/build/
  - tb/logs/
  - tb/test/

Each tb/ directory contains:
- build.sh        — compiles the testbench (uses iverilog)
- run.sh          — invokes build.sh and appends output to tb/logs/cpu_tb_run.log
- tb_files.txt    — list of test directories used by run scripts
- program_file.txt— (where present) alternative listing of programs to run
- test/*          — input .mem files and expected output files for each test

---

## Key files (per variant)

Example files found in both variants:
- rtl/CPU.v            — top-level CPU module
- rtl/imem.v, rtl/dmem.v, rtl/regfile.v, rtl/alu.v, etc.
- tb/cpu_tb.v          — top-level Verilog testbench used for simulation
- tb/build.sh          — builds cpu_tb using iverilog
- tb/run.sh            — runs build.sh and appends logs to tb/logs/cpu_tb_run.log

Generated outputs:
- tb/logs/cpu_tb_run.log — runtime log (appended by tb/run.sh)
- tb/build/cpu_tb.vcd    — waveform dump (if testbench writes VCD)

Test vectors and expected outputs:
- tb/test/<testname>/*.mem
  - idata.mem, data0..data3.mem, init_regfile.mem, exp_reg_out.mem, exp_data_out.mem

---

## Requirements

- Linux (development targeted on Linux)
- iverilog + vvp (for simulation)
  - Install: sudo apt-get update && sudo apt-get install -y iverilog

---

## How to run simulations

From a specific CPU folder (example: single-cycle):

1. Build and run (simple):
  - Open terminal and run:

  ```bash
    cd singlecycle_cpu/tb
    ./run.sh
  ```
  - run.sh already appends build/run output into `tb/logs/cpu_tb_run.log`.

2. Inspect waveform:
  - Open `tb/build/cpu_tb.vcd` with GTKWave:
  ```bash
    cd pipelined_cpu/tb
    gtkwave build/cpu_tb.vcd &
  ```
---

## Selecting tests / programs

- The run scripts iterate test directories listed in `tb/tb_files.txt`. Edit that file to change which test sets are executed.

---

## Logs and debugging

- Runtime output and errors are appended to `tb/logs/cpu_tb_run.log`.
- If there are any errors:
  - Check `tb/logs/cpu_tb_run.log` for accumulated output.
  - Inspect `tb/build/cpu_tb.vcd` for waveform data using GTKWave commands given above.

---

## Extending / Custom tests

- Add new test directories under `tb/test/` with the same .mem file naming convention.
- Update `tb/tb_files.txt` to include the new test directory.
- Adjust `$readmemh` in `rtl/imem.v` if you want the testbench to use alternate instruction memory files.

---


