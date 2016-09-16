
srand(2016);
@test RFlavor.datarange(rand(3,4))==(0.10640104595306332,0.9931674276761062)
@test RFlavor.datarange([randstring(3) for i in 1:5])==String["pQ9","qpx","5H2","W3V","807"]
@test RFlavor.datarange([DateTime(2013,7,i) for i in 1:10]) == (DateTime("2013-07-01T00:00:00"),DateTime("2013-07-10T00:00:00"))

using DataFrames
xf = pool(sample(1:10, 100));
@test setequal(RFlavor.datarange(xf),collect(1:10))

xb=rand(100).>0.5;
@test setequal(datarange(xb), [true, false])

@test datarange(DataArray(rand(3,4)))==(0.011173956574827226,0.8298861361038359)

@test setequal(datarange(sample(1:4, 100)), collect(1:4))
