'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Configurable paths for the application
  var appConfig = {
    app                   : require('./bower.json').appPath || 'app',
    dist                  : 'dist',
    cdnPath               : 's3.amazonaws.com/abc123',
    API_URL               : process.env.API_URL || 'https://api.topcoder-dev.com/v3',
    API_URL_V2            : process.env.API_URL_V2 || 'https://api.topcoder-dev.com/v2',
    clientId              : process.env.CLIENT_ID || 'JFDo7HMkf0q2CkVFHojy3zHWafziprhT',
    domain                : process.env.DOMAIN || 'topcoder-dev.com',
    auth0Domain           : process.env.AUTH0_DOMAIN || 'topcoder-dev.auth0.com',
    auth0Callback         : 'no-callback-needed-without-social-login',
    submissionDownloadPath: '/review/actions/DownloadContestSubmission?uid=',
    photoLinkLocation     : process.env.PHOTO_LINK_LOCATION || 'http://community.topcoder.com'
  };

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    yeoman: appConfig,

    ngconstant: {
      options: {
        space: '  ',
        wrap : '"use strict";\n\n {%= __ngModule %}',
        name : 'app.config',
      },
      development: {
        options: {
          dest: '<%= yeoman.app %>/app.constants.js'
        },
        constants: {
          ENV: {
            name                  : 'development',
            API_URL               : appConfig.API_URL,
            API_URL_V2            : appConfig.API_URL_V2,
            clientId              : appConfig.clientId,
            domain                : appConfig.domain,
            auth0Domain           : appConfig.auth0Domain,
            auth0Callback         : appConfig.auth0Callback,
            submissionDownloadPath: appConfig.submissionDownloadPath,
            photoLinkLocation     : appConfig.photoLinkLocation
          }
        }
      },
      production: {
        options: {
          dest: '<%= yeoman.app %>/app.constants.js'
        },
        constants: {
          ENV: {
            name                  : 'production',
            API_URL               : appConfig.API_URL,
            API_URL_V2            : appConfig.API_URL_V2,
            clientId              : appConfig.clientId,
            domain                : appConfig.domain,
            auth0Domain           : appConfig.auth0Domain,
            auth0Callback         : appConfig.auth0Callback,
            submissionDownloadPath: appConfig.submissionDownloadPath,
            photoLinkLocation     : appConfig.photoLinkLocation
          }
        }
      }
    },

    // Watches files for changes and runs tasks based on the changed files
    watch: {
      jade: {
        files: ['<%= yeoman.app %>/**/*.jade'],
        tasks: ['newer:jade:compile', 'jade:index']
      },
      coffee: {
        files: ['<%= yeoman.app %>/**/*.coffee'],
        tasks: ['newer:coffee:dist']
      },
      coffeeTest: {
        files: ['test/spec/**/*.coffee'],
        tasks: ['newer:coffee:test', 'karma:unit']
      },
      sass: {
        files: ['<%= yeoman.app %>/content/css/**/*.scss'],
        tasks: ['sass']
      },
      gruntfile: {
        files: ['Gruntfile.js']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= yeoman.app %>/**/*.{html,js,css}',
          '.tmp/**/*.{html,js,css}',
          '<%= yeoman.app %>/content/images/**/*.{png,jpg,jpeg,gif,webp,svg}'
        ]
      }
    },

    // The actual grunt server settings
    connect: {
      options: {
        port: 9002,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35730
      },
      livereload: {
        options: {
          open: true,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect().use(
                '/app/content/css',
                connect.static('./app/content/css')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      test: {
        options: {
          port: 9002,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect.static('test'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          open: true,
          base: '<%= yeoman.dist %>'
        }
      }
    },

    // Make sure code styles are up to par and there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: {
        src: [
          'Gruntfile.js'
        ]
      }
    },

    jade: {
      compile: {
        options: {
          pretty: true,
          data: {
            debug: false
          }
        },
        files: [
          {
            expand: true,
            cwd   : '<%= yeoman.app %>',
            src   : '**/*.jade',
            dest  : '.tmp',
            ext   : '.html'
          }
        ]
      },
      index: {
        options: {
          pretty: true,
          data: {
            debug: false
          }
        },
        files: [
          {
            expand: true,
            cwd   : '<%= yeoman.app %>',
            src   : 'index.jade',
            dest  : '.tmp',
            ext   : '.html'
          }
        ]
      }
    },

    coffee: {
      options: {
        sourceMap: false,
        sourceRoot: ''
      },
      dist: {
        files: [{
          expand: true,
          cwd   : '<%= yeoman.app %>',
          src   : '**/*.coffee',
          dest  : '.tmp',
          ext   : '.js',
          extDot: 'last'
        }]
      },
      test: {
        files: [{
          expand: true,
          cwd   : 'test/spec',
          src   : '{,*/}*.coffee',
          dest  : '.tmp/spec',
          ext   : '.js',
          extDot: 'last'
        }]
      }
    },

    js2coffee: {
      options: {
        single_quotes: true
      },
      single: {
        src: '<%= yeoman.app %>/app.constants.js',
        dest: '<%= yeoman.app %>/app.constants.coffee'
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= yeoman.dist %>/{,*/}*',
            '!<%= yeoman.dist %>/.git{,*/}*'
          ]
        }]
      },
      server: '.tmp',
      constants: '<%= yeoman.app %>/app.constants.js'
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['last 1 version']
      },
      server: {
        options: {
          map: true,
        },
        files: [{
          expand: true,
          cwd   : '.tmp/content/css/',
          src   : '{,*/}*.css',
          dest  : '.tmp/content/css/'
        }]
      },
      dist: {
        files: [{
          expand: true,
          cwd   : '.tmp/content/css/',
          src   : '{,*/}*.css',
          dest  : '.tmp/content/css/'
        }]
      }
    },

    sass: {
      options: {
        sourceMap   : true,
        includePaths: require('node-bourbon').includePaths
      },
      dist: {
        files: [{
          expand: true,
          cwd   : '<%= yeoman.app %>',
          src   : '**/*.scss',
          dest  : '.tmp',
          ext   : '.css'
        }]
      }
    },

    'string-replace': {
      cdnify: {
        files: [{
          expand: true,
          src: [
            '<%= yeoman.dist %>/**/*.js',
            '<%= yeoman.dist %>/**/*.css',
            '<%= yeoman.dist %>/**/*.html'
          ],
          dest: '.' // Note, dest is always relative to root
        }],
        options: {
          replacements: [{
            pattern: /\/(views|locales|images|styles|scripts)\//gi,
            replacement: '//<%= yeoman.cdnPath %>/$1/'
          }]
        }
      }
    },

    // Renames files for browser caching purposes
    filerev: {
      dist: {
        src: [
          '<%= yeoman.dist %>/scripts/*.js',
          '<%= yeoman.dist %>/content/locales/**/*.json',
          '<%= yeoman.dist %>/content/css/**/*.css',
          '<%= yeoman.dist %>/**/*.html',
          '!<%= yeoman.dist %>/index.html',
          '<%= yeoman.dist %>/content/images/**/*.{png,jpg,jpeg,gif,webp,svg,ico}',
          '<%= yeoman.dist %>/contents/fonts/**/*.{eot,svg,ttf,woff,otf}'
        ]
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: ['.tmp/index.html'],
      options: {
        dest: '<%= yeoman.dist %>',
        flow: {
          html: {
            steps: {
              // js: ['concat', 'uglifyjs'],
              js: ['concat'],
              css: ['cssmin']
            },
            post: {}
          }
        }
      }
    },

    // Performs rewrites based on filerev and the useminPrepare configuration
    usemin: {
      html   : ['<%= yeoman.dist %>/**/*.html'],
      js     : ['<%= yeoman.dist %>/**/*.js'],
      css    : ['<%= yeoman.dist %>/content/css/**/*.css'],
      options: {
        assetsDirs: [
          '<%= yeoman.dist %>',
          '<%= yeoman.dist %>/content/css',
          '<%= yeoman.dist %>/edit-review/',
          '<%= yeoman.dist %>/review-status/',
          '<%= yeoman.dist %>/completed-review/'
        ],
        patterns: {
          js: [
            [/(\/[-\w]+\.html)/gm, 'Update JS files to reference revved html files.']
            // [/(locales\/\w+\.json)/gm, 'Update JS files to reference revved locale files.']
          ]
        }
      }
    },

    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd   : '<%= yeoman.app %>/content/images',
          src   : '{,*/}*.{png,jpg,jpeg,gif}',
          dest  : '<%= yeoman.dist %>/content/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd   : '<%= yeoman.app %>/content/images',
          src   : '{,*/}*.svg',
          dest  : '<%= yeoman.dist %>/content/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          collapseWhitespace       : true,
          conservativeCollapse     : true,
          collapseBooleanAttributes: true,
          removeCommentsFromCDATA  : true,
          removeOptionalTags       : true,
          removeComments           : true
        },
        files: [{
          expand: true,
          cwd   : '<%= yeoman.dist %>',
          src   : ['**/*.html'],
          dest  : '<%= yeoman.dist %>'
        }]
      }
    },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [{
          expand: true,
          dot   : true,
          cwd   : '<%= yeoman.app %>',
          dest  : '<%= yeoman.dist %>',
          src   : [
            'content/images/**/*',
            'content/fonts/**/*',
            'content/locales/**/*',
            'content/data/**/*'
          ]
        }, {
          expand: true,
          cwd   : '<%= yeoman.app %>',
          dest  : '<%= yeoman.dist %>',
          src   : [
            'content/images/favicon.ico'
          ]
        }, {
          expand: true,
          cwd   : '.tmp/content/images',
          dest  : '<%= yeoman.dist %>/content/images',
          src   : ['generated/*']
        }, { // copy html files generated from jade
          expand: true,
          cwd   : '.tmp',
          dest  : '<%= yeoman.dist %>',
          src   : ['**/*.html']
        }]
      },
      styles: {
        expand: true,
        cwd   : '<%= yeoman.app %>/content/css',
        dest  : '.tmp/content/css/',
        src   : '{,*/}*.css'
      },
      images: {
        expand: true,
        cwd   : '<%= yeoman.app %>/content/images',
        dest  : '.tmp/content/images/',
        src   : ['*.png', '*.ico', '*.gif']
      }
    },

    // Run some tasks in parallel to speed up the build process
    concurrent: {
      server: [
        'sass',
        'coffee:dist',
        'jade:compile',
        'copy:images'
      ],
      test: [
        'coffee',
        'sass',
        'jade:compile',
      ],
      dist: [
        'coffee',
        'sass',
        'jade:compile',
        'imagemin',
        'svgmin'
      ]
    },

    // Test settings
    karma: {
      unit: {
        configFile: 'test/karma.conf.coffee',
        singleRun: true
      },
      server: {
        configFile: 'test/karma.conf.coffee',
        singleRun: false
      }
    }
  });


  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'ngconstant:development',
      'js2coffee',
      'clean:constants',
      'concurrent:server',
      'autoprefixer:server',
      'connect:livereload',
      'watch'
    ]);
  });

  grunt.registerTask('server', 'DEPRECATED TASK. Use the "serve" task instead', function (target) {
    grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
    grunt.task.run(['serve:' + target]);
  });

  grunt.registerTask('test', [
    'clean:server',
    'concurrent:test',
    'autoprefixer',
    'connect:test',
    'karma:unit'
  ]);

  grunt.registerTask('build', [
    'clean:dist',
    'ngconstant:production',
    'js2coffee',
    'clean:constants',
    // 'concurrent:dist',
    'coffee',
    'sass',
    'jade:compile',
    // 'imagemin',
    'svgmin',
    'useminPrepare',
    'autoprefixer',
    'concat:generated',
    'copy:dist',
    'cssmin:generated',
    // 'uglify:generated',
    // 'filerev',
    'usemin',
    'htmlmin'
    // 'string-replace:cdnify'
  ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'test',
    'build'
  ]);
};
