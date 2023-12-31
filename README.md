# SymbolicIndexingInterface.jl: Standardized Symbolic Indexing of Julia

SymbolicIndexingInterface.jl is a set of interface functions for handling containers
of symbolic variables.

## Installation

To install SymbolicIndexingInterface.jl, use the Julia package manager:

```julia
using Pkg
Pkg.add("SymbolicIndexingInterface")
```

## Introduction

The symbolic indexing interface has 2 levels:

1. The user level. At the user level, a modeler or engineer simply uses terms from a
   domain-specific language (DSL) inside of SciML functionality and will receive the requested
   values. For example, if a DSL defines a symbol `x`, then `sol[x]` returns the solution
   value(s) for `x`.
2. The DSL system structure level. This is the structure which defines the symbolic indexing
   for a given problem/solution. DSLs can tag a constructed problem/solution with this
   object in order to endow the SciML tools with the ability to index symbolically according
   to the definitions the DSL writer wants.


## Example

```julia
using ModelingToolkit, OrdinaryDiffEq, SymbolicIndexingInterface, Plots

@parameters σ ρ β
@variables t x(t) y(t) z(t) w(t)
D = Differential(t)

eqs = [D(D(x)) ~ σ * (y - x),
    D(y) ~ x * (ρ - z) - y,
    D(z) ~ x * y - β * z,
    w ~ x + y + z]

@named sys = ODESystem(eqs)
sys = structural_simplify(sys)

sol[x]
```
