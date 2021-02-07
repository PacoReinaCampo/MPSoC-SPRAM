@echo off
call ../../../../../../settings64_vivado.bat

xvlog -prj system.verilog.prj
xvhdl -prj system.vhdl.prj
xelab mpsoc_spram_testbench
xsim -R mpsoc_spram_testbench
pause
