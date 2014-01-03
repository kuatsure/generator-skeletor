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
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    this.scriptsLang = props.scriptsLang;
    this.stylesLang = props.stylesLang;

    cb();
  }.bind(this));
};

SkeletorGenerator.prototype.app = function app() {
  this.mkdir('app');

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
  this.mkdir('app/img');
  this.mkdir('app/fonts');
  this.mkdir('app/public');

  this.copy('htaccess', 'app/public/.htaccess');
  this.copy('Skeletor.jpg', 'app/img/Skeletor.jpg');
};

SkeletorGenerator.prototype.scripts = function scripts() {
  if ( this.scriptsLang === "coffeescript" ) {
    this.mkdir('app/coffee');
    this.copy('main.coffee', 'app/coffee/main.coffee');

  } else {
    this.mkdir('app/js');
    this.copy('main.js', 'app/js/main.js');
    this.copy('jshintrc', '.jshintrc');
  }
};

SkeletorGenerator.prototype.styles = function styles() {
  this.mkdir('app/css');

  if ( this.stylesLang === "sass" ) {
    this.mkdir('app/sass');
    this.copy('screen.scss', 'app/sass/screen.scss');
    this.copy('imports.scss', 'app/sass/_imports.scss');
    this.copy('_config.rb', 'config.rb');

  } else if ( this.stylesLang === "less" ) {
    this.mkdir('app/less');
    this.copy('imports.less', 'app/less/imports.less');
    this.copy('screen.less', 'app/less/screen.less');

  } else {
    this.copy('inuit.css', 'app/css/inuit.css');
    this.copy('screen.css', 'app/css/screen.css');
  }
};

SkeletorGenerator.prototype.markup = function markup() {
  this.mkdir('app/html');
  this.template('index.html', 'app/html/index.html');
};
