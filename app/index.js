'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var SkeletorGenerator = module.exports = function SkeletorGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(SkeletorGenerator, yeoman.generators.Base);

SkeletorGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  // have Yeoman greet the user.
  console.log(this.yeoman);
  console.log('Out of the box I include jQuery and Modernizr.');

  var prompts = [{
    name: 'projectName',
    message: 'Project Name'
  }, {
    type: 'list',
    name: 'scriptsLang',
    message: 'Preferred scripts language',
    choices: [ 'coffeescript', 'javascript' ]
  }, {
    type: 'list',
    name: 'stylesLang',
    message: 'Preferred styles language ( Sass comes with compass & inuit.css )',
    choices: [ 'sass', 'less', 'vanilla' ]
  }, {
    type: 'list',
    name: 'markupLang',
    message: 'Preferred markup language',
    choices: [ 'jekyll', 'haml', 'html' ]
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    this.scriptsLang = props.scriptsLang;
    this.stylesLang = props.stylesLang;
    this.markupLang = props.markupLang;

    cb();
  }.bind(this));
};

SkeletorGenerator.prototype.app = function app() {
  this.mkdir('_');

  this.template('_package.json', 'package.json');
  this.copy('editorconfig', '.editorconfig');
};

SkeletorGenerator.prototype.bower = function bower() {
  this.copy('_bower.json', 'bower.json');
  this.copy('bowerrc', '.bowerrc');
};

SkeletorGenerator.prototype.git = function git() {
  this.copy('gitignore', '.gitignore');
  this.copy('gitattributes', '.gitattributes');
};

SkeletorGenerator.prototype.gruntfile = function gruntfile() {
  this.template('Gruntfile.coffee');
};

SkeletorGenerator.prototype.projectfiles = function projectfiles() {
  this.mkdir('_/img');
  this.mkdir('_/fonts');
  this.mkdir('_/public');

  this.copy('htaccess', '_/public/.htaccess');
};

SkeletorGenerator.prototype.scripts = function scripts() {
  if ( this.scriptsLang === "coffeescript" ) {
    this.mkdir('_/coffee');
    this.copy('main.coffee', '_/coffee/main.coffee');

  } else {
    this.mkdir('_/js');
    this.copy('main.js', '_/js/main.js');
    this.copy('jshintrc', '.jshintrc');
  }
};

SkeletorGenerator.prototype.styles = function styles() {
  this.mkdir('_/css');

  if ( this.stylesLang === "sass" ) {
    this.mkdir('_/sass');
    this.mkdir('_/sass/partials');
    this.copy('screen.scss', '_/sass/screen.scss');
    this.copy('includes.scss', '_/sass/partials/_includes.scss');
    this.copy('_config.rb', 'config.rb');

  } else if ( this.stylesLang === "less" ) {
    this.mkdir('_/less');
    this.mkdir('_/less/partials');
    this.copy('screen.less', '_/sass/screen.less');

  } else {
    this.copy('screen.css', '_/css/screen.css');
  }
};

SkeletorGenerator.prototype.markup = function markup() {
  if ( this.markupLang === "jekyll" ) {
    this.mkdir('_/jekyll');
    this.mkdir('_/jekyll/_layouts');
    this.copy('jekyll_default.html', '_/jekyll/_layouts/default.html');
    this.mkdir('_/jekyll/_posts');
    this.mkdir('_/jekyll/_includes');
    this.copy('jekyll_index.html', '_/jekyll/index.html');
    this.template('jekyll_config.yml', '_config.yml');

  } else if ( this.markupLang === "haml" ) {
    this.mkdir('_/haml');
    this.copy('haml_index.haml', '_/haml/index.haml');

  } else {
    this.mkdir('_/html');
    this.copy('html_index.html', '_/html/index.html');
  }
};
