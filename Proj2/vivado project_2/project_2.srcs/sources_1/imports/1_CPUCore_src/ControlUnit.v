`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ControlUnit
// Description: RISC-V Instruction Decoder
//////////////////////////////////////////////////////////////////////////////////
`include "Parameters.v"   
module ControlUnit(
    input wire [6:0] Op,
    input wire [2:0] Fn3,
    input wire [6:0] Fn7,
    output wire JalD,
    output wire JalrD,
    output reg [2:0] RegWriteD,
    output wire MemToRegD,
    output reg [3:0] MemWriteD,
    output wire LoadNpcD,
    output reg [1:0] RegReadD,
    output reg [2:0] BranchTypeD,
    output reg [3:0] AluContrlD,
    output wire [1:0] AluSrc2D,
    output wire AluSrc1D,
    output reg [2:0] ImmType        
    );
//assign wire
//assign wire
    assign JalD = (Op == 7'b1101111) ? 1'b1:1'b0;
    assign JalrD = (Op == 7'b1100111) ? 1'b1:1'b0;
    assign MemToRegD = (Op == 7'b0000011) ? 1'b1:1'b0;
    assign LoadNpcD = ((Op == 7'b1101111)||(Op == 7'b1100111)) ? 1'b1:1'b0;
    assign AluSrc2D = ((Op == 7'b0010011)&&(Fn3[1:0] == 2'b01)) ? (2'b01) : (((Op == 7'b0110011)||(Op == 7'b1100011)) ? 2'b00 : 2'b10);//00:ForwardData2 01:Rs2E 10:Imm
    assign AluSrc1D = (Op == 7'b0010111) ? 1'b1:1'b0;//0:ForwardData1 1:PC

//sequence:R-type,I-type,S-type,B-type,U-type,J-type
//output reg    output sequence:
//                    ImmType
//                    RegWriteD
//                    MemWriteD
//                    RegReadD
//                    BranchTypeD
//                    AluContrlD
    always@(*)
    begin
        case(Op)
            7'b0110011:    //R-TYPE 
                begin
                    ImmType <= `RTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b11;
                    BranchTypeD <= `NOBRANCH;
//                  AluContrlD <= CASE BELOW;
                    case(Fn3)
                        3'b000:    //ADD or SUB
                            AluContrlD <= (Fn7 == 7'b0) ? (`ADD):(`SUB);
                        3'b001:    //SLL
                            AluContrlD <= `SLL;
                        3'b010:    //SLT
                            AluContrlD <= `SLT;
                        3'b011:    //SLTU
                            AluContrlD <= `SLTU;
                        3'b100:    //XOR
                            AluContrlD <= `XOR;
                        3'b101:    //SRL or SRA
                            AluContrlD <= (Fn7 == 7'b0) ? (`SRL):(`SRA);
                        3'b110:    //OR
                            AluContrlD <= `OR;
                        3'b111:    //AND
                            AluContrlD <= `AND;
                    endcase
                end
            7'b0010011:     //I-Type (ALU) 
                begin
                    ImmType <= `ITYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b10;
                    BranchTypeD <= `NOBRANCH;
//                  AluContrlD <= CASE BELOW;
                    case(Fn3)
                        3'b000:    //ADDI
                            AluContrlD <= `ADD;
                        3'b001:    //SLLI
                            AluContrlD <= `SLL;
                        3'b010:    //SLTI
                            AluContrlD <= `SLT;
                        3'b011:    //SLTUI
                            AluContrlD <= `SLTU;
                        3'b100:    //XORI
                            AluContrlD <= `XOR;
                        3'b101:    //SRLI or SRAI
                            AluContrlD <= (Fn7 == 7'b0) ? (`SRL):(`SRA);
                        3'b110:    //ORI
                            AluContrlD <= `OR;
                        3'b111:    //ANDI
                            AluContrlD <= `AND;
                    endcase
                end
            7'b0000011:    //I-Type (LOAD) 
                begin
                    ImmType <= `ITYPE;
//                  RegWriteD <= CASE BELOW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b10;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                    case(Fn3)
                        3'b000:    //LB
                            RegWriteD <= `LB;
                        3'b001:    //LH
                            RegWriteD <= `LH;
                        3'b010:    //LW
                            RegWriteD <= `LW;
                        3'b100: //LBU
                            RegWriteD <= `LBU;
                        3'b101: //LHU
                            RegWriteD <= `LHU;
                        default:
                            RegWriteD <= `NOREGWRITE;
                    endcase
                end
            7'b1100111: //I-Type (JALR) 
                begin
                    ImmType <= `ITYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b10;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                end
            7'b0100011:    //S-Type
                begin
                    ImmType <= `STYPE; 
                    RegWriteD <= `NOREGWRITE;
//                  MemWriteD <= CASE BELOW;
                    RegReadD <= 2'b11;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                    case(Fn3)
                        3'b000:    //SB
                            MemWriteD <= 4'b0001;
                        3'b001:    //SH
                            MemWriteD <= 4'b0011;
                        3'b010:    //SW
                            MemWriteD <= 4'b1111;
                    endcase
                end
            7'b1100011:    //B-Type
                begin
                    ImmType <= `BTYPE;
                    RegWriteD <= `NOREGWRITE;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b11;
//                  BranchTypeD <= `BEQ;
                    AluContrlD <= `ADD;
                    case(Fn3)
                        3'b000:    //BEQ
                            BranchTypeD <= `BEQ;
                        3'b001:    //BNE
                            BranchTypeD <= `BNE;
                        3'b100:    //BLT
                            BranchTypeD <= `BLT;
                        3'b101:    //BGE
                            BranchTypeD <= `BGE;
                        3'b110:    //BLTU
                            BranchTypeD <= `BLTU;
                        3'b111:    //BGEU
                            BranchTypeD <= `BGEU;
                        default:    //NOBRANCH
                            BranchTypeD <= `NOBRANCH;
                    endcase
                end
            7'b0110111:    //U-Type (LUI)
                begin
                    ImmType <= `UTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `LUI;
                end
            7'b0010111:    //U-Type (AUIPC)
                begin
                    ImmType <= `UTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                end
            7'b1101111:    //J-Type (JAL)
                begin
                    ImmType <= `JTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                end
            default:    //NOP
                begin
                    ImmType <= `ITYPE;
                    RegWriteD <= `NOREGWRITE;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;                    
                end
        endcase
    end
endmodule


//功能说明
    //ControlUnit       是本CPU的指令译码器，组合逻辑电路
//输入
    // Op               是指令的操作码部分
    // Fn3              是指令的func3部分
    // Fn7              是指令的func7部分
//输出
    // JalD==1          表示Jal指令到达ID译码阶段
    // JalrD==1         表示Jalr指令到达ID译码阶段
    // RegWriteD        表示ID阶段的指令对应的 寄存器写入模式 ，所有模式定义在Parameters.v中
    // MemToRegD==1     表示ID阶段的指令需要将data memory读取的值写入寄存器,
    // MemWriteD        共4bit，采用独热码格式，对于data memory的32bit字按byte进行写入,MemWriteD=0001表示只写入最低1个byte，和xilinx bram的接口类似
    // LoadNpcD==1      表示将NextPC输出到ResultM
    // RegReadD[1]==1   表示A1对应的寄存器值被使用到了，RegReadD[0]==1表示A2对应的寄存器值被使用到了，用于forward的处理
    // BranchTypeD      表示不同的分支类型，所有类型定义在Parameters.v中
    // AluContrlD       表示不同的ALU计算功能，所有类型定义在Parameters.v中
    // AluSrc2D         表示Alu输入源2的选择
    // AluSrc1D         表示Alu输入源1的选择
    // ImmType          表示指令的立即数格式，所有类型定义在Parameters.v中   
//实验要求  
    //实现ControlUnit模块   