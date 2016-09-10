using DataFrame
@test RFlavor.duplicated([1,2,2,3,4,1]) == [false, false, true, false, false, true]
@test RFlavor.duplicated(['a', 'b', 'c', 'c', 'd']) == [false, false, false, true, false]
@test RFlavor.duplicated([1 2; 2 3; 1 2; 3 4; 1 2]) == [false, false, true, false, true]
@test RFlavor.duplicated(DataFrame(x=[1,2,1,2,3], y =[2,1,2,1,2])) == [false, false, true, true, false]
