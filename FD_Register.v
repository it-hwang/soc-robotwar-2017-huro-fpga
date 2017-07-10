module FD_Register(clk, nRESET, readEn,RegAddr,ReadData,
						 Refpixel,Selpixel_0,Selpixel_1, Selpixel_2, 
						 Selpixel_3, Selpixel_4, Selpixel_5,Selpixel_6, Selpixel_7, 
						 Selpixel_8, Selpixel_9, Selpixel_10, Selpixel_11,Selpixel_12,
						 Selpixel_13, Selpixel_14, Selpixel_15,Threhol);

	input clk; //clock
	input nRESET; //Reset
	input readEn; //ReadEnable 1 is Ok, 2 is denied
	input[4:0] RegAddr; // you Should Select Register Address, After, you will write Data
	input[7:0] ReadData; // your Data
	
	output[7:0] Refpixel; // Compare pixel(Data) , it's Number is 0
	output[7:0] Selpixel_0,Selpixel_1, Selpixel_2, Selpixel_3, Selpixel_4, Selpixel_5; // Selected Pixel(Data), it's Number is 1 ~ 16
	output[7:0] Selpixel_6, Selpixel_7, Selpixel_8, Selpixel_9, Selpixel_10, Selpixel_11;
	output[7:0] Selpixel_12,Selpixel_13, Selpixel_14, Selpixel_15;
	output[7:0] Threhol; // Threhol , it's Number is 17.
	
	reg[7:0] reg_Refpixel;//0
	reg[7:0] reg_Selpixel_0;//1
	reg[7:0] reg_Selpixel_1;//2
	reg[7:0] reg_Selpixel_2;//3
	reg[7:0] reg_Selpixel_3;//4
	reg[7:0] reg_Selpixel_4;//5
	reg[7:0] reg_Selpixel_5;//6
	reg[7:0] reg_Selpixel_6;//7
	reg[7:0] reg_Selpixel_7;//8
	reg[7:0] reg_Selpixel_8;//9
	reg[7:0] reg_Selpixel_9;//10
	reg[7:0] reg_Selpixel_10;//11
	reg[7:0] reg_Selpixel_11;//12
	reg[7:0] reg_Selpixel_12;//13
	reg[7:0] reg_Selpixel_13;//14
	reg[7:0] reg_Selpixel_14;//15
	reg[7:0] reg_Selpixel_15;//16
	wire[7:0] reg_Therol;//17
	
	wire[17:0] decoder_out; //
	wire[17:0] reg_enable;//
	
	// out from first Decoder
	assign decoder_out = 
		(RegAddr == 5'b00000) ? 18'b000000000000000001:
		(RegAddr == 5'b00001) ? 18'b000000000000000010:
		(RegAddr == 5'b00010) ? 18'b000000000000000100:
		(RegAddr == 5'b00011) ? 18'b000000000000001000:
		(RegAddr == 5'b00100) ? 18'b000000000000010000:
		(RegAddr == 5'b00101) ? 18'b000000000000100000:
		(RegAddr == 5'b00110) ? 18'b000000000001000000:
		(RegAddr == 5'b00111) ? 18'b000000000010000000:
		(RegAddr == 5'b01000) ? 18'b000000000100000000:
		(RegAddr == 5'b01001) ? 18'b000000001000000000:
		(RegAddr == 5'b01010) ? 18'b000000010000000000:
		(RegAddr == 5'b01011) ? 18'b000000100000000000:
		(RegAddr == 5'b01100) ? 18'b000001000000000000:
		(RegAddr == 5'b01101) ? 18'b000010000000000000:
		(RegAddr == 5'b01110) ? 18'b000100000000000000:
		(RegAddr == 5'b01111) ? 18'b001000000000000000:
		(RegAddr == 5'b10000) ? 18'b010000000000000000:
		(RegAddr == 5'b10001) ? 18'b100000000000000000:18'bx;
		
	assign reg_enable[0] = decoder_out[0];
	assign reg_enable[1] = decoder_out[1];
	assign reg_enable[2] = decoder_out[2];
	assign reg_enable[3] = decoder_out[3];
	assign reg_enable[4] = decoder_out[4];
	assign reg_enable[5] = decoder_out[5];
	assign reg_enable[6] = decoder_out[6];
	assign reg_enable[7] = decoder_out[7];
	assign reg_enable[8] =  decoder_out[8];
	assign reg_enable[9] =  decoder_out[9];
	assign reg_enable[10] =  decoder_out[10];
	assign reg_enable[11] =  decoder_out[11];
	assign reg_enable[12] =  decoder_out[12];
	assign reg_enable[13] =  decoder_out[13];
	assign reg_enable[14] =  decoder_out[14];
	assign reg_enable[15] =  decoder_out[15];
	assign reg_enable[16] =  decoder_out[16];
	assign reg_enable[17] =  decoder_out[17];
	
	
	// reset// set first state
	always @(posedge clk or negedge nRESET)//0
	if(!nRESET)
		reg_Refpixel <=8'bx;
	else if(reg_enable[0])
		reg_Refpixel <=ReadData;
	
	always @(posedge clk or negedge nRESET)//1
	if(!nRESET)
		reg_Selpixel_0 <=8'bx;
	else if(reg_enable[1])
		reg_Selpixel_0 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//2
	if(!nRESET)
		reg_Selpixel_1 <=8'bx;
	else if(reg_enable[2])
		reg_Selpixel_1 <=ReadData;
	
	always @(posedge clk or negedge nRESET)//3
	if(!nRESET)
		reg_Selpixel_2 <=8'bx;
	else if(reg_enable[3])
		reg_Selpixel_2 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//4
	if(!nRESET)
		reg_Selpixel_3 <=8'bx;
	else if(reg_enable[4])
		reg_Selpixel_3 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//5
	if(!nRESET)
		reg_Selpixel_4 <=8'bx;
	else if(reg_enable[5])
		reg_Selpixel_4 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//6
	if(!nRESET)
		reg_Selpixel_5 <=8'bx;
	else if(reg_enable[6])
		reg_Selpixel_5 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//7
	if(!nRESET)
		reg_Selpixel_6 <=8'bx;
	else if(reg_enable[7])
		reg_Selpixel_6 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//8
	if(!nRESET)
		reg_Selpixel_7 <=8'bx;
	else if(reg_enable[8])
		reg_Selpixel_7 <=ReadData;

	always @(posedge clk or negedge nRESET)//9
	if(!nRESET)
		reg_Selpixel_8 <=8'bx;
	else if(reg_enable[9])
		reg_Selpixel_8 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//10
	if(!nRESET)
		reg_Selpixel_9 <=8'bx;
	else if(reg_enable[10])
		reg_Selpixel_9 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//11
	if(!nRESET)
		reg_Selpixel_10 <=8'bx;
	else if(reg_enable[11])
		reg_Selpixel_10 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//12
	if(!nRESET)
		reg_Selpixel_11 <=8'bx;
	else if(reg_enable[12])
		reg_Selpixel_11 <=ReadData;
	
	always @(posedge clk or negedge nRESET)//13
	if(!nRESET)
		reg_Selpixel_12 <=8'bx;
	else if(reg_enable[13])
		reg_Selpixel_12 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//14
	if(!nRESET)
		reg_Selpixel_13 <=8'bx;
	else if(reg_enable[14])
		reg_Selpixel_13 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//15
	if(!nRESET)
		reg_Selpixel_14 <=8'bx;
	else if(reg_enable[15])
		reg_Selpixel_14 <=ReadData;
		
	always @(posedge clk or negedge nRESET)//16
	if(!nRESET)
		reg_Selpixel_15 <=8'bx;
	else if(reg_enable[16])
		reg_Selpixel_15 <=ReadData;
		

	assign reg_Therol = 50;
		// set input Data
	assign Refpixel = reg_Refpixel;
	assign Threhol = reg_Therol;

	assign Selpixel_0 = (readEn == 0) ? 8'bx : reg_Selpixel_0;
	assign Selpixel_1 = (readEn == 0) ? 8'bx : reg_Selpixel_1;
	assign Selpixel_2 = (readEn == 0) ? 8'bx : reg_Selpixel_2;
	assign Selpixel_3 = (readEn == 0) ? 8'bx : reg_Selpixel_3;
	assign Selpixel_4 = (readEn == 0) ? 8'bx : reg_Selpixel_4;
	assign Selpixel_5 = (readEn == 0) ? 8'bx : reg_Selpixel_5;
	assign Selpixel_6 = (readEn == 0) ? 8'bx : reg_Selpixel_6;
	assign Selpixel_7 = (readEn == 0) ? 8'bx : reg_Selpixel_7;
	assign Selpixel_8 = (readEn == 0) ? 8'bx : reg_Selpixel_8;
	assign Selpixel_9 = (readEn == 0) ? 8'bx : reg_Selpixel_9;
	assign Selpixel_10 = (readEn == 0) ? 8'bx : reg_Selpixel_10;
	assign Selpixel_11 = (readEn == 0) ? 8'bx : reg_Selpixel_11;
	assign Selpixel_12 = (readEn == 0) ? 8'bx : reg_Selpixel_12;
	assign Selpixel_13 = (readEn == 0) ? 8'bx : reg_Selpixel_13;
	assign Selpixel_14 = (readEn == 0) ? 8'bx : reg_Selpixel_14;
	assign Selpixel_15 = (readEn == 0) ? 8'bx : reg_Selpixel_15;

	endmodule
		
	