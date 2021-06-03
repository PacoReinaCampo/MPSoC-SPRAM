@echo off
call ../../../../../../settings64_vivado.bat

xvlog -prj system.verilog.prj
xvhdl -prj system.vhdl.prj
xelab peripheral_spram_testbench
xsim -R peripheral_spram_testbench
pause
