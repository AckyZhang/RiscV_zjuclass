# 1 "auipc.S"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "auipc.S"
# See LICENSE for license details.

# 1 "riscv_test.h" 1





# 1 "./encoding.h" 1
# 7 "riscv_test.h" 2
# 4 "auipc.S" 2



# 1 "../rv64ui/auipc.S" 1
# See LICENSE for license details.

#*****************************************************************************
# auipc.S
#-----------------------------------------------------------------------------

# Test auipc instruction.


# 1 "../rv64ui/riscv_test.h" 1
# 11 "../rv64ui/auipc.S" 2
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
# 12 "../rv64ui/auipc.S" 2


.section .text; .align 6; .globl _start; _start: addi zero,zero, 0

  test_2: .align 3; lla a0, 1f + 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x29, ((10000) & ((1 << (32 - 1) << 1) - 1)); li gp, 2; bne a0, x29, fail;






  test_3: .align 3; lla a0, 1f - 10000; jal a1, 1f; 1: sub a0, a0, a1;; li x29, ((-10000) & ((1 << (32 - 1) << 1) - 1)); li gp, 3; bne a0, x29, fail;






  bne x0, gp, pass; fail: finish2: jal x20,finish2; pass: li gp,1;finish1: jal x20,finish1

unimp

  .data
 .pushsection .tohost,"aw",@progbits; .align 6; .global tohost; tohost: .dword 0; .align 6; .global fromhost; fromhost: .dword 0; .popsection; .align 4; .global begin_signature; begin_signature:

 

.align 4; .global end_signature; end_signature:
# 8 "auipc.S" 2
