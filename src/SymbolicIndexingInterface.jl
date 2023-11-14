module SymbolicIndexingInterface

using Requires

export ScalarSymbolic, ArraySymbolic, NotSymbolic, symbolic_type, getname
include("trait.jl")

export is_variable, variable_index, variable_symbols, is_parameter, parameter_index,
    parameter_symbols, is_independent_variable, independent_variable_symbols, is_observed,
    observed, is_time_dependent, constant_structure
include("interface.jl")

export SymbolCache
include("symbol_cache.jl")

@static if !isdefined(Base, :get_extension)
    function __init__()
        @require Symbolics="0c5d862f-8b57-4792-8d23-62f2024744c7" include("../ext/SymbolicIndexingInterfaceSymbolicsExt.jl")
        @require SymbolicUtils="d1185830-fcd6-423d-90d6-eec64667417b" include("../ext/SymbolicIndexingInterfaceSymbolicUtilsExt.jl")
    end
end

end
