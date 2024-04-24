module mp_top (clk, instruction , result );	 
	
	input clk;
	input [31:0] instruction;
	output reg [31:0] result;
	
	

	
	//if you want to read in the other direction use this 
	wire [5:0]opcode = machine_instruction[5:0];
	wire [4:0]addr1  = machine_instruction[10:6];
	wire [4:0]addr2  = machine_instruction[15:11];
	wire [4:0]addr3  = machine_instruction[20:16]; 	
	
	
	
	wire [31:0] machine_instruction;//output of instruction reg
    wire VOP;  //valid opcode flag (input for the reg file)
    wire [31:0] operand1;//output from reg file input for alu
    wire [31:0] operand2;//output from reg file input for alu
    wire [31:0] alu_result;//output from alu and the design input for reg file  


	
	 
	reg_32bit IR( clk, instruction,machine_instruction );//instriction reg 
	

	valid_opcode valid_opcode_inst(opcode,VOP);//valid opcode checker
	
   
    reg_file reg_file_inst (clk,VOP,addr1,addr2,addr3,result,operand1,operand2);//reg filr
      
    
    alu alu_inst (opcode,operand1,operand2,result);//alu
	
endmodule	



module alu (opcode, a, b, result );	  
	
	input [5:0] opcode;
	input [31:0] a, b;
	output reg [31:0] result;
	
	//opcode for operation according to my student ID 1181062 (so i take 2)
    parameter ADD    = 6'b000110,//6
              SUB    = 6'b001001,//9
              ABS    = 6'b000001,//1
              MINUS  = 6'b000101,//5
              MAX    = 6'b000111,//7
              MIN    = 6'b001000,//8
              AVG    = 6'b001011,//11
              NOT_OP = 6'b001110,//14
              OR_OP  = 6'b001101,//13
              AND_OP = 6'b001100,//12
              XOR_OP = 6'b000100;//4

    always @* begin	//compinational module
        case(opcode)//according to opcode do operatin X	
			//every operation implementation
            ADD: result <= a + b;
            SUB: result <= a - b;
            ABS: if (a[31]==1) result <= -a; else result <= a;
            MINUS: result <= ~a + 1;
            MAX: if (a > b) result <= a; else result <= b;
            MIN: if (a > b) result <= b; else result <= a;
            AVG: result <= (a + b) >> 1;  
            NOT_OP: result <= ~a;
            OR_OP: result <= a | b;
            AND_OP: result <= a & b;
            XOR_OP: result <= a ^ b;	 
			default: result <= 32'hxxxxxxxx;//if the opcode not valid the result dont care
        endcase
    end

endmodule






module reg_file (clk, valid_opcode, addr1, addr2, addr3, in , out1, out2);
	
	input clk;
	input valid_opcode;
	input [4:0] addr1, addr2, addr3;
	input [31:0] in;
	output reg [31:0] out1, out2;
	
    reg [31:0] registers [31:0];//32 registers all registers size in 32
	
    initial begin
      // Initialize registers with data (6) because my ID is 1181062
      registers[0]  = 32'h00000000;	// 0
      registers[1]  = 32'h00001208; // 4616
      registers[2]  = 32'h00002D78; // 11640
      registers[3]  = 32'h00002BF6; // 11254
      registers[4]  = 32'h00001A82; // 6786
      registers[5]  = 32'h00001A80; // 6784
      registers[6]  = 32'h00003090; // 12432
      registers[7]  = 32'h000034EC; // 13548
      registers[8]  = 32'h00003496; // 13462
      registers[9]  = 32'h0000348E; // 13454
      registers[10] = 32'h00002E04; // 11780
      registers[11] = 32'h00003372; // 13170
      registers[12] = 32'h00000BA6; // 2982
      registers[13] = 32'h00001FA0; // 8096
      registers[14] = 32'h00000202; // 514
      registers[15] = 32'h00000E10; // 3600
      registers[16] = 32'h00002A76; // 10870
      registers[17] = 32'h000030F0; // 12528
      registers[18] = 32'h00002684; // 9860
      registers[19] = 32'h00001816; // 6166
      registers[20] = 32'h000011A8; // 4520
      registers[21] = 32'h00003864; // 14436
      registers[22] = 32'h00002F68; // 12136
      registers[23] = 32'h0000140E; // 5134
      registers[24] = 32'h00002EB6; // 11958
      registers[25] = 32'h00001E08; // 7688
      registers[26] = 32'h0000148A; // 5258
      registers[27] = 32'h00003084; // 12420
      registers[28] = 32'h00000DE8; // 3560
      registers[29] = 32'h000004E0; // 1248
      registers[30] = 32'h00002214; // 8724
      registers[31] = 32'h00000000;	// 0
    end
   always @(posedge clk)
    begin
		#1//delay to synchronize 
        out1 <= registers[addr1]; 
		#1
        out2 <= registers[addr2];
    end
	
	always @(posedge clk)//if the opcode valid change the data
    begin
		#3//to make sure that the alu finish
            if(valid_opcode==1)registers[addr3] <= in;
    end


endmodule


module valid_opcode(opcode,valid_flag); //module to check if the opcode valid or not
	
	input  [5:0] opcode;
	output reg valid_flag;
	
	//according to my ID these are the invalid opcodes
	// 0 2 3 10 15 and any opcode above 15
	
	wire w1,w2,w3,w4,w5,w6;
	nor (w1,opcode[5],opcode[4]);//to detect that the number <= 15 
	nand (w2,opcode[3],opcode[2],opcode[1],opcode[0]);//to detect that the number != 15
	nand (w3,~opcode[3],~opcode[2],~opcode[1],~opcode[0]);//to detect that the number != 1
	nand (w4,opcode[3],~opcode[2],opcode[1],~opcode[0]);//to detect that the number != 10
	nand (w5,~opcode[3],~opcode[2],opcode[1],opcode[0]);//to detect that the number != 3
	nand (w6,~opcode[3],~opcode[2],opcode[1],~opcode[0]);//to detect that the number != 2  
	and  (valid_flag,w1,w2,w3,w4,w5,w6);//if the opcode pass all the conditions then its valid
	
endmodule		 

module reg_32bit ( clk,data_in, data_out );//register		
  	input clk;     
    input [31:0] data_in;
    output reg [31:0] data_out;
    always @(posedge clk) begin	
        data_out <= data_in; 
    end
endmodule
