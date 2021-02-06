// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _Vmpsoc_spram_testbench__Syms_H_
#define _Vmpsoc_spram_testbench__Syms_H_

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vmpsoc_spram_testbench.h"

// SYMS CLASS
class Vmpsoc_spram_testbench__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vmpsoc_spram_testbench*        TOPp;
    
    // CREATORS
    Vmpsoc_spram_testbench__Syms(Vmpsoc_spram_testbench* topp, const char* namep);
    ~Vmpsoc_spram_testbench__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(64);

#endif // guard
