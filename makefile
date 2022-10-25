SHELL=/bin/bash

JC = javac

SOURCE_FILE ?= $(shell bash -c 'read -p "source  file: " root; echo $$root')
TARGET_DIR ?= $(shell bash -c 'read -p "target   dir: " out; echo $$out')
MAIN_TARGET ?= $(shell bash -c 'read -p "run   source: " run; echo $$run')
INPUT_SOURCE ?= $(shell bash -c 'read -p "input source: " source; echo $$source')
source_file := $(SOURCE_FILE)
target_file := $(TARGET_DIR)

define complie 
	@echo "compling .... "
	@echo
	$(JC) $1 -d $2
endef

define run
	@echo
	@echo
	cd $1 && java $2 < $3
endef


default: lab2_run

lab2_complie:
	@$(call complie, $(source_file), $(target_file))
	@echo "do not enter target folder name for 'run   source' for next make run"

lab2_run: lab2_complie
	@$(call run, $(target_file), $(MAIN_TARGET), $(INPUT_SOURCE))


#sample input:
# source  file: src/DueDateCalculator.java
# target   dir: src
# run   source: DueDateCalculator
# input source: ../sampledates.txt