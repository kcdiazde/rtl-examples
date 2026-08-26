# Target executable name
TARGET = Vtestbench

# Verilog source files (space-separated if you have multiple)
VERILOG_SRCS = testbench.sv half_adder.sv full_adder.sv

# Top-level module name
TOP_MODULE = testbench

# Verilator Flags
# - Wall: Enable all warnings
# - binary: Build a standalone binary using auto-generated main wrapper
# - timing: Enable SystemVerilog timing / delays (#100, etc.)
# - CFLAGS: Pass required C++20 and coroutine flags to GCC
VERILATOR_FLAGS = -Wall \
                  --binary \
                  --timing \
                  --top-module $(TOP_MODULE) \
                  -CFLAGS "-std=c++20 -fcoroutines" \
                  -j 0

.PHONY: all run clean

# Default target: compile the binary
all: $(TARGET)

# Compile Verilog into an executable
$(TARGET): $(VERILOG_SRCS)
	verilator $(VERILATOR_FLAGS) $(VERILOG_SRCS)

# Build and immediately run the simulation
run: $(TARGET)
	./obj_dir/$(TARGET)

# Remove build artifacts
clean:
	rm -rf obj_dir
