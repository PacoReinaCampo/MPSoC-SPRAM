-- Converted from bench/verilog/regression/mpsoc_msi_testbench.sv
-- by verilog2vhdl - QueenField

--//////////////////////////////////////////////////////////////////////////////
--                                            __ _      _     _               //
--                                           / _(_)    | |   | |              //
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
--                  | |                                                       //
--                  |_|                                                       //
--                                                                            //
--                                                                            //
--              MPSoC-RISCV CPU                                               //
--              Master Slave Interface Tesbench                               //
--              AMBA3 AHB-Lite Bus Interface                                  //
--                                                                            //
--//////////////////////////////////////////////////////////////////////////////

-- Copyright (c) 2018-2019 by the author(s)
-- *
-- * Permission is hereby granted, free of charge, to any person obtaining a copy
-- * of this software and associated documentation files (the "Software"), to deal
-- * in the Software without restriction, including without limitation the rights
-- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- * copies of the Software, and to permit persons to whom the Software is
-- * furnished to do so, subject to the following conditions:
-- *
-- * The above copyright notice and this permission notice shall be included in
-- * all copies or substantial portions of the Software.
-- *
-- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- * THE SOFTWARE.
-- *
-- * =============================================================================
-- * Author(s):
-- *   Francisco Javier Reina Campo <frareicam@gmail.com>
-- */

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mpsoc_pkg.all;
entity mpsoc_msi_testbench is
end mpsoc_msi_testbench;

architecture RTL of mpsoc_msi_testbench is

  component mpsoc_ahb3_spram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO"
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic;
      HADDR     : in  std_logic_vector(PLEN-1 downto 0);
      HWDATA    : in  std_logic_vector(XLEN-1 downto 0);
      HRDATA    : out std_logic_vector(XLEN-1 downto 0);
      HWRITE    : in  std_logic;
      HSIZE     : in  std_logic_vector(2 downto 0);
      HBURST    : in  std_logic_vector(2 downto 0);
      HPROT     : in  std_logic_vector(3 downto 0);
      HTRANS    : in  std_logic_vector(1 downto 0);
      HMASTLOCK : in  std_logic;
      HREADYOUT : out std_logic;
      HREADY    : in  std_logic;
      HRESP     : out std_logic
      );
  end component;

  component mpsoc_wb_spram
    generic (
      MEM_SIZE          : integer := 256;  --Memory in Bytes
      MEM_DEPTH         : integer := 256;  --Memory depth
      PLEN              : integer := 64;
      XLEN              : integer := 64;
      TECHNOLOGY        : string  := "GENERIC";
      REGISTERED_OUTPUT : string  := "NO"
      );
    port (
      HRESETn : in std_logic;
      HCLK    : in std_logic;

      --AHB Slave Interfaces (receive data from AHB Masters)
      --AHB Masters connect to these ports
      HSEL      : in  std_logic;
      HADDR     : in  std_logic_vector(PLEN-1 downto 0);
      HWDATA    : in  std_logic_vector(XLEN-1 downto 0);
      HRDATA    : out std_logic_vector(XLEN-1 downto 0);
      HWRITE    : in  std_logic;
      HSIZE     : in  std_logic_vector(2 downto 0);
      HBURST    : in  std_logic_vector(2 downto 0);
      HPROT     : in  std_logic_vector(3 downto 0);
      HTRANS    : in  std_logic_vector(1 downto 0);
      HMASTLOCK : in  std_logic;
      HREADYOUT : out std_logic;
      HREADY    : in  std_logic;
      HRESP     : out std_logic
      );
  end component;

  --////////////////////////////////////////////////////////////////
  --
  -- Variables
  --

  --Common signals
  signal HRESETn : std_logic;
  signal HCLK    : std_logic;

  signal mst_sram_HSEL      : std_logic;
  signal mst_sram_HADDR     : std_logic_vector(PLEN-1 downto 0);
  signal mst_sram_HWDATA    : std_logic_vector(XLEN-1 downto 0);
  signal mst_sram_HRDATA    : std_logic_vector(XLEN-1 downto 0);
  signal mst_sram_HWRITE    : std_logic;
  signal mst_sram_HSIZE     : std_logic_vector(2 downto 0);
  signal mst_sram_HBURST    : std_logic_vector(2 downto 0);
  signal mst_sram_HPROT     : std_logic_vector(3 downto 0);
  signal mst_sram_HTRANS    : std_logic_vector(1 downto 0);
  signal mst_sram_HMASTLOCK : std_logic;
  signal mst_sram_HREADY    : std_logic;
  signal mst_sram_HREADYOUT : std_logic;
  signal mst_sram_HRESP     : std_logic;

begin
  --////////////////////////////////////////////////////////////////
  --
  -- Module Body
  --

  --DUT AHB3
  ahb3_spram : mpsoc_ahb3_spram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_sram_HSEL,
      HADDR     => mst_sram_HADDR,
      HWDATA    => mst_sram_HWDATA,
      HRDATA    => mst_sram_HRDATA,
      HWRITE    => mst_sram_HWRITE,
      HSIZE     => mst_sram_HSIZE,
      HBURST    => mst_sram_HBURST,
      HPROT     => mst_sram_HPROT,
      HTRANS    => mst_sram_HTRANS,
      HMASTLOCK => mst_sram_HMASTLOCK,
      HREADYOUT => mst_sram_HREADYOUT,
      HREADY    => mst_sram_HREADY,
      HRESP     => mst_sram_HRESP
      );

  --DUT WB
  wb_spram : mpsoc_wb_spram
    generic map (
      MEM_SIZE          => 256,
      MEM_DEPTH         => 256,
      PLEN              => PLEN,
      XLEN              => XLEN,
      TECHNOLOGY        => TECHNOLOGY,
      REGISTERED_OUTPUT => "NO"
      )
    port map (
      --AHB Slave Interface
      HRESETn => HRESETn,
      HCLK    => HCLK,

      HSEL      => mst_sram_HSEL,
      HADDR     => mst_sram_HADDR,
      HWDATA    => mst_sram_HWDATA,
      HRDATA    => open,
      HWRITE    => mst_sram_HWRITE,
      HSIZE     => mst_sram_HSIZE,
      HBURST    => mst_sram_HBURST,
      HPROT     => mst_sram_HPROT,
      HTRANS    => mst_sram_HTRANS,
      HMASTLOCK => mst_sram_HMASTLOCK,
      HREADYOUT => open,
      HREADY    => mst_sram_HREADY,
      HRESP     => open
      );
end RTL;
