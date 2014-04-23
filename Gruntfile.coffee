module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n'

    bower:
      install:
        options:
          targetDir: 'tmp/vendor'
          layout: 'byType'
          install: true
          verbose: false
          cleanTargetDir: yes
          cleanBowerDir: false
          bowerOptions: {}

    browserify:
      app:
        files:
          'build/js/app.js': [
            'app/**/*.coffee'
            'app/**/*.js'
            'app/**/*.hbs'
          ]
        options:
          debug: true
          transform: ['coffeeify','hbsfy']
          extensions: ['.coffee','.hbs']
          insertGlobals: true
          aliasMappings: [{
            cwd: 'app/controllers'
            src: ['**/*.coffee']
            dest: 'controllers'
          }, {
            cwd: 'app/views'
            src: ['**/*.coffee']
            dest: 'views'
          }, {
            cwd: 'app/models'
            src: ['**/*.coffee']
            dest: 'models'
          }]

    clean:
      dist: ['build/', 'tmp/']

    concat:
      distCss:
        src: [
          'tmp/vendor/*/*.css'
          'tmp/css/app.css'
        ]
        dest: 'build/css/app.css'
      bowerConcat:
        src: [
          'tmp/vendor/jquery/jquery.js'
          'tmp/vendor/bootstrap/bootstrap.js'
        ]
        dest: 'build/js/vendor.js'

    copy:
      assets:
        files: [
          {
            expand: true
            cwd: 'app/assets/'
            src: ['**']
            dest: 'build/'
            filter: 'isFile'
          }
        ]

    express:
      dev:
        options:
          port: 4040
          script: 'server.js'

    mincss:
      dist:
        files:
          "build/css/app.css": "build/css/app.css"

    stylus:
      dist:
        options:
          compress: false
          paths: ['app/css']
        files:
          'tmp/css/app.css': 'app/css/application.styl'

    mocha:
      test:
        src: "http://localhost:4466/index.html"
        mocha:
          ignoreLeaks: false
          timeout: 20000
        run: true

    uglify:
      app:
        options:
          report: 'min'
          preserveComments: 'some'
        src: 'build/js/app.js'
        dest: 'build/js/app.js'

    watch:
      assets:
        files: ['app/assets/**/*'],
        tasks: ['copy']
        options:
          debounceDelay: 50
      css:
        files: ['app/css/**/*.styl'],
        tasks: ['styles']
        options:
          debounceDelay: 50
      express:
        files: ['server.js']
        tasks: ['express:dev']
        options:
          nospawn: true
      hbs:
        files: ['app/templates/**/*.hbs']
        tasks: ['scripts', 'concat:devJs']
        options:
          debounceDelay: 250
      js:
        files: ['app/**/*.coffee'],
        tasks: ['scripts', 'concat:devJs']
        options:
          debounceDelay: 250
      livereload:
        options:
          livereload: true
        files: [
          'build/**/*'
        ]

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  grunt.registerTask 'foo', ['clean', 'bower', 'copy', 'browserify', 'concat']
  grunt.registerTask 'default', 'foo'
