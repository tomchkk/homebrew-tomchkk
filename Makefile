PROJECT_NAME = $(shell basename $(PWD))
APP_VERSION = $(shell git describe --always --first-parent HEAD 2>/dev/null || echo "v0.0.0")
TAP = /usr/local/Homebrew/Library/Taps/tomchkk/

.usage.usage: ## : usage : Print this usage info
usage:
	@echo
	@echo "$(PROJECT_NAME) - $(APP_VERSION)"
	@echo
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo
	@grep -Eh '^.*\.usage:\ ##\ :\ .+' ${MAKEFILE_LIST} | cut -d ' ' -f '3-' | column -t -s ':' | sort
	@echo

.is.installed.%:
	@: $(if $(shell type $* &>/dev/null && echo 0), \
			, \
			$(error $* is not installed))

.tap.usage: ## : tap : Symlink project to brew's tap directory
tap: .is.installed.brew
tap:
	mkdir -p ${TAP}
	ln -s ${PWD} ${TAP}

.update.usage: ## : update : Update or install the latest versions of all available formula
update: .is.installed.brew
update:
	@echo TODO!
