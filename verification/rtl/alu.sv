//=============================================================================
// [Filename]       tb_alu.sv
// [Project]        -
// [Author]         Adrian Valle
// [Language]       SystemVerilog
// [Created]        Jul 2026
// [Modified]       -
// [Description]    - 
// [Notes]          -
// [Status]         stable
// [Revisions]      -
//=============================================================================

module alu #(
    parameter int DataWidth = 16
) (
    input  logic                 clk_i,
    input  logic                 rst_i,
    input  logic [DataWidth-1:0] x_i,
    input  logic [DataWidth-1:0] y_i,
    input  logic                 zx_i,
    input  logic                 nx_i,
    input  logic                 zy_i,
    input  logic                 ny_i,
    input  logic                 f_i,
    input  logic                 no_i,
    output logic [DataWidth-1:0] out_o,
    output logic                 zr_o,
    output logic                 ng_o,
    output logic                 pos_o
);

  localparam logic [5:0] ALU_ZERO  = 6'b101010;
  localparam logic [5:0] ALU_ONE   = 6'b111111;
  localparam logic [5:0] ALU_MONE  = 6'b111010;
  localparam logic [5:0] ALU_X     = 6'b001100;
  localparam logic [5:0] ALU_Y     = 6'b110000;
  localparam logic [5:0] ALU_NOTX  = 6'b001101;
  localparam logic [5:0] ALU_NOTY  = 6'b110001;
  localparam logic [5:0] ALU_NEGX  = 6'b001111;
  localparam logic [5:0] ALU_NEGY  = 6'b110011;
  localparam logic [5:0] ALU_XP1   = 6'b011111;
  localparam logic [5:0] ALU_YP1   = 6'b110111;
  localparam logic [5:0] ALU_XM1   = 6'b001110;
  localparam logic [5:0] ALU_YM1   = 6'b110010;
  localparam logic [5:0] ALU_ADD   = 6'b000010;
  localparam logic [5:0] ALU_SUBXY = 6'b010011;
  localparam logic [5:0] ALU_SUBYX = 6'b000111;
  localparam logic [5:0] ALU_AND   = 6'b000000;
  localparam logic [5:0] ALU_OR    = 6'b010101;

  logic [5:0] inst;

assign inst = {zx_i, nx_i, zy_i, ny_i, f_i, no_i};

always_comb begin
    unique case (inst)
      ALU_ZERO:  out_o = '0;
      ALU_ONE:   out_o = 1;
      ALU_MONE:  out_o = '1;  // -1
      ALU_X:     out_o = x_i;
      ALU_Y:     out_o = y_i;
      ALU_NOTX:  out_o = ~x_i;  // ~x_i bitwise
      ALU_NOTY:  out_o = ~y_i;  // ~y_i bitwise
      ALU_NEGX:  out_o = -x_i;
      ALU_NEGY:  out_o = -y_i;
      ALU_XP1:   out_o = x_i + 1;
      ALU_YP1:   out_o = y_i + 1;
      ALU_XM1:   out_o = x_i - 1;
      ALU_YM1:   out_o = y_i - 1;
      ALU_ADD:   out_o = x_i + y_i;
      ALU_SUBXY: out_o = x_i - y_i;
      ALU_SUBYX: out_o = y_i - x_i;
      ALU_AND:   out_o = x_i & y_i;
      ALU_OR:    out_o = x_i | y_i;
      default:   out_o = '0;
    endcase
  end

always_ff @(posedge clk_i or posedge rst_i) begin
  if (!rst_i) begin
    zr_o  <= 0;
    ng_o  <= 0;
    pos_o <= 0;
  end

  else begin
    zr_o  <= (out_o == '0);
    ng_o  <= out_o[DataWidth-1];
    pos_o <= !zr_o && !ng_o;
  end
end

endmodule : alu