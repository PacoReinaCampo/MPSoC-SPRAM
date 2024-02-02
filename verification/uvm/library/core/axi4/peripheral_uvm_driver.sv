`include "peripheral_uvm_transaction.sv"

import peripheral_axi4_pkg::*;

class peripheral_uvm_driver extends uvm_driver #(peripheral_uvm_transaction);
  // Declaration of component utils to register with factory
  peripheral_uvm_transaction       transaction;

  // Declaration of Virtual interface
  virtual peripheral_uvm_interface vif;

  // Declaration of component utils to register with factory
  `uvm_component_utils(peripheral_uvm_driver)

  uvm_analysis_port #(peripheral_uvm_transaction) driver2rm_port;

  // Method name : new
  // Description : constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Method name : build_phase
  // Description : construct the components
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual peripheral_uvm_interface)::get(this, "", "intf", vif)) begin
      `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
    end
    driver2rm_port = new("driver2rm_port", this);
  endfunction : build_phase

  // Method name : run_phase
  // Description : Drive the transaction info to DUT
  virtual task run_phase(uvm_phase phase);
    reset();
    forever begin
      seq_item_port.get_next_item(req);
      write_drive();
      read_drive();
      `uvm_info(get_full_name(), $sformatf("TRANSACTION FROM DRIVER"), UVM_LOW);
      req.print();
      @(vif.dr_cb);
      $cast(rsp, req.clone());
      rsp.set_id_info(req);
      driver2rm_port.write(rsp);
      seq_item_port.item_done();
      seq_item_port.put(rsp);
    end
  endtask : run_phase

  // Method name : drive
  // Description : Driving the dut inputs
  task write_drive();
    begin
      // Operate in a synchronous manner
      @(posedge vif.clk_i);

      // Address Phase
      vif.dr_cb.axi_aw_id    <= 0;
      vif.dr_cb.axi_aw_adr   <= req.address;
      vif.dr_cb.axi_aw_valid <= 1;
      vif.dr_cb.axi_aw_len   <= AXI_BURST_LENGTH_1;
      vif.dr_cb.axi_aw_size  <= AXI_BURST_SIZE_WORD;
      vif.dr_cb.axi_aw_burst <= AXI_BURST_TYPE_FIXED;
      vif.dr_cb.axi_aw_lock  <= AXI_LOCK_NORMAL;
      vif.dr_cb.axi_aw_cache <= 0;
      vif.dr_cb.axi_aw_prot  <= AXI_PROTECTION_NORMAL;
      @(posedge vif.axi_aw_ready);

      // Data Phase
      vif.dr_cb.axi_aw_valid <= 0;
      vif.dr_cb.axi_aw_adr   <= 'bX;
      vif.dr_cb.axi_w_id     <= 0;
      vif.dr_cb.axi_w_valid  <= 1;
      vif.dr_cb.axi_w_rdata  <= req.wrdata;
      vif.dr_cb.axi_w_strb   <= 4'hF;
      vif.dr_cb.axi_w_last   <= 1;
      @(posedge vif.axi_w_ready);

      // Response Phase
      vif.dr_cb.axi_w_id    <= 0;
      vif.dr_cb.axi_w_valid <= 0;
      vif.dr_cb.axi_w_rdata <= 'bX;
      vif.dr_cb.axi_w_strb  <= 0;
      vif.dr_cb.axi_w_last  <= 0;
    end
  endtask

  task read_drive();
    begin
      // Address Phase
      vif.dr_cb.axi_ar_id    <= 0;
      vif.dr_cb.axi_ar_addr  <= req.address;
      vif.dr_cb.axi_ar_valid <= 1;
      vif.dr_cb.axi_ar_len   <= AXI_BURST_LENGTH_1;
      vif.dr_cb.axi_ar_size  <= AXI_BURST_SIZE_WORD;
      vif.dr_cb.axi_ar_lock  <= AXI_LOCK_NORMAL;
      vif.dr_cb.axi_ar_cache <= 0;
      vif.dr_cb.axi_ar_prot  <= AXI_PROTECTION_NORMAL;
      vif.dr_cb.rready  <= 0;
      @(posedge vif.axi_ar_ready);

      // Data Phase
      vif.dr_cb.axi_ar_valid <= 0;
      vif.dr_cb.rready  <= 1;
      @(posedge vif.rvalid);

      vif.dr_cb.rready <= 0;
      @(negedge vif.rvalid);

      vif.dr_cb.axi_ar_addr <= 'bx;
    end
  endtask

  // Method name : reset
  // Description : Driving the dut inputs
  task reset();
    // Global Signals
    vif.dr_cb.rst_ni <= 0;  // Active LOW

    // Write Address Channel
    vif.dr_cb.axi_aw_id    <= 0;  // Address Write ID
    vif.dr_cb.axi_aw_adr   <= 0;  // Write Address
    vif.dr_cb.axi_aw_len   <= 0;  // Burst Length
    vif.dr_cb.axi_aw_size  <= 0;  // Burst Size
    vif.dr_cb.axi_aw_burst <= 0;  // Burst Type
    vif.dr_cb.axi_aw_lock  <= 0;  // Lock Type
    vif.dr_cb.axi_aw_cache <= 0;  // Cache Type
    vif.dr_cb.axi_aw_prot  <= 0;  // Protection Type
    vif.dr_cb.axi_aw_valid <= 0;  // Write Address Valid

    // Write Data Channel
    vif.dr_cb.wid     <= 0;  // Write ID
    vif.dr_cb.wrdata  <= 0;  // Write Data
    vif.dr_cb.wstrb   <= 0;  // Write Strobes
    vif.dr_cb.wlast   <= 0;  // Write Last
    vif.dr_cb.wvalid  <= 0;  // Write Valid

    // Write Response CHannel
    vif.dr_cb.axi_b_id     <= 0;  // Response ID
    vif.dr_cb.axi_b_resp   <= 0;  // Write Response
    vif.dr_cb.axi_b_valid  <= 0;  // Write Response Valid   

    // Read Address Channel
    vif.dr_cb.axi_ar_id    <= 0;  // Read Address ID
    vif.dr_cb.axi_ar_addr  <= 0;  // Read Address
    vif.dr_cb.axi_ar_len   <= 0;  // Burst Length
    vif.dr_cb.axi_ar_size  <= 0;  // Burst Size
    vif.dr_cb.axi_ar_lock  <= 0;  // Lock Type
    vif.dr_cb.axi_ar_cache <= 0;  // Cache Type
    vif.dr_cb.axi_ar_prot  <= 0;  // Protection Type
    vif.dr_cb.axi_ar_valid <= 0;  // Read Address Valid

    // Read Data Channel
    vif.dr_cb.rready  <= 0;  // Read Ready

    repeat (5) @(posedge vif.aclk);

    vif.dr_cb.axi_ar_esetn <= 1;  // Inactive HIGH
  endtask
endclass : peripheral_uvm_driver
