# 现在保留这个是为了方便直接跑test，ctest只有结果没有输出
# 现在`make`即`make run`
TARGET = ../build/calcifer

# 公共部分便捷测试
run:
	$(TARGET) ../test_set/test.c | tee ../doc/output.log
