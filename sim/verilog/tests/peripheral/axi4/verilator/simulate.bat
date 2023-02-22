@echo off
call ../../../../../../settings64_verilator.bat

verilator -Wno-lint +incdir+../../../../../../rtl/verilog/axi4/pkg --cc -f system.vc --top-module peripheral_spram_testbench
pause
