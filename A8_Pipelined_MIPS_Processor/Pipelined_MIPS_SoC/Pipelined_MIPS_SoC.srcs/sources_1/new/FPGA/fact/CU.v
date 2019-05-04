
module CU #(parameter DATA_WIDTH = 32)(
    input GO,
    input GT,
    input RST,
    input CLK,
    input EC,
    output reg load_cnt,
    output reg cnt_en,
    output reg mux_sel,
    output reg load_reg,
    output reg buf_oe,
    output reg done,
    output reg error
    );

    parameter   S0 = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100;
    reg [2:0] CS, NS;
    //NS driver
    always @ (posedge CLK, posedge RST)
        begin
            if(RST == 1) CS <= S0;
            else         CS <= NS;
        
        end
    //Output logic
    always @ (CS, GT, EC)
        begin
            case(CS)
                S0: begin
                        load_cnt =0;
                        cnt_en = 0;
                        mux_sel = 0;
                        load_reg = 0;
                        buf_oe = 0;
                        done = 0;
                        error = 0;
                    end
                //Load
                S1: begin

                        load_cnt =1;
                        cnt_en = 0;
                        mux_sel = 1;
                        load_reg = 1;
                        buf_oe = 0;
                        done = 0;
                        error = 0;

                        
                    end
                //Finished
                S2: begin
                
                    if(EC)begin
                        load_cnt <= 0;
                        cnt_en <= 0;
                        mux_sel <= 0;
                        load_reg <= 0;
                        buf_oe <= 0;
                        done <= 1;
                        error <= 1; 
                        end
                    else if(!EC && !GT)begin
                        load_cnt = 0;
                        cnt_en = 0;
                        mux_sel = 0;
                        load_reg = 0;
                        buf_oe = 0;
                        done = 1;
                        error = 0;  
                        end
                    else begin
                        load_cnt = 0;
                        cnt_en = 1;
                        mux_sel = 0;
                        load_reg = 1;
                        buf_oe = 0;
                        done = 0;
                        error = 0;  
                    
                        end    
                    end

             endcase                 
        end
    always @ (CS, GO, GT, EC)
        begin
            case(CS)
                S0: begin
                        if(GO == 1) NS <= S1;      // Go = 1 and D <= 12, go state 1
                        else NS <= S0;                       // Go = 0
                    end
                S1: begin
                        NS <= S2; 
                    end
                 //Finished   
                 S2: 
                    if(GT == 0 || EC == 1) NS <= S0;
                    else NS <= S2;


            
            endcase       
        end
    
        
    
    
    
endmodule
