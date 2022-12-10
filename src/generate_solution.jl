"""
    generate_solution(city, num_times=0, method=breadth_first, max_depth=5)

This function generates a solution to the problem using the current preferred method.
"""
function generate_solution(;
    city=read_city(), num_times=0, method=breadth_first, max_depth=5
)
    return repeat(city, num_times, method, max_depth)
end
