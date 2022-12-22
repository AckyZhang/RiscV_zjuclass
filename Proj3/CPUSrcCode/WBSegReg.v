`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: WBSegReg
// Description: Write Back Segment Register
//////////////////////////////////////////////////////////////////////////////////
module WBSegReg(
    input wire clk,
    input wire en,
    input wire clear,
    //Data Memory Access
    input wire [31:0] A,
    input wire [31:0] WD,
    input wire [3:0] WE,
    output wire [31:0] RD,
    output reg [1:0] LoadedBytesSelect,
    //input control signals
    input wire [31:0] ResultM,
    output reg [31:0] ResultW, 
    input wire [4:0] RdM,
    output reg [4:0] RdW,
    //output constrol signals
    input wire [2:0] RegWriteM,
    output reg [2:0] RegWriteW,
    input wire MemToRegM,
    output reg MemToRegW,
    output wire DCacheMiss
    );
    // Add clear and stall support
    // if chip not enabled, output output last read result
    // else if chip clear, output 0
    // else output values from bram
    // 以下部分无需修改
    reg stall_ff= 1'b0;
    reg clear_ff= 1'b0;
    reg [31:0] RD_old=32'b0;
    wire [31:0] RD_raw;
    always @ (posedge clk)
    begin
        stall_ff<=~en;
        clear_ff<=clear;
        RD_old<=RD;
    end    
    assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );
    //
    initial begin
        LoadedBytesSelect = 2'b00;
        RegWriteW         =  1'b0;
        MemToRegW         =  1'b0;
        ResultW           =     0;
        RdW               =  5'b0;
    end
    //
    always@(posedge clk)
        if(en) begin
            LoadedBytesSelect <= clear ? 2'b00 : A[1:0];
            RegWriteW         <= clear ?  1'b0 : RegWriteM;
            MemToRegW         <= clear ?  1'b0 : MemToRegM;
            ResultW           <= clear ?     0 : ResultM;
            RdW               <= clear ?  5'b0 : RdM;
        end
reg [31:0] hit_count = 0, miss_count = 0;  // counter for cache miss and hit times
reg [31:0] last_addr = 0;   // 
wire cache_rd_wr = (|WE) | MemToRegM;
always @ (posedge clk or posedge clear) begin
    if(clear) begin
        last_addr  <= 0;
    end else begin
        if( cache_rd_wr ) begin
            last_addr <= A;
        end
    end
end

always @ (posedge clk or posedge clear) begin
    if(clear) begin
        hit_count  <= 0;
        miss_count <= 0;
    end else begin
        if( cache_rd_wr & (last_addr!=A) ) begin
            if(DCacheMiss)
                miss_count <= miss_count+1;
            else
                hit_count  <= hit_count +1;
        end
    end
end


    cache #(
    .LINE_ADDR_LEN  ( 3             ),
    .SET_ADDR_LEN   ( 2             ),
    .TAG_ADDR_LEN   ( 8            ),
    .WAY_CNT        ( 8             )
) cache_test_instance (
    .clk            ( clk           ),
    .rst            ( clear         ),
    .miss           ( DCacheMiss    ),
    .addr           ( A       ),
    .rd_req         ( MemToRegM     ),
    .rd_data        ( RD_raw        ),
    .wr_req         ( |WE           ),
    .wr_data        ( WD            )
);

endmodule

//功能说明
    //WBSegReg是Write Back段寄存器�?
    //类似于IDSegReg.V中对Bram的调用和拓展，它同时包含了一个同步读写的Bram
    //（此处你可以调用我们提供的InstructionRam，它将会自动综合为block memory，你也可以替代�?�的调用xilinx的bram ip核）�?
    //同步读memory 相当�? 异步读memory 的输出外接D触发器，�?要时钟上升沿才能读取数据�?
    //此时如果再�?�过段寄存器缓存，那么需要两个时钟上升沿才能将数据传递到Ex�?
    //因此在段寄存器模块中调用该同步memory，直接将输出传�?�到WB段组合�?�辑
    //调用mem模块后输出为RD_raw，�?�过assign RD = stall_ff ? RD_old : (clear_ff ? 32'b0 : RD_raw );
    //从�?�实现RD段寄存器stall和clear功能
//实验要求  
    //你需要补全上方代码，�?补全的片段截取如�?
    //DataRam DataRamInst (
    //    .clk    (???),                      //请补�?
    //    .wea    (???),                      //请补�?
    //    .addra  (???),                      //请补�?
    //    .dina   (???),                      //请补�?
    //    .douta  ( RD_raw         ),
    //    .web    ( WE2            ),
    //    .addrb  ( A2[31:2]       ),
    //    .dinb   ( WD2            ),
    //    .doutb  ( RD2            )
    //);   
//注意事项
    //输入到DataRam的addra是字地址，一个字32bit
    //请配合DataExt模块实现非字对齐字节load
    //请�?�过补全代码实现非字对齐store