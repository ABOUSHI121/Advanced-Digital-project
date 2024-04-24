module mp_top_TB;
	
	//reg for inputs wire for outputs
    reg clk;
    reg [31:0] instruction;
    wire [31:0] result;	
	reg [31:0]expected_result;
	
	int passed_flag = 1 ;//flag to check if all cases passed, the flag change only if there is a failed case
    
    mp_top mp_top_inst (clk,instruction,result);// Instantiate the mp_top module
      

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Stimulus generation
    initial begin
        // Test Case 1 (R20 = R3 + R18)	 
		#10
        instruction = 32'b00000000000101001001000011000110;		 
		#20	  
		expected_result=32'h0000527A;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end
       
		
			
			
			
			
			
			
			// Test Case 2 ( R18 = R14 - R20)
        instruction = 32'b00000000000100101010001110001001;
        #20	  
		expected_result=32'hFFFFAF88;
        if (result != expected_result)begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end 
        
			
			
			
			
			
			// Test Case 3 ( R6 = abs R18) R18 is the result of the previous case (it will be minus) so here we can make sure from the write on reg file
        instruction = 32'b00000000000001100000010010000001;
        #20			
		expected_result=32'h00005078;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
      
			
			
			
			
			// Test Case 4 (R7 = -R18) this case must give the same answer of case 3 because R18 negative so -R18=|R18|
        instruction = 32'b00000000000001110000010010000101;
        #20			  
		expected_result=32'h00005078;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
      
			
			
			
			
			
			// Test Case 5(R4 = MAX(R20 , R3)) 
        instruction = 32'b00000000000001000001110100000111;
        #20
		expected_result=32'h0000527A;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
       
			
			
			
			
			// Test Case 6 (R5 = MIN(R13,R5))
      
		instruction = 32'b00000000000001010010101101001000;
        #20	  
		expected_result=32'h00001A80;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
       
			
			
			
			
			// Test Case 7 (R19 = AVG(R18 R7))this will give zero because R7 = -R18
        instruction = 32'b00000000000100110011110010001011;
        #20
		expected_result=32'h00000000;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
       
			
			
			
			
			// Test Case 8(R23 =  ~R5)
        instruction = 32'b00000000000101110000000101001110;
        #20
		expected_result=32'hFFFFE57F;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
       
			
			
			
			// Test Case 9 (R6 = R25 OR R9)
        instruction = 32'b00000000000001100100111001001101;
        #20	 
		expected_result=32'h00003E8E;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
       
			
			
			
			// Test Case 10 (R30 = R9 AND R26)
        instruction = 32'b00000000000111101101001001001100;
        #20
		expected_result=32'h0000148A;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
      
			
			
			
			// Test Case 11 (R14 = R24 XOR R8)
        instruction = 32'b00000000000011100100011000000100;
        #20	  
		expected_result=32'h00001A20;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
			
			
			
			// Test Case 12	 (invalid operation to check the output in this case and check if the reg file update or not)
        instruction = 32'b00000000000111000100011000000000;
        #20		   
		expected_result=32'hxxxxxxxx;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end  
			
			
			
		
			
			
			// Test Case 13	 R1=R1+R1 (check is i used the two operands from the same address and write on it)
       instruction = 32'b00000000000000010000100001000110;
	   #20	   
	   expected_result=32'h00002410;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display           ("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end 
		
		
		// Test Case 14 in this we try to check if case 12 update the value to xxx or not (it must not)
        instruction = 32'b00000000000111110000001110000001;
        #20		   
		expected_result=32'h00001A20;
        if (result != expected_result) begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,      Test Failed!", $time, result, expected_result);
			$display();
			passed_flag=0;	
		end		
		else begin
			$display("Time=%3t,      Actual Result=%10h,       Expected Result=%10h,       Test Passed", $time, result, expected_result);
			$display();	
		end 
		
		$display();
		$display();
		if(passed_flag)$display("                                     THE TEST PASSED "); 
		else $display          ("                                     THE TEST FAILED ! ");
		$display();
		$display();
		$display();
        // stop simulation after all test cases
        $finish;
    end


endmodule


