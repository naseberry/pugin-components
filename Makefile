.PHONY: test checkout_to_release deploy_to_release

# Common variables
SRC_FOLDER=src
ICONS_LOC=$(SRC_FOLDER)/icons
IMAGES_LOC=$(SRC_FOLDER)/images
JAVASCRIPTS_LOC=$(SRC_FOLDER)/javascripts
STYLESHEETS_LOC=$(SRC_FOLDER)/stylesheets
RESOURCES_FOLDER=resources
STYLESHEETS_DEST=$(RESOURCES_FOLDER)/css
JAVASCRIPTS_DEST=$(RESOURCES_FOLDER)/js
CONTAINER_PORT=5500

# Node module variables
NODE_MODULES=./node_modules
IMAGEMIN=$(NODE_MODULES)/.bin/imagemin
MOCHA=$(NODE_MODULES)/.bin/mocha
NODE_SASS=$(NODE_MODULES)/.bin/node-sass
POSTCSS=$(NODE_MODULES)/.bin/postcss
SVGO=$(NODE_MODULES)/.bin/svgo
UGLIFY_JS=$(NODE_MODULES)/.bin/uglifyjs
LEAFLET=$(NODE_MODULES)/leaflet/dist/leaflet.js
LEAFLET_FULLSCREEN=$(NODE_MODULES)/leaflet.fullscreen/Control.FullScreen.js

# Github variables
GITHUB_API=https://api.github.com
ORG=ukparliament
REPO=pugin-components
LATEST_REL=$(GITHUB_API)/repos/$(ORG)/$(REPO)/releases
REL_TAG=$(shell curl -s $(LATEST_REL) | jq -r '.[0].tag_name')

# Installs npm packages
install:
	npm install

# Compiles sass to css
css:
	@mkdir -p $(STYLESHEETS_DEST)
	@$(NODE_SASS) --output-style compressed -o $(STYLESHEETS_DEST) $(STYLESHEETS_LOC)
	@$(POSTCSS) -r $(STYLESHEETS_DEST)/* --no-map

# Minifies javascript files
js:
	@mkdir -p $(JAVASCRIPTS_DEST)
	@$(UGLIFY_JS) $(LEAFLET) $(LEAFLET_FULLSCREEN) $(JAVASCRIPTS_LOC)/*.js -m -c -o $(JAVASCRIPTS_DEST)/main.js

# Builds application
build: css js

# Watches project files for changes
watch:
	@node scripts/watch.js $(STYLESHEETS_LOC)=css $(JAVASCRIPTS_LOC)=js

test:
	npm test && cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js

develop:
	env PORT=$(CONTAINER_PORT) ./node_modules/foreman/nf.js --procfile ProcfileForeman start

serve:
	npm run serve

json: # Run task to beautify *.json files
	./jsbeautify.sh

checkout_to_release:
	git checkout -b release $(REL_TAG)

deploy_to_release: install build
	npm test
	npm publish
