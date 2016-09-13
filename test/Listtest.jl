using DataFrames, StatsBase

li = list(x=rand(10), y = rand(Int, 2,3), df = DataFrame(rand(5,2)),
    fa = pool(sample([true, false], 100)))

li2 = merge(li, list(f1=*, f2=-))
li3 = list(list1=li, list2=list(f1=*, f2=-))
@test length(unlist(li3, true))==6

py=as_list(Any[rand(i) for i in 1:10])
@test length(unlist(lapply(py, mean)))==10
