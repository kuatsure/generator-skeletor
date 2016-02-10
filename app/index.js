'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');
var yosay = require('yosay');
var chalk = require('chalk');
var shelljs = require('shelljs');
var bundle = false;

var SkeletorGenerator = module.exports = function SkeletorGenerator(args, options, config) {
  if (this.stylesLang === 'sass') {
    var dependenciesInstalled = ['bundle', 'ruby'].every(function (depend) {
      return shelljs.which(depend);
    });

    if (!dependenciesInstalled) {
      console.log('Looks like you\'re missing some dependencies.' +
        '\nMake sure ' + chalk.white('Ruby') + ' and the ' + chalk.white('Bundler gem') + ' are installed, then run again.');
      shelljs.exit(1);
    }
  }

  yeoman.generators.Base.apply(this, arguments);

  this.gitInfo = {
    name: shelljs.exec('git config user.name', { silent: true }).output.replace( '\n', '' ),
    email: shelljs.exec('git config user.email', { silent: true }).output.replace( '\n', '' )
  };

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });

    if (this.stylesLang === 'sass') {
      if (bundle === false) {
        console.log(chalk.yellow.bold('Bundle install failed. Try running the command yourself.'));
      }
    }
  });
};

util.inherits(SkeletorGenerator, yeoman.generators.Base);

SkeletorGenerator.prototype.askFor = function askFor() {
  var cb = this.async();

  console.log(yosay('Everything comes to he who waits... and I have waited so very long for this moment.'));

  var prompts = [{
    name: 'projectName',
    message: 'Project Name',
    default: this.appname
  },{
    name: 'projectDescription',
    message: 'Project Description'
  },{
    name: 'authorName',
    message: 'Author Name',
    default: this.gitInfo.name
  },{
    name: 'authorEmail',
    message: 'Author Email',
    default: this.gitInfo.email
  }, {
    type: 'list',
    name: 'scriptsLang',
    message: 'Preferred scripts language:',
    choices: [ 'coffeescript', 'javascript' ]
  }, {
    type: 'list',
    name: 'stylesLang',
    message: 'Preferred styles language:',
    choices: [ 'sass', 'less', 'vanilla' ]
  }];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    this.projectDescription = props.projectDescription;

    this.authorName = props.authorName;
    this.authorEmail = props.authorEmail;

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

  if ( this.scriptsLang === 'coffeescript' ) {
    this.copy('main.coffee', 'app/scripts/main.coffee');
    this.copy('coffeelint.json', 'coffeelint.json');

  } else {
    this.copy('main.js', 'app/scripts/' + this.projectName + '.js');
    this.copy('jshintrc', '.jshintrc');
  }
};

SkeletorGenerator.prototype.styles = function styles() {
  this.mkdir('app/styles');

  if ( this.stylesLang === 'sass' ) {
    this.copy('screen.scss', 'app/styles/screen.scss');
    this.copy('variables.scss', 'app/styles/_variables.scss');
    this.copy('Gemfile', 'Gemfile');

  } else if ( this.stylesLang === 'less' ) {
    this.copy('screen.less', 'app/styles/screen.less');
    this.copy('variables.less', 'app/styles/variables.less');

  } else {
    this.copy('inuit.css', 'app/styles/inuit.css');
    this.copy('screen.css', 'app/styles/screen.css');
  }
};

SkeletorGenerator.prototype.markup = function markup() {
  this.template('index.html', 'app/index.html');
};

SkeletorGenerator.prototype.readme = function readme() {
  this.template('readme.md', 'README.md');
};

SkeletorGenerator.prototype.rubies = function rubies() {
  if (this.options['skip-install'] !== true && this.stylesLang === 'sass') {
    var execComplete;

    console.log('\nRunning ' + chalk.yellow.bold('bundle install') + ' to install the required gems.');

    this.conflicter.resolve(function (err) {
      if (err) {
        return this.emit('error', err);
      }

      execComplete = shelljs.exec('bundle install');

      if (execComplete.code === 0) {
        bundle = true;
      }
    });
  }
};
