// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vmpsoc_spram_testbench.h for the primary calling header

#include "Vmpsoc_spram_testbench.h" // For This
#include "Vmpsoc_spram_testbench__Syms.h"


//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vmpsoc_spram_testbench) {
    Vmpsoc_spram_testbench__Syms* __restrict vlSymsp = __VlSymsp = new Vmpsoc_spram_testbench__Syms(this, name());
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vmpsoc_spram_testbench::__Vconfigure(Vmpsoc_spram_testbench__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vmpsoc_spram_testbench::~Vmpsoc_spram_testbench() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vmpsoc_spram_testbench::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vmpsoc_spram_testbench::eval\n"); );
    Vmpsoc_spram_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    while (VL_LIKELY(__Vchange)) {
	VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
    }
}

void Vmpsoc_spram_testbench::_eval_initial_loop(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    int __VclockLoop = 0;
    QData __Vchange = 1;
    while (VL_LIKELY(__Vchange)) {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
    }
}

//--------------------
// Internal Methods

void Vmpsoc_spram_testbench::_eval(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_eval\n"); );
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Final
    vlTOPp->__Vclklast__TOP__mpsoc_spram_testbench__DOT__HCLK 
	= vlTOPp->mpsoc_spram_testbench__DOT__HCLK;
    vlTOPp->__Vclklast__TOP__mpsoc_spram_testbench__DOT__HRESETn 
	= vlTOPp->mpsoc_spram_testbench__DOT__HRESETn;
}

void Vmpsoc_spram_testbench::_eval_initial(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_eval_initial\n"); );
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vmpsoc_spram_testbench::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::final\n"); );
    // Variables
    Vmpsoc_spram_testbench__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vmpsoc_spram_testbench::_eval_settle(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_eval_settle\n"); );
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

VL_INLINE_OPT QData Vmpsoc_spram_testbench::_change_request(Vmpsoc_spram_testbench__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_change_request\n"); );
    Vmpsoc_spram_testbench* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vmpsoc_spram_testbench::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_eval_debug_assertions\n"); );
}
#endif // VL_DEBUG

void Vmpsoc_spram_testbench::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vmpsoc_spram_testbench::_ctor_var_reset\n"); );
    // Body
    mpsoc_spram_testbench__DOT__HRESETn = VL_RAND_RESET_I(1);
    mpsoc_spram_testbench__DOT__HCLK = VL_RAND_RESET_I(1);
    __Vclklast__TOP__mpsoc_spram_testbench__DOT__HCLK = VL_RAND_RESET_I(1);
    __Vclklast__TOP__mpsoc_spram_testbench__DOT__HRESETn = VL_RAND_RESET_I(1);
}
