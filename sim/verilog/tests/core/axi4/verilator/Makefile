all: build

build:
	verilator -Wno-lint +incdir+../../../../../../rtl/verilog/axi4/pkg --cc -f system.vc --top-module peripheral_spram_testbench

simulate:

clean:
	rm -rf obj_dir
