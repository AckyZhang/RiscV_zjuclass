# 1 "beq.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "beq.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "beq.S" 2



# 1 "../rv64ui/beq.S" 1
# See LICENSE for license details.

#*****************************************************************************
# beq.S
#-----------------------------------------------------------------------------

# Test beq instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/beq.S" 2
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
# 12 "../rv64ui/beq.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Branch tests
  #-------------------------------------------------------------

  # Each test checks both forward and backward branches

  test_2: li gp, 2; li x1, 0; li x2, 0; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;
  test_3: li gp, 3; li x1, 1; li x2, 1; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;
  test_4: li gp, 4; li x1, -1; li x2, -1; beq x1, x2, 2f; bne x0, gp, fail; 1: bne x0, gp, 3f; 2: beq x1, x2, 1b; bne x0, gp, fail; 3:;

  test_5: li gp, 5; li x1, 0; li x2, 1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_6: li gp, 6; li x1, 1; li x2, 0; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_7: li gp, 7; li x1, -1; li x2, 1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;
  test_8: li gp, 8; li x1, 1; li x2, -1; beq x1, x2, 1f; bne x0, gp, 2f; 1: bne x0, gp, fail; 2: beq x1, x2, 1b; 3:;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_9: li gp, 9; li x4, 0; 1: li x1, 0; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_10: li gp, 10; li x4, 0; 1: li x1, 0; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_11: li gp, 11; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_12: li gp, 12; li x4, 0; 1: li x1, 0; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_13: li gp, 13; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_14: li gp, 14; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  test_15: li gp, 15; li x4, 0; 1: li x1, 0; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_16: li gp, 16; li x4, 0; 1: li x1, 0; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_17: li gp, 17; li x4, 0; 1: li x1, 0; li x2, -1; nop; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_18: li gp, 18; li x4, 0; 1: li x1, 0; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_19: li gp, 19; li x4, 0; 1: li x1, 0; nop; li x2, -1; nop; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_20: li gp, 20; li x4, 0; 1: li x1, 0; nop; nop; li x2, -1; beq x1, x2, fail; addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_21: li x1, 1; beq x0, x0, 1f; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; addi x1, x1, 1; 1: addi x1, x1, 1; addi x1, x1, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 21; bne x1, x29, fail;
# 64 "../rv64ui/beq.S"
  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "beq.S" 2
