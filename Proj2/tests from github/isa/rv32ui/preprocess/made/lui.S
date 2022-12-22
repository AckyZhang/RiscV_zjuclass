# 1 "lui.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "lui.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "lui.S" 2



# 1 "../rv64ui/lui.S" 1
# See LICENSE for license details.

#*****************************************************************************
# lui.S
#-----------------------------------------------------------------------------

# Test lui instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/lui.S" 2
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
# 12 "../rv64ui/lui.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  test_2: lui x1, 0x00000; li x29, ((0x0000000000000000) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne x1, x29, fail;;
  test_3: lui x1, 0xfffff;sra x1,x1,1; li x29, ((0xfffffffffffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne x1, x29, fail;;
  test_4: lui x1, 0x7ffff;sra x1,x1,20; li x29, ((0x00000000000007ff) & ((1 << (32 - 1) << 1) - 1)); li gp, 4; bne x1, x29, fail;;
  test_5: lui x1, 0x80000;sra x1,x1,20; li x29, ((0xfffffffffffff800) & ((1 << (32 - 1) << 1) - 1)); li gp, 5; bne x1, x29, fail;;

  test_6: lui x0, 0x80000; li x29, ((0) & ((1 << (32 - 1) << 1) - 1)); li gp, 6; bne x0, x29, fail;;

  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "lui.S" 2
