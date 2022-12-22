`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB (Embeded System Lab)
// Engineer: Haojun Xia
// Create Date: 2019/02/08
// Design Name: RISCV-Pipline CPU
// Module Name: 
// Target Devices: Nexys4
// Tool Versions: Vivado 2017.4.1
// Description: Define some constant values
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONST_VALUES
`define CONST_VALUES
//ALUContrl[4:0]
    `define ADD     5'b00000
    `define SLL     5'b00010
    `define SLT     5'b00100
    `define SLTU    5'b00110
    `define XOR     5'b01000
    `define SRL     5'b01010
    `define OR      5'b01100
    `define AND     5'b01110
    `define SUB     5'b10000
    `define SRA     5'b11010
    `define LUI     5'b10100
    `define VECADD  5'b00001
    `define VECSLL  5'b00011
    `define VECSLT  5'b00101
    `define VECSLTU 5'b00111
    `define VECXOR  5'b01001
    `define VECSRL  5'b01011
    `define VECOR   5'b01101
    `define VECAND  5'b01111
    `define VECSUB  5'b10001
    `define VECSRA  5'b11011
    `define VECLUI  5'b10101
//BranchType[2:0]
    `define NOBRANCH  3'b000
    `define BEQ  3'b110
    `define BNE  3'b111
    `define BLT  3'b010
    `define BGE  3'b011
    `define BLTU  3'b100
    `define BGEU  3'b101
//ImmType[2:0]
    `define RTYPE  3'd0
    `define ITYPE  3'd1
    `define STYPE  3'd2
    `define BTYPE  3'd3
    `define UTYPE  3'd4
    `define JTYPE  3'd5  
//RegWrite[2:0]  six kind of ways to save values to Register
    `define NOREGWRITE  3'b000	//	Do not write Register
    `define LB  3'b001			//	load 8bit from Mem then signed extended to 32bit
    `define LH  3'b010			//	load 16bit from Mem then signed extended to 32bit
    `define LW  3'b011			//	write 32bit to Register
    `define LBU  3'b101			//	load 8bit from Mem then unsigned extended to 32bit
    `define LHU  3'b110			//	load 16bit from Mem then unsigned extended to 32bit
`endif

//功能说明
    //为了代码可读性，定义了常量值
//实验要求  
    //无需修改