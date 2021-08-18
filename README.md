[![test](https://github.com/dani3/EvOS/actions/workflows/test.yml/badge.svg)](https://github.com/dani3/EvOS/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/dani3/EvOS/branch/master/graph/badge.svg?token=F8N5EKFGV0)](https://codecov.io/gh/dani3/EvOS)
# EvOS

Multitasking OS and kernel with an interactive shell.

## Debugging with GDB

1. Run gdb:

    ```sh
    $ gdb
    ```

2. Load symbol file:

    ```sh
    add-symbol-file <root>/build/kernelfull.o 0x100000
    ```

3. Set a breakpoint:

    ```sh
    break kernel_main
    ```

4. Attach the debugger to QEMU:

    ```sh
    target remote | qemu-system-x86_64 -S -gdb stdio -hda ./os.bin
    ```

### Cheat sheet

|   Command    | Description                                           |
|:------------:|:------------------------------------------------------|
|     `c`      | Continue                                              |
| `layout asm` | Enter assembly layout                                 |
| `layout src` | Enter source layout                                   |
|    `step`    | Step program until it reaches a different source line |
|   `stepi`    | Step one instruction exactly                          |
|   `finish`   | Complete the current stack frame                      |

## References

- [BIOS routines](http://ctyme.com/intr/int.htm)
- [Cross compiler](https://wiki.osdev.org/GCC_Cross-Compiler)
