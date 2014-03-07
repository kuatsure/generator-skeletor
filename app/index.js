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
  // console.log(this.yeoman);
  console.log('Everything comes to he who waits... and I have waited so very long for this moment.');

  var prompts = [{
    name: 'projectName',
    message: 'Project Name',
    default: this.appname
  }, {
    type: 'list',
    name: 'scriptsLang',
    message: 'Preferred scripts language',
    choices: [ 'coffeescript', 'javascript' ]
  }, {
    type: 'list',
    name: 'stylesLang',
    message: 'Preferred styles language\n    * Sass comes with compass & inuit.css\n    * Less with elements.less',
    choices: [ 'sass', 'less', 'vanilla' ]
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    this.scriptsLang = props.scriptsLang;
    this.stylesLang = props.stylesLang;

    cb();
  }.bind(this));

  this.config.save();
};

SkeletorGenerator.prototype.app = function app() {
  this.mkdir('app');

  this.template('_package.json', 'package.json');
  this.copy('editorconfig', '.editorconfig');
  this.copy('travis.yml', '.travis.yml');
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
  this.mkdir('app/images');
  this.mkdir('app/fonts');

  this.copy('htaccess', 'app/.htaccess');
  this.copy('Skeletor.jpg', 'app/images/Skeletor.jpg');
};

SkeletorGenerator.prototype.scripts = function scripts() {
  this.mkdir('app/scripts');

  if ( this.scriptsLang === "coffeescript" ) {
    this.copy('main.coffee', 'app/scripts/main.coffee');

  } else {
    this.copy('main.js', 'app/scripts/' + this.projectName + '.js');
    this.copy('jshintrc', '.jshintrc');
  }
};

SkeletorGenerator.prototype.styles = function styles() {
  this.mkdir('app/styles');

  if ( this.stylesLang === "sass" ) {
    this.copy('screen.scss', 'app/styles/screen.scss');
    this.copy('imports.scss', 'app/styles/_imports.scss');
    this.copy('variables.scss', 'app/styles/_variables.scss');
    this.copy('_config.rb', 'config.rb');

  } else if ( this.stylesLang === "less" ) {
    this.copy('imports.less', 'app/styles/imports.less');
    this.copy('variables.less', 'app/styles/variables.less');
    this.copy('screen.less', 'app/styles/screen.less');

  } else {
    this.copy('inuit.css', 'app/styles/inuit.css');
    this.copy('screen.css', 'app/styles/screen.css');
  }
};

SkeletorGenerator.prototype.markup = function markup() {
  this.template('index.html', 'app/index.html');
};
