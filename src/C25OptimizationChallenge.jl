"""
    C25OptimizationChallenge

This is a package for the Optimization Challenge for the C25 course at MIT.
"""
module C25OptimizationChallenge

using HashCode2014
using Graphs
using SimpleWeightedGraphs

export breadth_first
export generate_solution
export read_city_problem
export total_distance
export generate_bound

include("util.jl")
include("city.jl")
include("depth_first.jl")
include("breadth_first.jl")
include("repeat.jl")
include("generate_solution.jl")
include("bound.jl")

end
