all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vcom -2008 -f spram.vc
	vsim -c -do run.do work.mpsoc_spram_testbench
