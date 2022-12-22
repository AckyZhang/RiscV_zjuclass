`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ALU
// Description: ALU unit of RISCV CPU
//////////////////////////////////////////////////////////////////////////////////
`include "Parameters.v"   
module ALU(
    input wire [31:0] Operand1,
    input wire [31:0] Operand2,
    input wire [4:0] AluContrl,
    input wire alu_vec,
    output reg [31:0] AluOut
    );
    wire [4:0] AluCon;
    assign AluCon[4:1] = AluContrl[4:1];
    assign AluCon[0] = alu_vec;

    reg [7:0] vec1 [3:0];
    reg [7:0] vec2 [3:0];
    reg [7:0] vecout [3:0];
    integer i;
    
    always@(*)
    begin
        {vec1[3], vec1[2], vec1[1], vec1[0]} = Operand1;
        {vec2[3], vec2[2], vec2[1], vec2[0]} = Operand2;
        case (AluCon)
            `SLL:        AluOut<=Operand1 << Operand2[4:0]; 
            `SRL:        AluOut<=Operand1 >> Operand2[4:0]; 
            `SRA:        AluOut<=$signed(Operand1) >>> Operand2[4:0]; 
            `ADD:        AluOut<=Operand1 + Operand2; 
            `SUB:        AluOut<=Operand1 - Operand2; 
            `XOR:        AluOut<=Operand1 ^ Operand2; 
            `OR:         AluOut<=Operand1 | Operand2; 
            `AND:        AluOut<=Operand1 & Operand2; 
            `SLT:        AluOut<=($signed(Operand1) < $signed(Operand2)) ? 32'b1:32'b0; 
            `SLTU:       AluOut<=(Operand1 < Operand2) ? 32'b1:32'b0; 
            `LUI:        AluOut<={Operand2[31:12], 12'b0}; 
            `VECSLL:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] << vec2[i][4:0]; 
            `VECSRL:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] >> vec2[i][4:0]; 
            `VECSRA:     for(i=0;i<4;i=i+1) vecout[i]<=$signed(vec1[i]) >>> vec2[i][4:0]; 
            `VECADD:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] + vec2[i]; 
            `VECSUB:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] - vec2[i]; 
            `VECXOR:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] ^ vec2[i]; 
            `VECOR:      for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] | vec2[i]; 
            `VECAND:     for(i=0;i<4;i=i+1) vecout[i]<=vec1[i] & vec2[i]; 
            `VECSLT:     for(i=0;i<4;i=i+1) vecout[i]<=($signed(vec1[i]) < $signed(vec2[i])) ? 32'b1:32'b0; 
            `VECSLTU:    for(i=0;i<4;i=i+1) vecout[i]<=(vec1[i] < vec2[i]) ? 32'b1:32'b0; 
            default:     AluOut<=32'hxxxxxxxx;
        endcase         
        if (alu_vec)
            begin
            AluOut <= {vecout[3][7:0], vecout[2][7:0], vecout[1][7:0], vecout[0][7:0]};
            end
    end
endmodule

//功能和接口说�?
	//ALU接受两个操作数，根据AluContrl的不同，进行不同的计算操作，将计算结果输出到AluOut
	//AluContrl的类型定义在Parameters.v�?
//推荐格式�?
    //case()
    //    `ADD:        AluOut<=Operand1 + Operand2; 
    //   	.......
    //    default:    AluOut <= 32'hxxxxxxxx;                          
    //endcase
//实验要求  
    //实现ALU模块
	//实现SIMD模块用到的指�?