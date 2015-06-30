BUILD_DIR = "./public"

gulp        = require "gulp"
jade        = require "gulp-jade"
stylus      = require "gulp-stylus"
concat      = require "gulp-concat"
debug       = require "gulp-debug"
coffee      = require "gulp-coffee"
browserSync = require "browser-sync"
plumber     = require "gulp-plumber"
sourcemaps  = require "gulp-sourcemaps"
autoprefixer= require "gulp-autoprefixer"


browserSync.create()
reload      = browserSync.reload

paths =
    root:   ''
    coffee: 'src/coffee/'
    jade:   'src/jade/'
    stylus:   'src/stylus/'
    assets: 'assets/'
    bower:  'bower_components/'
    output:  BUILD_DIR + '/'
    js:      BUILD_DIR + '/js/'
    vendors: BUILD_DIR + '/vendors/'

javascript_main_script = "app.js"

gulp.task 'build', [ 'coffee', 'jade', 'stylus', 'copy-vendors', 'copy-assets']

gulp.task 'stylus', ->

  gulp.src paths.stylus + '/app.styl'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe stylus()
    .pipe sourcemaps.write({includeContent: false})
    .pipe sourcemaps.init({loadMaps: true})
    .pipe autoprefixer()
    .pipe sourcemaps.write()
    .pipe gulp.dest paths.output + "css/"
    .pipe reload({stream: true})

gulp.task 'jade', ->

  gulp.src(paths.jade + '**/*.jade')
    .pipe plumber()
    .pipe jade
        pretty: true
    .pipe gulp.dest paths.output
    # .pipe livereload()

gulp.task 'coffee', ->
  gulp.src(paths.coffee + '**/*.coffee')
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe coffee sourceMap: true
    .pipe concat javascript_main_script
    .pipe sourcemaps.write()
    .pipe gulp.dest paths.js
    # .pipe livereload()

gulp.task 'copy-assets', ->
  gulp.src paths.assets + '**/*.*'
    .pipe gulp.dest paths.output

gulp.task 'copy-vendors', ->
  gulp.src paths.bower + '**/*.*'
    .pipe gulp.dest paths.vendors


gulp.task 'watch', ->
    gulp.watch paths.coffee + "**/*.coffee", { interval: 300 },  [ 'coffee' ]
    gulp.watch paths.jade   + "**/*.jade", { interval: 300 },    [ 'jade' ]
    gulp.watch paths.stylus + "**/*.*",  { interval: 300 },      [ 'stylus' ]
    gulp.watch paths.assets + "**/*.*", { interval: 300 },       [ 'copy-assets' ]
    gulp.watch paths.bower  + "**/*.*",  { interval: 300 },      [ 'copy-vendors' ]


gulp.task 'w', [ 'build', 'watch' ]
gulp.task 'default', [ 'build' ]
