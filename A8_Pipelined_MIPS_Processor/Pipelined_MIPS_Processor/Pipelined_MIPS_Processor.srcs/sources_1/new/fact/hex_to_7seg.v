
module hex_to_7seg(number, out);
    output [7:0] out;
    input [3:0] number;
    reg s0, s1, s2, s3, s4, s5, s6;
	assign out = {1'b1, s6, s5,s4,s3,s2,s1,s0};
    always @ (number)
        begin // BCD to 7-segment decoding
            case (number) // s0 - s6 are active low
            4'h0: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=0; s6=1; end
            4'h1: begin s0=1; s1=0; s2=0; s3=1; s4=1; s5=1; s6=1; end
            4'h2: begin s0=0; s1=0; s2=1; s3=0; s4=0; s5=1; s6=0; end
            4'h3: begin s0=0; s1=0; s2=0; s3=0; s4=1; s5=1; s6=0; end
            4'h4: begin s0=1; s1=0; s2=0; s3=1; s4=1; s5=0; s6=0; end
            4'h5: begin s0=0; s1=1; s2=0; s3=0; s4=1; s5=0; s6=0; end
            4'h6: begin s0=0; s1=1; s2=0; s3=0; s4=0; s5=0; s6=0; end
            4'h7: begin s0=0; s1=0; s2=0; s3=1; s4=1; s5=1; s6=1; end
            4'h8: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=0; s6=0; end
            4'h9: begin s0=0; s1=0; s2=0; s3=1; s4=1; s5=0; s6=0; end
            4'ha: begin s0=0; s1=0; s2=0; s3=0; s4=0; s5=1; s6=0; end
            4'hb: begin s0=1; s1=1; s2=0; s3=0; s4=0; s5=0; s6=0; end
            4'hc: begin s0=1; s1=1; s2=1; s3=0; s4=0; s5=1; s6=0; end
            4'hd: begin s0=1; s1=0; s2=0; s3=0; s4=0; s5=1; s6=0; end
            4'he: begin s0=0; s1=0; s2=1; s3=0; s4=0; s5=0; s6=0; end
            4'hf: begin s0=0; s1=1; s2=1; s3=1; s4=0; s5=0; s6=0; end
     default: begin s0=1; s1=1; s2=1; s3=1; s4=1; s5=1; s6=1; end
     endcase
     end
endmodule
