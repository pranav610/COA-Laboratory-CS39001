`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:30 11/08/2022 
// Design Name: 
// Module Name:    processor 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module processor(clk, rst, sel, inp, out);
    input clk, rst, sel;
	 input [9:0] inp; 
	 output [15:0] out;

    // Program counter module with two wires instrAddr, nextInstrAddr
    wire [31:0] instrAddr, nextIntrAddr;
    PC pc(clk, rst, nextIntrAddr, instrAddr);

    // Instruction memory module: connection with BROM
    // use next instruction address shifted by 4 bits
    wire [31:0] Instr;
    BROM instrMem(.clka(clk), .addra({2'b00, nextIntrAddr[9:2]}), .douta(Instr));

    // divide instrction 32 bits into opCode, shamt, rs, rt, imm
    wire [5:0] opCode ;
	 wire [4:0] funCode;
	wire [4:0] shamt, rs, rt;       
	wire [15:0] imm;
    wire [25:0] immJump;
	assign opCode  = Instr[31:26];
	assign funCode = Instr[4:0];
	assign shamt   = Instr[15:11];
	assign rs      = Instr[25:21];
	assign rt      = Instr[20:16];
	assign imm     = Instr[15:0];
    assign immJump = Instr[25:0];

    // control module
    wire regWrite, ALUsrc, MemRead, MemWrite, LblSel, JumpAddr;
    wire [1:0] regDest, MemToReg;
    control_unit controller(.opCode(opCode), .regDest(regDest), .regWrite(regWrite), .ALUsrc(ALUsrc), .MemRead(MemRead), .MemWrite(MemWrite), .MemToReg(MemToReg), .LblSel(LblSel), .JumpAddr(JumpAddr)); 

    // register file
    wire [4:0] writeAddr;
	wire [31:0] writeData, readData1, readData2;
	wire [4:0] ra;
	assign ra = 5'b11111;
    mux_5_3_to_1 regSelMUX(.inp1(rs), .inp2(rt), .inp3(ra), .sel(regDest), . out(writeAddr));
    register_file regFile(.regWrite(regWrite), .readReg1(rs), .readReg2(rt), .writeReg(writeAddr), .writeData(writeData), .clk(clk), .rst(rst), .readData1(readData1), .readData2(readData2));

    // ALU controller
    wire [3:0] ALUop;
    ALU_control ALU_controller(.opCode(opCode), .funCode(funCode), .ALUop(ALUop));

    // sign-extension
    wire [31:0] extImm;
    sign_extend extender(.inp(imm), .out(extImm));

    //////////////// ALU ////////////////

    // ALU src MUX
    wire [31:0] selReadData2;
    mux_32_2_to_1 ALUsrcMUX(.a0(readData2), .a1(extImm), .sel(ALUsrc), .out(selReadData2));

    // ALU
    wire [31:0] ALUres;
    wire flagCarry, flagZero, flagSign, cout;

    ALU ALUunit(
	    .a(readData1),
	    .b(selReadData2),
	    .ALUop(ALUop),
	    .shamt(shamt),
	    .result(ALUres),
	    .fZero(flagZero),
	    .fSign(flagSign),
	    .fCarry(cout)
    );

    d_flip_flop carryDFF (
        .in(cout), 
        .clk(clk), 
        .rst(rst), 
        .out(flagCarry)
    );

    // branch controller
    wire flagBranch;
    branch_control branch_controller(
        .opCode(opCode), 
        .flagZero(flagZero), 
        .flagSign(flagSign), 
        .flagCarry(flagCarry), 
        .out(flagBranch)
    );  

    // Data memory
	 
    wire ena;
    wire [31:0] memData; 
    assign ena = MemRead | MemWrite | sel;
	 wire [9:0] addraRAM;
			
		
	assign addraRAM = sel ? inp :  {2'b00, ALUres[9:2]};
	assign out = memData[15:0];
		
	 
	// mux_32_2_to_1  ramMUX(.a0(ALUres), .a1(numAddr), .sel(RAMSel), .out(addraRAM));

    BRAM dataMem (
  .clka(~clk), // input clka
  .ena(ena), // input ena
  .wea(MemWrite), // input [0 : 0] wea
  .addra(addraRAM), // input [9 : 0] addra
  .dina(readData2), // input [31 : 0] dina
  .douta(memData) // output [31 : 0] douta
);

	wire [31:0] pc_4, jmpLabel, jmpImmLabel;
   
	assign pc_4 = instrAddr + 32'd4;
	assign jmpLabel = {pc_4[31:28], {immJump, 2'b00}};			// 26-bit Jump Label
	assign jmpImmLabel = pc_4 + {extImm[29:0], 2'b00};       // 16-bit Jump Label
	
	wire [31:0] LblSelOut, jmpSelOut;
	
	mux_32_2_to_1  mLblSel(.a0(jmpLabel),.a1(jmpImmLabel),.sel(LblSel),.out(LblSelOut)); // jump label select
	mux_32_2_to_1  mJmpSel(.a0(LblSelOut), .a1(readData1), .sel(JumpAddr), .out(jmpSelOut)); // Select label-type jump or register-value type jump
	mux_32_2_to_1  mBrnchSel(pc_4, jmpSelOut, flagBranch, nextIntrAddr);	// Select to branch or not

	mux_32_3_to_1 mMemToReg(
	.inp1(ALUres),
	.inp2(memData),
	.inp3(pc_4),
	.sel(MemToReg),
	.out(writeData)
    );
	 


    





endmodule
