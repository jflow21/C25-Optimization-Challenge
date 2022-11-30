"""
    generate_solution()

This function generates a solution to the problem using the current preferred method.
"""
function generate_solution(num_times=10, method=breadth_first)
    city = read_city()
    return repeat(city, num_times, method)
end