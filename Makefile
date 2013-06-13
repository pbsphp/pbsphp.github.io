
all:
	coffee -b --compile --output ./javascript ./src


clean:
	rm ./javascript/*
