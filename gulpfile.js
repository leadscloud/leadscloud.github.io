var gulp = require('gulp');
var minifycss = require('gulp-minify-css');
var htmlmin = require('gulp-htmlmin');
var htmlclean = require('gulp-htmlclean');
var imagemin = require('gulp-imagemin');

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

// 压缩图片
gulp.task('minify-images', function() {
    return gulp.src('./public/wp-content/uploads/**/*.*')
        .pipe(imagemin(
        [imagemin.gifsicle({'optimizationLevel': 3}), 
        imagemin.jpegtran({'progressive': true}), 
        imagemin.optipng({'optimizationLevel': 7}), 
        imagemin.svgo()],
        {'verbose': true}))
        .pipe(gulp.dest('./public/wp-content/uploads/'))
});

// 执行 gulp 命令时执行的任务
gulp.task('default', ['minify-html', 'minify-css', 'minify-images']);
