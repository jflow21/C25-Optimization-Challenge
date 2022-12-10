"""
    breadth_first(city)

This function tries to find a good solution to the problem using something similar to a breadth-first search.

The algorithm used here is based on the random walk algorithm presented in class. There are two key differences:
1. There is a preference to take streets that have not been visited yet.
2. For a street that has not been visited yet, if there are multiple streets that have not been visited yet, the street with the highest speed is chosen.

The first of these prevents the algorithm from backtracking too much. The second of these is simply a heuristic that results in favorable behavior; it is generally better to travel faster.
"""
function breadth_first(city::CityProblemInst)
    (; total_duration, nb_cars, starting_junction, distances, times, speeds) = city
    g = city.graph
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    used_edges::Set{Tuple{Int, Int}} = Set()
    used_nodes = falses(nv(g))
    used_nodes[starting_junction] = true
    total_distance = 0
    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        while true
            current = last(itinerary)
            candidates = [
                node for node in neighbors(g, current) if (
                    duration + times[(current, node)] <= total_duration
                )
            ]
            if isempty(candidates)
                break
            end
            next_node = select_node(current, candidates, g, used_nodes, used_edges, speeds)
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
# function breadth_first_parallel(city::CityProblemInst)
#     (; total_duration, nb_cars, starting_junction, distances, times) = city
#     g = city.graph
#     itineraries = [[starting_junction] for i in 1:nb_cars]
#     car_running = trues(nb_cars)
#     durations = [0 for i in 1:nb_cars]
#     used_edges::Set{Tuple{Int, Int}} = Set()
#     used_nodes = falses(nv(g))
#     used_nodes[starting_junction] = true
#     total_distance = 0
#     while any(car_running)
#         for c in 1:nb_cars
#             if !car_running[c]
#                 continue
#             end
#             current = last(itineraries[c])
#             candidates = [
#                 node for node in neighbors(g, current) if (
#                     durations[c] + times[(current, node)] <= total_duration
#                 )
#             ]
#             if isempty(candidates)
#                 car_running[c] = false
#                 continue
#             end
#             next_node = select_node(current, candidates, g, used_nodes, used_edges, distances, times)
#             if !((next_node, current) in used_edges || (current, next_node) in used_edges)
#                 total_distance += distances[(current, next_node)]
#             end
#             push!(used_edges, (current, next_node))
#             used_nodes[next_node] = true
#             durations[c] += times[(current, next_node)]
#             push!(itineraries[c], next_node)
#         end
#     end
#     return (Solution(itineraries), total_distance)
# end