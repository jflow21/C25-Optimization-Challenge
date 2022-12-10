"""
    breadth_first(city; max_depth=5)

This function tries to find a good solution to the problem using a greedy approach with lookahead, using sequential computation of each of the car agendas.
"""
function breadth_first(city::CityProblemInst; max_depth=5)
    (; total_duration, nb_cars, starting_junction, distances, times, speeds) = city
    g = city.graph
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    used_edges::Set{Tuple{Int,Int}} = Set()
    used_nodes = falses(nv(g))
    used_nodes[starting_junction] = true
    total_distance = 0
    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        while true
            current = last(itinerary)
            candidates = [
                node for node in neighbors(g, current) if
                (duration + times[(current, node)] <= total_duration)
            ]
            if isempty(candidates)
                break
            end
            next_node = select_node(
                current, candidates, g, used_nodes, used_edges, speeds; max_depth=max_depth
            )
            if !((next_node, current) in used_edges || (current, next_node) in used_edges)
                total_distance += distances[(current, next_node)]
            end
            push!(used_edges, (current, next_node))
            push!(itinerary, next_node)
            used_nodes[next_node] = true
            duration += times[(current, next_node)]
        end
        itineraries[c] = itinerary
    end
    return (Solution(itineraries), total_distance)
end
"""
    breadth_first_parallel(city; max_depth=5)

This function tries to find a good solution to the problem using a greedy approach with lookahead, using parallel computation of each of the car agendas.
"""
function breadth_first_parallel(city::CityProblemInst; max_depth=5)
    (; total_duration, nb_cars, starting_junction, distances, times, speeds) = city
    g = city.graph
    itineraries = [[starting_junction] for i in 1:nb_cars]
    car_running = trues(nb_cars)
    durations = [0 for i in 1:nb_cars]
    used_edges::Set{Tuple{Int,Int}} = Set()
    used_nodes = falses(nv(g))
    used_nodes[starting_junction] = true
    total_distance = 0
    while any(car_running)
        for c in 1:nb_cars
            if !car_running[c]
                continue
            end
            current = last(itineraries[c])
            candidates = [
                node for node in neighbors(g, current) if
                (durations[c] + times[(current, node)] <= total_duration)
            ]
            if isempty(candidates)
                car_running[c] = false
                continue
            end
            next_node = select_node(
                current, candidates, g, used_nodes, used_edges, speeds; max_depth=max_depth
            )
            if !((next_node, current) in used_edges || (current, next_node) in used_edges)
                total_distance += distances[(current, next_node)]
            end
            push!(used_edges, (current, next_node))
            used_nodes[next_node] = true
            durations[c] += times[(current, next_node)]
            push!(itineraries[c], next_node)
        end
    end
    return (Solution(itineraries), total_distance)
end
