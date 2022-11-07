`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:49 11/07/2022 
// Design Name: 
// Module Name:    RISC 
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
module RISC(
	input clk,
	input rst
    );
	wire [31:0] nextInstrAddr, instrAddr;
	PC pc(nextInstrAddr, clk, rst, instrAddr);
	wire [31:0] current_instruction; 
	
	// instruction memory
	instr_bram im(clk, {2'b0, nextInstrAddr[9:2], instruct});
	
	wire fZero, fNegative, fCarry; // flags from ALU
	wire aluSrc;                   // ALU source
	wire fMemRead, fMemWrite;      // memory access flags
	wire lblSel, jmpSel;           // label-select and jump-select
	wire [1:0] regDst, memToReg;   // register destination and memory-to-register destination
	wire regWrite;
	
	//Instruction decode
	wire [5:0] opcode ,funcode;
	wire [4:0] shamt, rs, rt;       
	wire [15:0] imm;
	assign opcode  = current_instruction[31:26];
	assign funcode = current_instruction[10:5];
	assign shamt   = current_instruction[15:11];
	assign rs      = current_instruction[25:21];
	assign rt      = current_instruction[20:16];
	assign imm     = current_instruction[15:0];
	
	wire [4:0] writeAddr;
	wire [31:0] writeData, readData1, readData2;
	wire [4:0] ra;
	assign ra = 5'b11111;
	
	mux_5_3_to_1 mRegDst(rs, rt, ra, regDst, writeAddr);
	register_file RFile(
		regWrite,
		rs,
		rt,
		writeAddr,
		writeData,
		clk,
		rst,
		readData1,
		readData2
		);

	// Controller
	control_unit ctrl(
		opcode,
		fMemRead,
		fMemWrite,
		regWrite,
		regDst,
		memToReg,
		aluSrc,
		lblSel,
		jmpSel
		);

	// ALU-controller to provide ALU control lines (alucode)
	wire [3:0] alucode;
	ALU_Control  aluControl(
		opcode,
		funcode,
		alucode
	);

	// Sign-extend the immediate value
	wire [31:0] extendImm;
    sign_extend signExtend(
		imm,
		extendImm
	);	

	// 2-1 MUX to select between the two read data sources (readData2, extended immediate)
	wire [31:0] aluInp2;
	mux_32_2_to_1 aluMux(
		readData2,
		extendImm,
		aluSrc,
		aluInp2
	);

	wire [31:0] aluResult;
	wire carryOut;
	// ALU
	ALU alu(
		readData1,
		aluInp2,
		alucode,
		shamt,
		aluResult,
		fZero,
		fNegative,
		carryOut
		);
	
	d_flip_flop Carry(carryOut, clk, rst, fCarry); // Store current carry value in DFF
	
	// Branch-controller to provide if it is valid to branch
	wire fBranch;				   	// branch flag
	branch_control bContrl(
		opcode,
		fZero,
		fNegative,
		fCarry,
		fBranch
	);

	// Data memory
	// 32-bit wide 1024-word memory
	// ena set to 1 when fMemRead or fMemWrite is set
	wire ena;
	wire [31:0] memData;
	assign ena = fMemRead | fMemWrite;
	bram dataMem(
		~clk,					 // Datamem read synchronous to clock so negedge used
		ena,
		fMemWrite,
		{2'b00, aluResult[9:2]}, // indexing / 4
		readData2,
		memData
	);
	wire [31:0] pc4, jmpLabel, jmpImmLabel;
   
	// ** PC-LOGIC ** 
	assign pc4 = instrAddr + 32'd4;
	assign jmpLabel = {pc4[31:28], {current_instruction[25:0], 2'b00}};	// 26-bit Jump Label
	assign jmpImmLabel = pc4 + {extendImm[29:0], 2'b00};        // 16-bit Jump Label
	// ** PC-LOGIC ** 
	
	wire [31:0] lblSelOut, jmpSelOut;
	mux_32_2_to_1 mLblSel(jmpLabel, jmpImmLabel, lblSel, lblSelOut);   // Select jump label
	mux_32_2_to_1 mJmpSel(lblSelOut, readData1, jmpSel, jmpSelOut);    // Select label-type jump or register-value type jump
	mux_32_2_to_1 mBrnchSel(pc4, jmpSelOut, fBranch, nxtInstrAddr);	// Select to branch or not

	mux_32_3_to_1 mMemToReg(aluResult, memData, pc4, memToReg, writeData); // Mux for writeData for regfile
	
endmodule
