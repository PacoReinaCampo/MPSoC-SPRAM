@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/axi4/core/mpsoc_axi4_spram.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/axi4/mpsoc_spram_testbench.vhd
ghdl -m --std=08 mpsoc_spram_testbench
ghdl -r --std=08 mpsoc_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > mpsoc_spram_testbench.tree
pause
