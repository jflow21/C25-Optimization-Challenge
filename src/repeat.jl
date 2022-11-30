"""
    repeat(city, method=breadth_first, num_times=100)

This function tries to find a good solution to the problem by repeatedly calling `method` and keeping the best solution found. This should result in improvements if `method` is randomized.
"""
function repeat(city, num_times, method)
    best_solution = method(city)
    best_distance = total_distance(best_solution, city)
    for i in 1:num_times
        solution = method(city)
        distance = total_distance(solution, city)
        if distance > best_distance
            best_solution = solution
            best_distance = distance
        end
    end
    return best_solution
end
