xvlog -i ../../../../../../rtl/verilog/ahb3/pkg -prj system.verilog.prj
xvhdl -prj system.vhdl.prj
xelab mpsoc_spram_testbench
xsim -R mpsoc_spram_testbench