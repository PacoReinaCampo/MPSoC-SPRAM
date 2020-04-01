all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vlog -sv +incdir+../../../../rtl/verilog/pkg -f spram_verilog.vc
	@vcom -2008 -f spram_vhdl.vc
	vsim -c -do run.do work.mpsoc_spram_testbench
