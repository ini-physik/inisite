# ini make file



HUGO = ../hugo
SITE_OFFSET := test/
BASE_URL := http://ini.physik.tu-berlin.de/${SITE_OFFSET}
OUTPUT_DIR := public_html
REMOTE_LOCATION := iniwww@rosa.physik.tu-berlin.de:/home/i/iniwww/public_html/${SITE_OFFSET}
SOURCE_DIR := ./

INPUTS := static/
INPUTS += layouts/
INPUTS += content/

.PHONY: all test clean deploy clean

all: ${OUTPUT_DIR}

${OUTPUT_DIR}: ${INPUTS}
	@echo "Create ing output dir: ${OUTPUT_DIR}"
	@mkdir ${OUTPUT_DIR}
	@echo "hugo --source=${SOURCE_DIR} --base-url=${BASE_URL} --destination=${OUTPUT_DIR}"
	${HUGO} --source=${SOURCE_DIR} --base-url=${BASE_URL} --destination=${OUTPUT_DIR}
	@echo "Changing permissions"
	@find ${OUTPUT_DIR} -type d -exec chmod a+x '{}' \; 

test:
	${HUGO} server --source=./

deploy: all
	@rsync -ravud ${OUTPUT_DIR}/* ${REMOTE_LOCATION}

clean: 
	@rm -rf ${OUTPUT_DIR} public
