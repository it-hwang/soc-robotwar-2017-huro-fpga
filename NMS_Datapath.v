module NMS_Datapath(refPxl,
						  nighScore0, nighScore1, nighScore2, nighScore3,
						  nighScore4, nighScore5, nighScore6, nighScore7,
						  refScore,
						  
						  //outrefPxl,
						  NMS_isCorner);
						  
	input[7:0] refPxl;
	input[11:0] nighScore0, nighScore1, nighScore2, nighScore3,
				  nighScore4, nighScore5, nighScore6, nighScore7,
				  refScore;
				  
	//output[7:0]outrefPxl;
	output NMS_isCorner;
	
	wire JudgerefScore;
	
	
	assign JudgerefScore = (refScore > nighScore0) &&
	                       (refScore > nighScore1) &&
								  (refScore > nighScore2) &&
								  (refScore > nighScore3) &&
								  (refScore > nighScore4) &&
								  (refScore > nighScore5) &&
								  (refScore > nighScore6) &&
								  (refScore > nighScore7);
	
	//assign outrefPxl = (JudgerefScore == 1) ? refPxl : 8'b0;
	assign NMS_isCorner = (JudgerefScore == 1) ? 1'b1 : 1'b0;

endmodule 