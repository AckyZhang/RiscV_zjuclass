`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ControlUnit
// Description: RISC-V Instruction Decoder
//////////////////////////////////////////////////////////////////////////////////
`include "Parameters.v"
`define OP_JAL    7'b1101111 //JAL的操作码
`define OP_JALR   7'b1100111 //JALR的操作码
`define OP_Load   7'b0000011 //Load类指令的操作�?
`define OP_Store  7'b0100011 //Store类指令的操作�?
`define OP_Branch 7'b1100011 //Branch类指令的操作�?
`define OP_LUI    7'b0110111 //LUI的操作码
`define OP_AUIPC  7'b0010111 //AUIPC的操作码
`define OP_RegReg 7'b0110011 //寄存�?-寄存器算术指令的操作�?
`define OP_RegImm 7'b0010011 //寄存�?-立即数算术指令的操作�?
`define OP_vecReg 7'b1010111 //向量操作指令的操作码
`define OP_vecImm 7'b1010110 //向量操作指令的操作码(立即数操�?)
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
    output reg [4:0] AluContrlD,
    output wire [1:0] AluSrc2D,
    output wire AluSrc1D, alu_vec_id,
    output reg [2:0] ImmType
    );

    assign JalD       = (Op == `OP_JAL) ? 1'b1:1'b0;
    assign JalrD      = (Op == `OP_JALR) ? 1'b1:1'b0;
    assign MemToRegD  = (Op == `OP_Load) ? 1'b1:1'b0;
    assign LoadNpcD   = ((Op == `OP_JAL)||(Op == `OP_JALR)) ? 1'b1:1'b0;
    assign AluSrc2D   = (((Op == `OP_RegImm)||(Op == `OP_vecImm))&&(Fn3[1:0] == 2'b01)) ? (2'b01) : (((Op == `OP_RegReg)||(Op == `OP_vecReg)||(Op == `OP_Branch)) ? 2'b00 : 2'b10);//00:ForwardData2 01:Rs2E 10:Imm
    assign AluSrc1D   = (Op == `OP_AUIPC) ? 1'b1:1'b0;//0:ForwardData1 1:PC
    assign alu_vec_id = ((Op == `OP_vecReg)||(Op ==`OP_vecImm)) ? 1'b1:1'b0;

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
            `OP_RegReg,
            `OP_vecReg:    //R-TYPE Reg-Reg/vec
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
            `OP_RegImm,
            `OP_vecImm:     //I-Type (ALU) Reg-Imm/vecImm
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
            `OP_Load:    //I-Type (LOAD) 
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
            `OP_JALR: //I-Type (JALR) 
                begin
                    ImmType <= `ITYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b10;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                end
            `OP_Store:    //S-Type
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
                        default:
                            MemWriteD <= 4'b0000;
                    endcase
                end
            `OP_Branch:    //B-Type
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
            `OP_LUI:    //U-Type (LUI)
                begin
                    ImmType <= `UTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `LUI;
                end
            `OP_AUIPC:    //U-Type (AUIPC)
                begin
                    ImmType <= `UTYPE;
                    RegWriteD <= `LW;
                    MemWriteD <= 4'b0000;
                    RegReadD <= 2'b00;
                    BranchTypeD <= `NOBRANCH;
                    AluContrlD <= `ADD;
                end
            `OP_JAL:    //J-Type (JAL)
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
    //ControlUnit       是本CPU的指令译码器，组合�?�辑电路
//输入
    // Op               是指令的操作码部�?
    // Fn3              是指令的func3部分
    // Fn7              是指令的func7部分
//输出
    // JalD==1          表示Jal指令到达ID译码阶段
    // JalrD==1         表示Jalr指令到达ID译码阶段
    // RegWriteD        表示ID阶段的指令对应的寄存器写入模�? ，所有模式定义在Parameters.v�?
    // MemToRegD==1     表示ID阶段的指令需要将data memory读取的�?�写入寄存器,
    // MemWriteD        �?4bit，采用独热码格式，对于data memory�?32bit字按byte进行写入,MemWriteD=0001表示只写入最�?1个byte，和xilinx bram的接口类�?
    // LoadNpcD==1      表示将NextPC输出到ResultM
    // RegReadD[1]==1   表示A1对应的寄存器值被使用到了，RegReadD[0]==1表示A2对应的寄存器值被使用到了，用于forward的处�?
    // BranchTypeD      表示不同的分支类型，�?有类型定义在Parameters.v�?
    // AluContrlD       表示不同的ALU计算功能，所有类型定义在Parameters.v�?
    // AluSrc2D         表示Alu输入�?2的�?�择
    // AluSrc1D         表示Alu输入�?1的�?�择
    // ImmType          表示指令的立即数格式，所有类型定义在Parameters.v�?   
    // alu_vec_id       表示该条指令是否为向量扩展指�?