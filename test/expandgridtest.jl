using DataFrames

@test nrow(RFlavor.expand_grid(x=1:10, y=[1., 2.], z=["a","b"]))==40
@test RFlavor.expand_grid()==DataFrame()
