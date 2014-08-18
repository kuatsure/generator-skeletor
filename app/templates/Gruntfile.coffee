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
    bower: grunt.file.readJSON 'bower.json'

    config:
      app:      'app'
      dist:     'dist'
      temp:     '.tmp'
      bower:    '<%%= config.app %>/bower_components'

    watch:
      gruntfile:
        files: [ 'Gruntfile.coffee' ]<% if ( stylesLang === 'sass') { %>

      styles:
        files: '<%%= config.app %>/styles/{,*/}*.scss'
        tasks: [
          'compass'
          'autoprefixer'
        ]<% } %><% if ( stylesLang === 'less') { %>

      styles:
        files: '<%%= config.app %>/styles/{,*/}*.less'
        tasks: [
          'less'
          'autoprefixer'
        ]<% } %><% if ( stylesLang === 'vanilla') { %>

      styles:
        files: [ '<%%= config.app %>/styles/{,*/}*.css' ]
        tasks: [
          'copy:styles'
          'autoprefixer'
        ]<% } %><% if ( scriptsLang === 'coffeescript') { %>

      scripts:
        files: [ '<%%= config.app %>/scripts/{,*/}*.coffee' ]
        tasks: [
          'coffeelint'
          'coffee:jitter'
          'replace:scripts'
        ]<% } %><% if ( scriptsLang === 'javascript') { %>

      scripts:
        files: [ '<%%= config.app %>/scripts/{,*/}*.js' ]
        tasks: [
          'jshint'
          'copy:scripts'
          'replace:scripts'
        ]<% } %>

      pages:
        files: [ '<%%= config.app %>/{,*/}*.html' ]
        tasks: [ 'replace:pages' ]
        options:
          livereload: true

      livereload:
        options:
          livereload: '<%%= connect.options.livereload %>'
        files: [
          '<%%= config.temp %>/styles/{,*/}*.css'
          '<%%= config.temp %>/scripts/{,*/}*.js'
          '<%%= config.app %>/img/{,*/}*'
        ]

    clean:
      dist:
        src: '<%%= config.dist %>'
        dot: true
      server:
        src: '<%%= config.temp %>'<% if ( scriptsLang === 'coffeescript') { %>

    coffeelint:
      options:
        'max_line_length':
          'level': 'ignore'
        'no_empty_param_list':
          'level': 'error'
      files: [ '<%%= config.app %>/scripts/*.coffee' ]<% } %><% if ( scriptsLang === 'javascript') { %>

    jshint:
      files: [ '<%%= config.app %>/scripts/*.js' ]
      options:
        jshintrc: '.jshintrc'<% } %><% if ( stylesLang === 'sass') { %>

    compass:
      compile:
        options:
          sourcemap: true
          config: 'config.rb'<% } %><% if ( stylesLang === 'less') { %>

    less:
      compile:
        options:
          paths: [ '<%%= config.app %>/styles' ]
        files:
          '<%%= config.temp %>/styles/screen.css': '<%%= config.app %>/styles/screen.less'<% } %><% if ( scriptsLang === 'coffeescript') { %>

    coffee:
      jitter:
        options:
          bare: true
          sourceMap: true
        files:
          '<%%= config.temp %>/scripts/<%%= pkg.name %>.js': [ '<%%= config.app %>/scripts/*.coffee' ]<% } %>

    concat:
      imports:
        files:
          '<%%= config.temp %>/scripts/imports-global.js': [
            '<%%= config.bower %>/jquery/jquery.js'
            '<%%= config.bower %>/modernizr/modernizr.js'
          ]

    autoprefixer:
      options:
        browsers: [ 'last 2 version' ]
      post:
        files: [
          expand: true
          cwd: '<%%= config.temp %>/styles/'
          src: '{,*/}*.css'
          dest: '<%%= config.temp %>/styles/'
        ]

    copy:
      images:
        expand: true
        dot: true
        cwd: '<%%= config.app %>/images'
        dest: '<%%= config.dist %>/images'
        src: '*.{ico,png,txt,jpg}'<% if ( stylesLang === 'vanilla') { %>
      styles:
        expand: true
        dot: true
        cwd: '<%%= config.app %>/styles'
        dest: '<%%= config.temp %>/styles'
        src: '*.css'<% } %><% if ( scriptsLang === 'javascript') { %>
      scripts:
        expand: true
        dot: true
        cwd: '<%%= config.app %>/scripts'
        dest: '<%%= config.temp %>/scripts'
        src: '*.js'<% } %>

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
          flatten: true
          src: [ '<%%= config.temp %>/scripts/<%%= pkg.name %>.js' ]
          dest: '<%%= config.temp %>/scripts'
        ]
      pages:
        files: [
          expand: true
          flatten: true
          src: [ '<%%= config.app %>/*.{html,php}' ]
          dest: '<%%= config.temp %>'
        ]

    cssmin:
      minify:
        options:
          keepSpecialComments: 0
          banner: '/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today("yyyy-mm-dd") %> */'
        files:
          '<%%= config.dist %>/styles/screen.css': [ '<%%= config.temp %>/styles/screen.css' ]<% if ( stylesLang === 'vanilla') { %>
          '<%%= config.dist %>/styles/inuit.css': [ '<%%= config.temp %>/styles/inuit.css' ]<% } %>

    uglify:
      options:
        mangle: false
      imports:
        options:
          banner: '/*! <%%= bower.name %> - v<%%= bower.version %> - <%%= grunt.template.today("yyyy-mm-dd") %> */\n'
        files:
          '<%%= config.dist %>/scripts/imports-global.js': [ '<%%= config.temp %>/scripts/imports-global.js' ]
      scripts:
        options:
          banner: '/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today("yyyy-mm-dd") %> */\n'
        files:
          '<%%= config.dist %>/scripts/<%%= pkg.name %>.js': [ '<%%= config.temp %>/scripts/<%%= pkg.name %>.js' ]

    htmlmin:
      dist:
        options:
          collapseWhitespace: true
          removeComments: true
        files: [
          expand: true
          cwd: '<%%= config.temp %>'
          src: '*.html'
          dest: '<%%= config.dist %>'
        ]

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
      lint: [ <% if ( scriptsLang === 'coffeescript') { %>
        'coffeelint'<% } %><% if ( scriptsLang === 'javascript') { %>
        'jshint'<% } %>
      ]
      compile: [ <% if ( stylesLang === 'sass') { %>
        'compass'<% } %><% if ( stylesLang === 'less') { %>
        'less'<% } %><% if ( stylesLang === 'vanilla') { %>
        'copy:styles'<% } %><% if ( scriptsLang === 'coffeescript') { %>
        'coffee'<% } %><% if ( scriptsLang === 'javascript') { %>
        'copy:scripts'<% } %>
        'concat'
      ]
      post: [
        'autoprefixer'
        'replace'
      ]
      minify: [
        'cssmin'
        'uglify'
        'htmlmin'
      ]

  grunt.registerTask 'build', [
    'concurrent:compile'
    'concurrent:post'
  ]

  grunt.registerTask 'serve', 'Serve a local copy', ( target ) ->
    if grunt.option 'allow-remote'
      grunt.config.set 'connect.options.hostname', '0.0.0.0'

    if target is undefined
      grunt.task.run [
        'default'
        'connect:livereload'
        'watch'
      ]

    else if target is 'dist'
      grunt.task.run [
        'dist'
        'connect:dist'
      ]

  grunt.registerTask 'dist', [
    'clean:dist'
    'default'
    'concurrent:minify'
    'copy:images'
  ]

  grunt.registerTask 'default', [
    'clean:server'
    'concurrent:lint'
    'build'
  ]
