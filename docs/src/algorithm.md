# Greedy Algorithm

The basic idea for the algorithm is as follows: at each step, pick the neighboring junction that has the highest score and travel to it. The main complexity lies in choosing a good score function that will lead to desireable results. The randomized solution given in HashCode2014.jl may be thought of as the greedy solution with a constant score function.

## Motivation for Greedy Algorithm

Often, complex graph problems like this turn out to be NP-complete. While we have not formally made a reduction, this problem is intuitively hard to solve exactly, and so we suspect an approximate solution is more reasonable. Greedy solutions are particularly nice because they feed on intuition; the main thing that determines how a greedy solution will perform is the quality of the heuristic used. Moreover, while an optimal solution may be hard, an approximate solution should actually give decent results. The un-optimized, randomized solution was able to get within an order of magnitude of the upper bound, which suggests that a sufficiently-optimal greedy solution should be able to perform near-perfect.

## Score Function

There are a few natural choices for a score function: the distance of the connecting road, whether or not the connecting road has been visited, whether or not the junction has been visited, the speed of the road, etc. We ended up choosing the speed of the road, as intuitively, solutions that travel at higher speeds will cover more road. Also, we decided that a junction should have a score of zero if the connecting road has already been traveled. This will create a preference towards non-visited roads for the greedy algorithm.

## Implementing Depth-First Search

The above score function works decently well, but it also exemplifies the problem with a simple greedy algorithm for this problem: greedy algorithms work locally, but global analysis is necessary for a good solution. One solution to this is to increase the size of the locale that the greedy algorithm works in. In more specific terms, if we implement some sort of lookahead, then the greedy algorithm can choose the next junction based on how it will increase future prospects. Thus, we examine all of the paths of a fixed length $\ell$ starting from the current node, compute the path with the highest score, and choose the first node along that path to be the next node.

## Revised Score Function

Since the score function must now evaluate paths instead of individual nodes, we must change the score function from earlier. The naive way to do this is just to compute the sum of the score function applied to each node in the path; however, this actually results in worse results that the no-lookahead solution. The key observation is that while future prospects matter to an extent, what matters most is still simply increasing the amount of road traveled. Thus, we add weights so that junctions that are closer will count for more in the sum. Specifically, for a given junction, we multiply the score by the current recursion depth remaining plus one. For instance, if there is a remaining recursion depth of 0, the score is trivially 0, and for neighbors of the original node, the score is multiplied by 1 plus the fixed recursion depth. This does lead to a slightly odd phenomenon; higher recursion depths do not always result in better solutions. This is counterintuitive, as higher recursion depths means more lookahead is taking place; however, because we are combining the scores of a path in such a naive way, the score of a path can become watered down by its length, and it can also strongly avoid paths that lead to corners, even if they are necessary. Other ways of combining the individual scores of each junction could likely result in better results; for instance, we tried a decay factor instead of a linear multiplicative factor, as well as changing the constant of addition, but none of these resulted in improvement.

## Computing in Parallel vs Sequentially

Recall that we are working with 8 cars, and not just one. Thus, we can either compute the path of each car one after the other or all at the same time. Intuitively, it seems like computing them together should yield the best results; cars will be able to update their strategy according to the actions of other cars. While this is generally true up to a recursion depth of 9, it ceases to be true for larger recursion depths. Since the computation of the optimal solution involved a recursion depth of 12, we compute the agenda for each car sequentially. It is unclear why this phenomenon occurs, but it could potentially be mitigated by more explicitly encouraging cars to spread out; however, we did not implement that behavior. The parallel solution is still implemented, but is not exported from the package by default.

## Stochasticity

We wondered whether introducing randomness into our solution could help produce a better result, as otherwise, our solution quality had plateaued. Specifically, we tried replacing the addition by 1 in the computation of the score function with addition by a random number between 0 and 1. While this generally decreased the solution quality, repeating this over multiple trials and taking the best result did result in improvement in some cases. However, as the recursion depth increased, the effect of the randomness seemed to become more and more negative. Moreover, using more trials requires linearly more time, and so this quickly became infeasible to run in a reasonable timeframe. With more preciseness, though, this could result in an improved solution even for larger recursion depths; however, we did not include it in the final version.

## Room for Improvement

There are 3 main avenues for improvement that we see:

1. Pruning,
2. Enforcing car separation,
3. Using an algorithmic and non-greedy solution.

The second of these is likely the most straightforward, and the second requires more algorithmic thought. The third is currently intractible, as it requires significant further algorithmic development; however, we suspect that there is an algorithmic solution related to computing Euler paths.
