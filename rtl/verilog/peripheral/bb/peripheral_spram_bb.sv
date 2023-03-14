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
//              MSP430 CPU                                                    //
//              Processing Unit                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2015-2016 by the author(s)
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the authors nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 * OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE
 *
 * =============================================================================
 * Author(s):
 *   Olivier Girard <olgirard@gmail.com>
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

module peripheral_spram_bb #(
  parameter AW       = 6,   // Address bus
  parameter DW       = 16,  // Data bus
  parameter MEM_SIZE = 256  // Memory size in bytes
) (
  input ram_clk,  // RAM clock

  input  [AW-1:0] ram_addr,  // RAM address
  output [DW-1:0] ram_dout,  // RAM data output
  input  [DW-1:0] ram_din,   // RAM data input
  input           ram_cen,   // RAM chip enable (low active)
  input  [   1:0] ram_wen    // RAM write enable (low active)
);

  // RAM
  //============

  reg  [DW-1:0]                          mem          [0:(MEM_SIZE/2)-1];
  reg  [AW-1:0]                          ram_addr_reg;

  wire [DW-1:0] mem_val = mem[ram_addr];

  always @(posedge ram_clk) begin
    if (~ram_cen & ram_addr < (MEM_SIZE / 2)) begin
      if (ram_wen == 2'b00) mem[ram_addr] <= ram_din;
      else if (ram_wen == 2'b01) mem[ram_addr] <= {ram_din[DW-1:DW/2], mem_val[DW/2-1:0]};
      else if (ram_wen == 2'b10) mem[ram_addr] <= {mem_val[DW-1:DW/2], ram_din[DW/2-1:0]};
      ram_addr_reg <= ram_addr;
    end
  end

  assign ram_dout = mem[ram_addr_reg];
endmodule  // peripheral_spram_bb
