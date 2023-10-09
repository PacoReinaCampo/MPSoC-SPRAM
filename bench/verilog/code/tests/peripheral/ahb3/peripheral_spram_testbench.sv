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
//              Peripheral-GPIO for MPSoC                                     //
//              General Purpose Input Output for MPSoC                        //
//              AMBA3 AHB-Lite Bus Interface                                  //
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
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

module peripheral_spram_testbench;

  //////////////////////////////////////////////////////////////////////////////
  //
  // Constants
  //

  parameter HADDR_SIZE = 16;
  parameter HDATA_SIZE = 32;

  //////////////////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  // AHB3 signals
  logic                   HSEL;
  logic [HADDR_SIZE -1:0] HADDR;
  logic [HDATA_SIZE -1:0] HWDATA;
  logic [HDATA_SIZE -1:0] HRDATA;
  logic                   HWRITE;
  logic [            2:0] HSIZE;
  logic [            2:0] HBURST;
  logic [            3:0] HPROT;
  logic [            1:0] HTRANS;
  logic                   HMASTLOCK;
  logic                   HREADY;
  logic                   HREADYOUT;
  logic                   HRESP;

  //////////////////////////////////////////////////////////////////////////////
  //
  // Clock & Reset
  //

  bit HCLK, HRESETn;
  initial begin : gen_HCLK
    HCLK <= 1'b0;
    forever #10 HCLK = ~HCLK;
  end : gen_HCLK

  initial begin : gen_HRESETn;
    HRESETn = 1'b1;
    //ensure falling edge of HRESETn
    #10;
    HRESETn = 1'b0;
    #32;
    HRESETn = 1'b1;
  end : gen_HRESETn;

  //////////////////////////////////////////////////////////////////////////////
  //
  // TB and DUT
  //

  peripheral_bfm_ahb3 #(
    .HADDR_SIZE(HADDR_SIZE),
    .HDATA_SIZE(HDATA_SIZE)
  ) tb (
    .*
  );

  peripheral_spram_ahb3 #(
    .MEM_SIZE         (256),
    .MEM_DEPTH        (256),
    .PLEN             (HADDR_SIZE),
    .XLEN             (HDATA_SIZE),
    .TECHNOLOGY       ("GENERIC"),
    .REGISTERED_OUTPUT("NO")
  ) spram_ahb3 (
    .HRESETn(HRESETn),
    .HCLK   (HCLK),

    .HSEL     (HSEL),
    .HADDR    (HADDR),
    .HWDATA   (HWDATA),
    .HRDATA   (HRDATA),
    .HWRITE   (HWRITE),
    .HSIZE    (HSIZE),
    .HBURST   (HBURST),
    .HPROT    (HPROT),
    .HTRANS   (HTRANS),
    .HMASTLOCK(HMASTLOCK),
    .HREADYOUT(HREADYOUT),
    .HREADY   (HREADY),
    .HRESP    (HRESP)
  );

  assign HREADY = HREADYOUT;
endmodule : peripheral_spram_testbench
