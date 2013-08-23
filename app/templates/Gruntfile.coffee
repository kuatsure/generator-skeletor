mountFolder = ( connect, dir ) ->
  connect.static require( "path" ).resolve( dir )

# global module:false
module.exports = ( grunt ) ->
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    watch:<% if ( stylesLang === 'sass') { %>
      compass:
        files: "_/sass/**/*"
        tasks: [ "compass", "copy:css" ]<% } %>

      css:
        files: "dist/_/css/*"
        options:
          livereload: true<% if ( markupLang === 'jekyll') { %>

      jekyll:
        files: "_/jekyll/**/*"
        tasks: [ "jekyll", "javascript:dev", "copy" ]
        options:
          livereload:true<% } %><% if ( markupLang === 'haml') { %>

      haml:
        files: "_/haml/**/*"
        tasks: [ "haml" ]
        options:
          livereload:true<% } %>

      public:
        files: "_/public/**/*"
        tasks: [ "copy:static" ]
        options:
          livereload:true<% if ( scriptsLang === 'coffeescript') { %>

      coffee:
        files: "_/coffee/*"
        tasks: [ "coffeelint", "coffee" ]
        options:
          livereload:true<% } %><% if ( scriptsLang === 'javascript') { %>

      js:
        files: "_/js/*"
        tasks: [ "javascript:dev" ]
        options:
          livereload:true<% } %><% if ( stylesLang === 'sass') { %>

    compass:
      compile:
        options:
          config: "config.rb"<% } %><% if ( stylesLang === 'less') { %>

    less:
      development:
        options:
          paths: [ "_/css" ]
        files:
          "_/css/screen.css": "_/less/screen.less"<% } %><% if ( scriptsLang === 'coffeescript') { %>

    coffee:
      files:
        files:
          "_/js/main.js": [ "_/coffee/main.coffee" ]<% } %>

    connect:
      options:
        port: 9001
        base: "dist"
      dist:
        options:
          middleware: ( connect ) ->
            [ mountFolder( connect, "dist" ) ]<% if ( markupLang === 'haml') { %>

    haml:
      options:
        "double-quote-attributes": true
      files:
        "dist/index.html": [ "_/haml/index.haml" ]<% } %>

    open:
      localhost:
        path: "http://localhost:<%%= connect.options.port %>"

    concat:
      html: <% if ( markupLang !== 'html') { %># To process the file for the pkg & grunt variables, nothing more<% } %>
        options:
          process: true
        files:<% if ( markupLang !== 'html') { %>
          "dist/index.html":        [ "dist/index.html" ]<% } else { %>
          "dist/index.html":        [ "_/html/index.html" ]<% } %>
      imports:
        files:
          "_/js/imports-global.js": [
                                      "_/bower_components/jquery/jquery.js",
                                      "_/bower_components/modernizr/modernizr.js",
                                    ]<% if ( scriptsLang === 'coffeescript') { %>

    coffeelint:
      options:
        'max_line_length':
          'level': 'ignore'
      files: [ "_/coffee/*" ]<% } %><% if ( scriptsLang === 'javascript') { %>

    jshint:
      files: [ "_/js/main.js" ]
      options:
        jshintrc: ".jshintrc"<% } %>

    clean:
      all:
        src: "dist"
        dot: true<% if ( markupLang === 'jekyll') { %>

    jekyll:
      hyde:
        options:
          config: "_config.yml"<% } %>

    uglify:
      options:
        mangle: false
      imports:
        files:
          "dist/_/js/imports-global.min.js": [ "_/js/imports-global.js" ]
      scripts:
        options:
          banner: "/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today(\"yyyy-mm-dd\") %> */"
        files:
          "dist/_/js/main.js": [ "_/js/main.js" ]

    cssmin:
      minify:
        options:
          banner: "/*! <%%= pkg.name %> - v<%%= pkg.version %> - <%%= grunt.template.today(\"yyyy-mm-dd\") %> */"
        files:
          'dist/_/css/screen.css': [ '_/css/screen.css' ]

    copy:
      css:
        files: [
          expand: true
          cwd:"_/css/"
          src: ["**"]
          dest: "dist/_/css/"
        ]
      static:
        files: [
          expand: true
          cwd:"_/img/"
          src: ["**"]
          dest: "dist/_/img/"
        ,
          expand: true
          cwd:"_/fonts/"
          src: ["**"]
          dest: "dist/_/fonts/"
        ,
          expand: true
          cwd:"_/public/"
          src: [ ".*" ]
          dest: "dist"
        ]

  # NOTE: this has to wipe out everything
  grunt.registerTask "root-canal", [ "clean:all" ]

  # Clean, compile and concatenate JS
  grunt.registerTask "javascript:dev", [ <% if ( scriptsLang === 'javascript') { %>"jshint",<% } %><% if ( scriptsLang === 'coffeescript') { %>"coffeelint", "coffee",<% } %> "concat:imports", "uglify:imports"]

  grunt.registerTask "javascript:dist", [ "javascript:dev", "uglify:scripts" ]

  # Setting up bigger tasks
  grunt.registerTask "dev", [ "root-canal", <% if ( markupLang === 'jekyll') { %>"jekyll",<% } %><% if ( markupLang === 'haml') { %>"haml",<% } %> "concat:html", <% if ( stylesLang === 'sass') { %>"compass",<% } %> "javascript:dev", "copy:css", "copy:static" ]

  grunt.registerTask "dist", [ "root-canal", <% if ( markupLang === 'jekyll') { %>"jekyll",<% } %><% if ( markupLang === 'haml') { %>"haml",<% } %> "concat:html", <% if ( stylesLang === 'sass') { %>"compass",<% } %> "javascript:dist", "cssmin", "copy:static" ]

  grunt.registerTask "server", ["connect", "watch"]
  grunt.registerTask "server:open", ["connect", "open", "watch"]
  grunt.registerTask "server:first", ["dev", "server:open"]

  # Default task
  grunt.registerTask "default", "dev"
