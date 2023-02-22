@echo off
call ../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab peripheral_spram_testbench
xsim -R peripheral_spram_testbench
pause
