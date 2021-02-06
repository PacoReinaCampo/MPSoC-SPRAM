call ../../../../../../settings64_vivado.bat

xvlog -prj system.prj
xelab mpsoc_spram_testbench
xsim -R mpsoc_spram_testbench
