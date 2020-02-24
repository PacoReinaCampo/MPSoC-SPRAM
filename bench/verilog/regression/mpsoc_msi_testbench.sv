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
//              Master Slave Interface Tesbench                               //
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
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

module mpsoc_msi_testbench;

  //////////////////////////////////////////////////////////////////
  //
  // Constants
  //
  localparam XLEN = 64;
  localparam PLEN = 64;

  localparam MASTERS = 5;
  localparam SLAVES  = 5;

  localparam SYNC_DEPTH = 3;
  localparam TECHNOLOGY = "GENERIC";

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  //Common signals
  wire                                     HRESETn;
  wire                                     HCLK;

  wire                                     mst_sram_HSEL;
  wire               [PLEN           -1:0] mst_sram_HADDR;
  wire               [XLEN           -1:0] mst_sram_HWDATA;
  wire               [XLEN           -1:0] mst_sram_HRDATA;
  wire                                     mst_sram_HWRITE;
  wire               [                2:0] mst_sram_HSIZE;
  wire               [                2:0] mst_sram_HBURST;
  wire               [                3:0] mst_sram_HPROT;
  wire               [                1:0] mst_sram_HTRANS;
  wire                                     mst_sram_HMASTLOCK;
  wire                                     mst_sram_HREADY;
  wire                                     mst_sram_HREADYOUT;
  wire                                     mst_sram_HRESP;

  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  //DUT AHB3
  mpsoc_ahb3_spram #(
    .MEM_SIZE          ( 0 ),
    .MEM_DEPTH         ( 256 ),
    .HADDR_SIZE        ( PLEN ),
    .HDATA_SIZE        ( XLEN ),
    .TECHNOLOGY        ( TECHNOLOGY ),
    .REGISTERED_OUTPUT ( "NO" )
  )
  ahb3_spram (
    //AHB Slave Interface
    .HRESETn   ( HRESETn ),
    .HCLK      ( HCLK    ),

    .HSEL      ( mst_sram_HSEL      ),
    .HADDR     ( mst_sram_HADDR     ),
    .HWDATA    ( mst_sram_HWDATA    ),
    .HRDATA    ( mst_sram_HRDATA    ),
    .HWRITE    ( mst_sram_HWRITE    ),
    .HSIZE     ( mst_sram_HSIZE     ),
    .HBURST    ( mst_sram_HBURST    ),
    .HPROT     ( mst_sram_HPROT     ),
    .HTRANS    ( mst_sram_HTRANS    ),
    .HMASTLOCK ( mst_sram_HMASTLOCK ),
    .HREADYOUT ( mst_sram_HREADYOUT ),
    .HREADY    ( mst_sram_HREADY    ),
    .HRESP     ( mst_sram_HRESP     )
  );

  //DUT WB
  mpsoc_wb_spram #(
    .MEM_SIZE          ( 0 ),
    .MEM_DEPTH         ( 256 ),
    .HADDR_SIZE        ( PLEN ),
    .HDATA_SIZE        ( XLEN ),
    .TECHNOLOGY        ( TECHNOLOGY ),
    .REGISTERED_OUTPUT ( "NO" )
  )
  wb_spram (
    //AHB Slave Interface
    .HRESETn   ( HRESETn ),
    .HCLK      ( HCLK    ),

    .HSEL      (       ),
    .HADDR     (      ),
    .HWDATA    (     ),
    .HRDATA    (     ),
    .HWRITE    (     ),
    .HSIZE     (      ),
    .HBURST    (     ),
    .HPROT     (      ),
    .HTRANS    (     ),
    .HMASTLOCK (  ),
    .HREADYOUT (  ),
    .HREADY    (     ),
    .HRESP     (      )
  );
endmodule
