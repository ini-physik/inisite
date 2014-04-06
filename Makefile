# ini make file



HUGO = ../hugo
SITE_OFFSET := test/
BASE_URL := http://ini.physik.tu-berlin.de/${SITE_OFFSET}
OUTPUT_DIR := public_html
REMOTE_LOCATION := iniwww@rosa.physik.tu-berlin.de:/home/i/iniwww/public_html/${SITE_OFFSET}

INPUTS := static/
INPUTS += layouts/
INPUTS += content/

.PHONY: all test clean deploy clean

all: ${OUTPUT_DIR}

${OUTPUT_DIR}: ${INPUTS}
	@mkdir ${OUTPUT_DIR}
	${HUGO} --source=./ --base-url=${BASE_URL} --destination=${OUTPUT_DIR}

test:
	${HUGO} server --source=./

deploy: all
	@rsync -ravud ${OUTPUT_DIR}/* ${REMOTE_LOCATION}

clean: 
	@rm -rf ${OUTPUT_DIR} public
