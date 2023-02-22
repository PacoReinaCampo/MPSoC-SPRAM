all: build simulate

build:
	verilator -Wno-lint +incdir+../../../../../../rtl/verilog/pkg/ahb3 --cc -f system.vc --top-module peripheral_spram_testbench

simulate:

clean:
	rm -rf obj_dir
