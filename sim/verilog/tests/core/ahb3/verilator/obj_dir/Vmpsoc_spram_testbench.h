// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vmpsoc_spram_testbench_H_
#define _Vmpsoc_spram_testbench_H_

#include "verilated.h"

class Vmpsoc_spram_testbench__Syms;

//----------

VL_MODULE(Vmpsoc_spram_testbench) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    VL_SIG8(mpsoc_spram_testbench__DOT__HRESETn,0,0);
    VL_SIG8(mpsoc_spram_testbench__DOT__HCLK,0,0);
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    VL_SIG8(__Vclklast__TOP__mpsoc_spram_testbench__DOT__HCLK,0,0);
    VL_SIG8(__Vclklast__TOP__mpsoc_spram_testbench__DOT__HRESETn,0,0);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vmpsoc_spram_testbench__Syms* __VlSymsp;  // Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    Vmpsoc_spram_testbench& operator= (const Vmpsoc_spram_testbench&);  ///< Copying not allowed
    Vmpsoc_spram_testbench(const Vmpsoc_spram_testbench&);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible WRT DPI scope names.
    Vmpsoc_spram_testbench(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vmpsoc_spram_testbench();
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vmpsoc_spram_testbench__Syms* symsp, bool first);
  private:
    static QData _change_request(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp);
    void _ctor_var_reset();
  public:
    static void _eval(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif // VL_DEBUG
  public:
    static void _eval_initial(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp);
    static void _eval_settle(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(128);

#endif // guard
