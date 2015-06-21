# Lime-Topcoder

This repository uses Jade, SCSS, CoffeeScript, Angular, and Grunt.

## Installation

If you don't have compass installed run the following:
 - Windows - gem install compass
 - Linux/OS X - sudo gem install compass

Install dependencies by running the following in the root of the project:
 - npm install
 - bower install

## Build & Development

- To run locally without minification: `grunt serve`

- To build dist folder
 - dev: `grunt build-dev`
 - qa: `grunt build-qa`
 - prod: `grunt build`

- To serve builds
 - dev: `grunt serve:dev`
 - qa: `grunt serve:qa`
 - prod: `grunt serve:prod`

## Testing

Running `grunt test` will run the unit tests with karma.

## Contributing

### Pull Requests

To contribute to the repository, please create a feature branch off of the dev branch. Once you're finished working on the feature, make a pull request to merge it into dev. Then, delete the branch when it's no longer used.

### Quick Description of Key Files and Folders

 - app.coffee - where our Angular app is created
 - app.constants.coffee - created from the Gruntfile's ngconstant task. Add constants to the Gruntfile.
 - app.routes.coffee - UI-Router states
 - index.jade - contains the header, content (ui-view), and footer
 - Content folder - contains CSS, Fonts, Images, and Locales, and Scripts (Non-Bower JavaScript files)

### Adding new content

Bower JS/CSS Files
  - Make sure to add new bower files to index.jade

Jade Files
  - Use landing.jade and index.jade as a guide for syntax
  - You (usually) don't need to write the div tag

SCSS Files
  - Add new files to index.jade
  - Use SCSS syntax (nesting)
  - Use variables and mixins as much as possible
  - Store new variables and mixins in the appropriate file in `app/content/css/partials`
  - Use landing.scss as a guide

CoffeeScript
  - Add new files to index.jade
  - Use other coffee files in the repository as a guide. When in doubt, check our [AngularJS style guide](https://github.com/appirio-tech/angularjs-styleguide)

Creating New Views/Pages
  - To add a new page, create a folder in the app directory and a new state in app.routes.coffee
  - Name the new folder the same as the state name
  - In order to keep the SCSS files modular, a class is automatically added with the name of the state to the ui-view div in index.jade. For example, if you create a new `/feature1` state and navigate there, the div with the content will look like this: `<div class="view-container feature1">`. This allows you to have your own feature1.scss file. Use the landing.scss file as an example, where you can see how all the styles are nested in `.landing`.
