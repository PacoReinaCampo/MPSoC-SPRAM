@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/axi4/peripheral_spram_axi4.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/peripheral/axi4/peripheral_spram_testbench.vhd
ghdl -m --std=08 peripheral_spram_testbench
ghdl -r --std=08 peripheral_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_spram_testbench.tree
pause
