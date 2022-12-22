# 1 "lbu.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "lbu.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "lbu.S" 2



# 1 "../rv64ui/lbu.S" 1
# See LICENSE for license details.

#*****************************************************************************
# lbu.S
#-----------------------------------------------------------------------------

# Test lbu instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/lbu.S" 2
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
# 12 "../rv64ui/lbu.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: la x1, tdat; lbu x30, 0(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x30, x29, fail;;
  test_3: la x1, tdat; lbu x30, 1(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x30, x29, fail;;
  test_4: la x1, tdat; lbu x30, 2(x1);; li x29, ((0x00000000000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x30, x29, fail;;
  test_5: la x1, tdat; lbu x30, 3(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x30, x29, fail;;

  # Test with negative offset

  test_6: la x1, tdat4; lbu x30, -3(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x30, x29, fail;;
  test_7: la x1, tdat4; lbu x30, -2(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne x30, x29, fail;;
  test_8: la x1, tdat4; lbu x30, -1(x1);; li x29, ((0x00000000000000f0) & ((1 << (32 - 1) << 1) - 1)); li gp, 8; bne x30, x29, fail;;
  test_9: la x1, tdat4; lbu x30, 0(x1);; li x29, ((0x000000000000000f) & ((1 << (32 - 1) << 1) - 1)); li gp, 9; bne x30, x29, fail;;

  # Test with a negative base

  test_10: la x1, tdat; addi x1, x1, -32; lbu x5, 32(x1);; li x29, ((0x00000000000000ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 10; bne x5, x29, fail;





  # Test with unaligned base

  test_11: la x1, tdat; addi x1, x1, -6; lbu x5, 7(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 11; bne x5, x29, fail;





  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_12: li gp, 12; li x4, 0; 1: la x1, tdat2; lbu x30, 1(x1); addi x6, x30, 0; li x29, 0x00000000000000f0; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_13: li gp, 13; li x4, 0; 1: la x1, tdat3; lbu x30, 1(x1); nop; addi x6, x30, 0; li x29, 0x000000000000000f; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;
  test_14: li gp, 14; li x4, 0; 1: la x1, tdat1; lbu x30, 1(x1); nop; nop; addi x6, x30, 0; li x29, 0x0000000000000000; bne x6, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;;

  test_15: li gp, 15; li x4, 0; 1: la x1, tdat2; lbu x30, 1(x1); li x29, 0x00000000000000f0; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li gp, 16; li x4, 0; 1: la x1, tdat3; nop; lbu x30, 1(x1); li x29, 0x000000000000000f; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li gp, 17; li x4, 0; 1: la x1, tdat1; nop; nop; lbu x30, 1(x1); li x29, 0x0000000000000000; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test write-after-write hazard
  #-------------------------------------------------------------

  test_18: la x5, tdat; lbu x2, 0(x5); li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 18; bne x2, x29, fail;





  test_19: la x5, tdat; lbu x2, 0(x5); nop; li x2, 2;; li x29, ((2) & ((1 << (32 - 1) << 1) - 1)); li gp, 19; bne x2, x29, fail;






  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

tdat:
tdat1: .byte 0xff
tdat2: .byte 0x00
tdat3: .byte 0xf0
tdat4: .byte 0x0f

.align 4; .global end_signature; end_signature:
# 8 "lbu.S" 2
