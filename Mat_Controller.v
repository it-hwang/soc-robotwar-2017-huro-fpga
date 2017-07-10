`define INIT			5'b00000
`define ONE				5'b00001
`define TWO				5'b00010
`define THREE			5'b00011
`define FOUR			5'b00100
`define FIVE			5'b00101
`define SIX				5'b00110
`define SEVEN			5'b00111
`define EIGHT			5'b01000
`define NINE			5'b01001
`define TEN				5'b01010
`define ELEVEN			5'b01011
`define TWELVE			5'b01100
`define THIRTEEN		5'b01101
`define FOURTEEN		5'b01110
`define FIFTEEN		5'b01111
`define SIXTEEN		5'b10000
`define SEVENTEEN 	5'b10001
`define EIGHTTEEN 	5'b10010
`define NINETEEN 		5'b10011
`define TWENTY			5'b10100
`define TWENTYONE 	5'b10101
`define TWENTYTWO 	5'b10110
`define TWENTYTHREE	5'b10111
`define TWENTYFOUR	5'b11000
`define TWENTYFIVE 	5'b11001
`define TWENTYSIX 	5'b11010
`define TWENTYSEVEN	5'b11011
`define TWENTYEIGHT 	5'b11100
`define TWENTYNINE 	5'b11101
`define THIRTY			5'b11110

module Mat_Controller(
	nRESET, clk, input_addr,
	
	refAddr, readEn, regAddr, regAddrToCal);
	
	input nRESET;
	input clk;
	input	[15:0]	input_addr;
	
	output readEn;
	output [4:0]	regAddr;
	output [4:0]	regAddrToCal;
	output [15:0]	refAddr;

	reg [4:0] curState, nextState, regAddrToCal;
	reg [4:0] regAddr;
	reg readEn;
	
	//refAddr = input_addr - 722;
	assign refAddr = input_addr - 16'b0000001011010010;
	
	always@ (posedge clk or negedge nRESET)
		if(!nRESET)
			curState <= `ONE;
		else
			curState <= nextState;
				
	always@(curState)
		casex(curState)
			`INIT:
				begin
					nextState	=	`ONE;
					regAddr		=	`INIT;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYNINE;
				end
			
			`ONE:
				begin
					nextState	=	`TWO;
					regAddr		=	`ONE;
					readEn		=	1'b0;
					regAddrToCal	=	`THIRTY;
				end
	
			`TWO:
				begin
					nextState	=	`THREE;
					regAddr		=	`TWO;		
					readEn		=	1'b0;
					regAddrToCal	=	`INIT;
				end
				
			`THREE:
				begin
					nextState	=	`FOUR;
					regAddr		=	`THREE;
					readEn		=	1'b0;
					regAddrToCal	=	`ONE;
				end
				
			`FOUR:
				begin
					nextState	=	`FIVE;
					regAddr		=	`FOUR;
					readEn		=	1'b0;		
					regAddrToCal	=	`TWO;
				end
			
			`FIVE:
				begin
					nextState	=	`SIX;
					regAddr		=	`FIVE;		
					readEn		=	1'b0;
					regAddrToCal	=	`THREE;
				end
				
			`SIX:
				begin
					nextState	=	`SEVEN;
					regAddr		=	`SIX;	
					readEn		=	1'b0;
					regAddrToCal	=	`FOUR;
				end
				
			`SEVEN:
				begin
					nextState	=	`EIGHT;
					regAddr		=	`SEVEN;
					readEn		=	1'b0;
					regAddrToCal	=	`FIVE;
				end
				
			`EIGHT:
				begin
					nextState	=	`NINE;
					regAddr		=	`EIGHT;
					readEn		=	1'b0;
					regAddrToCal	=	`SIX;
				end
				
			`NINE:
				begin
					nextState	=	`TEN;
					regAddr		=	`NINE;
					readEn		=	1'b0;
					regAddrToCal	=	`SEVEN;		
				end
				
			`TEN:
				begin
					nextState	=	`ELEVEN;
					regAddr		=	`TEN;
					readEn		=	1'b0;
					regAddrToCal	=	`EIGHT;
				end
				
			`ELEVEN:
				begin
					nextState	=	`TWELVE;
					regAddr		=	`ELEVEN;
					readEn		=	1'b0;
					regAddrToCal	=	`NINE;
				end
				
			`TWELVE:
				begin
					nextState	=	`THIRTEEN;
					regAddr		=	`TWELVE;
					readEn		=	1'b0;
					regAddrToCal	=	`TEN;
				end
				
			`THIRTEEN:
				begin
					nextState	=	`FOURTEEN;
					regAddr		=	`THIRTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`ELEVEN;
				end
				
			`FOURTEEN: 
				begin
					nextState	=	`FIFTEEN;
					regAddr		=	`FOURTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`TWELVE;
				end
				
			`FIFTEEN:
				begin
					nextState	=	`SIXTEEN;
					regAddr		=	`FIFTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`THIRTEEN;
				end
				
			`SIXTEEN:
				begin
					nextState	=	`SEVENTEEN;
					regAddr		=	`SIXTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`FOURTEEN;
				end
			
			`SEVENTEEN:
				begin
					nextState	=	`EIGHTTEEN;
					regAddr		=	`SEVENTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`FIFTEEN;
				end
			
			`EIGHTTEEN:
				begin
					nextState	=	`NINETEEN;
					regAddr		=	`EIGHTTEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`SIXTEEN;
				end
		
			`NINETEEN:
				begin
					nextState	=	`TWENTY;
					regAddr		=	`NINETEEN;
					readEn		=	1'b0;
					regAddrToCal	=	`SEVENTEEN;
				end
				
			`TWENTY:
				begin
					nextState	=	`TWENTYONE;
					regAddr		=	`TWENTY;
					readEn		=	1'b0;
					regAddrToCal	=	`EIGHTTEEN;
				end
				
			`TWENTYONE:
				begin
					nextState	=	`TWENTYTWO;
					regAddr		=	`TWENTYONE;
					readEn		=	1'b0;
					regAddrToCal	=	`NINETEEN;
				end
				
			`TWENTYTWO:
				begin
					nextState	=	`TWENTYTHREE;
					regAddr		=	`TWENTYTWO;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTY;
				end
				
			`TWENTYTHREE:
				begin
					nextState	=	`TWENTYFOUR;
					regAddr		=	`TWENTYTHREE;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYONE;
				end
			
			`TWENTYFOUR:
				begin
					nextState	=	`TWENTYFIVE;
					regAddr		=	`TWENTYFOUR;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYTWO;
				end
				
			`TWENTYFIVE:
				begin
					nextState	=	`TWENTYSIX;
					regAddr		=	`TWENTYFIVE;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYTHREE;
				end
				
			`TWENTYSIX:
				begin
					nextState	=	`TWENTYSEVEN;
					regAddr		=	`TWENTYSIX;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYFOUR;
				end
				
			`TWENTYSEVEN:
				begin
					nextState	=	`TWENTYEIGHT;
					regAddr		=	`TWENTYSEVEN;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYFIVE;
				end
				
			`TWENTYEIGHT:
				begin
					nextState	=	`TWENTYNINE;
					regAddr		=	`TWENTYEIGHT;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYSIX;
				end
				
			`TWENTYNINE:
				begin
					nextState	=	`THIRTY;
					regAddr		=	`TWENTYNINE;
					readEn		=	1'b1;
					regAddrToCal	=	`TWENTYSEVEN;
				end
				
			`THIRTY:
				begin
					nextState	=	`INIT;
					regAddr		=	`THIRTY;
					readEn		=	1'b0;
					regAddrToCal	=	`TWENTYEIGHT;
				end
			
			default:
				begin
					nextState = 1'bx;
					regAddr		=	5'bx;
					readEn		=	1'b0;
					regAddrToCal	=	5'bx;
				end
			endcase
endmodule 