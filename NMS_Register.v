module NMS_Register(clk, nRESET, regAddr, readEn, scoreData,
						  
						  nighScore0, nighScore1, nighScore2, nighScore3,
						  nighScore4, nighScore5, nighScore6, nighScore7,
						  
						  refScore
							);
							
	input clk;
	input nRESET;
	input readEn;
	input[3:0] regAddr;
	input[11:0] scoreData;
	
	output[11:0] nighScore0, nighScore1, nighScore2, nighScore3,
					nighScore4, nighScore5, nighScore6, nighScore7;
	
	output[11:0] refScore;
	
	reg[11:0] reg_refScore; // special
	reg[11:0] reg_nighScore_0;//0
	reg[11:0] reg_nighScore_1;//1
	reg[11:0] reg_nighScore_2;//2
	reg[11:0] reg_nighScore_3;//3
	reg[11:0] reg_nighScore_4;//4
	reg[11:0] reg_nighScore_5;//5
	reg[11:0] reg_nighScore_6;//6
	reg[11:0] reg_nighScore_7;//7
	
	
	wire[8:0] decoder_out; //
	wire[8:0] reg_enable;//
	
	// out from first Decoder
	assign decoder_out = 
		(regAddr == 4'b0000) ? 9'b000000001:
		(regAddr == 4'b0001) ? 9'b000000010:
		(regAddr == 4'b0010) ? 9'b000000100:
		(regAddr == 4'b0011) ? 9'b000001000:
		(regAddr == 4'b0100) ? 9'b000010000:
		(regAddr == 4'b0101) ? 9'b000100000:
		(regAddr == 4'b0110) ? 9'b001000000:
		(regAddr == 4'b0111) ? 9'b010000000:
		(regAddr == 4'b1000) ? 9'b100000000: 9'bx;
		
	assign reg_enable[0] = decoder_out[0];
	assign reg_enable[1] = decoder_out[1];
	assign reg_enable[2] = decoder_out[2];
	assign reg_enable[3] = decoder_out[3];
	assign reg_enable[4] = decoder_out[4];
	assign reg_enable[5] = decoder_out[5];
	assign reg_enable[6] = decoder_out[6];
	assign reg_enable[7] = decoder_out[7];
	assign reg_enable[8] = decoder_out[8];
	
	
	// reset// set first state
	always @(posedge clk or negedge nRESET)//0
	if(!nRESET)
		reg_refScore <=12'bx;
	else if(reg_enable[0])
		reg_refScore <=scoreData;
	
	always @(posedge clk or negedge nRESET)//1
	if(!nRESET)
		reg_nighScore_0 <=12'bx;
	else if(reg_enable[1])
		reg_nighScore_0 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//2
	if(!nRESET)
		reg_nighScore_1 <=12'bx;
	else if(reg_enable[2])
		reg_nighScore_1 <=scoreData;
	
	always @(posedge clk or negedge nRESET)//3
	if(!nRESET)
		reg_nighScore_2 <=12'bx;
	else if(reg_enable[3])
		reg_nighScore_2 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//4
	if(!nRESET)
		reg_nighScore_3 <=12'bx;
	else if(reg_enable[4])
		reg_nighScore_3 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//5
	if(!nRESET)
		reg_nighScore_4 <=12'bx;
	else if(reg_enable[5])
		reg_nighScore_4 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//6
	if(!nRESET)
		reg_nighScore_5 <=12'bx;
	else if(reg_enable[6])
		reg_nighScore_5 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//7
	if(!nRESET)
		reg_nighScore_6 <=12'bx;
	else if(reg_enable[7])
		reg_nighScore_6 <=scoreData;
		
	always @(posedge clk or negedge nRESET)//8
	if(!nRESET)
		reg_nighScore_7 <=12'bx;
	else if(reg_enable[8])
		reg_nighScore_7 <=scoreData;


		// set input Data
	assign refScore = reg_refScore;

	assign nighScore0 = (readEn == 0) ? 12'bx : reg_nighScore_0;
	assign nighScore1 = (readEn == 0) ? 12'bx : reg_nighScore_1;
	assign nighScore2 = (readEn == 0) ? 12'bx : reg_nighScore_2;
	assign nighScore3 = (readEn == 0) ? 12'bx : reg_nighScore_3;
	assign nighScore4 = (readEn == 0) ? 12'bx : reg_nighScore_4;
	assign nighScore5 = (readEn == 0) ? 12'bx : reg_nighScore_5;
	assign nighScore6 = (readEn == 0) ? 12'bx : reg_nighScore_6;
	assign nighScore7 = (readEn == 0) ? 12'bx : reg_nighScore_7;


	endmodule 