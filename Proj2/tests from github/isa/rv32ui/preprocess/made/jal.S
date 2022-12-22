# 1 "jal.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "jal.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "jal.S" 2



# 1 "../rv64ui/jal.S" 1
# See LICENSE for license details.

#*****************************************************************************
# jal.S
#-----------------------------------------------------------------------------

# Test jal instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/jal.S" 2
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
# 12 "../rv64ui/jal.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

test_2:
  li gp, 2
  li ra, 0

  jal x4, target_2
linkaddr_2:
  nop
  nop

  j fail

target_2:
  la x2, linkaddr_2
  bne x2, x4, fail

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  test_3: li ra, 1; jal x0, 1f; addi ra, ra, 1; addi ra, ra, 1; addi ra, ra, 1; addi ra, ra, 1; 1: addi ra, ra, 1; addi ra, ra, 1;; li x29, ((3) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne ra, x29, fail;
# 50 "../rv64ui/jal.S"
  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "jal.S" 2
