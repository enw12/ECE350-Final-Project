module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

	wire [31:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17,
					w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;
	
	wire [31:0] writeDec, readADec, readBDec, writeEnable;
	
   /* YOUR CODE HERE */
	
	//Decode readReg and writeReg
	dec5to32 write_decode(.out(writeDec), .In(ctrl_writeReg));
	dec5to32 readA_decode(.out(readADec), .In(ctrl_readRegA));
	dec5to32 readB_decode(.out(readBDec), .In(ctrl_readRegB));
	
	// Check for write enable
	and writeEn0(writeEnable[0], writeDec[0],1'b0); 
	and writeEn1(writeEnable[1], writeDec[1],ctrl_writeEnable); 
	and writeEn2(writeEnable[2], writeDec[2],ctrl_writeEnable); 
	and writeEn3(writeEnable[3], writeDec[3],ctrl_writeEnable); 
	and writeEn4(writeEnable[4], writeDec[4],ctrl_writeEnable); 
	and writeEn5(writeEnable[5], writeDec[5],ctrl_writeEnable); 
	and writeEn6(writeEnable[6], writeDec[6],ctrl_writeEnable); 
	and writeEn7(writeEnable[7], writeDec[7],ctrl_writeEnable); 
	and writeEn8(writeEnable[8], writeDec[8],ctrl_writeEnable); 
	and writeEn9(writeEnable[9], writeDec[9],ctrl_writeEnable); 
	and writeEn10(writeEnable[10], writeDec[10],ctrl_writeEnable); 
	and writeEn11(writeEnable[11], writeDec[11],ctrl_writeEnable); 
	and writeEn12(writeEnable[12], writeDec[12],ctrl_writeEnable); 
	and writeEn13(writeEnable[13], writeDec[13],ctrl_writeEnable); 
	and writeEn14(writeEnable[14], writeDec[14],ctrl_writeEnable); 
	and writeEn15(writeEnable[15], writeDec[15],ctrl_writeEnable); 
	and writeEn16(writeEnable[16], writeDec[16],ctrl_writeEnable); 
	and writeEn17(writeEnable[17], writeDec[17],ctrl_writeEnable); 
	and writeEn18(writeEnable[18], writeDec[18],ctrl_writeEnable); 
	and writeEn19(writeEnable[19], writeDec[19],ctrl_writeEnable); 
	and writeEn20(writeEnable[20], writeDec[20],ctrl_writeEnable); 
	and writeEn21(writeEnable[21], writeDec[21],ctrl_writeEnable); 
	and writeEn22(writeEnable[22], writeDec[22],ctrl_writeEnable); 
	and writeEn23(writeEnable[23], writeDec[23],ctrl_writeEnable); 
	and writeEn24(writeEnable[24], writeDec[24],ctrl_writeEnable); 
	and writeEn25(writeEnable[25], writeDec[25],ctrl_writeEnable); 
	and writeEn26(writeEnable[26], writeDec[26],ctrl_writeEnable); 
	and writeEn27(writeEnable[27], writeDec[27],ctrl_writeEnable); 
	and writeEn28(writeEnable[28], writeDec[28],ctrl_writeEnable); 
	and writeEn29(writeEnable[29], writeDec[29],ctrl_writeEnable); 
	and writeEn30(writeEnable[30], writeDec[30],ctrl_writeEnable); 
	and writeEn31(writeEnable[31], writeDec[31],ctrl_writeEnable); 

	// Registers
	register reg_0(.read_data(w0), .write_data(data_writeReg), .clk(clock), .enable(1'b0), .clr(1'b0));
	register reg_1(.read_data(w1), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[1]), .clr(ctrl_reset));
	register reg_2(.read_data(w2), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[2]), .clr(ctrl_reset));
	register reg_3(.read_data(w3), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[3]), .clr(ctrl_reset));
	register reg_4(.read_data(w4), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[4]), .clr(ctrl_reset));
	register reg_5(.read_data(w5), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[5]), .clr(ctrl_reset));
	register reg_6(.read_data(w6), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[6]), .clr(ctrl_reset));
	register reg_7(.read_data(w7), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[7]), .clr(ctrl_reset));
	register reg_8(.read_data(w8), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[8]), .clr(ctrl_reset));
	register reg_9(.read_data(w9), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[9]), .clr(ctrl_reset));
	register reg_10(.read_data(w10), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[10]), .clr(ctrl_reset));
	register reg_11(.read_data(w11), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[11]), .clr(ctrl_reset));
	register reg_12(.read_data(w12), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[12]), .clr(ctrl_reset));
	register reg_13(.read_data(w13), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[13]), .clr(ctrl_reset));
	register reg_14(.read_data(w14), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[14]), .clr(ctrl_reset));
	register reg_15(.read_data(w15), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[15]), .clr(ctrl_reset));
	register reg_16(.read_data(w16), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[16]), .clr(ctrl_reset));
	register reg_17(.read_data(w17), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[17]), .clr(ctrl_reset));
	register reg_18(.read_data(w18), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[18]), .clr(ctrl_reset));
	register reg_19(.read_data(w19), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[19]), .clr(ctrl_reset));
	register reg_20(.read_data(w20), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[20]), .clr(ctrl_reset));
	register reg_21(.read_data(w21), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[21]), .clr(ctrl_reset));
	register reg_22(.read_data(w22), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[22]), .clr(ctrl_reset));
	register reg_23(.read_data(w23), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[23]), .clr(ctrl_reset));
	register reg_24(.read_data(w24), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[24]), .clr(ctrl_reset));
	register reg_25(.read_data(w25), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[25]), .clr(ctrl_reset));
	register reg_26(.read_data(w26), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[26]), .clr(ctrl_reset));
	register reg_27(.read_data(w27), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[27]), .clr(ctrl_reset));
	register reg_28(.read_data(w28), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[28]), .clr(ctrl_reset));
	register reg_29(.read_data(w29), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[29]), .clr(ctrl_reset));
	register reg_30(.read_data(w30), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[30]), .clr(ctrl_reset));
	register reg_31(.read_data(w31), .write_data(data_writeReg), .clk(clock), .enable(writeEnable[31]), .clr(ctrl_reset));

	// Sets read value for RegA
	assign data_readRegA = readADec[0] ? 32'b0 : 32'bz;
	assign data_readRegA = readADec[1] ? w1 : 32'bz;
	assign data_readRegA = readADec[2] ? w2 : 32'bz;
	assign data_readRegA = readADec[3] ? w3 : 32'bz;
	assign data_readRegA = readADec[4] ? w4 : 32'bz;
	assign data_readRegA = readADec[5] ? w5 : 32'bz;
	assign data_readRegA = readADec[6] ? w6 : 32'bz;
	assign data_readRegA = readADec[7] ? w7 : 32'bz;
	assign data_readRegA = readADec[8] ? w8 : 32'bz;
	assign data_readRegA = readADec[9] ? w9 : 32'bz;
	assign data_readRegA = readADec[10] ? w10 : 32'bz;
	assign data_readRegA = readADec[11] ? w11 : 32'bz;
	assign data_readRegA = readADec[12] ? w12 : 32'bz;
	assign data_readRegA = readADec[13] ? w13 : 32'bz;
	assign data_readRegA = readADec[14] ? w14 : 32'bz;
	assign data_readRegA = readADec[15] ? w15 : 32'bz;
	assign data_readRegA = readADec[16] ? w16 : 32'bz;
	assign data_readRegA = readADec[17] ? w17 : 32'bz;
	assign data_readRegA = readADec[18] ? w18 : 32'bz;
	assign data_readRegA = readADec[19] ? w19 : 32'bz;
	assign data_readRegA = readADec[20] ? w20 : 32'bz;
	assign data_readRegA = readADec[21] ? w21 : 32'bz;
	assign data_readRegA = readADec[22] ? w22 : 32'bz;
	assign data_readRegA = readADec[23] ? w23 : 32'bz;
	assign data_readRegA = readADec[24] ? w24 : 32'bz;
	assign data_readRegA = readADec[25] ? w25 : 32'bz;
	assign data_readRegA = readADec[26] ? w26 : 32'bz;
	assign data_readRegA = readADec[27] ? w27 : 32'bz;
	assign data_readRegA = readADec[28] ? w28 : 32'bz;
	assign data_readRegA = readADec[29] ? w29 : 32'bz;
	assign data_readRegA = readADec[30] ? w30 : 32'bz;
	assign data_readRegA = readADec[31] ? w31 : 32'bz;

	// Sets read value for RegB
	assign data_readRegB = readBDec[0] ? 32'b0 : 32'bz;
	assign data_readRegB = readBDec[1] ? w1 : 32'bz;
	assign data_readRegB = readBDec[2] ? w2 : 32'bz;
	assign data_readRegB = readBDec[3] ? w3 : 32'bz;
	assign data_readRegB = readBDec[4] ? w4 : 32'bz;
	assign data_readRegB = readBDec[5] ? w5 : 32'bz;
	assign data_readRegB = readBDec[6] ? w6 : 32'bz;
	assign data_readRegB = readBDec[7] ? w7 : 32'bz;
	assign data_readRegB = readBDec[8] ? w8 : 32'bz;
	assign data_readRegB = readBDec[9] ? w9 : 32'bz;
	assign data_readRegB = readBDec[10] ? w10 : 32'bz;
	assign data_readRegB = readBDec[11] ? w11 : 32'bz;
	assign data_readRegB = readBDec[12] ? w12 : 32'bz;
	assign data_readRegB = readBDec[13] ? w13 : 32'bz;
	assign data_readRegB = readBDec[14] ? w14 : 32'bz;
	assign data_readRegB = readBDec[15] ? w15 : 32'bz;
	assign data_readRegB = readBDec[16] ? w16 : 32'bz;
	assign data_readRegB = readBDec[17] ? w17 : 32'bz;
	assign data_readRegB = readBDec[18] ? w18 : 32'bz;
	assign data_readRegB = readBDec[19] ? w19 : 32'bz;
	assign data_readRegB = readBDec[20] ? w20 : 32'bz;
	assign data_readRegB = readBDec[21] ? w21 : 32'bz;
	assign data_readRegB = readBDec[22] ? w22 : 32'bz;
	assign data_readRegB = readBDec[23] ? w23 : 32'bz;
	assign data_readRegB = readBDec[24] ? w24 : 32'bz;
	assign data_readRegB = readBDec[25] ? w25 : 32'bz;
	assign data_readRegB = readBDec[26] ? w26 : 32'bz;
	assign data_readRegB = readBDec[27] ? w27 : 32'bz;
	assign data_readRegB = readBDec[28] ? w28 : 32'bz;
	assign data_readRegB = readBDec[29] ? w29 : 32'bz;
	assign data_readRegB = readBDec[30] ? w30 : 32'bz;
	assign data_readRegB = readBDec[31] ? w31 : 32'bz;
	
endmodule
