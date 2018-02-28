var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');

// 压缩 css
gulp.task('minify-css', function() {
    return gulp.src(['./public/**/*.css', './public/*.css'])
        .pipe(minifycss())
        .pipe(gulp.dest('./public'));
});

// 压缩 html
gulp.task('minify-html', function() {
  return gulp.src(['./public/**/*.html', './public/*.html'])
    .pipe(htmlclean())
    .pipe(htmlmin({
         removeComments: true,
         minifyJS: true,
         minifyCSS: true,
         minifyURLs: true,
    }))
    .pipe(gulp.dest('./public'))
});
// 执行 gulp 命令时执行的任务
gulp.task('default', ['minify-html', 'minify-css']);
