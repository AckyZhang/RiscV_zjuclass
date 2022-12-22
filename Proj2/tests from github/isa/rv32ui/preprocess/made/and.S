# 1 "and.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "and.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "and.S" 2



# 1 "../rv64ui/and.S" 1
# See LICENSE for license details.

#*****************************************************************************
# and.S
#-----------------------------------------------------------------------------

# Test and instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/and.S" 2
# 1 "../rv64ui/test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 20 "../rv64ui/test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 36 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 92 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 120 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 214 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 340 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 369 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
# 631 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in gp)
#-----------------------------------------------------------------------
# 643 "../rv64ui/test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "../rv64ui/and.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Logical tests
  #-------------------------------------------------------------

  test_2: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x30, x29, fail;;
  test_3: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x30, x29, fail;;
  test_4: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x30, x29, fail;;
  test_5: li x1, ((0xf00ff00f) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2;; li x29, ((0xf000f000) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x30, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_6: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x1, x1, x2;; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x1, x29, fail;;
  test_7: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x2, x1, x2;; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne x2, x29, fail;;
  test_8: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x1, x1, x1;; li x29, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li gp, 8; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_9: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 9; bne x6, x29, fail;;
  test_10: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 10; bne x6, x29, fail;;
  test_11: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; nop; nop; addi x6, x30, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 11; bne x6, x29, fail;;

  test_12: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 12; bne x30, x29, fail;;
  test_13: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 13; bne x30, x29, fail;;
  test_14: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 14; bne x30, x29, fail;;
  test_15: li x4, 0; 1: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 15; bne x30, x29, fail;;
  test_16: li x4, 0; 1: li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 16; bne x30, x29, fail;;
  test_17: li x4, 0; 1: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 17; bne x30, x29, fail;;

  test_18: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 18; bne x30, x29, fail;;
  test_19: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 19; bne x30, x29, fail;;
  test_20: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); nop; nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 20; bne x30, x29, fail;;
  test_21: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x0f000f00) & ((1 << (32 - 1) << 1) - 1)); li gp, 21; bne x30, x29, fail;;
  test_22: li x4, 0; 1: li x2, ((0xf0f0f0f0) & ((1 << (32 - 1) << 1) - 1)); nop; li x1, ((0x0ff00ff0) & ((1 << (32 - 1) << 1) - 1)); nop; and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x00f000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 22; bne x30, x29, fail;;
  test_23: li x4, 0; 1: li x2, ((0x0f0f0f0f) & ((1 << (32 - 1) << 1) - 1)); nop; nop; li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); and x30, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b; li x29, ((0x000f000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 23; bne x30, x29, fail;;

  test_24: li x1, ((0xff00ff00) & ((1 << (32 - 1) << 1) - 1)); and x2, x0, x1;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 24; bne x2, x29, fail;;
  test_25: li x1, ((0x00ff00ff) & ((1 << (32 - 1) << 1) - 1)); and x2, x1, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 25; bne x2, x29, fail;;
  test_26: and x1, x0, x0;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 26; bne x1, x29, fail;;
  test_27: li x1, ((0x11111111) & ((1 << (32 - 1) << 1) - 1)); li x2, ((0x22222222) & ((1 << (32 - 1) << 1) - 1)); and x0, x1, x2;; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 27; bne x0, x29, fail;;

  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "and.S" 2
