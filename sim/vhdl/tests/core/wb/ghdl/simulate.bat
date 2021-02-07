@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/pkg/mpsoc_spram_wb_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/mpsoc_wb_ram_generic.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/mpsoc_wb_spram.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/wb/mpsoc_spram_testbench.vhd
ghdl -m --std=08 mpsoc_spram_testbench
ghdl -r --std=08 mpsoc_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_spram_testbench.tree
pause
