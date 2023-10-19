using SimpleBoids
using Test

@testset "SimpleBoids.jl" begin
    @test SimpleBoids.norm([1.,0.],[1.,0.])==0.
end
