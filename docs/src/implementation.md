# Implementation Details

In this document, we detail the various performance optimizations made to allow our algorithm to run in a reasonable timeframe.

## Graph Storage

We store the city map as a graph using the Graphs.jl package; this allows for $O(1)$ time checking of whether an edge exists between two junctions. Moreover, it allows us to quickly generate all of the neighbors of a given junction. We store the times, distances, and speed of each street as a dictionary to give $O(1)$ access time. We experimented with using a weighted graph and storing the speeds as the weight of the edges, but this was slower than using the dictionary method. During execution of the algorithm itself, we store whether or not each node has been visited using a Boolean vector, and we store whether or not each edge has been visited using a set. Theoretically, one could use a Boolean vector to store edge visitations as well, but we could not think of any easy way to convert an edge into an index uniquely and figured the set method would be good enough.

## General Speed Optimizations

We tried to perform as many general speed optimizations as possible, testing the speed after each optimization to make sure it actually increased the speed. One such optimization was precomputing the speed of each edge, which resulted in around a 5% improvement in speed. We made sure that every written function and computation was type stable, and we used the most appropriate types for each scenario (e.g., prefer integers over floats). The main focus of optimization was the `partial_dfs` function, as we determined that this is where the bulk of the computation time was. As written, there is little more optimization possible in this function without substantial restructuring or using different data types. Performance was one motivating factor in choosing our score function for the algorithm: each score computation takes one addition, one multiplication, and one dictionary access. There is some potential optimization left in that we are repeatedly pushing and popping a set, which, though $O(1)$, is still relatively expensive.
