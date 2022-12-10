using Test
using Aqua
using Documenter
using HashCode2014
using JuliaFormatter
using C25OptimizationChallenge

DocMeta.setdocmeta!(
    C25OptimizationChallenge,
    :DocTestSetup,
    :(using C25OptimizationChallenge);
    recursive=true,
)

@testset verbose = true "C25OptimizationChallenge.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(C25OptimizationChallenge)
    end

    @testset verbose = true "Code quality (JuliaFormatter.jl)" begin
        JuliaFormatter.format(C25OptimizationChallenge)
    end

    @testset verbose = true "Code quality (Documenter.jl)" begin
        Documenter.doctest(C25OptimizationChallenge)
    end

    @testset verbose = true "Large instance" begin
        city = read_city()
        city_problem = read_city_problem()
        random_solution = random_walk(city)
        solution, dist = generate_solution()
        @test is_feasible(solution, city)
        @test C25OptimizationChallenge.total_distance(solution) == dist
        @test dist == breadth_first(city_problem)[2]
        @test dist <= generate_bound(city_problem)
        # @test C25OptimizationChallenge.speed(1, 2) = 1 / 2
    end
end
