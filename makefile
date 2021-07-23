BUILD = ./build
BIN = ./bin
SRC = ./src

FILES = $(BUILD)/kernel.asm.o $(BUILD)/kernel.o $(BUILD)/tui.o $(BUILD)/string.o $(BUILD)/memory.o $(BUILD)/idt.o $(BUILD)/idt.asm.o
INCLUDES = -I$(SRC)
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

all: $(BIN)/boot.bin $(BIN)/kernel.bin
	rm -rf $(BIN)/os.bin
	dd if=$(BIN)/boot.bin >> $(BIN)/os.bin
	dd if=$(BIN)/kernel.bin >> $(BIN)/os.bin
	dd if=/dev/zero bs=512 count=100 >> $(BIN)/os.bin

$(BIN)/kernel.bin: $(FILES)
	i686-elf-ld -g -relocatable $(FILES) -o $(BUILD)/kernelfull.o
	i686-elf-gcc $(FLAGS) -T $(SRC)/linker.ld -o $@ -ffreestanding -O0 -nostdlib $(BUILD)/kernelfull.o

$(BIN)/boot.bin: $(SRC)/boot/boot.asm
	nasm -f bin $< -o $@

$(BUILD)/kernel.asm.o: $(SRC)/kernel.asm
	nasm -f elf -g $< -o $@

$(BUILD)/kernel.o: $(SRC)/kernel.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c $< -o $@

$(BUILD)/tui.o: $(SRC)/tui/tui.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c $< -o $@

$(BUILD)/string.o: $(SRC)/string/string.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c $< -o $@

$(BUILD)/memory.o: $(SRC)/memory/memory.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c $< -o $@

$(BUILD)/idt.asm.o: $(SRC)/idt/idt.asm
	nasm -f elf -g $< -o $@

$(BUILD)/idt.o: $(SRC)/idt/idt.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c $< -o $@

clean:
	rm -rf $(BIN)/*
	rm -rf $(BUILD)/*
