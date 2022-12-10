"""
    generate_bound(city)

This computes the best bound on the problem across all the different bounding methods.
"""
function generate_bound(city::CityProblemInst)
    return min(naive_bound(city), small_bound(city))
    # return naive_bound(city)
end

"""
    naive_bound(city::CityProblemInst)

This generates a naive bound on the problem by just finding the total road length.
"""
function naive_bound(city::CityProblemInst)
    # naive solution
    graph = city.graph
    used_edges::Set{Tuple{Int,Int}} = Set()
    total_distance = 0
    for edge in edges(graph)
        A, B = src(edge), dst(edge)
        if !((A, B) in used_edges || (B, A) in used_edges)
            push!(used_edges, (A, B))
            total_distance += city.distances[(A, B)]
        end
    end
    return total_distance
end
"""
    small_bound(city::CityProblemInst)

This bounds the solution by repeatedly choosing the fastest street until the time is up.
"""
function small_bound(city::CityProblemInst)
    graph = city.graph
    graph_edges::Vector{Tuple{Int,Int}} = []
    let used_edges::Set{Tuple{Int,Int}} = Set()
        for edge in edges(graph)
            A, B = src(edge), dst(edge)
            if !((A, B) in used_edges)
                push!(used_edges, (A, B))
                push!(used_edges, (B, A))
                push!(graph_edges, (city.distances[(A, B)], city.times[(A, B)]))
            end
        end
    end
    sort!(graph_edges; by=((el) -> el[1] / el[2]), rev=true)
    time = city.total_duration * city.nb_cars
    total_distance = 0
    for i in 1:lastindex(graph_edges)
        total_distance += graph_edges[i][1]
        time -= graph_edges[i][2]
        if time < 0
            total_distance -= abs(time) * graph_edges[i][1] / graph_edges[i][2]
            break
        end
    end
    return total_distance
end
