module FD_AddrCal(refAddr, regAddr, srmAddr);

	input		[14:0]	refAddr;
	input		[4:0]		regAddr;
	output	[14:0]	srmAddr;
	
	wire	[14:0]	tempAddr;
	
	assign tempAddr = refAddr;
	
	assign srmAddr = (regAddr == 5'b00000) ? tempAddr :
						(regAddr == 5'b00001) ? tempAddr - 540 :
						(regAddr == 5'b00010) ? tempAddr - 539 :
						(regAddr == 5'b00011) ? tempAddr - 358 :
						(regAddr == 5'b00100) ? tempAddr - 177 :
						(regAddr == 5'b00101) ? tempAddr + 3 	:
						(regAddr == 5'b00110) ? tempAddr + 183	:
						(regAddr == 5'b00111) ? tempAddr + 362 :
						(regAddr == 5'b01000) ? tempAddr + 541	:
						(regAddr == 5'b01001) ? tempAddr + 540	:
						(regAddr == 5'b01010) ? tempAddr + 539	:
						(regAddr == 5'b01011) ? tempAddr + 358	:
						(regAddr == 5'b01100) ? tempAddr + 177	:
						(regAddr == 5'b01101) ? tempAddr - 3	:
						(regAddr == 5'b01110) ? tempAddr - 183	:
						(regAddr == 5'b01111) ? tempAddr - 362	:
						(regAddr == 5'b10000) ? tempAddr - 541	: 15'bx;

endmodule 