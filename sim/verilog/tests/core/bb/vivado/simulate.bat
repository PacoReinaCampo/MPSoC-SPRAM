@echo off
call ../../../../../../settings64_vivado.bat

xvlog -i ../../../../../../rtl/verilog/wb/pkg -prj system.verilog.prj
xelab peripheral_spram_testbench
xsim -R peripheral_spram_testbench
pause
