# Generated on <%= (new Date).toISOString().split('T')[0] %> using
# <%= pkg.name %> <%= pkg.version %>

module.exports = ( grunt ) ->
  # show elapsed time at the end
  require( 'time-grunt' ) grunt
  # load all grunt tasks
  require( 'load-grunt-tasks' ) grunt

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    config:
      app:      'app'
      dist:     'dist'
      temp:     '.tmp'
      bower:    '<%%= config.app %>/bower_components'

    watch:
      gruntfile:
        files: [ 'Gruntfile.coffee' ]<% if ( stylesLang === 'sass' ) { %>

      sass:
        files: [ '<%%= config.app %>/styles/**/*.{scss,sass}' ]
        tasks: [
          'sass:server'
          'autoprefixer:server'
        ]<% } %><% if ( stylesLang === 'less' ) { %>

      less:
        files: '<%%= config.app %>/styles/{,*/}*.less'
        tasks: [
          'less'
          'autoprefixer:server'
        ]<% } %>

      styles:
        files: [ '<%%= config.app %>/styles/{,*/}*.css' ]
        tasks: [
          'copy:styles'
          'autoprefixer:server'
        ]<% if ( scriptsLang === 'coffeescript' ) { %>

      coffee:
        files: [ '<%%= config.app %>/scripts/{,*/}*.coffee' ]
        tasks: [
          'coffeelint'
          'coffee:dist'
          'replace:scripts'
        ]<% } %><% if ( scriptsLang === 'javascript' ) { %>

      javascript:
        files: [ '<%%= config.app %>/scripts/{,*/}*.js' ]
        tasks: [
          'jshint'
          'copy:scripts'
          'replace:scripts'
        ]<% } %>

      pages:
        files: [ '<%%= config.app %>/{,*/}*.{html,php}' ]
        tasks: [
          'replace:pages'
        ]

      livereload:
        options:
          livereload: '<%%= connect.options.livereload %>'
        files: [
          '<%%= config.temp %>/**/*.html'
          '<%%= config.temp %>/styles/**/*.css'
          '{<%%= config.temp %>,<%%= config.app %>}/scripts/**/*.js'
          '<%%= config.app %>/images/**/*.{gif,jpg,jpeg,png,svg,webp}'
        ]

    clean:
      dist:
        files: [
          dot: true
          src: [
            '<%%= config.dist %>/*'
            '!<%%= config.dist %>/.git*'
          ]
        ]
      server: [
        '<%%= config.temp %>'
      ]<% if ( scriptsLang === 'coffeescript' ) { %>

    coffeelint:
      options:
        'max_line_length':
          'level': 'ignore'
        'no_empty_param_list':
          'level': 'error'
      files: [ '<%%= config.app %>/scripts/{,*/}*.coffee' ]<% } %><% if ( scriptsLang === 'javascript' ) { %>

    jshint:
      files: [ '<%%= config.app %>/scripts/{,*/}*.js' ]
      options:
        jshintrc: '.jshintrc'<% } %><% if ( stylesLang === 'sass' ) { %>

    sass:
      options:
        sourcemap: 'inline'
        loadPath: [ '<%%= config.app %>/bower_components' ]
      server:
        files: [
          expand: true
          cwd: '<%%= config.app %>/styles'
          src: '**/*.{scss,sass}'
          dest: '<%%= config.temp %>/styles'
          ext: '.css'
        ]<% } %><% if ( stylesLang === 'less' ) { %>

    less:
      compile:
        options:
          paths: [ '<%%= config.app %>/styles' ]
        files:
          '<%%= config.temp %>/styles/screen.css': '<%%= config.app %>/styles/screen.less'<% } %><% if ( scriptsLang === 'coffeescript' ) { %>

    coffee:
      dist:
        options:
          sourceMap: true
          sourceRoot: ''
        files:
          '<%%= config.temp %>/scripts/<%%= pkg.name %>.js': [ '<%%= config.app %>/scripts/{,*/}*.coffee' ]<% } %>

    autoprefixer:
      options:
        browsers: [ 'last 2 versions' ]<% if ( stylesLang === 'sass' ) { %>
        map: true<% } %>
      dist:
        files: [
          expand: true
          cwd: '<%%= config.dist %>/styles'
          src: '**/*.css'
          dest: '<%%= config.dist %>/styles'
        ]
      server:
        files: [
          expand: true
          cwd: '<%%= config.temp %>/styles'
          src: '**/*.css'
          dest: '<%%= config.temp %>/styles'
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: '<%%= config.app %>'
          src: [
            'images/**/*'
            'fonts/**/*'
            '!**/_*{,/**}'<% if ( scriptsLang === 'javascript' ) { %>
            'scripts/**/*'<% } %>
          ]
          dest: '<%%= config.dist %>'
        ]
      styles:
        files: [
          expand: true
          dot: true
          cwd: '<%%= config.app %>/styles'
          src: [ '**/*.css' ]
          dest: '<%%= config.temp %>/styles'
        ]

    replace:
      options:
        patterns: [
          match: 'VERSION'
          replacement: '<%%= pkg.version %>'
        ,
          match: 'DATE'
          replacement: '<%%= grunt.template.today("yyyy-mm-dd") %>'
        ,
          match: 'NAME'
          replacement: '<%%= pkg.name %>'
        ,
          match: 'YEAR'
          replacement: '<%%= grunt.template.today("yyyy") %>'
        ,
          match: 'DESCRIPTION'
          replacement: '<%%= pkg.description %>'
        ,
          match: 'KEYWORDS'
          replacement: '<%%= pkg.keywords.join(",") %>'
        ]
      scripts:
        files: [
          expand: true
          src: [ '<%%= config.temp %>/scripts/<%%= pkg.name %>.js' ]
          dest: '<%%= config.temp %>/scripts'
        ]
      pages:
        files: [
          expand: true
          flatten: true
          src: [
            '<%%= config.app %>/**/*.{html,php}'
            '!<%%= config.bower %>/**/*.{html,php}'
          ]
          dest: '<%%= config.temp %>/'
        ]
      dist:
        files: [
          expand: true
          flatten: true
          src: [
            '<%%= config.app %>/**/*.{html,php}'
            '!<%%= config.bower %>/**/*.{html,php}'
          ]
          dest: '<%%= config.dist %>'
        ]

    concat: {}

    uglify:
      options:
        banner: '/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today("yyyy-mm-dd") %> */\n'

    cssmin:
      options:
        keepSpecialComments: 0
        banner: '/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today("yyyy-mm-dd") %> */'
      dist:
        options:
          check: 'gzip'

    htmlmin:
      dist:
        options:
          collapseBooleanAttributes: true
          collapseWhitespace: true
          removeAttributeQuotes: true
          removeRedundantAttributes: true
        files: [
          expand: true
          cwd: '<%%= config.dist %>'
          src: [ '**/*.html' ]
          dest: '<%%= config.dist %>'
        ]

    imagemin:
      dist:
        options:
          progressive: true
          optimizationLevel: 3
        files: [
          expand: true
          cwd: '<%%= config.app %>/images'
          src: '**/*.{jpg,jpeg,png}'
          dest: '<%%= config.dist %>/images'
        ]

    useminPrepare:
      options:
        dest: '<%%= config.dist %>'
      html: [ '<%%= config.dist %>/**/*.html' ]

    usemin:
      options:
        assetsDirs: '<%%= config.dist %>'
      html: [ '<%%= config.dist %>/**/*.html' ]
      css: [ '<%%= config.dist %>/styles/**/*.css' ]

    bump:
      options:
        files: [
          'package.json'
          'bower.json'
        ]
        commitFiles: [
          'package.json'
          'bower.json'
        ]
        pushTo: 'origin'

    connect:
      options:
        hostname: 'localhost'
        port: 9001
        livereload: 35729
      livereload:
        options:
          base: [
            '<%%= config.temp %>'
            '<%%= config.app %>'
          ]
          livereload: true
      dist:
        options:
          base: [ '<%%= config.dist %>' ]
          keepalive: true
          livereload: false

    concurrent:
      server: [<% if ( stylesLang === 'sass' ) { %>
        'sass:server'<% } %><% if ( stylesLang === 'less' ) { %>
        'less'<% } %><% if ( scriptsLang === 'coffeescript' ) { %>
        'coffee'<% } %>
        'copy:styles'
      ]
      dist: [<% if ( stylesLang === 'sass' ) { %>
        'sass:server'<% } %><% if ( stylesLang === 'less' ) { %>
        'less'<% } %><% if ( scriptsLang === 'coffeescript' ) { %>
        'coffee'<% } %>
        'copy:dist'
      ]

  grunt.registerTask 'serve', ( target ) ->
    grunt.config.set 'connect.options.hostname', '0.0.0.0' if grunt.option 'allow-remote'

    if target is 'dist'
      return grunt.task.run [
        'build'
        'connect:dist:keepalive'
      ]

    grunt.task.run [
      'clean:server'
      'concurrent:server'
      'replace:pages'
      'replace:scripts'
      'autoprefixer:server'
      'connect:livereload'
      'watch'
    ]
    return

  grunt.registerTask 'build', [
    'clean'<% if ( scriptsLang === 'coffeescript' ) { %>
    'coffeelint'<% } %><% if ( scriptsLang === 'javascript' ) { %>
    'jshint'<% } %>
    'replace:dist'
    'concurrent:dist'
    'replace:scripts'
    'useminPrepare'
    'concat'
    'autoprefixer:dist'
    'cssmin'
    'uglify'
    'imagemin'
    'usemin'
  ]

  grunt.registerTask 'default', [<% if ( scriptsLang === 'coffeescript' ) { %>
    'coffeelint'<% } %><% if ( scriptsLang === 'javascript' ) { %>
    'jshint'<% } %>
    'build'
  ]
  return
