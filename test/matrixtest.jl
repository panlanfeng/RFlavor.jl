x = rand(10)
@test typeof(RFlavor.matrix(1.0, 5)) == Array{Float64,2}
@test typeof(RFlavor.matrix(1, 5)) == Array{Int64,2}
@test size(RFlavor.matrix(1.0, 4, 2)) == (4,2)
@test size(RFlavor.matrix(x, 5)) == (5,2)
@test RFlavor.matrix(x, 5) == RFlavor.matrix(x, 2, byrow = true)'
@test RFlavor.matrix(x, ncol = 2) == RFlavor.matrix(x, 5)
@test size(RFlavor.matrix(x, 15, 2)) == (15,2)
@test_throws DimensionMismatch RFlavor.matrix(1:5,2)


