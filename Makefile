export UID = $(shell id -u)

help: # Afficher toutes les recettes du Makefile
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#-------------------
# Commandes usuelles
#-------------------

build: ## Génération des statiques finaux
	hugo

deploy: build ## Deploiement du site
	rsync -avz --delete public/ ccc:/var/www/ccc-static
