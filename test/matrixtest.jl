@test typeof(RFlavor.matrix(1, 5)) == Array{Float64,2}
@test size(RFlavor.matrix(rand(10), 5)) == (5,2)
@test RFlavor.matrix(1:10, 5) == RFlavor.matrix(1:10, 2, byrow = true)'
@test RFlavor.matrix(1:10, ncol = 2) == RFlavor.matrix(1:10, 5)
@test_throws DimensionMismatch RFlavor.matrix(1:5,2)

x = rand(10)
RFlavor.matrix(1, 5)
RFlavor.matrix(1.0, 4, 2)

RFlavor.matrix(x)
RFlavor.matrix(x, 5)
RFlavor.matrix(x, 5, byrow=true)

RFlavor.matrix(x, ncol = 2)
RFlavor.matrix(x, ncol = 2, byrow = true)

RFlavor.matrix(x, 5, 2, true)
RFlavor.matrix(1:5, 2) # error

RFlavor.matrix(1, 4)
RFlavor.matrix(1, 4, 2)
RFlavor.matrix(2.0, nrow = 4, ncol =2)
