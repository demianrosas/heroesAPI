help: ## Output available commands.
	@echo "Available commands:"
	@echo
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

images: ## Builds images with installed dependencies for all the services listed in docker-compose.yml.
	docker-compose build

up: ## Run containers for all services listed in docker-compose.yml.
	docker-compose up

database: ## Create the database and run the migrate process
	docker-compose exec app rails db:create db:migrate

down: ## Remove local containers
	docker-compose down

clean: ## Remove local containers, images, and volumes.
	docker-compose down --rmi all && docker volume prune -f

test: ## Run the tests
	docker-compose exec -e "RAILS_ENV=test" app rails db:create db:migrate
	docker-compose exec -e "RAILS_ENV=test" app bundle exec rspec
