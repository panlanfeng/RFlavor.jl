x = (1,2, 4)
x1 = [4,2,1]
x2 = [8,4,2,1, "a"]
x3 = ("a", 1,2,4, 8)
@test setequal(x, x1)
@test setequal(x2, x3)
@test !setequal(x, x2)
@test !setequal(x1, x3)
