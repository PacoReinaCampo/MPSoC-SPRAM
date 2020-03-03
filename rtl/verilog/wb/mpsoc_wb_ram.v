////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MPSoC-RISCV CPU                                               //
//              Generic RAM                                                   //
//              Wishbone Bus Interface                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2018-2019 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

module mpsoc_wb_ram #(
  //Wishbone parameters
  parameter DW = 32,

  //Memory parameters
  parameter DEPTH   = 256,
  parameter AW      = $clog2(DEPTH),
  parameter MEMFILE = ""
)
  (
    input           wb_clk_i,
    input           wb_rst_i,

    input  [AW-1:0] wb_adr_i,
    input  [DW-1:0] wb_dat_i,
    input  [3:0]    wb_sel_i,
    input           wb_we_i,
    input  [1:0]    wb_bte_i,
    input  [2:0]    wb_cti_i,
    input           wb_cyc_i,
    input           wb_stb_i,

    output reg      wb_ack_o,
    output          wb_err_o,
    output [DW-1:0] wb_dat_o
  );

  //////////////////////////////////////////////////////////////////
  //
  // Constants
  //
  `include "wb_common.v"

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //
  reg  [AW-1:0] adr_r;
  wire [AW-1:0] next_adr;
  wire          valid;
  reg           valid_r;
  reg           is_last_r;
  wire          new_cycle;
  wire [AW-1:0] adr;
  wire          ram_we;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //
  assign valid = wb_cyc_i & wb_stb_i;

  always @(posedge wb_clk_i) begin
    is_last_r <= wb_is_last(wb_cti_i);
  end

  assign new_cycle = (valid & !valid_r) | is_last_r;

  assign next_adr = wb_next_adr(adr_r, wb_cti_i, wb_bte_i, DW);

  assign adr = new_cycle ? wb_adr_i : next_adr;

  always@(posedge wb_clk_i) begin
    adr_r   <= adr;
    valid_r <= valid;
    //Ack generation
    wb_ack_o <= valid & (!((wb_cti_i == 3'b000) | (wb_cti_i == 3'b111)) | !wb_ack_o);
    if(wb_rst_i) begin
      adr_r    <= {AW{1'b0}};
      valid_r  <= 1'b0;
      wb_ack_o <= 1'b0;
    end
  end

  assign ram_we = wb_we_i & valid & wb_ack_o;

  //TODO:ck for burst address errors
  assign wb_err_o =  1'b0;

  mpsoc_wb_ram_generic #(
    .DEPTH   (DEPTH/4),
    .MEMFILE (MEMFILE)
  ) ram0 (
    .clk   (wb_clk_i),
    .we    ({4{ram_we}} & wb_sel_i),
    .din   (wb_dat_i),
    .waddr (adr_r[AW-1:2]),
    .raddr (adr[AW-1:2]),
    .dout  (wb_dat_o)
  );
endmodule
