@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/pkg/mpsoc_spram_ahb3_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ahb3_spram.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ram_1r1w.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/ahb3/core/mpsoc_ram_1r1w_generic.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/ahb3/mpsoc_spram_testbench.vhd
ghdl -m --std=08 mpsoc_spram_testbench
ghdl -r --std=08 mpsoc_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_spram_testbench.tree
pause
