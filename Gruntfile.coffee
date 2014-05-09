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
            # 引入kiwi的插件
            'node_modules/kiwi-*/**/*.coffee'
            'node_modules/kiwi-*/**/*.js'
            'node_modules/kiwi-*/**/*.hbs'
          ]
        options:
          debug: true
          transform: ['coffeeify', 'hbsfy']
          extensions: ['.coffee', '.hbs', '.js']
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
          }, {
            cwd: 'app/lib'
            src: ['**/*.coffee']
            dest: 'lib'
          }, {
            cwd: 'app/locale'
            src: ['**/*.js']
            dest: 'locale'
          }, {
            cwd: 'app/data'
            src: [
              '**/*.coffee'
              '**/*.js'
            ]
            dest: 'data'
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
          'tmp/css/app.css': 'app/views/**/*.styl'

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
        files: ['app/**/*.styl'],
        tasks: ['stylus', 'concat:distCss']
        options:
          debounceDelay: 50
      hbs:
        files: [
          'app/views/**/*.hbs'
          'app/templates/**/*.hbs'
          'node_modules/kiwi-*/**/*.hbs'
        ]
        tasks: ['browserify']
        options:
          debounceDelay: 250
      js:
        files: [
          'app/**/*.coffee'
          'node_modules/kiwi-*/**/*.coffee'
          'node_modules/kiwi-*/**/*.js'
        ],
        tasks: ['browserify']
        options:
          debounceDelay: 250
      livereload:
        options:
          livereload: true
        files: [
          'build/**/*'
        ]

    connect:
      server:
        options:
          port: 8000
          base: 'build'
          hostname: '*'

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  grunt.registerTask 'build', ['clean', 'bower', 'copy', 'stylus', 'browserify', 'concat']
  grunt.registerTask 'watchserver', ['build', 'connect', 'watch']
  grunt.registerTask 'default', 'build'
