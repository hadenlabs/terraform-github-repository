#
# See ./docs/contributing.md
#

docs:
	make docs.help

docs.help:
	@echo '    Docs:'
	@echo ''
	@echo '        docs.build                  Show mkdocs'
	@echo '        docs.serve                  server Make documentation'
	@echo '        docs.terraform             generated docs for terraform'
	@echo ''

docs.terraform:
	$(call terraform-docs, ${TERRAFORM_README_FILE}, \
			'This document gives an overview of variables used in the platform of the ${PROJECT}.', \
			variables.tf)

docs.build:
	$(PIPENV_RUN) mkdocs build

docs.serve:
	$(PIPENV_RUN) mkdocs serve
