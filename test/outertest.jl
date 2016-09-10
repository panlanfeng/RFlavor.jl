@test RFlavor.outer(1:4, 1:4) == [i*j for i in 1:4, j in 1:4]
@test RFlavor.outer(["a","b"], ["c", "d"]) == ["ac" "ad"; "bc" "bd"]
