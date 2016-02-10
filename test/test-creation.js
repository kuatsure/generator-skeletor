/*global describe, beforeEach, it*/
'use strict';

var path    = require('path');
var helpers = require('yeoman-generator').test;


describe('skeletor generator', function () {
  beforeEach(function (done) {
    helpers.testDirectory(path.join(__dirname, 'temp'), function (err) {
      if (err) {
        return done(err);
      }

      this.app = helpers.createGenerator('skeletor:app', [
        '../../app'
      ]);
      done();
    }.bind(this));
  });

  it('creates sass & coffee files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'coffeelint.json',
      'Gemfile',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/main.coffee',
      'app/styles/screen.scss',
      'app/styles/_variables.scss',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'coffeescript',
      'stylesLang': 'sass'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });

  it('creates less & coffee files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'coffeelint.json',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/main.coffee',
      'app/styles/screen.less',
      'app/styles/variables.less',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'coffeescript',
      'stylesLang': 'less'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });

  it('creates vanilla & coffee files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'coffeelint.json',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/main.coffee',
      'app/styles/screen.css',
      'app/styles/inuit.css',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'coffeescript',
      'stylesLang': 'vanilla'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });

  it('creates sass & javascript files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.jshintrc',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'Gemfile',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/skel.js',
      'app/styles/screen.scss',
      'app/styles/_variables.scss',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'javascript',
      'stylesLang': 'sass',
      'projectName': 'skel'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });

  it('creates less & javascript files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.jshintrc',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/skel.js',
      'app/styles/screen.less',
      'app/styles/variables.less',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'javascript',
      'stylesLang': 'less',
      'projectName': 'skel'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });

  it('creates vanilla & javascript files', function (done) {
    var expected = [
      // add files you expect to exist here.
      '.bowerrc',
      '.editorconfig',
      '.gitattributes',
      '.gitignore',
      '.jshintrc',
      '.travis.yml',
      '.yo-rc.json',
      'Gruntfile.coffee',
      'bower.json',
      'package.json',
      'app/fonts',
      'app/images/Skeletor.jpg',
      'app/scripts/skel.js',
      'app/styles/screen.css',
      'app/styles/inuit.css',
      'app/index.html',
      'app/.htaccess'
    ];

    helpers.mockPrompt(this.app, {
      'scriptsLang': 'javascript',
      'stylesLang': 'vanilla',
      'projectName': 'skel'
    });

    this.app.options['skip-install'] = true;
    this.app.run({}, function () {
      helpers.assertFile(expected);
      done();
    });
  });
});
