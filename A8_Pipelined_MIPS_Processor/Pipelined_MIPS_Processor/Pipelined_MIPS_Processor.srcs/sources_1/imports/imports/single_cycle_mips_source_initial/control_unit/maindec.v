module maindec (
        input  wire [5:0] opcode,
        output wire       branch,
        output wire       jump,
        output wire       reg_dst,
        output wire       we_reg,
        output wire       alu_src,
        output wire       we_dm,
        output wire       dm2reg,
        output wire [1:0] alu_op,
        output wire       jal_wa_mux_sel,
        output wire       jal_wd_mux_sel
    );

    reg [10:0] ctrl;

    assign {branch, jump, reg_dst, we_reg, alu_src, we_dm, dm2reg, alu_op, jal_wa_mux_sel, jal_wd_mux_sel} = ctrl;

    always @ (opcode) begin
        case (opcode)
            6'b00_0000: ctrl = 11'b0_0_1_1_0_0_0_10_0_0; // R-type
            6'b00_1000: ctrl = 11'b0_0_0_1_1_0_0_00_0_0; // ADDI
            6'b00_0100: ctrl = 11'b1_0_0_0_0_0_0_01_0_0; // BEQ
            6'b00_0010: ctrl = 11'b0_1_0_0_0_0_0_00_0_0; // J
            6'b00_0011: ctrl = 11'b0_1_0_1_0_0_0_00_1_1; // JAL //TODO
            6'b10_1011: ctrl = 11'b0_0_0_0_1_1_0_00_0_0; // SW
            //6'b10_0011: ctrl = 11'b0_0_0_1_1_0_1_00_0_0; // LW
            6'b10_0011: ctrl = 11'b0_0_0_1_1_0_1_00_0_0; // LW
            default:    ctrl = 11'bx_x_x_0_x_0_x_xx_x_x;
            //default:    ctrl = 11'b0_0_0_0_0_0_0_00_0_0;
        endcase
    end

endmodule