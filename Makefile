
# ----- SRCS and TARGET setting ----- #
# T    : src file name you want to test
# PRE  : test bench prefix (Write test bench file like tb_hoge.v)
# POST : filename extension
# TOP  : a top name of this testbench
T=led_blinking
PRE=tb_
POST=.v
TOP=test

SRCS=$(PRE)$(T)$(POST)
TARGET=$(PRE)$(T)

# ----- Log files setting ----- #
# LOG  : simulation result (text, Verilog)
# VCD  : simulation result (wave, Verilog)
LOG=log.txt
VCD=uut.vcd

# ----- iverilog setting ----- #
IV=iverilog -I ./src/ -o $(TARGET) $(SRCS)

# ----- VCS setting ----- #
VCS=vcs -full64 -v2005 +incdir+./src/ -o $(TARGET) $(SRCS)

# ----- ModelSim setting ----- #
WRK_DIR=work
MS=vlib $(WRK_DIR) && vmap $(TARGET) "./$(WRK_DIR)" && vlog -work $(TARGET) -incr +incdir+./src/ -lint $(SRCS)

# ----- gtkwave setting ----- #
GTK=gtkwave $(VCD) &


iverilog:
	$(IV)

vcs:
	$(VCS)

run:
	./$(TARGET)

dump:
	./$(TARGET) > $(LOG)

view:
	$(GTK)

ms_compile:
	$(MS)

ms_cuirun:
	vsim $(TOP) -c -lib $(TARGET) -do "run -all;quit"

ms_guirun:
	vsim $(TOP) -lib $(TARGET) -do "add wave -position insertpoint sim:/$(TOP)/*"

clean:
	rm -rf $(TARGET) $(VCD) $(LOG) csrc $(TARGET).daidir ucli.key modelsim.ini transcript $(WRK_DIR)

