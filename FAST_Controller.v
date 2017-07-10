`define INIT		5'b00000
`define ONE			5'b00001
`define TWO			5'b00010
`define THREE		5'b00011
`define FOUR		5'b00100
`define FIVE		5'b00101
`define SIX			5'b00110
`define SEVEN		5'b00111
`define EIGHT		5'b01000
`define NINE		5'b01001
`define TEN			5'b01010
`define ELEVEN		5'b01011
`define TWELVE		5'b01100
`define THIRTEEN	5'b01101
`define FOURTEEN	5'b01110
`define FIFTEEN	5'b01111
`define SIXTEEN	5'b10000

module FAST_Controller(
	//input
	clock,
	input_addr,
	nRESET,
	FAST_En,
	//output
	FD_refAddr,
	FD_calAddr,
	FD_regAddr,
	FD_readEn,
	FS_writeEn,
	FS_readEn,
	NMS_refAddr,
	NMS_regAddr,
	NMS_calAddr,
	NMS_readEn);
	
	//---------------------------------
	//input
	input	clock;
	input	[15:0]	input_addr;
	input	nRESET;
	input FAST_En;
	//---------------------------------
	
	//---------------------------------
	//output
	output	[15:0]	FD_refAddr;
	output	[4:0]		FD_calAddr;
	output	[4:0]		FD_regAddr;
	output	FD_readEn;
	output	FS_writeEn;
	output	FS_readEn;
	output	[15:0]	NMS_refAddr;
	output	[3:0]		NMS_calAddr;
	output	[3:0]		NMS_regAddr;
	output	NMS_readEn;
	//---------------------------------
	
	//---------------------------------
	//reg
	reg	[4:0]	curState;
	reg	[4:0]	nextState;
	reg	[4:0]	FD_calAddr;
	reg	[4:0]	FD_regAddr;
	reg	FD_readEn;
	reg	FS_writeEn;
	reg	FS_readEn;
	reg	[3:0]	NMS_calAddr;
	reg	[3:0]	NMS_regAddr;
	reg	NMS_readEn;
	//----------------------------------

	//----------------------------------
	//wire
	wire	[15:0]	row;
	wire	[15:0]	col;
	//wire signed [16:0] clip_refAddr;
	//----------------------------------
	
	//FD_refAddr = input_addr - 541
	assign FD_refAddr = input_addr - 16'b0000001000011101;
	//assign clip_refAddr = input_addr - 541;
	//assign FD_refAddr = (clip_refAddr < 543) ? input_addr : clip_refAddr;
	
	//NMS_refAddr = input_addr - 722
	assign NMS_refAddr = input_addr - 16'b0000001011010010;
	
	assign row = (input_addr - 16'b0000001000011101) / 16'b0000000010110100;
	assign col = (input_addr - 16'b0000001000011101) % 16'b0000000010110100;
	//assign row = FD_refAddr / 180;
	//assign col = FD_refAddr % 180;
	
	//----------------------------------
	//FSM state control
	always @ (posedge clock or negedge nRESET)
		if(!nRESET)
			curState <= `INIT;
		else if(FAST_En)
			curState <= nextState;
	//-----------------------------------
	
	
	always @ (curState)
		casex(curState)
			`INIT:
				begin
					nextState = `ONE;
					//FD control
					FD_calAddr = `INIT;
					FD_regAddr = `FIFTEEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `FOUR;
					NMS_regAddr = `TWO;
					NMS_readEn	= 1'b0;
				end
			
			`ONE:
				begin
					nextState = `TWO;
					//FD control
					FD_calAddr = `ONE;
					FD_regAddr = `SIXTEEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `FIVE;
					NMS_regAddr	= `THREE;
					NMS_readEn	= 1'b0;
				end
	
			`TWO:
				begin
					nextState = `THREE;
					//FD control
					FD_calAddr = `TWO;
					FD_regAddr = `INIT;
					if((row < 3) || (col < 3) || (col > 175) || (row > 116))
						FD_readEn = 1'b0;
					else
						FD_readEn = 1'b1;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `SIX;
					NMS_regAddr = `FOUR;
					NMS_readEn	= 1'b0;
				end
				
			`THREE:
				begin
					nextState = `FOUR;
					//FD control
					FD_calAddr = `THREE;
					FD_regAddr = `ONE;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b1;
					FS_readEn = 1'b1;
					NMS_calAddr = `SEVEN;
					NMS_regAddr = `FIVE;
					NMS_readEn	= 1'b0;
				end
				
			`FOUR:
				begin
					nextState = `FIVE;
					//FD control
					FD_calAddr = `FOUR;
					FD_regAddr = `TWO;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `EIGHT;
					NMS_regAddr = `SIX;
					NMS_readEn	= 1'b0;
					
				end
			
			`FIVE:
				begin
					nextState = `SIX;
					//FD control
					FD_calAddr = `FIVE;
					FD_regAddr = `THREE;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `INIT;
					NMS_regAddr	= `SEVEN;
					NMS_readEn	= 1'b0;
					
				end
				
			`SIX:
				begin
					nextState = `SEVEN;
					//FD control
					FD_calAddr = `SIX;
					FD_regAddr = `FOUR;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `ONE;
					NMS_regAddr	= `EIGHT;
					NMS_readEn	= 1'b0;
					
				end
				
			`SEVEN:
				begin
					nextState = `EIGHT;
					//FD control
					FD_calAddr = `SEVEN;
					FD_regAddr = `FIVE;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `TWO;
					NMS_regAddr	= `INIT;
					NMS_readEn = 1'b1;
					
				end
				
			`EIGHT:
				begin
					nextState = `NINE;
					//FD control
					FD_calAddr = `EIGHT;
					FD_regAddr = `SIX;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `THREE;
					NMS_regAddr	= `ONE;
					NMS_readEn	= 1'b0;
					
				end
				
			`NINE:
				begin
					nextState = `TEN;
					//FD control
					FD_calAddr = `NINE;
					FD_regAddr = `SEVEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `FOUR;
					NMS_regAddr	= `TWO;
					NMS_readEn	= 1'b0;
						
				end
				
			`TEN:
				begin
					nextState = `ELEVEN;
					//FD control
					FD_calAddr = `TEN;
					FD_regAddr = `EIGHT;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `FIVE;
					NMS_regAddr	= `THREE;
					NMS_readEn	= 1'b0;
					
				end
				
			`ELEVEN:
				begin
					nextState = `TWELVE;
					//FD control
					FD_calAddr = `ELEVEN;
					FD_regAddr = `NINE;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `SIX;
					NMS_regAddr = `FOUR;
					NMS_readEn	= 1'b0;
					
				end
				
			`TWELVE:
				begin
					nextState = `THIRTEEN;
					//FD control
					FD_calAddr = `TWELVE;
					FD_regAddr = `TEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `SEVEN;
					NMS_regAddr = `FIVE;
					NMS_readEn	= 1'b0;
					
				end
				
			`THIRTEEN:
				begin
					nextState = `FOURTEEN;
					//FD control
					FD_calAddr = `THIRTEEN;
					FD_regAddr = `ELEVEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr	= `INIT;
					NMS_regAddr	= `SEVEN;
					NMS_readEn	= 1'b0;
				end
				
			`FOURTEEN: 
				begin
					nextState = `FIFTEEN;
					//FD control
					FD_calAddr = `FOURTEEN;
					FD_regAddr = `TWELVE;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `ONE;
					NMS_regAddr	= `EIGHT;
					NMS_readEn	= 1'b0;
				end
				
			`FIFTEEN:
				begin
					nextState = `SIXTEEN;
					//FD control
					FD_calAddr = `FIFTEEN;
					FD_regAddr = `THIRTEEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr = `TWO;
					NMS_regAddr	= `INIT;
					NMS_readEn	= 1'b0;
				end
				
			`SIXTEEN:
				begin
					nextState = `INIT;
					//FD control
					FD_calAddr = `SIXTEEN;
					FD_regAddr = `FOURTEEN;
					FD_readEn = 1'b0;
					FS_writeEn = 1'b0;
					FS_readEn = 1'b1;
					NMS_calAddr	= `THREE;
					NMS_regAddr	= `ONE;
					NMS_readEn	= 1'b0;
					
				end
			default:
				begin
					nextState = 5'bx;
					//FD control
					FD_calAddr = 5'bx;
					FD_regAddr = 5'bx;
					FD_readEn = 1'bx;
					FS_writeEn = 1'bx;
					FS_readEn = 1'bx;
					NMS_calAddr	=	5'bx;
					NMS_regAddr = 5'bx;
					NMS_readEn	= 1'bx;
				end
			endcase
endmodule 