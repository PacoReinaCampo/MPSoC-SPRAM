@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/pkg/peripheral/wb/peripheral_spram_wb_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/wb/peripheral_ram_generic_wb.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/peripheral/wb/peripheral_spram_wb.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/peripheral/wb/peripheral_spram_testbench.vhd
ghdl -m --std=08 peripheral_spram_testbench
ghdl -r --std=08 peripheral_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_spram_testbench.tree
pause
