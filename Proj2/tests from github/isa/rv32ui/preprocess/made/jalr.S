# 1 "jalr.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "jalr.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "jalr.S" 2



# 1 "../rv64ui/jalr.S" 1
# See LICENSE for license details.

#*****************************************************************************
# jalr.S
#-----------------------------------------------------------------------------

# Test jalr instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/jalr.S" 2
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
# 12 "../rv64ui/jalr.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Test 2: Basic test
  #-------------------------------------------------------------

test_2:
  li gp, 2
  li t0, 0
  la t1, target_2

  jalr t0, t1, 0
linkaddr_2:
  j fail

target_2:
  la t1, linkaddr_2
  bne t0, t1, fail

  #-------------------------------------------------------------
  # Test 3: Basic test2, rs = rd
  #-------------------------------------------------------------

test_3:
  li gp, 3
  la t0, target_3

  jalr t0, t0, 0
linkaddr_3:
  j fail

target_3:
  la t1, linkaddr_3
  bne t0, t1, fail

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_4: li gp, 4; li x4, 0; 1: la x6, 2f; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_5: li gp, 5; li x4, 0; 1: la x6, 2f; nop; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;
  test_6: li gp, 6; li x4, 0; 1: la x6, 2f; nop; nop; jalr x19, x6, 0; bne x0, gp, fail; 2: addi x4, x4, 1; li x5, 2; bne x4, x5, 1b;

  #-------------------------------------------------------------
  # Test delay slot instructions not executed nor bypassed
  #-------------------------------------------------------------

  .option push
  .align 2
  .option norvc
  test_7: li t0, 1; la t1, 1f; jr t1, -4; addi t0, t0, 1; addi t0, t0, 1; addi t0, t0, 1; addi t0, t0, 1; 1: addi t0, t0, 1; addi t0, t0, 1;; li x29, ((4) & ((1 << (32 - 1) << 1) - 1)); li gp, 7; bne t0, x29, fail;
# 75 "../rv64ui/jalr.S"
  .option pop

  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "jalr.S" 2
