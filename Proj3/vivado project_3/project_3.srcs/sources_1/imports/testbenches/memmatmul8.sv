
module mem #(                   // 
    parameter  ADDR_LEN  = 11   // 
) (
    input  clk, rst,
    input  [ADDR_LEN-1:0] addr, // memory address
    output reg [31:0] rd_data,  // data read out
    input  wr_req,
    input  [31:0] wr_data       // data write in
);
localparam MEM_SIZE = 1<<ADDR_LEN;
reg [31:0] ram_cell [MEM_SIZE];

always @ (posedge clk or posedge rst)
    if(rst)
        rd_data <= 0;
    else
        rd_data <= ram_cell[addr];

always @ (posedge clk)
    if(wr_req) 
        ram_cell[addr] <= wr_data;

initial begin
    // dst matrix C
    ram_cell[       0] = 32'h0;  // 32'h0a12087b;
    ram_cell[       1] = 32'h0;  // 32'hca9d756b;
    ram_cell[       2] = 32'h0;  // 32'h6fea444f;
    ram_cell[       3] = 32'h0;  // 32'hf7e2f107;
    ram_cell[       4] = 32'h0;  // 32'he41af7e6;
    ram_cell[       5] = 32'h0;  // 32'h63fdf1c0;
    ram_cell[       6] = 32'h0;  // 32'hadcafd60;
    ram_cell[       7] = 32'h0;  // 32'hf604b620;
    ram_cell[       8] = 32'h0;  // 32'he8d5d4f4;
    ram_cell[       9] = 32'h0;  // 32'h11a9f37b;
    ram_cell[      10] = 32'h0;  // 32'hb88cdfe1;
    ram_cell[      11] = 32'h0;  // 32'h76d274d3;
    ram_cell[      12] = 32'h0;  // 32'h83d9bf3c;
    ram_cell[      13] = 32'h0;  // 32'he115676c;
    ram_cell[      14] = 32'h0;  // 32'h6e51858f;
    ram_cell[      15] = 32'h0;  // 32'h79009f0b;
    ram_cell[      16] = 32'h0;  // 32'h20f726a0;
    ram_cell[      17] = 32'h0;  // 32'h1acdb2ca;
    ram_cell[      18] = 32'h0;  // 32'he5dee81d;
    ram_cell[      19] = 32'h0;  // 32'had3896b5;
    ram_cell[      20] = 32'h0;  // 32'h2d283061;
    ram_cell[      21] = 32'h0;  // 32'h47701514;
    ram_cell[      22] = 32'h0;  // 32'hc24165c2;
    ram_cell[      23] = 32'h0;  // 32'he82b86ce;
    ram_cell[      24] = 32'h0;  // 32'h5b947f55;
    ram_cell[      25] = 32'h0;  // 32'hde001f85;
    ram_cell[      26] = 32'h0;  // 32'h87cc41eb;
    ram_cell[      27] = 32'h0;  // 32'h6b9116f9;
    ram_cell[      28] = 32'h0;  // 32'h3086ba58;
    ram_cell[      29] = 32'h0;  // 32'h0f26d98d;
    ram_cell[      30] = 32'h0;  // 32'h1c2afda8;
    ram_cell[      31] = 32'h0;  // 32'h622a8f9e;
    ram_cell[      32] = 32'h0;  // 32'hed7db30c;
    ram_cell[      33] = 32'h0;  // 32'hb405669a;
    ram_cell[      34] = 32'h0;  // 32'h8ecf36b8;
    ram_cell[      35] = 32'h0;  // 32'h01984ca9;
    ram_cell[      36] = 32'h0;  // 32'heb3659df;
    ram_cell[      37] = 32'h0;  // 32'h7e715bab;
    ram_cell[      38] = 32'h0;  // 32'h1ac87210;
    ram_cell[      39] = 32'h0;  // 32'hba675956;
    ram_cell[      40] = 32'h0;  // 32'hb26c9a25;
    ram_cell[      41] = 32'h0;  // 32'h1f0022fb;
    ram_cell[      42] = 32'h0;  // 32'heb52213c;
    ram_cell[      43] = 32'h0;  // 32'h22093dd3;
    ram_cell[      44] = 32'h0;  // 32'hbe29efe5;
    ram_cell[      45] = 32'h0;  // 32'h17d511ef;
    ram_cell[      46] = 32'h0;  // 32'ha4c48259;
    ram_cell[      47] = 32'h0;  // 32'h962c44e4;
    ram_cell[      48] = 32'h0;  // 32'h6b63c13d;
    ram_cell[      49] = 32'h0;  // 32'h56ff7a44;
    ram_cell[      50] = 32'h0;  // 32'hfc60e7bd;
    ram_cell[      51] = 32'h0;  // 32'hb0f90669;
    ram_cell[      52] = 32'h0;  // 32'h90d47d25;
    ram_cell[      53] = 32'h0;  // 32'ha7a8be86;
    ram_cell[      54] = 32'h0;  // 32'h41930831;
    ram_cell[      55] = 32'h0;  // 32'h86bda4a7;
    ram_cell[      56] = 32'h0;  // 32'h4b967def;
    ram_cell[      57] = 32'h0;  // 32'h1cf06349;
    ram_cell[      58] = 32'h0;  // 32'h4b8ae9e5;
    ram_cell[      59] = 32'h0;  // 32'hfa1074d3;
    ram_cell[      60] = 32'h0;  // 32'h158ffe80;
    ram_cell[      61] = 32'h0;  // 32'hf6e8b6a0;
    ram_cell[      62] = 32'h0;  // 32'ha6174b9b;
    ram_cell[      63] = 32'h0;  // 32'h86d74878;
    // src matrix A
    ram_cell[      64] = 32'hf9a0de84;
    ram_cell[      65] = 32'hd47764dd;
    ram_cell[      66] = 32'hf465a437;
    ram_cell[      67] = 32'hcf663d74;
    ram_cell[      68] = 32'hf05d89e7;
    ram_cell[      69] = 32'ha243a041;
    ram_cell[      70] = 32'ha4656bf3;
    ram_cell[      71] = 32'h885090e4;
    ram_cell[      72] = 32'h10cacafc;
    ram_cell[      73] = 32'h9e3d9fb8;
    ram_cell[      74] = 32'hba520335;
    ram_cell[      75] = 32'hb8bc13cd;
    ram_cell[      76] = 32'h72629be2;
    ram_cell[      77] = 32'hb9c24588;
    ram_cell[      78] = 32'h1b057313;
    ram_cell[      79] = 32'hc940aa91;
    ram_cell[      80] = 32'h79d1ff50;
    ram_cell[      81] = 32'h4f02bcea;
    ram_cell[      82] = 32'h3d06f5b1;
    ram_cell[      83] = 32'h07447618;
    ram_cell[      84] = 32'h909b5d5e;
    ram_cell[      85] = 32'h63c684a8;
    ram_cell[      86] = 32'h1502d283;
    ram_cell[      87] = 32'h0f291fc1;
    ram_cell[      88] = 32'h67152b5f;
    ram_cell[      89] = 32'h42b93784;
    ram_cell[      90] = 32'heb48cd51;
    ram_cell[      91] = 32'hf7b70e6b;
    ram_cell[      92] = 32'hf9fb97d5;
    ram_cell[      93] = 32'hd3501f68;
    ram_cell[      94] = 32'h6bf847a6;
    ram_cell[      95] = 32'hce9c4a9c;
    ram_cell[      96] = 32'hee397ef3;
    ram_cell[      97] = 32'h25377959;
    ram_cell[      98] = 32'h19f144de;
    ram_cell[      99] = 32'h35f607d6;
    ram_cell[     100] = 32'h8588919e;
    ram_cell[     101] = 32'h4a94a7de;
    ram_cell[     102] = 32'h7d5db44b;
    ram_cell[     103] = 32'h1b87b7aa;
    ram_cell[     104] = 32'h94bab577;
    ram_cell[     105] = 32'h5570e4e6;
    ram_cell[     106] = 32'hd66e1b3e;
    ram_cell[     107] = 32'h68598f07;
    ram_cell[     108] = 32'h63bba4e3;
    ram_cell[     109] = 32'hdb20ad4b;
    ram_cell[     110] = 32'h7d057e25;
    ram_cell[     111] = 32'hf1399b78;
    ram_cell[     112] = 32'heb67ebcd;
    ram_cell[     113] = 32'he825343f;
    ram_cell[     114] = 32'h977f7ad0;
    ram_cell[     115] = 32'h96841b40;
    ram_cell[     116] = 32'h6d2cdc2b;
    ram_cell[     117] = 32'hcb23d609;
    ram_cell[     118] = 32'h8c4488d1;
    ram_cell[     119] = 32'h1e6c06c5;
    ram_cell[     120] = 32'h07c88aa2;
    ram_cell[     121] = 32'hc85aecea;
    ram_cell[     122] = 32'hccd1bd61;
    ram_cell[     123] = 32'hf9f15acc;
    ram_cell[     124] = 32'h7ee3473d;
    ram_cell[     125] = 32'h57e79e76;
    ram_cell[     126] = 32'hefe752ea;
    ram_cell[     127] = 32'h4122b273;
    // src matrix B
    ram_cell[     128] = 32'haa1ed8e8;
    ram_cell[     129] = 32'hb2be3120;
    ram_cell[     130] = 32'h59170f5c;
    ram_cell[     131] = 32'hfdd6d224;
    ram_cell[     132] = 32'h9fb3159d;
    ram_cell[     133] = 32'h0dc2d281;
    ram_cell[     134] = 32'h0c39fb32;
    ram_cell[     135] = 32'he4ba477e;
    ram_cell[     136] = 32'h6ad3c5d4;
    ram_cell[     137] = 32'h216a9255;
    ram_cell[     138] = 32'he91dcac5;
    ram_cell[     139] = 32'h7ad65e3a;
    ram_cell[     140] = 32'h93e6c2d7;
    ram_cell[     141] = 32'h3fd47b4d;
    ram_cell[     142] = 32'h83163971;
    ram_cell[     143] = 32'h86c4db79;
    ram_cell[     144] = 32'h01afdf36;
    ram_cell[     145] = 32'h3f5fd1a8;
    ram_cell[     146] = 32'h0f5e0538;
    ram_cell[     147] = 32'h2c35f8d6;
    ram_cell[     148] = 32'h2bfec8de;
    ram_cell[     149] = 32'h6ec56377;
    ram_cell[     150] = 32'hc8b7d269;
    ram_cell[     151] = 32'hd4c02034;
    ram_cell[     152] = 32'hdd138d70;
    ram_cell[     153] = 32'hf2e2d951;
    ram_cell[     154] = 32'h8375e6a0;
    ram_cell[     155] = 32'h33455a22;
    ram_cell[     156] = 32'hd9993809;
    ram_cell[     157] = 32'h8fbf9bde;
    ram_cell[     158] = 32'h59230093;
    ram_cell[     159] = 32'h4688e68d;
    ram_cell[     160] = 32'hbff32299;
    ram_cell[     161] = 32'he30d46f0;
    ram_cell[     162] = 32'h2a755bdb;
    ram_cell[     163] = 32'hc1ff4359;
    ram_cell[     164] = 32'hb78bd274;
    ram_cell[     165] = 32'h9a9f47e3;
    ram_cell[     166] = 32'h9d1981f6;
    ram_cell[     167] = 32'h55ea569b;
    ram_cell[     168] = 32'h0148079e;
    ram_cell[     169] = 32'h37f1b0d9;
    ram_cell[     170] = 32'hab6eaa80;
    ram_cell[     171] = 32'h26987eb7;
    ram_cell[     172] = 32'h58126a76;
    ram_cell[     173] = 32'hfb082602;
    ram_cell[     174] = 32'h9c3537d9;
    ram_cell[     175] = 32'h423ed015;
    ram_cell[     176] = 32'hf79ddcc0;
    ram_cell[     177] = 32'ha2ff29ed;
    ram_cell[     178] = 32'h85df235b;
    ram_cell[     179] = 32'h365d10db;
    ram_cell[     180] = 32'hf3e4593b;
    ram_cell[     181] = 32'h63fa6329;
    ram_cell[     182] = 32'hdf217073;
    ram_cell[     183] = 32'h74cd6ac3;
    ram_cell[     184] = 32'h12097b40;
    ram_cell[     185] = 32'h86ea2aa5;
    ram_cell[     186] = 32'hebfb092a;
    ram_cell[     187] = 32'ha3872fb0;
    ram_cell[     188] = 32'he5c209aa;
    ram_cell[     189] = 32'h774d0c6c;
    ram_cell[     190] = 32'ha99fac56;
    ram_cell[     191] = 32'h01590a57;
end

endmodule

