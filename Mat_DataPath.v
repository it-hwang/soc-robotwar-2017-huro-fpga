`define DB_9 	13'b0000000010000
`define DB_8 	13'b0000000000000
`define DB_7 	13'b1000000000000
`define DB_6 	13'b0101000000000
`define DB_5 	13'b1000100010000
`define DB_4 	13'b0101001000000
`define DB_3 	13'b0101001000000
`define DB_2 	13'b1000100010000
`define DB_1 	13'b0000001000000
`define DB_0 	13'b0000000010000



module Mat_DataPath(
						  RefPxl,	//input 
						  IsCorner,
						  SelPxl1, SelPxl2, SelPxl3, SelPxl4, SelPxl5, SelPxl6,
						  SelPxl7, SelPxl8, SelPxl9, SelPxl10, SelPxl11, SelPxl12,
						  SelPxl13, SelPxl14, SelPxl15, SelPxl16, SelPxl17, SelPxl18,
						  SelPxl19, SelPxl20, SelPxl21, SelPxl22, SelPxl23, SelPxl24,
						  SelPxl25, SelPxl26, 
						  Threshold,
						  IsMatching //output
						  
						  );
						  
	input [7:0] RefPxl,
					SelPxl1, SelPxl2, SelPxl3, SelPxl4, SelPxl5, SelPxl6,
					SelPxl7, SelPxl8, SelPxl9, SelPxl10, SelPxl11, SelPxl12,
					SelPxl13, SelPxl14, SelPxl15, SelPxl16, SelPxl17, SelPxl18,
					SelPxl19, SelPxl20, SelPxl21, SelPxl22, SelPxl23, SelPxl24,
					SelPxl25, SelPxl26, 
					Threshold;
	input IsCorner;
	
	output IsMatching;
	
	
	wire [12:0] BitString;
	
	wire [9:0] MatArray;
	
	//For XOR compare
	wire [12:0]XOR_CmpArray0;
	wire [12:0]XOR_CmpArray1;
	wire [12:0]XOR_CmpArray2;
	wire [12:0]XOR_CmpArray3;
	wire [12:0]XOR_CmpArray4;
	wire [12:0]XOR_CmpArray5;
	wire [12:0]XOR_CmpArray6;
	wire [12:0]XOR_CmpArray7;
	wire [12:0]XOR_CmpArray8;
	wire [12:0]XOR_CmpArray9;
	
	
	
	//Create BitString
	assign BitString[12] = (SelPxl1 < SelPxl2) ? 1 : 0;
	assign BitString[11] = (SelPxl3 < SelPxl4) ? 1 : 0;
	assign BitString[10] = (SelPxl5 < SelPxl6) ? 1 : 0;
	assign BitString[9] = (SelPxl7 < SelPxl8) ? 1 : 0;
	assign BitString[8] = (SelPxl9 < SelPxl10) ? 1 : 0;
	
	assign BitString[7] = (SelPxl11 < SelPxl12) ? 1 : 0;
	assign BitString[6] = (SelPxl13 < SelPxl14) ? 1 : 0;
	assign BitString[5] = (SelPxl15 < SelPxl16) ? 1 : 0;
	assign BitString[4] = (SelPxl17 < SelPxl18) ? 1 : 0;
	assign BitString[3] = (SelPxl19 < SelPxl20) ? 1 : 0;
	
	assign BitString[2] = (SelPxl21 < SelPxl22) ? 1 : 0;
	assign BitString[1] = (SelPxl23 < SelPxl24) ? 1 : 0;
	assign BitString[0] = (SelPxl25 < SelPxl26) ? 1 : 0;

	//XOR cmp
	assign XOR_CmpArray9 = BitString ^ `DB_9;
	assign XOR_CmpArray8 = BitString ^ `DB_8;
	assign XOR_CmpArray7 = BitString ^ `DB_7;
	assign XOR_CmpArray6 = BitString ^ `DB_6;
	assign XOR_CmpArray5 = BitString ^ `DB_5;
	
	assign XOR_CmpArray4 = BitString ^ `DB_4;
	assign XOR_CmpArray3 = BitString ^ `DB_3;
	assign XOR_CmpArray2 = BitString ^ `DB_2;
	assign XOR_CmpArray1 = BitString ^ `DB_1;
	assign XOR_CmpArray0 = BitString ^ `DB_0;
	
	//Detect (XOR Threshold = 5) , IsMatching Threshold = 8
	assign MatArray[9] =((
							   XOR_CmpArray9[12] + XOR_CmpArray9[11] +
							   XOR_CmpArray9[10] + XOR_CmpArray9[9] +
								XOR_CmpArray9[8] + XOR_CmpArray9[7] + 
								XOR_CmpArray9[6] + XOR_CmpArray9[5] +
								XOR_CmpArray9[4] + XOR_CmpArray9[3] + 
								XOR_CmpArray9[2] + XOR_CmpArray9[1] +
								XOR_CmpArray9[0]) < 4) ? 1 : 0;
								
	assign MatArray[8] =((
							   XOR_CmpArray8[12] + XOR_CmpArray8[11] +
							   XOR_CmpArray8[10] + XOR_CmpArray8[9] +
								XOR_CmpArray8[8] + XOR_CmpArray8[7] + 
								XOR_CmpArray8[6] + XOR_CmpArray8[5] +
								XOR_CmpArray8[4] + XOR_CmpArray8[3] + 
								XOR_CmpArray8[2] + XOR_CmpArray8[1] +
								XOR_CmpArray8[0]) < 4) ? 1 : 0;
								
	assign MatArray[7] =((
							   XOR_CmpArray7[12] + XOR_CmpArray7[11] +
							   XOR_CmpArray7[10] + XOR_CmpArray7[9] +
								XOR_CmpArray7[8] + XOR_CmpArray7[7] + 
								XOR_CmpArray7[6] + XOR_CmpArray7[5] +
								XOR_CmpArray7[4] + XOR_CmpArray7[3] + 
								XOR_CmpArray7[2] + XOR_CmpArray7[1] +
								XOR_CmpArray7[0]) < 4) ? 1 : 0;
								
	assign MatArray[6] =((
							   XOR_CmpArray6[12] + XOR_CmpArray6[11] +
							   XOR_CmpArray6[10] + XOR_CmpArray6[9] +
								XOR_CmpArray6[8] + XOR_CmpArray6[7] + 
								XOR_CmpArray6[6] + XOR_CmpArray6[5] +
								XOR_CmpArray6[4] + XOR_CmpArray6[3] + 
								XOR_CmpArray6[2] + XOR_CmpArray6[1] +
								XOR_CmpArray6[0]) < 4) ? 1 : 0;
	
	assign MatArray[5] =((
							   XOR_CmpArray5[12] + XOR_CmpArray5[11] +
							   XOR_CmpArray5[10] + XOR_CmpArray5[9] +
								XOR_CmpArray5[8] + XOR_CmpArray5[7] + 
								XOR_CmpArray5[6] + XOR_CmpArray5[5] +
								XOR_CmpArray5[4] + XOR_CmpArray5[3] + 
								XOR_CmpArray5[2] + XOR_CmpArray5[1] +
								XOR_CmpArray5[0]) < 4) ? 1 : 0;
								
	assign MatArray[4] =((
							   XOR_CmpArray4[12] + XOR_CmpArray4[11] +
							   XOR_CmpArray4[10] + XOR_CmpArray4[9] +
								XOR_CmpArray4[8] + XOR_CmpArray4[7] + 
								XOR_CmpArray4[6] + XOR_CmpArray4[5] +
								XOR_CmpArray4[4] + XOR_CmpArray4[3] + 
								XOR_CmpArray4[2] + XOR_CmpArray4[1] +
								XOR_CmpArray4[0]) < 4) ? 1 : 0;
								
	assign MatArray[3] =((
							   XOR_CmpArray3[12] + XOR_CmpArray3[11] +
							   XOR_CmpArray3[10] + XOR_CmpArray3[9] +
								XOR_CmpArray3[8] + XOR_CmpArray3[7] + 
								XOR_CmpArray3[6] + XOR_CmpArray3[5] +
								XOR_CmpArray3[4] + XOR_CmpArray3[3] + 
								XOR_CmpArray3[2] + XOR_CmpArray3[1] +
								XOR_CmpArray3[0]) < 4) ? 1 : 0;
								
	assign MatArray[2] =((
							   XOR_CmpArray2[12] + XOR_CmpArray2[11] +
							   XOR_CmpArray2[10] + XOR_CmpArray2[9] +
								XOR_CmpArray2[8] + XOR_CmpArray2[7] + 
								XOR_CmpArray2[6] + XOR_CmpArray2[5] +
								XOR_CmpArray2[4] + XOR_CmpArray2[3] + 
								XOR_CmpArray2[2] + XOR_CmpArray2[1] +
								XOR_CmpArray2[0]) < 4) ? 1 : 0;
								
	assign MatArray[1] =((
							   XOR_CmpArray1[12] + XOR_CmpArray1[11] +
							   XOR_CmpArray1[10] + XOR_CmpArray1[9] +
								XOR_CmpArray1[8] + XOR_CmpArray1[7] + 
								XOR_CmpArray1[6] + XOR_CmpArray1[5] +
								XOR_CmpArray1[4] + XOR_CmpArray1[3] + 
								XOR_CmpArray1[2] + XOR_CmpArray1[1] +
								XOR_CmpArray1[0]) < 4) ? 1 : 0;
								
	assign MatArray[0] =((
							   XOR_CmpArray0[12] + XOR_CmpArray0[11] +
							   XOR_CmpArray0[10] + XOR_CmpArray0[9] +
								XOR_CmpArray0[8] + XOR_CmpArray0[7] + 
								XOR_CmpArray0[6] + XOR_CmpArray0[5] +
								XOR_CmpArray0[4] + XOR_CmpArray0[3] + 
								XOR_CmpArray0[2] + XOR_CmpArray0[1] +
								XOR_CmpArray0[0]) < 4) ? 1 : 0;
	
	assign IsMatching =( ((MatArray[9] + MatArray[8] +
							     MatArray[7] + MatArray[6] +
							     MatArray[5] + MatArray[4] +
							     MatArray[3] + MatArray[2] +
							     MatArray[1] + MatArray[0]) >= 8) & IsCorner) ? 1 : 0;
endmodule
	
	
	
	
	
	
	