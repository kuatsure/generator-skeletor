# Generated on <%= (new Date).toISOString().split('T')[0] %> using <%= pkg.name %> <%= pkg.version %>
# global module:false
module.exports = ( grunt ) ->
  # show elapsed time at the end
  require( "time-grunt" ) grunt
  # load all grunt tasks
  require( "load-grunt-tasks" ) grunt

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    bower: grunt.file.readJSON "bower.json"

    yeoman:
      app:      'app'
      dist:     'dist'
      bower:    '<%%= yeoman.app %>/bower_components'

    watch:<% if ( stylesLang === 'sass') { %>
      compass:
        files: "<%%= yeoman.app %>/sass/**/*"
        tasks: [ "compass" ]
        options:
          livereload:true<% } %><% if ( stylesLang === 'less') { %>
      less:
        files: "<%%= yeoman.app %>/less/**/*"
        tasks: [ "less", "copy:css" ]
        options:
          livereload:true<% } %><% if ( stylesLang === 'vanilla') { %>
      css:
        files: [ "<%%= yeoman.app %>/css/*" ]
        tasks: [ "copy:css" ]
        options:
          livereload:true<% } %><% if ( scriptsLang === 'coffeescript') { %>

      coffee:
        files: [ "<%%= yeoman.app %>/coffee/*", "package.json" ]
        tasks: [ "coffeelint", "coffee:jitter", "copy:js" ]
        options:
          livereload:true<% } %>

      imports:
        files: [ "<%%= yeoman.bower %>/*.js", "bower.json" ]
        tasks: [ "concat:imports" ]
        options:
          livereload:true

      html:
        files: "<%%= yeoman.app %>/html/**/*"
        tasks: [ "concat:html" ]
        options:
          livereload:true

      public:
        files: "<%%= yeoman.app %>/public/**/*"
        tasks: [ "copy:public" ]
        options:
          livereload:true<% if ( stylesLang === 'sass') { %>

    compass:
      compile:
        options:
          config: "config.rb"<% } %><% if ( stylesLang === 'less') { %>

    less:
      compile:
        options:
          paths: [ "<%%= yeoman.app %>/css" ]
        files:
          "<%%= yeoman.app %>/css/screen.css": "<%%= yeoman.app %>/less/screen.less"<% } %>

    autoprefixer:
      options:
        browsers: [ "last 2 version" ]
      post:
        files: [
          expand: true
          cwd: "<%%= yeoman.app %>/css/"
          src: "{,*/}*.css"
          dest: "<%%= yeoman.dist %>/_/css/"
        ]

    cssmin:
      minify:
        options:
          keepSpecialComments: 1
          banner: "/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today(\"yyyy-mm-dd\") %> */"
        files:
          "<%%= yeoman.dist %>/_/css/screen.css": [ "<%%= yeoman.dist %>/_/css/screen.css" ]<% if ( stylesLang === 'vanilla') { %>
          "<%%= yeoman.dist %>/_/css/inuit.css": [ "<%%= yeoman.dist %>/_/css/inuit.css" ]<% } %><% if ( scriptsLang === 'coffeescript') { %>

    coffeelint:
      options:
        "max_line_length":
          "level": "ignore"
        "no_empty_param_list":
          "level": "error"
      files: [ "<%%= yeoman.app %>/coffee/*" ]

    coffee:
      jitter:
        options:
          bare: true
        files:
          "<%%= yeoman.app %>/js/main.js": [ "<%%= yeoman.app %>/coffee/*.coffee" ]<% } %><% if ( scriptsLang === 'javascript') { %>

    jshint:
      files: [ "<%%= yeoman.app %>/js/main.js" ]
      options:
        jshintrc: ".jshintrc"<% } %>

    concat:
      html:
        options:
          process: true
        files:
          "<%%= yeoman.dist %>/index.html": [ "<%%= yeoman.app %>/html/index.html" ]
      imports:
        files:
          "<%%= yeoman.app %>/js/imports-global.js":   [
                                                      "<%%= yeoman.bower %>/jquery/jquery.js",
                                                      "<%%= yeoman.bower %>/modernizr/modernizr.js"
                                                    ]

    copy:
      css:
        expand: true
        dot: true
        cwd: '<%%= yeoman.app %>/css'
        dest: '<%%= yeoman.dist %>/_/css'
        src: [ '{,*/}*.css', 'images/*.png' ]
      js:
        expand: true
        dot: true
        cwd: '<%%= yeoman.app %>/js'
        dest: '<%%= yeoman.dist %>/_/js'
        src: '{,*/}*.js'
      img:
        expand: true
        dot: true
        cwd: '<%%= yeoman.app %>/img'
        dest: '<%%= yeoman.dist %>/_/img'
        src: '*.{ico,png,txt,jpg}'
      public:
        expand: true
        dot: true
        cwd:"<%%= yeoman.app %>/public/"
        dest: "<%%= yeoman.dist %>"
        src: [ ".*" ]

    uglify:
      options:
        mangle: false
      imports:
        options:
          banner: "/*! <%%= bower.name %> - v<%%= bower.version %> - <%%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
        files:
          "<%%= yeoman.dist %>/_/js/imports-global.js": [ "<%%= yeoman.app %>/js/imports-global.js" ]
      coffee:
        options:
          banner: "/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
        files:
          "<%%= yeoman.dist %>/_/js/main.js": [ "<%%= yeoman.app %>/js/main.js" ]

    htmlmin:
      dist:
        options:
          # removeCommentsFromCDATA: true
          # # https://github.com/yeoman/grunt-usemin/issues/44
          # # collapseWhitespace: true
          # collapseBooleanAttributes: true
          # removeAttributeQuotes: true
          # removeRedundantAttributes: true
          # useShortDoctype: true
          # removeEmptyAttributes: true
          # removeOptionalTags: true
          collapseWhitespace: true
          removeComments: true
        files: [
          expand: true
          cwd: "<%%= yeoman.dist %>"
          src: "*.html"
          dest: "<%%= yeoman.dist %>"
        ]

    clean:
      dist:
        src: "<%%= yeoman.dist %>"
        dot: true

    connect:
      options:
        base: "<%%= yeoman.dist %>"
        port: 9001
        livereload: true
      server:
        options:
          hostname: "*"

    concurrent:
      lint:     [ <% if ( scriptsLang === 'coffeescript') { %>"coffeelint"<% } %><% if ( scriptsLang === 'javascript') { %>"jshint"<% } %> ]
      compile:  [ <% if ( stylesLang === 'sass') { %>"compass", <% } %><% if ( stylesLang === 'less') { %>"less", <% } %><% if ( scriptsLang === 'coffeescript') { %>"coffee",<% } %> "concat:imports" ]
      post:     [ "autoprefixer" ]
      dist:     [ "copy", "concat:html" ]
      minify:   [ "cssmin", "uglify", "htmlmin" ]

  # Setting up bigger tasks
  grunt.registerTask "dev", [ "clean", "concurrent:lint", "concurrent:compile", "concurrent:dist" ]
  grunt.registerTask "dist", [ "clean", "concurrent:lint", "concurrent:compile", "concurrent:post", "copy:img", "concat:html", "concurrent:minify" ]

  grunt.registerTask "serve", [ "dev", "connect:server", "watch" ]

  # Default task
  grunt.registerTask "default", [ "dev" ]
