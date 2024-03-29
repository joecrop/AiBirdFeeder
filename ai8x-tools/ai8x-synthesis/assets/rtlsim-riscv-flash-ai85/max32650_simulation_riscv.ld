/*******************************************************************************
 * Copyright (C) 2016 Maxim Integrated Products, Inc., All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL MAXIM INTEGRATED BE LIABLE FOR ANY CLAIM, DAMAGES
 * OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name of Maxim Integrated
 * Products, Inc. shall not be used except as stated in the Maxim Integrated
 * Products, Inc. Branding Policy.
 *
 * The mere transfer of this software does not imply any licenses
 * of trade secrets, proprietary technology, copyrights, patents,
 * trademarks, maskwork rights, or any other form of intellectual
 * property whatsoever. Maxim Integrated Products, Inc. retains all
 * ownership rights.
 *
 * $Date: 2016-12-22 17:11:40 -0600 (Thu, 22 Dec 2016) $ 
 * $Revision: 25614 $
 *
 ******************************************************************************/

/* RVC :: ????? :: ROM        (rx) : ORIGIN = 0x00000000, LENGTH = 0x00001000 */ /* 4kB ROM */
/* RVC :: ????? :: SPIX_FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 0x08000000 */ /* 128MB SPIX Flash */
/* RVC :: ????? :: FLASH1     (rx) : ORIGIN = 0x10080000, LENGTH = 0x00080000 */ /* 512KB Flash */
/* RVC :: ????? :: HBUS      (rwx) : ORIGIN = 0x60000000, LENGTH = 0x20000000 */ /* 512MB Hyperbus */
/* RVC :: ????? :: SPIX_DATA (rwx) : ORIGIN = 0x80000000, LENGTH = 0x20000000 */ /* 512MB SPIX Data */
MEMORY {
    FLASH0  (rwx) : ORIGIN = 0x10000000, LENGTH = 0x00001000
    FLASH1  (rwx) : ORIGIN = 0x10001000, LENGTH = 0x0007F000
    SRAM2I  (rwx) : ORIGIN = 0x20010000, LENGTH = 0x00001000 /*  4kB SRAM2 :: 4KB Start used for const */
    SRAM2   (rwx) : ORIGIN = 0x20011000, LENGTH = 0x0000B000 /* 44kB SRAM2 :: SRAM2_0=8KB*/
    SRAM3   (rwx) : ORIGIN = 0x2001C000, LENGTH = 0x00004000 /* 16kB SRAM3 */
}

SECTIONS {
    .rvflash :
    {
      _rvflash = .;
        KEEP(*(.rvflash_section))   /* program code */
      _ervflash = .;
    } > FLASH1
    
    .text :
    {
        _text = .;
        KEEP(*(.isr_vector))
        *(.text*)    /* program code */

        KEEP(*(.init))
        KEEP(*(.fini))

        /* C++ Exception handling */
        KEEP(*(.eh_frame*))
        _etext = .;
    } > SRAM3

    .consts :
    {
        *(.rodata*)  /* read-only data: "const" */
        *(.srodata*) /* read-only data: "const" */
    } > SRAM2I 

    .sram3_code :
    {
        . = ALIGN(16);
        _sran_code = .;
        *(.sram3_code_section)
        _esran_code = .;
    } > SRAM3 


    /* it's used for C++ exception handling      */
    /* we need to keep this to avoid overlapping */
    .ARM.exidx :
    {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } > SRAM3

    /* short/global data section */
    .sdata :
    {
        _sdata = ALIGN(., 4);
        __sdata_start = .; 
        PROVIDE(__global_pointer$ = . + 0x800);        
        *(.sdata*)  /*read-write initialized data: initialized global variable*/

        _esdata = ALIGN(., 4);
        __sdata_end = .;
	
    } > SRAM2 AT>SRAM2I
    __load_sdata = LOADADDR(.sdata);

    .data :
    {
        _data = ALIGN(., 4);
        __data_start__ = . ;            /* Standard newlib definition. */
	
        *(.data*)           /*read-write initialized data: initialized global variable*/
        *(.spix_config*)    /* SPIX configuration functions need to be run from SRAM3 */

        /* These array sections are used by __libc_init_array to call static C++ constructors */
        . = ALIGN(4);
        /* preinit data */
        PROVIDE_HIDDEN (__preinit_array_start = .);
        KEEP(*(.preinit_array))
        PROVIDE_HIDDEN (__preinit_array_end = .);

        . = ALIGN(4);
        /* init data */
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array))
        PROVIDE_HIDDEN (__init_array_end = .);

        . = ALIGN(4);
        /* finit data */
        PROVIDE_HIDDEN (__fini_array_start = .);
        KEEP(*(SORT(.fini_array.*)))
        KEEP(*(.fini_array))
        PROVIDE_HIDDEN (__fini_array_end = .);

        _edata = ALIGN(., 4);
       __data_end__ = . ;                /* Standard newlib definition. */
    } > SRAM2 AT>SRAM2I
    __load_data = LOADADDR(.data);

    .sbss :
    {
        . = ALIGN(4);
        __sbss_start = .;                 /* Standard newlib definition. */
	__sbss_start__ = .;                 /* Standard newlib definition. */
        _sbss = .;
        *(.sbss*)     /*read-write zero initialized data: uninitialzed global variable*/
        *(COMMON)
        _esbss = ALIGN(., 4);
       __sbss_end__ = .;                /* Standard newlib definition. */
       __sbss_end = .;                    /* Standard newlib definition. */
    } > SRAM2

    .bss :
    {
        . = ALIGN(4);
        __bss_start = .;                 /* Standard newlib definition. */
	__bss_start__ = .;                 /* Standard newlib definition. */
        _bss = .;
        *(.bss*)     /*read-write zero initialized data: uninitialzed global variable*/
        *(COMMON)
        _ebss = ALIGN(., 4);
        __bss_end__ = .;                /* Standard newlib definition. */
	__bss_end = .;                    /* Standard newlib definition. */
     } > SRAM2

    /* Set stack top to end of RAM, and stack limit move down by
     * size of stack_dummy section */
    __StackTop = ORIGIN(SRAM2) + LENGTH(SRAM2);
    __StackLimit = __StackTop - SIZEOF(.stack_dummy);

    /* .stack_dummy section doesn't contains any symbols. It is only
     * used for linker to calculate size of stack sections, and assign
     * values to stack symbols later */
    .stack_dummy (COPY):
    {
        *(.stack*)
    } > SRAM2

    .heap (COPY):
    {
        . = ALIGN(4);
        *(.heap*)
        __HeapLimit = ABSOLUTE(__StackLimit);
    } > SRAM2

    PROVIDE(__stack = __StackTop);

    /* Check if data + heap + stack exceeds RAM limit */
    ASSERT(__StackLimit >= _ebss, "region RAM overflowed with stack")
}
