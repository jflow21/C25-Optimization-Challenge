# Bounds

## Trivial Bound

One trivial bound is that we can at at most travel through every single road. Thus, the sum of all of the road lengths is an upper bound. We suspect that for the large case, this actually results in a fairly good bound, as current solutions are very close to it. It is potentially even possible to attain this bound in the large case.

## Speed Bound

The other bound can be attained by repeatedly choosing the road with the highest speed limit, and simulating taking it.

## Other Bound ideas

If we replace all of the edge speeds by the highest speed, the problem becomes easier to solve. It also becomes easier if we remove the directed aspect of the graph, and simply make every edge bidirectional. Perhaps these could lead to better bounds, but more algorithmic work is necessary to properly utilize them.
