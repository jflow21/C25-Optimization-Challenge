"""
    C25OptimizationChallenge

This is a package for the Optimization Challenge for the C25 course at MIT.
"""
module C25OptimizationChallenge

using HashCode2014

export breadth_first
export generate_solution

include("util.jl")
include("breadth_first.jl")
include("repeat.jl")
include("generate_solution.jl")

end
