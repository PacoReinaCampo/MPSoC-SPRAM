source ../../../../../../settings64_vivado.sh

xvlog -i ../../../../../../rtl/verilog/ahb3/pkg -prj system.verilog.prj
xelab mpsoc_spram_testbench
xsim -R mpsoc_spram_testbench
