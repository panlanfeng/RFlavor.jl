@test isnothing(nothing)
@test isempty(nothing)

x = seq(1, 100, 0.1);
@test length(RFlavor.head(x))==6
@test length(RFlavor.tail(x))==6
x = matrix(1:120, 30, 4)
@test nrow(RFlavor.head(x)) == 6
@test ncol(RFlavor.head(x)) == 4
@test size(RFlavor.tail(x)) == (6, 4)
