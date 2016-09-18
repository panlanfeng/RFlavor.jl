x = list(a=1:10, beta=exp(-3:3), logic = [true,false, false, true])
y = list(a = ["a", "b", "c"], b = ["d", "e", "f"])
@test unlist(RFlavor.lapply(x, mean)) == RFlavor.sapply(x, mean)
@test length(RFlavor.lapply(x, quantile, collect(1:3)/4)) == 3
@test size(RFlavor.sapply(x, quantile, collect(1:3)/4)) == (3, 3)
@test typeof(RFlavor.sapply(y, x->outer(x, x))) <: Array
## need `==` for List object
# RFlavor.lapply(x, x->outer(x, x)) == RFlavor.sapply(x, x->outer(x, x))

