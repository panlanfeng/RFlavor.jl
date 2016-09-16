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

dict = Dict("a" => 1, "b" => 2, "c" => 3)
@test typeof(List(dict)) == RFlavor.List
dict = Dict("a" => 1:2, "b" => [:x, :y], "c" => seq(1,2,.1))
@test typeof(List(dict)) == RFlavor.List

mat = rand(5,2)
@test typeof(List(mat)) == RFlavor.List

df = DataFrame(x=rand(10), y=rand(10))
@test typeof(List(df)) == RFlavor.List

li[:x5]=rand(5)
@test names(li) == [:x1, :x2, :x3, :x4, :x5]
licopy=deepcopy(li)
names!(licopy, [:y1,:y2,:y3,:y4,:y5])
@test names(licopy) == [:y1,:y2,:y3,:y4,:y5]
@test names(rename(licopy, [:y1,:y2,:y3,:y4,:y5],[:x1, :x2, :x3, :x4, :x5])) == [:x1, :x2, :x3, :x4, :x5]

li[6]=rand(5)
@test length(li) == 6
li[7:8]="a"
@test length(li)==8
li[:]="b"
@test all( unlist(lapply(li, x->x=="b")) )
li[[true, false, true]] = "c"
@test li[1]=="c" && li[3] == "c"


empty!(li)
@test isempty(li)
insert!(li, 1, "abc",:x1)
@test length(li)==1
merge!(li, li2)
@test length(li)==7

delete!(li, 2)
@test length(li)==6

@test length(hcat(li, rand(4)))==7
@test length(hcat(li))==6
@test length(hcat(li, rand(4), li2))==8

li3copy=copy(li3)
empty!(li3)
@test length(li3copy)==2

li3[1:2]=li3copy
@test length(li3)==2

@test typeof(li[1:1]) == List
@test typeof(li[1]) != List
