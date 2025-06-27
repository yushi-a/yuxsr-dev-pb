format:
	buf format -w

lint:
	buf lint

gencode:
	npm run generate

.PHONY: format, lint, gencode
