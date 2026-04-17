pdf:
	pandoc --defaults metadata/pdf.yaml src/*.md

html:
	pandoc --defaults metadata/html.yaml src/*.md

all: pdf html