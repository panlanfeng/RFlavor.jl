@test RFlavor.findinterval(1, [0.5, 1, 2]) == 2
@test RFlavor.findinterval(1:3, 0:0.5:4) == [3, 5, 7]
@test RFlavor.findinterval([1,4], [2, 3, 3, 5]) == [0, 3]
