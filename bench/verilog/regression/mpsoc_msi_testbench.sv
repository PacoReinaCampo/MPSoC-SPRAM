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

  //AHB3 parameters
  localparam XLEN = 64;
  localparam PLEN = 64;

  localparam MASTERS = 5;
  localparam SLAVES  = 5;

  localparam SYNC_DEPTH = 3;
  localparam TECHNOLOGY = "GENERIC";

  //WB parameters
  parameter DW      = 32;
  parameter DEPTH   = 256;
  parameter AW      = $clog2(DEPTH);
  parameter MEMFILE = "";

  //////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  //Common signals
  wire                                     HRESETn;
  wire                                     HCLK;

  //AHB3 signals
  wire                                     mst_spram_HSEL;
  wire               [PLEN           -1:0] mst_spram_HADDR;
  wire               [XLEN           -1:0] mst_spram_HWDATA;
  wire               [XLEN           -1:0] mst_spram_HRDATA;
  wire                                     mst_spram_HWRITE;
  wire               [                2:0] mst_spram_HSIZE;
  wire               [                2:0] mst_spram_HBURST;
  wire               [                3:0] mst_spram_HPROT;
  wire               [                1:0] mst_spram_HTRANS;
  wire                                     mst_spram_HMASTLOCK;
  wire                                     mst_spram_HREADY;
  wire                                     mst_spram_HREADYOUT;
  wire                                     mst_spram_HRESP;

  //WB signals
  wire               [AW             -1:0] mst_spram_adr_i;
  wire               [DW             -1:0] mst_spram_dat_i;
  wire               [                3:0] mst_spram_sel_i;
  wire                                     mst_spram_we_i;
  wire               [                1:0] mst_spram_bte_i;
  wire               [                2:0] mst_spram_cti_i;
  wire                                     mst_spram_cyc_i;
  wire                                     mst_spram_stb_i;
  reg                                      mst_spram_ack_o;
  wire                                     mst_spram_err_o;
  wire               [DW             -1:0] mst_spram_dat_o;

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

    .HSEL      ( mst_spram_HSEL      ),
    .HADDR     ( mst_spram_HADDR     ),
    .HWDATA    ( mst_spram_HWDATA    ),
    .HRDATA    ( mst_spram_HRDATA    ),
    .HWRITE    ( mst_spram_HWRITE    ),
    .HSIZE     ( mst_spram_HSIZE     ),
    .HBURST    ( mst_spram_HBURST    ),
    .HPROT     ( mst_spram_HPROT     ),
    .HTRANS    ( mst_spram_HTRANS    ),
    .HMASTLOCK ( mst_spram_HMASTLOCK ),
    .HREADYOUT ( mst_spram_HREADYOUT ),
    .HREADY    ( mst_spram_HREADY    ),
    .HRESP     ( mst_spram_HRESP     )
  );

  //DUT WB
  mpsoc_wb_spram #(
    .DW      ( DW      ),
    .DEPTH   ( DEPTH   ),
    .AW      ( AW      ),
    .MEMFILE ( MEMFILE )
  )
  wb_spram (
    //Wishbone Master interface
    .wb_clk_i ( HRESETn ),
    .wb_rst_i ( HCLK    ),

    .wb_adr_i ( mst_spram_adr_i ),
    .wb_dat_i ( mst_spram_dat_i ),
    .wb_sel_i ( mst_spram_sel_i ),
    .wb_we_i  ( mst_spram_we_i  ),
    .wb_bte_i ( mst_spram_bte_i ),
    .wb_cti_i ( mst_spram_cti_i ),
    .wb_cyc_i ( mst_spram_cyc_i ),
    .wb_stb_i ( mst_spram_stb_i ),
    .wb_ack_o ( mst_spram_ack_o ),
    .wb_err_o ( mst_spram_err_o ),
    .wb_dat_o ( mst_spram_dat_o )
  );
endmodule
