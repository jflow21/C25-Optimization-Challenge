"""
    select_node(current, candidates, graph, visited_nodes, visited_edges, distances, times)

This function selects the next node to traverse from a list of candidates by assigning each node a score and choosing the highest. The score is based on how `good` the best path starting with that node is.
"""
function select_node(
    current, candidates, graph, visited_nodes, visited_edges, speeds; max_depth=5
)
    # return rand(candidates)
    best_so_far = 0
    best_node = 0
    for neighbor in candidates
        edge = (current, neighbor)
        already_visited_node = visited_nodes[neighbor]
        already_visited_edge = edge in visited_edges
        score = already_visited_edge ? 0 : speeds[edge] * (max_depth + 1)
        # traverse edge
        visited_nodes[neighbor] = true
        push!(visited_edges, edge)
        score += partial_dfs(
            graph, neighbor, max_depth, visited_nodes, visited_edges, speeds
        )
        # un-traverse edge
        visited_nodes[neighbor] = already_visited_node
        already_visited_edge || pop!(visited_edges, edge)
        # update best
        if score >= best_so_far
            best_so_far = score
            best_node = neighbor
        end
    end
    return best_node
end

"""
    partial_dfs(graph, node, depth, visited_nodes, visited_edges, distances, times)

This function recursively calculates the score of a given node.
"""
function partial_dfs(graph, node::Int, depth::Int, visited_nodes, visited_edges, speeds)
    # return score of node
    if depth == 0
        return 0
    end
    best = 0
    for neighbor in neighbors(graph, node)
        edge = (node, neighbor)
        already_visited_node = visited_nodes[neighbor]
        already_visited_edge = edge in visited_edges
        score = already_visited_edge ? 0 : speeds[edge] * (depth + 1)
        # traverse edge
        visited_nodes[neighbor] = true
        push!(visited_edges, edge)
        score += partial_dfs(
            graph, neighbor, depth - 1, visited_nodes, visited_edges, speeds
        )
        # un-traverse edge
        visited_nodes[neighbor] = already_visited_node
        already_visited_edge || pop!(visited_edges, edge)
        best = max(best, score)
    end
    return best
end
