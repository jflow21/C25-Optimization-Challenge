"""
    breadth_first(city)

This function tries to find a good solution to the problem using something similar to a breadth-first search.

The algorithm used here is based on the random walk algorithm presented in class. There are two key differences:
1. There is a preference to take streets that have not been visited yet.
2. For a street that has not been visited yet, if there are multiple streets that have not been visited yet, the street with the highest speed is chosen.

The first of these prevents the algorithm from backtracking too much. The second of these is simply a heuristic that results in favorable behavior; it is generally better to travel faster.
"""
function breadth_first(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    used_junctions = streets .== starting_junction
    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        while true
            current_junction = last(itinerary)
            candidates_repeat = [
                (s, street) for (s, street) in enumerate(streets) if (
                    HashCode2014.is_street_start(current_junction, street) &&
                    duration + street.duration <= total_duration
                )
            ]
            candidates = [
                (s, street) for (s, street) in candidates_repeat if !used_junctions[s]
            ]
            if isempty(candidates) && isempty(candidates_repeat)
                break
            elseif isempty(candidates) # must use a used junction
                s, street = rand(candidates_repeat)
                next_junction = HashCode2014.get_street_end(current_junction, street)
                push!(itinerary, next_junction)
                duration += street.duration
            else
                s, street = argmax((cand) -> speed(cand[2]), candidates)
                next_junction = HashCode2014.get_street_end(current_junction, street)
                push!(itinerary, next_junction)
                duration += street.duration
                used_junctions[s] = true
            end
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end