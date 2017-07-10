module Mat_Register(clk, nRESET, readEn, RegAddr, ReadData, RefPixel, 
                    SelPixel1, SelPixel2, SelPixel3, SelPixel4, SelPixel5, SelPixel6, 
						  SelPixel7, SelPixel8, SelPixel9, SelPixel10, SelPixel11, SelPixel12,
						  SelPixel13, SelPixel14, SelPixel15, SelPixel16, SelPixel17, SelPixel18,  
						  SelPixel19, SelPixel20, SelPixel21, SelPixel22, SelPixel23, SelPixel24, 
						  SelPixel25, SelPixel26,  
						  
						  Threshold
						  );
						  
	input clk;
	input nRESET;
	input readEn;
	input [4:0] RegAddr;
	input [7:0] ReadData;
	
	output [7:0] RefPixel;	//reg0
	output [7:0] SelPixel1, SelPixel2, SelPixel3, SelPixel4, SelPixel5, SelPixel6, 
					 SelPixel7, SelPixel8, SelPixel9, SelPixel10, SelPixel11, SelPixel12,
					 SelPixel13, SelPixel14, SelPixel15, SelPixel16, SelPixel17, SelPixel18,  
				    SelPixel19, SelPixel20, SelPixel21, SelPixel22, SelPixel23, SelPixel24, 
					 SelPixel25, SelPixel26;  
	
	output [7:0] Threshold;
	
	reg[7:0] RegRefPixel;	//Don't use
	reg[7:0] RegSelPixel1;
	reg[7:0] RegSelPixel2;
	reg[7:0] RegSelPixel3;
	reg[7:0] RegSelPixel4;
	reg[7:0] RegSelPixel5;
	reg[7:0] RegSelPixel6;
	reg[7:0] RegSelPixel7;
	reg[7:0] RegSelPixel8;
	reg[7:0] RegSelPixel9;
	reg[7:0] RegSelPixel10;
	reg[7:0] RegSelPixel11;
	reg[7:0] RegSelPixel12;
	reg[7:0] RegSelPixel13;
	reg[7:0] RegSelPixel14;
	reg[7:0] RegSelPixel15;
	reg[7:0] RegSelPixel16;
	reg[7:0] RegSelPixel17;
	reg[7:0] RegSelPixel18;
	reg[7:0] RegSelPixel19;
	reg[7:0] RegSelPixel20;
	reg[7:0] RegSelPixel21;
	reg[7:0] RegSelPixel22;
	reg[7:0] RegSelPixel23;
	reg[7:0] RegSelPixel24;
	reg[7:0] RegSelPixel25;
	reg[7:0] RegSelPixel26;
	
	wire[7:0]  RegTheshold;
	wire[26:0] DecoderOut; 
	wire[26:0] RegEnable;
	
	assign DecoderOut = 
		(RegAddr == 5'b00000) ? 27'b0000000000000000000000000000001:
		(RegAddr == 5'b00001) ? 27'b0000000000000000000000000000010:
		(RegAddr == 5'b00010) ? 27'b0000000000000000000000000000100:
		(RegAddr == 5'b00011) ? 27'b0000000000000000000000000001000:
		(RegAddr == 5'b00100) ? 27'b0000000000000000000000000010000:
		(RegAddr == 5'b00101) ? 27'b0000000000000000000000000100000:
		(RegAddr == 5'b00110) ? 27'b0000000000000000000000001000000:
		(RegAddr == 5'b00111) ? 27'b0000000000000000000000010000000:
		(RegAddr == 5'b01000) ? 27'b0000000000000000000000100000000:
		(RegAddr == 5'b01001) ? 27'b0000000000000000000001000000000:
		(RegAddr == 5'b01010) ? 27'b0000000000000000000010000000000:
		(RegAddr == 5'b01011) ? 27'b0000000000000000000100000000000:
		(RegAddr == 5'b01100) ? 27'b0000000000000000001000000000000:
		(RegAddr == 5'b01101) ? 27'b0000000000000000010000000000000:
		(RegAddr == 5'b01110) ? 27'b0000000000000000100000000000000:
		(RegAddr == 5'b01111) ? 27'b0000000000000001000000000000000:
		(RegAddr == 5'b10000) ? 27'b0000000000000010000000000000000:
		(RegAddr == 5'b10001) ? 27'b0000000000000100000000000000000:
		(RegAddr == 5'b10010) ? 27'b0000000000001000000000000000000:
		(RegAddr == 5'b10011) ? 27'b0000000000010000000000000000000:
		(RegAddr == 5'b10100) ? 27'b0000000000100000000000000000000:
		(RegAddr == 5'b10101) ? 27'b0000000001000000000000000000000:
		(RegAddr == 5'b10110) ? 27'b0000000010000000000000000000000:
		(RegAddr == 5'b10111) ? 27'b0000000100000000000000000000000:
		(RegAddr == 5'b11000) ? 27'b0000001000000000000000000000000:
		(RegAddr == 5'b11001) ? 27'b0000010000000000000000000000000:
		(RegAddr == 5'b11010) ? 27'b0000100000000000000000000000000:27'bx;
		
		assign RegEnable[0] = DecoderOut[0];
		assign RegEnable[1] = DecoderOut[1];
		assign RegEnable[2] = DecoderOut[2];
		assign RegEnable[3] = DecoderOut[3];
		assign RegEnable[4] = DecoderOut[4];
		assign RegEnable[5] = DecoderOut[5];
		assign RegEnable[6] = DecoderOut[6];
		assign RegEnable[7] = DecoderOut[7];
		assign RegEnable[8] =  DecoderOut[8];
		assign RegEnable[9] =  DecoderOut[9];
		assign RegEnable[10] =  DecoderOut[10];
		assign RegEnable[11] =  DecoderOut[11];
		assign RegEnable[12] =  DecoderOut[12];
		assign RegEnable[13] =  DecoderOut[13];
		assign RegEnable[14] =  DecoderOut[14];
		assign RegEnable[15] =  DecoderOut[15];
		assign RegEnable[16] =  DecoderOut[16];
		assign RegEnable[17] =  DecoderOut[17];
		assign RegEnable[18] = DecoderOut[18];
		assign RegEnable[19] = DecoderOut[19];
		assign RegEnable[20] = DecoderOut[20];
		assign RegEnable[21] = DecoderOut[21];
		assign RegEnable[22] = DecoderOut[22];
		assign RegEnable[23] = DecoderOut[23];
		assign RegEnable[24] = DecoderOut[24];
		assign RegEnable[25] = DecoderOut[25];
		assign RegEnable[26] =  DecoderOut[26];
	
		
	always @(posedge clk or negedge nRESET)//0
	if(!nRESET)
		RegRefPixel <=8'bx;
	else if(RegEnable[0])
		RegRefPixel <=ReadData;
	
	always @(posedge clk or negedge nRESET)//1
	if(!nRESET)
		RegSelPixel1 <=8'bx;
	else if(RegEnable[1])
		RegSelPixel1 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//2
	if(!nRESET)
		RegSelPixel2 <=8'bx;
	else if(RegEnable[2])
		RegSelPixel2 <=ReadData;
	
	always @(posedge clk or negedge nRESET)//3
	if(!nRESET)
		RegSelPixel3 <=8'bx;
	else if(RegEnable[3])
		RegSelPixel3 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//4
	if(!nRESET)
		RegSelPixel4 <=8'bx;
	else if(RegEnable[4])
		RegSelPixel4 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//5
	if(!nRESET)
		RegSelPixel5 <=8'bx;
	else if(RegEnable[5])
		RegSelPixel5 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//6
	if(!nRESET)
		RegSelPixel6 <=8'bx;
	else if(RegEnable[6])
		RegSelPixel6 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//7
	if(!nRESET)
		RegSelPixel7 <=8'bx;
	else if(RegEnable[7])
		RegSelPixel7 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//8
	if(!nRESET)
		RegSelPixel8 <=8'bx;
	else if(RegEnable[8])
		RegSelPixel8 <=ReadData;

	always @(posedge clk or negedge nRESET)//9
	if(!nRESET)
		RegSelPixel9 <=8'bx;
	else if(RegEnable[9])
		RegSelPixel9 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//10
	if(!nRESET)
		RegSelPixel10 <=8'bx;
	else if(RegEnable[10])
		RegSelPixel10 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//11
	if(!nRESET)
		RegSelPixel11 <=8'bx;
	else if(RegEnable[11])
		RegSelPixel11 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//12
	if(!nRESET)
		RegSelPixel12 <=8'bx;
	else if(RegEnable[12])
		RegSelPixel12 <=ReadData;
	
	always @(posedge clk or negedge nRESET)//13
	if(!nRESET)
		RegSelPixel13 <=8'bx;
	else if(RegEnable[13])
		RegSelPixel13 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//14
	if(!nRESET)
		RegSelPixel14 <=8'bx;
	else if(RegEnable[14])
		RegSelPixel14 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//15
	if(!nRESET)
		RegSelPixel15 <=8'bx;
	else if(RegEnable[15])
		RegSelPixel15 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//16
	if(!nRESET)
		RegSelPixel16 <=8'bx;
	else if(RegEnable[16])
		RegSelPixel16 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//1
	if(!nRESET)
		RegSelPixel17 <=8'bx;
	else if(RegEnable[17])
		RegSelPixel17 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//2
	if(!nRESET)
		RegSelPixel18 <=8'bx;
	else if(RegEnable[18])
		RegSelPixel18 <=ReadData;
	
	always @(posedge clk or negedge nRESET)//3
	if(!nRESET)
		RegSelPixel19 <=8'bx;
	else if(RegEnable[19])
		RegSelPixel19 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//4
	if(!nRESET)
		RegSelPixel20 <=8'bx;
	else if(RegEnable[20])
		RegSelPixel20 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//5
	if(!nRESET)
		RegSelPixel21 <=8'bx;
	else if(RegEnable[21])
		RegSelPixel21 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//6
	if(!nRESET)
		RegSelPixel22 <=8'bx;
	else if(RegEnable[22])
		RegSelPixel22 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//7
	if(!nRESET)
		RegSelPixel23 <=8'bx;
	else if(RegEnable[23])
		RegSelPixel23 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//8
	if(!nRESET)
		RegSelPixel24 <=8'bx;
	else if(RegEnable[24])
		RegSelPixel24 <=ReadData;

	always @(posedge clk or negedge nRESET)//9
	if(!nRESET)
		RegSelPixel25 <=8'bx;
	else if(RegEnable[25])
		RegSelPixel25 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//10
	if(!nRESET)
		RegSelPixel26 <=8'bx;
	else if(RegEnable[26])
		RegSelPixel26 <=ReadData;
		

	assign RegThreshold = 30;
	//Mat Threshold
	
	assign Threshold = RegThreshold;

	assign RefPixel = RegRefPixel;
	assign SelPixel1 = (readEn == 0) ? 8'bx : RegSelPixel1;
	assign SelPixel2 = (readEn == 0) ? 8'bx : RegSelPixel2;
	assign SelPixel3 = (readEn == 0) ? 8'bx : RegSelPixel3;
	assign SelPixel4 = (readEn == 0) ? 8'bx : RegSelPixel4;
	assign SelPixel5 = (readEn == 0) ? 8'bx : RegSelPixel5;
	assign SelPixel6 = (readEn == 0) ? 8'bx : RegSelPixel6;
	assign SelPixel7 = (readEn == 0) ? 8'bx : RegSelPixel7;
	assign SelPixel8 = (readEn == 0) ? 8'bx : RegSelPixel8;
	assign SelPixel9 = (readEn == 0) ? 8'bx : RegSelPixel9;
	assign SelPixel10 = (readEn == 0) ? 8'bx : RegSelPixel10;
	assign SelPixel11 = (readEn == 0) ? 8'bx : RegSelPixel11;
	assign SelPixel12 = (readEn == 0) ? 8'bx : RegSelPixel12;
	assign SelPixel13 = (readEn == 0) ? 8'bx : RegSelPixel13;
	assign SelPixel14 = (readEn == 0) ? 8'bx : RegSelPixel14;
	assign SelPixel15 = (readEn == 0) ? 8'bx : RegSelPixel15;
	assign SelPixel16 = (readEn == 0) ? 8'bx : RegSelPixel16;
	assign SelPixel17 = (readEn == 0) ? 8'bx : RegSelPixel17;
	assign SelPixel18 = (readEn == 0) ? 8'bx : RegSelPixel18;
	assign SelPixel19 = (readEn == 0) ? 8'bx : RegSelPixel19;
	assign SelPixel20 = (readEn == 0) ? 8'bx : RegSelPixel20;
	assign SelPixel21 = (readEn == 0) ? 8'bx : RegSelPixel21;
	assign SelPixel22 = (readEn == 0) ? 8'bx : RegSelPixel22;
	assign SelPixel23 = (readEn == 0) ? 8'bx : RegSelPixel23;
	assign SelPixel24 = (readEn == 0) ? 8'bx : RegSelPixel24;
	assign SelPixel25 = (readEn == 0) ? 8'bx : RegSelPixel25;
	assign SelPixel26 = (readEn == 0) ? 8'bx : RegSelPixel26;

endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
