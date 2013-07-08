
all:
	coffee --lint --bare --compile --output ./javascript ./src


clean:
	rm ./javascript/*
