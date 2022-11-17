include common.mk

SRC_DIR := src
TESTS_DIR := test
BENCH_DIR := benchmarks

MARKDOWN := doc/Markdown/Markdown.pl

all: tests benchmarks README.html

debug: CPPFLAGS += -DCONFIG_DEBUG
debug: all

PHONY += lib
lib:
	$(MAKE) -C $(SRC_DIR)

PHONY += docs
docs: *.c *.cc *.h README.html
	doxygen

README.html: README.md
	$(MARKDOWN) $< > $@

%.pdf: %.dot
	dot -Tpdf $< -o $@

PHONY += clean
clean:
	rm -f *.o *.so .*.d *.pdf *.dot
	$(MAKE) -C $(SRC_DIR) clean
	$(MAKE) -C $(TESTS_DIR) clean
	$(MAKE) -C $(BENCH_DIR) clean

PHONY += mrclean
mrclean: clean
	rm -rf docs

PHONY += tags
tags:
	ctags -R

PHONY += tests
tests: lib
	$(MAKE) -C $(TESTS_DIR)

PHONY += benchmarks
benchmarks: lib
	@if ! test -d $(BENCH_DIR); then \
		echo "Directory $(BENCH_DIR) does not exist" && \
		echo "Please clone the benchmarks repository" && \
		echo && \
		exit 1; \
	fi
	$(MAKE) -C $(BENCH_DIR)

PHONY += pdfs
pdfs: $(patsubst %.dot,%.pdf,$(wildcard *.dot))

.PHONY: $(PHONY)

# A 1-inch margin PDF generated by 'pandoc'
%.pdf: %.md
	pandoc -o $@ $< -V header-includes='\usepackage[margin=1in]{geometry}'
