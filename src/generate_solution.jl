"""
    generate_solution(city, num_times=10, method=breadth_first)

This function generates a solution to the problem using the current preferred method.
"""
function generate_solution(city=read_city(), num_times=10, method=breadth_first)
    return repeat(city, num_times, method)
end
