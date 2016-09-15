x = rand(10)
@test RFlavor.seq(0, 1, by = 0.1) == RFlavor.seq(0, 1, 0.1) == RFlavor.seq(0, 1, length = 11)
@test RFlavor.seq_len(10) == RFlavor.seq_along(x)

