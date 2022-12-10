"""
    repeat(city, num_times, method)

This function tries to find a good solution to the problem by repeatedly calling `method` and keeping the best solution found. This should result in improvements if `method` is randomized.
"""
function repeat(city, num_times, method)
    city_problem = read_city_problem(city)
    best_solution, best_distance = method(city_problem)
    for i in 1:num_times
        solution, distance = method(city_problem)
        if distance > best_distance
            best_solution = solution
            best_distance = distance
        end
    end
    return best_solution, best_distance
end
