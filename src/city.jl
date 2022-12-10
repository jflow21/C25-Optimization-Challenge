"""
    CityProblemInst

This stores an instance of the problem for internal use.
"""
Base.@kwdef struct CityProblemInst
    total_duration::Int
    nb_cars::Int
    starting_junction::Int
    graph::SimpleDiGraph
    distances::Dict{Tuple{Int, Int}, Int}
    times::Dict{Tuple{Int, Int}, Int}
    speeds::Dict{Tuple{Int, Int}, Float64}
end



"""
    CityProblem(city_string)

This function parses a city string and returns a `CityProblemInst` object. The city string is a string that contains the description of the city. The format of the string is described in the problem statement.
"""
function CityProblem(city::City)
    N = length(city.junctions)
    M = length(city.streets)

    graph = SimpleDiGraph(N)
    edges = Vector{Edge}(undef, M)
    distances::Dict{Tuple{Int, Int}, Int} = Dict()
    times::Dict{Tuple{Int, Int}, Int} = Dict()
    speeds::Dict{Tuple{Int, Int}, Float64} = Dict()
    # it is slow to add edges one by one, so we do it in bulk
    for j in 1:M
        A, B = city.streets[j].endpointA, city.streets[j].endpointB
        edges[j] = Edge(A, B)
        times[(A, B)] = city.streets[j].duration
        distances[(A, B)] = city.streets[j].distance
        speeds[(A, B)] = city.streets[j].distance / city.streets[j].duration
        if (city.streets[j].bidirectional)
            push!(edges, Edge(B, A))
            distances[(B, A)] = city.streets[j].distance
            times[(B, A)] = city.streets[j].duration
            speeds[(B, A)] = city.streets[j].distance / city.streets[j].duration
        end
    end
    city = CityProblemInst(;
        total_duration=city.total_duration,
        nb_cars=city.nb_cars,
        starting_junction=city.starting_junction,
        graph=SimpleDiGraphFromIterator(edges),
        distances=distances,
        times=times,
        speeds=speeds
    )
    return city
end

function read_city_problem(city=read_city())
    return CityProblem(city)
end

function total_distance(solution::Solution, city::CityProblemInst=read_city_problem())
    total_distance::Int = 0
    used::Set{Tuple{Int, Int}} = Set()
    for itinerary in solution.itineraries
        for i in 1:(length(itinerary) - 1)
            if !((itinerary[i], itinerary[i + 1]) in used || (itinerary[i + 1], itinerary[i]) in used)
                total_distance += city.distances[(itinerary[i], itinerary[i + 1])]
                push!(used, (itinerary[i], itinerary[i + 1]))
            end
        end
    end
    return total_distance
end