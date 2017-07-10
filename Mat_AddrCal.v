module Mat_AddrCal(refAddr, regAddr, srmAddr);

	input [14:0] refAddr;
	input [4:0] regAddr;
	output[14:0] srmAddr;
	
	wire [14:0]  tempAddr;
	
	assign tempAddr = refAddr;
	
/*
        *
      * * *
    * * * * * 
* * * * r * * * *
    * * * * * 
      * * *
        *
*/
	assign srmAddr = (regAddr == 5'b00000) ? tempAddr:
						  (regAddr == 5'b00001) ? tempAddr - 540:
						  (regAddr == 5'b00010) ? tempAddr - 361:
						  (regAddr == 5'b00011) ? tempAddr - 360:
						  (regAddr == 5'b00100) ? tempAddr - 359:
						  (regAddr == 5'b00101) ? tempAddr - 182:
						  (regAddr == 5'b00110) ? tempAddr - 181:
						  (regAddr == 5'b00111) ? tempAddr - 180:
						  (regAddr == 5'b01000) ? tempAddr - 179:
						  (regAddr == 5'b01001) ? tempAddr - 178:
						  (regAddr == 5'b01010) ? tempAddr -   4:
						  (regAddr == 5'b01011) ? tempAddr -   3:
						  (regAddr == 5'b01100) ? tempAddr -   2:
						  (regAddr == 5'b01101) ? tempAddr -   1:
						  (regAddr == 5'b01110) ? tempAddr +   1:
						  (regAddr == 5'b01111) ? tempAddr +   2:
						  (regAddr == 5'b10000) ? tempAddr +   3:
						  (regAddr == 5'b10001) ? tempAddr +   4:
						  (regAddr == 5'b10010) ? tempAddr + 178:
						  (regAddr == 5'b10011) ? tempAddr + 179:
						  (regAddr == 5'b10100) ? tempAddr + 180:
						  (regAddr == 5'b10101) ? tempAddr + 181:
						  (regAddr == 5'b10110) ? tempAddr + 182:
						  (regAddr == 5'b10111) ? tempAddr + 359:
						  (regAddr == 5'b11000) ? tempAddr + 360:
						  (regAddr == 5'b11001) ? tempAddr + 361:
						  (regAddr == 5'b11010) ? tempAddr + 540:15'bx;
						  
endmodule
