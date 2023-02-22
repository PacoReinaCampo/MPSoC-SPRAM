@echo off
call ../../../../../../settings64_vivado.bat

xvlog -i ../../../../../../rtl/verilog/pkg/wb -prj system.verilog.prj
xelab peripheral_spram_testbench
xsim -R peripheral_spram_testbench
pause
