
all:
	coffee --lint -b --compile --output ./javascript ./src


clean:
	rm ./javascript/*