module alu_TB; //alu test bench	
	
	//reg for inputs wire for outputs

    reg [5:0] opcode;
    reg [31:0] a, b;
    wire [31:0] result;

    
    alu alu_inst (opcode,a,b,result); // instantiate the alu module



    
    initial begin	 
        // Test Case 1 - ADD
        opcode = 6'b000110;
        a = 32'h0000000A;
        b = 32'h00000005;
        #10;

        // Test Case 2 - SUB
        opcode = 6'b001001;
        a = 32'h0000000A;
        b = 32'h00000005;
        #10;

        // Test Case 3 - ABS
        opcode = 6'b000001;
        a = 32'hFFFFFFF5;
        b = 32'h00000000;
        #10;

        // Test Case 4 - MINUS
        opcode = 6'b000101;
        a = 32'h0000000A;
        b = 32'h00000000;
        #10;

        // Test Case 5 - MAX
        opcode = 6'b000111;
        a = 32'h0000000A;
        b = 32'h00000005;
        #10;

        // Test Case 6 - MIN
        opcode = 6'b001000;
        a = 32'h0000000A;
        b = 32'h00000005;
        #10;

        // Test Case 7 - AVG
        opcode = 6'b001011;
        a = 32'h0000000A;
        b = 32'h00000005;
        #10;

        // Test Case 8 - NOT_OP
        opcode = 6'b001110;
        a = 32'h0000FFFF;
        b = 32'h00000000;
        #10;

        // Test Case 9 - OR_OP
        opcode = 6'b001101;
        a = 32'h0000FFFF;
        b = 32'hFFFF0000;
        #10;

        // Test Case 10 - AND_OP
        opcode = 6'b001100;
        a = 32'h0000FFFF;
        b = 32'hFFFF0000;
        #10;

		
		 // Test Case 11 - invalid
        opcode = 6'b000000;
        a = 32'h0000FFFF;
        b = 32'hFFFF0000;
        #10;
		
		 // Test Case 12 - XOR_OP
        opcode = 6'b000100;
        a = 32'h0000FFFF;
        b = 32'hFFFF0000;
        #10;

        $finish;
    end
endmodule		   





module valid_opcode_tb;				 
	
	//reg for inputs wire for outputs
    
	reg [5:0] opcode;
    wire valid_flag;

    
    valid_opcode uut (opcode,valid_flag);// instantiate the valid_opcode module
	
    initial begin
        // Test Case 1
        opcode = 6'b000000;
        #10;
       

        // Test Case 2
        opcode = 6'b111111;
        #10;
        

        // Test Case 3
        opcode = 6'b010101;
        #10;
        

        // Test Case 4
        opcode = 6'b100000;
        #10;
      

        // Test Case 5
        opcode = 6'b011111;
        #10;
        
			
		 // Test Case 6
        opcode = 6'b000001;
        #10;
		
		 // Test Case 7
        opcode = 6'b000111;
        #10;
		
		 // Test Case 8
        opcode = 6'b000010;
        #10;
		
		 // Test Case 9
        opcode = 6'b001011;
        #10;
		
		 // Test Case 10
        opcode = 6'b001010;
        #10;
		

        $finish;
    end
endmodule





module reg_file_tb;	 				 
	
	//reg for inputs wire for outputs
	
    reg clk;
    reg valid_opcode;
    reg [4:0] addr1, addr2, addr3;
    reg [31:0] in;
    wire [31:0] out1, out2;

    
    reg_file uut (clk,valid_opcode,addr1,addr2,addr3,in,out1,out2);// instantiate the reg file module

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin 

        // Test Case 1
        valid_opcode = 1'b1;
        addr1 = 5'b00000;
        addr2 = 5'b00000;
        addr3 = 5'b00000;
        in = 32'h00000001;
        #10;

        // Test Case 2
        valid_opcode = 1'b1;
        addr1 = 5'b11111;
        addr2 = 5'b00000;
        addr3 = 5'b11111;
        in = 32'h00000002;
        #10;
		
		// Test Case 3
        valid_opcode = 1'b0;
        addr1 = 5'b00000;
        addr2 = 5'b11111;
        addr3 = 5'b11111;
        in = 32'h01234567;
        #10;
		
		// Test Case 4
        valid_opcode = 1'b1;
        addr1 = 5'b00000;
        addr2 = 5'b11111;
        addr3 = 5'b11111;
        in = 32'h00000001;
        #10;
		
	   
        $finish;
    end
endmodule


module reg_32bit_tb;	 				 
	
	//reg for inputs wire for outputs
	
	reg clk;
    reg [31:0] in;
    wire [31:0] out;

    
    reg_32bit register( clk,in, out ); //instantiate the register module

    // clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin 
		#5
		
        // Test Case 1
        in = 32'h00000000;
		#10	
		
		 // Test Case 2
        in = 32'hffffffff;
		#10
		
		 // Test Case 3
        in = 32'hf0f0f0f0;
		#10
		
		 // Test Case 4
        in = 32'h0f0f0f0f;
		#10
	   
        $finish;
    end
endmodule