`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: NPC_Generator
// Description: Choose Next PC value
//////////////////////////////////////////////////////////////////////////////////
module NPC_Generator(
    input wire [31:0] PCF,JalrTarget, BranchTarget, JalTarget,
    input wire BranchE,JalD,JalrE,
    output reg [31:0] PC_In
    );
    always @(*)
    begin
        if(BranchE)
            PC_In <= BranchTarget;
        else if(JalrE)
            PC_In <= JalrTarget;
        else if(JalD)
            PC_In <= JalTarget;
        else
            PC_In <= PCF+4;
    end
endmodule
//功能说明
    //NPC_Generator是用来生成Next PC值得模块，根据不同的跳转信号选择不同的新PC值
//输入
    //PCF              旧的PC值
    //JalrTarget       jalr指令的对应的跳转目标
    //BranchTarget     branch指令的对应的跳转目标
    //JalTarget        jal指令的对应的跳转目标
    //BranchE==1       Ex阶段的Branch指令确定跳转
    //JalD==1          ID阶段的Jal指令确定跳转
    //JalrE==1         Ex阶段的Jalr指令确定跳转
//输出
    //PC_In            NPC的值
//实验要求  
    //实现NPC_Generator模块  