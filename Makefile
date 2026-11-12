BUILD_DIR := ./build
SRC_DIR := ./src

README.md: madlib.json
	pilcrow -i README.md --repo brekk/might --auto

version.lock: madlib.json
	madlib install

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)
