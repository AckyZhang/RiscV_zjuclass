# 1 "sb.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "sb.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "sb.S" 2



# 1 "../rv64ui/sb.S" 1
# See LICENSE for license details.

#*****************************************************************************
# sb.S
#-----------------------------------------------------------------------------

# Test sb instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/sb.S" 2
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
# 12 "../rv64ui/sb.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: la x1, tdat; li x2, 0xffffffffffffffaa; sb x2, 0(x1); lb x30, 0(x1);; li x29, ((0xffffffffffffffaa) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x30, x29, fail;;
  test_3: la x1, tdat; li x2, 0x0000000000000000; sb x2, 1(x1); lb x30, 1(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x30, x29, fail;;
  test_4: la x1, tdat; li x2, 0xffffffffffffefa0; sb x2, 2(x1); lh x30, 2(x1);; li x29, ((0xffffffffffffefa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x30, x29, fail;;
  test_5: la x1, tdat; li x2, 0x000000000000000a; sb x2, 3(x1); lb x30, 3(x1);; li x29, ((0x000000000000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x30, x29, fail;;

  # Test with negative offset

  test_6: la x1, tdat8; li x2, 0xffffffffffffffaa; sb x2, -3(x1); lb x30, -3(x1);; li x29, ((0xffffffffffffffaa) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x30, x29, fail;;
  test_7: la x1, tdat8; li x2, 0x0000000000000000; sb x2, -2(x1); lb x30, -2(x1);; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne x30, x29, fail;;
  test_8: la x1, tdat8; li x2, 0xffffffffffffffa0; sb x2, -1(x1); lb x30, -1(x1);; li x29, ((0xffffffffffffffa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 8; bne x30, x29, fail;;
  test_9: la x1, tdat8; li x2, 0x000000000000000a; sb x2, 0(x1); lb x30, 0(x1);; li x29, ((0x000000000000000a) & ((1 << (32 - 1) << 1) - 1)); li gp, 9; bne x30, x29, fail;;

  # Test with a negative base

  test_10: la x1, tdat9; li x2, 0x12345678; addi x4, x1, -32; sb x2, 32(x4); lb x5, 0(x1);; li x29, ((0x78) & ((1 << (32 - 1) << 1) - 1)); li gp, 10; bne x5, x29, fail;







  # Test with unaligned base

  test_11: la x1, tdat9; li x2, 0x00003098; addi x1, x1, -6; sb x2, 7(x1); la x4, tdat10; lb x5, 0(x4);; li x29, ((0xffffffffffffff98) & ((1 << (32 - 1) << 1) - 1)); li gp, 11; bne x5, x29, fail;
# 53 "../rv64ui/sb.S"
  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_12: li gp, 12; li x4, 0; 1: li x1, 0xffffffffffffffdd; la x2, tdat; sb x1, 0(x2); lb x30, 0(x2); li x29, 0xffffffffffffffdd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_13: li gp, 13; li x4, 0; 1: li x1, 0xffffffffffffffcd; la x2, tdat; nop; sb x1, 1(x2); lb x30, 1(x2); li x29, 0xffffffffffffffcd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_14: li gp, 14; li x4, 0; 1: li x1, 0xffffffffffffffcc; la x2, tdat; nop; nop; sb x1, 2(x2); lb x30, 2(x2); li x29, 0xffffffffffffffcc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_15: li gp, 15; li x4, 0; 1: li x1, 0xffffffffffffffbc; nop; la x2, tdat; sb x1, 3(x2); lb x30, 3(x2); li x29, 0xffffffffffffffbc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li gp, 16; li x4, 0; 1: li x1, 0xffffffffffffffbb; nop; la x2, tdat; nop; sb x1, 4(x2); lb x30, 4(x2); li x29, 0xffffffffffffffbb; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li gp, 17; li x4, 0; 1: li x1, 0xffffffffffffffab; nop; nop; la x2, tdat; sb x1, 5(x2); lb x30, 5(x2); li x29, 0xffffffffffffffab; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_18: li gp, 18; li x4, 0; 1: la x2, tdat; li x1, 0x33; sb x1, 0(x2); lb x30, 0(x2); li x29, 0x33; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_19: li gp, 19; li x4, 0; 1: la x2, tdat; li x1, 0x23; nop; sb x1, 1(x2); lb x30, 1(x2); li x29, 0x23; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_20: li gp, 20; li x4, 0; 1: la x2, tdat; li x1, 0x22; nop; nop; sb x1, 2(x2); lb x30, 2(x2); li x29, 0x22; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_21: li gp, 21; li x4, 0; 1: la x2, tdat; nop; li x1, 0x12; sb x1, 3(x2); lb x30, 3(x2); li x29, 0x12; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_22: li gp, 22; li x4, 0; 1: la x2, tdat; nop; li x1, 0x11; nop; sb x1, 4(x2); lb x30, 4(x2); li x29, 0x11; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_23: li gp, 23; li x4, 0; 1: la x2, tdat; nop; nop; li x1, 0x01; sb x1, 5(x2); lb x30, 5(x2); li x29, 0x01; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  li a0, 0xef
  la a1, tdat
  sb a0, 3(a1)

  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

tdat:
tdat1: .byte 0xef
tdat2: .byte 0xef
tdat3: .byte 0xef
tdat4: .byte 0xef
tdat5: .byte 0xef
tdat6: .byte 0xef
tdat7: .byte 0xef
tdat8: .byte 0xef
tdat9: .byte 0xef
tdat10: .byte 0xef

.align 4; .global end_signature; end_signature:
# 8 "sb.S" 2
