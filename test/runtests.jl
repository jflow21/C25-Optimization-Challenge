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
        other_city = HashCode2014.City(;
            total_duration=18000,
            streets=city.streets,
            starting_junction=city.starting_junction,
            nb_cars=8,
            junctions=city.junctions,
        )
        city_problem = read_city_problem()
        other_city_problem = read_city_problem(other_city)
        random_solution = random_walk(city)
        solution, dist = generate_solution(; num_times=1)
        @test is_feasible(solution, city)
        @test is_feasible(
            C25OptimizationChallenge.breadth_first_parallel(city_problem)[1], city
        )
        @test C25OptimizationChallenge.total_distance(solution) == dist
        @test dist == breadth_first(city_problem)[2]
        @test dist <= generate_bound(city_problem)
        @test C25OptimizationChallenge.speed(1, 2) == 1 / 2
        @test generate_solution(; city=other_city)[2] < generate_bound(other_city_problem)
    end
end
