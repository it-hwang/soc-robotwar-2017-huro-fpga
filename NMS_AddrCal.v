module NMS_AddrCal(
						//input
						refAddr, regAddr, 
						 
						//output
						srmAddr);

	input		[14:0]	refAddr;
	input		[3:0]		regAddr;
	output	[14:0]	srmAddr;
	
	wire	[14:0]	tempAddr;
	
	assign tempAddr	=	refAddr;
	
	assign srmAddr		=	(regAddr == 4'b0000) ? tempAddr	:
								(regAddr == 4'b0001) ? tempAddr - 181 :
								(regAddr == 4'b0010) ? tempAddr - 180 :
								(regAddr == 4'b0011) ? tempAddr - 179 :
								(regAddr == 4'b0100) ? tempAddr - 1   :
								(regAddr == 4'b0101) ? tempAddr + 1   :
								(regAddr == 4'b0110) ? tempAddr + 179 :
								(regAddr == 4'b0111) ? tempAddr + 180 :
								(regAddr == 4'b1000) ? tempAddr + 181 : 15'bx;

endmodule 