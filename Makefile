FILES_PT := $(wildcard ./cv_data_pt/*csv)
FILES_EN := $(wildcard ./cv_data_en/*csv)


all: ./cv.pdf ./cv_en.pdf


./cv.pdf: ./cv.typ ./cv_functions.typ $(FILES_PT)
	typst compile $<

./cv_en.pdf: ./cv_en.typ ./cv_functions.typ $(FILES_EN)
	typst compile $<

./cv_data_en/%.csv: ./cv_data_pt/%.csv
	uv run translation_script.py

# List the files used for the CV creation
.PHONY: list-files
list-files:
	$(info VAR="$(FILES)")
