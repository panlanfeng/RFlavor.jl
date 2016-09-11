@test typeof(RFlavor.matrix(1, 5)) == Array{Float64,2}
@test size(RFlavor.matrix(rand(10), 5)) == (5,2)
@test RFlavor.matrix(1:10, 5) == RFlavor.matrix(1:10, 5, byrow = false)'
#@test RFlavor.matrix(1:10, nrow = 5)
@test RFlavor.matrix(1:10, ncol = 2) == RFlavor.matrix(1:10, 5)
# RFlavor.matrix(1:10, nrow = 5, ncol = 2)
@test_throws DimensionMismatch RFlavor.matrix(1:5,2)

