all: build simulate

build:
	if [ ! -e work ]; then vlib work; fi
	vlog -sv +incdir+../../../../../../rtl/verilog/ahb3/pkg -f system.vc

simulate:
	vsim -c -do run.do work.peripheral_spram_testbench

clean:
	rm -rf work transcript
