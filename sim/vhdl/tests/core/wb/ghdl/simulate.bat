@echo off
call ../../../../../../settings64_ghdl.bat

ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/pkg/peripheral_spram_wb_pkg.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_ram_generic_wb.vhd
ghdl -a --std=08 ../../../../../../rtl/vhdl/wb/core/peripheral_spram_wb.vhd
ghdl -a --std=08 ../../../../../../bench/vhdl/tests/core/wb/peripheral_spram_testbench.vhd
ghdl -m --std=08 peripheral_spram_testbench
ghdl -r --std=08 peripheral_spram_testbench --ieee-asserts=disable-at-0 --disp-tree=inst > peripheral_spram_testbench.tree
pause
