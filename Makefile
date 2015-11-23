# ini make file



HUGO = hugo
SITE_OFFSET := 
BASE_URL := http://ini.physik.tu-berlin.de/${SITE_OFFSET}
OUTPUT_DIR := public_html
REMOTE_LOCATION := iniwww@rosa.physik.tu-berlin.de:/home/i/iniwww/public_html/${SITE_OFFSET}
SOURCE_DIR := ./

INPUTS := static/
INPUTS += layouts/
INPUTS += content/

.PHONY: all test clean deploy clean

FAVICON := static/favicon.ico
FAVICON_SVG := resources/img/favicon.svg

all: ${OUTPUT_DIR}

$(FAVICON): $(FAVICON_SVG)
	convert $<  -bordercolor blue -border 0 \
	\( -clone 0 -resize 16x16 \) \
	\( -clone 0 -resize 32x32 \) \
	\( -clone 0 -resize 48x48 \) \
	\( -clone 0 -resize 64x64 \) \
	-delete 0 -alpha off -colors 256 $@


basedir: $(FAVICON)
	@echo "Create ing output dir: ${OUTPUT_DIR}"
	@mkdir -p ${OUTPUT_DIR}

${OUTPUT_DIR}: ${INPUTS} basedir
	${HUGO} --source=${SOURCE_DIR} --baseUrl=${BASE_URL} --destination=${OUTPUT_DIR}
	@echo "Changing permissions"
	@find ${OUTPUT_DIR} -type d -exec chmod a+x '{}' \; 

test:
	${HUGO} server --watch --source=./

deploy: all
	@rsync -ravud ${OUTPUT_DIR}/* ${REMOTE_LOCATION}

clean:
	@rm -rf $(FAVICON)
	@rm -rf ${OUTPUT_DIR} public
