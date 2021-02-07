@echo off
call ../../../../../../settings64_vivado.bat

xvlog -i ../../../../../../rtl/verilog/wb/pkg -prj system.verilog.prj
xelab wb_spram_tb
xsim -R wb_spram_tb
pause
