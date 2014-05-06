# Copyright © 2014 Kosma Moczek <kosma@cloudyourcar.com>
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License, Version 2, as
# published by Sam Hocevar. See the COPYING file for more details.

CFLAGS = -g -Wall -Wextra -Werror -std=c99 -I. -Itests
LDLIBS = -lcheck

all: scan-build test example
	@echo "+++ All good."""

test: tests/tests
	@echo "+++ Running Check test suite..."
	tests/tests

scan-build: clean
	@echo "+++ Running Clang Static Analyzer..."
	scan-build $(MAKE) tests

docs:
	doxygen

clean:
	$(RM) *.o tests/*.o tests/tests html/ *.sim tags

ringfs.o: ringfs.c ringfs.h
example: example.o ringfs.o tests/flashsim.o
example.o: example.c ringfs.h tests/flashsim.h

tests/tests: ringfs.o tests/tests.o tests/flashsim.o
tests/tests.o: tests/tests.c ringfs.h
tests/flashsim.o: tests/flashsim.c tests/flashsim.h

.PHONY: all test scan-build clean docs
