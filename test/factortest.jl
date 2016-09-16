

using RFlavor, StatsBase, DataFrames, DataArrays, Base.Test
srand(1)
x = DataArray(RFlavor.rep(1:4, 11:14))
x[1] = NA
@test table(RFlavor.factor(x)).array==[10,12,13,14]

@test table(RFlavor.factor(x, exclude=[3,1])).array==[12,14]
@test table(RFlavor.factor(x, levels=[1,2])).array==[10,12]
@test setequal(RFlavor.factor(x, labels=["a","b","c","d"]).pool, ["a","b","c","d"])
