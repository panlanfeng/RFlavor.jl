@test isnothing(nothing)
@test isempty(nothing)

x = seq(1, 100, 0.1);
@test length(head(x))==6
@test length(tail(x))==6
x = matrix(1:120, 30, 4)
@test nrow(head(x)) == 6
@test ncol(head(x)) == 4
@test size(tail(x)) == (6, 4)
