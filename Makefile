.DEFAULT_GOAL:=help

.PHONY: test
test: ## Run the integration tests.
	@./run_test.sh $(target)

.PHONY: dev
dev: ## Installs dbt-* packages in develop mode along with development dependencies.
	@\
	echo "Install dbt-$(target)..."; \
	python -m pip install --upgrade pip setuptools; \
	python -m pip install --pre dbt-core "dbt-$(target)";

.PHONY: setup-db
setup-db: ## Setup Postgres database with docker-compose for system testing.
	@\
	docker-compose up --detach postgres

.PHONY: help
help: ## Show this help message.
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@grep -E '^[8+a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
