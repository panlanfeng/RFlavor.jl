using StatsBase

srand(2016);
x = sample(1:5, 100);
y = sample(["a", "b"], 100);
table1 = RFlavor.table(y)
table2=RFlavor.table(x, y)

@test sprint(show, table1) == """\
2-element Named Array{Int64,1}
Dim1 │ 
──┼───
a │ 61
b │ 39"""

@test sprint(show, table2) == """\
5×2 Named Array{Int64,2}
Dim1 ╲ Dim2 │  a   b
────────────┼───────
1           │ 14   9
2           │ 15   7
3           │ 10  10
4           │ 10   5
5           │ 12   8"""
