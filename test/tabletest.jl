x = repeat(["a", "b", "c", "d"], outer=[100]);
y = repeat(["A", "B", "C", "D"], inner=[10], outer=[10]);

@test table(x).array == [100, 100, 100, 100]
@test table(y).array == [100, 100, 100, 100]
@test table(x, y).array == [30 20 30 20;
                                30 20 30 20;
                                20 30 20 30;
                                20 30 20 30]
