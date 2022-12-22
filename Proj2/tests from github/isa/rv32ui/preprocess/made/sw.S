# 1 "sw.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "sw.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "sw.S" 2



# 1 "../rv64ui/sw.S" 1
# See LICENSE for license details.

#*****************************************************************************
# sw.S
#-----------------------------------------------------------------------------

# Test sw instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/sw.S" 2
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
# 12 "../rv64ui/sw.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: la x1, tdat; li x2, 0x0000000000aa00aa; sw x2, 0(x1); lw x30, 0(x1);; li x29, ((0x0000000000aa00aa) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x30, x29, fail;;
  test_3: la x1, tdat; li x2, 0xffffffffaa00aa00; sw x2, 4(x1); lw x30, 4(x1);; li x29, ((0xffffffffaa00aa00) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x30, x29, fail;;
  test_4: la x1, tdat; li x2, 0x000000000aa00aa0; sw x2, 8(x1); lw x30, 8(x1);; li x29, ((0x000000000aa00aa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x30, x29, fail;;
  test_5: la x1, tdat; li x2, 0xffffffffa00aa00a; sw x2, 12(x1); lw x30, 12(x1);; li x29, ((0xffffffffa00aa00a) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x30, x29, fail;;

  # Test with negative offset

  test_6: la x1, tdat8; li x2, 0x0000000000aa00aa; sw x2, -12(x1); lw x30, -12(x1);; li x29, ((0x0000000000aa00aa) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x30, x29, fail;;
  test_7: la x1, tdat8; li x2, 0xffffffffaa00aa00; sw x2, -8(x1); lw x30, -8(x1);; li x29, ((0xffffffffaa00aa00) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne x30, x29, fail;;
  test_8: la x1, tdat8; li x2, 0x000000000aa00aa0; sw x2, -4(x1); lw x30, -4(x1);; li x29, ((0x000000000aa00aa0) & ((1 << (32 - 1) << 1) - 1)); li gp, 8; bne x30, x29, fail;;
  test_9: la x1, tdat8; li x2, 0xffffffffa00aa00a; sw x2, 0(x1); lw x30, 0(x1);; li x29, ((0xffffffffa00aa00a) & ((1 << (32 - 1) << 1) - 1)); li gp, 9; bne x30, x29, fail;;

  # Test with a negative base

  test_10: la x1, tdat9; li x2, 0x12345678; addi x4, x1, -32; sw x2, 32(x4); lw x5, 0(x1);; li x29, ((0x12345678) & ((1 << (32 - 1) << 1) - 1)); li gp, 10; bne x5, x29, fail;







  # Test with unaligned base

  test_11: la x1, tdat9; li x2, 0x58213098; addi x1, x1, -3; sw x2, 7(x1); la x4, tdat10; lw x5, 0(x4);; li x29, ((0x58213098) & ((1 << (32 - 1) << 1) - 1)); li gp, 11; bne x5, x29, fail;
# 53 "../rv64ui/sw.S"
  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_12: li gp, 12; li x4, 0; 1: li x1, 0xffffffffaabbccdd; la x2, tdat; sw x1, 0(x2); lw x30, 0(x2); li x29, 0xffffffffaabbccdd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_13: li gp, 13; li x4, 0; 1: li x1, 0xffffffffdaabbccd; la x2, tdat; nop; sw x1, 4(x2); lw x30, 4(x2); li x29, 0xffffffffdaabbccd; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_14: li gp, 14; li x4, 0; 1: li x1, 0xffffffffddaabbcc; la x2, tdat; nop; nop; sw x1, 8(x2); lw x30, 8(x2); li x29, 0xffffffffddaabbcc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_15: li gp, 15; li x4, 0; 1: li x1, 0xffffffffcddaabbc; nop; la x2, tdat; sw x1, 12(x2); lw x30, 12(x2); li x29, 0xffffffffcddaabbc; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li gp, 16; li x4, 0; 1: li x1, 0xffffffffccddaabb; nop; la x2, tdat; nop; sw x1, 16(x2); lw x30, 16(x2); li x29, 0xffffffffccddaabb; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li gp, 17; li x4, 0; 1: li x1, 0xffffffffbccddaab; nop; nop; la x2, tdat; sw x1, 20(x2); lw x30, 20(x2); li x29, 0xffffffffbccddaab; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_18: li gp, 18; li x4, 0; 1: la x2, tdat; li x1, 0x00112233; sw x1, 0(x2); lw x30, 0(x2); li x29, 0x00112233; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_19: li gp, 19; li x4, 0; 1: la x2, tdat; li x1, 0x30011223; nop; sw x1, 4(x2); lw x30, 4(x2); li x29, 0x30011223; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_20: li gp, 20; li x4, 0; 1: la x2, tdat; li x1, 0x33001122; nop; nop; sw x1, 8(x2); lw x30, 8(x2); li x29, 0x33001122; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_21: li gp, 21; li x4, 0; 1: la x2, tdat; nop; li x1, 0x23300112; sw x1, 12(x2); lw x30, 12(x2); li x29, 0x23300112; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_22: li gp, 22; li x4, 0; 1: la x2, tdat; nop; li x1, 0x22330011; nop; sw x1, 16(x2); lw x30, 16(x2); li x29, 0x22330011; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_23: li gp, 23; li x4, 0; 1: la x2, tdat; nop; nop; li x1, 0x12233001; sw x1, 20(x2); lw x30, 20(x2); li x29, 0x12233001; bne x30, x29, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

tdat:
tdat1: .word 0xdeadbeef
tdat2: .word 0xdeadbeef
tdat3: .word 0xdeadbeef
tdat4: .word 0xdeadbeef
tdat5: .word 0xdeadbeef
tdat6: .word 0xdeadbeef
tdat7: .word 0xdeadbeef
tdat8: .word 0xdeadbeef
tdat9: .word 0xdeadbeef
tdat10: .word 0xdeadbeef

.align 4; .global end_signature; end_signature:
# 8 "sw.S" 2
