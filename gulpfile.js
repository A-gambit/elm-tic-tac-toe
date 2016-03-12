var gulp = require('gulp')
var elm  = require('gulp-elm')
var uglify = require('gulp-uglify')

gulp.task('elm-init', elm.init)

gulp.task('elm-minify', ['elm-init'], function() {
  return gulp.src('src/*.elm')
    .pipe(elm.bundle('game.js'))
    .pipe(uglify())
    .pipe(gulp.dest('dist/'))
})

gulp.task('elm-build', ['elm-init'], function() {
  return gulp.src('src/*.elm')
    .pipe(elm.bundle('game.js'))
    .pipe(gulp.dest('dist/'))
})

gulp.task('elm-watch', function () {
  gulp.watch('src/**/*.elm', ['elm-minify'])
})

gulp.task('default', ['elm-minify', 'elm-watch'])
