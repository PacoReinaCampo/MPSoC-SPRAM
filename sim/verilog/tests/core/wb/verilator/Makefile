all: build simulate

build:
	verilator -Wno-lint --cc -f system.vc --top-module mpsoc_spram_testbench

simulate:

clean:
	rm -rf obj_dir
