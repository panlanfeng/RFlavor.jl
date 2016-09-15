using DataFrames, StatsBase

li = list(x=rand(10), y = rand(Int, 2,3), df = DataFrame(rand(5,2)),
    fa = pool(sample([true, false], 100)))

li2 = merge(li, list(f1=*, f2=-))
li3 = list(li, list(f1=*, f2=-))
@test length(unlist(li3, true)) == 6
@test length(unlist(li3, false)) == 2

py=List(Any[rand(i) for i in 1:10])
@test length(unlist(lapply(py, mean)))==10

@test isempty(List())
@test haskey(li, :x)
@test get(li, :x, -1) == li[:x]
names!(li, [:x1, :x2, :x3, :x4])
@test names(li) == [:x1, :x2, :x3, :x4]

# ERROR: dict = Dict("a" => 1, "b" => 2, "c" => 3)
dict = Dict("a" => 1:2, "b" => [:x, :y], "c" => seq(1,2,.1))
@test typeof(List(dict)) == RFlavor.List

mat = rand(5,2)
@test typeof(List(mat)) == RFlavor.List

df = DataFrame(x=rand(10), y=rand(10))
@test typeof(List(df)) == RFlavor.List

## TOTO: push! definition might be problematic
