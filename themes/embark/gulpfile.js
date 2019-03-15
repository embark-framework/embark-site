/******************************************************
 * PATTERN LAB NODE
 * EDITION-NODE-GULP
 * The gulp wrapper around patternlab-node core, providing tasks to interact with the core library and move supporting frontend assets.
******************************************************/
var gulp                  = require('gulp'),
    path                  = require('path'),
    runSequence           = require('run-sequence'),
    browserSync           = require('browser-sync').create(),
    minimist                  = require('minimist'),
    sass                  = require('gulp-sass'),
    sourcemaps            = require('gulp-sourcemaps'),
    autoprefixer          = require('gulp-autoprefixer'),
    bump                  = require('gulp-bump'),
    gutil                 = require('gulp-util'),
    git                   = require('gulp-git'),
    concat                = require('gulp-concat'),
    svgSprite             = require('gulp-svg-sprites'),
    chalk                 = require('chalk'),
    fs                    = require('fs');

/**
 * Normalize all paths to be plain, paths with no leading './',
 * relative to the process root, and with backslashes converted to
 * forward slashes. Should work regardless of how the path was
 * written. Accepts any number of parameters, and passes them along to
 * path.resolve().
 *
 * This is intended to avoid all known limitations of gulp.watch().
 *
 * @param {...string} pathFragment - A directory, filename, or glob.
*/
function normalizePath() {
  return path
    .relative(
      process.cwd(),
      path.resolve.apply(this, arguments)
    )
    .replace(/\\/g, "/");
}

/******************************************************
 * COPY TASKS - stream assets from source to destination
******************************************************/
// JS copy
gulp.task('pl-copy:js', function () {
  return gulp.src('**/*.js', {cwd: normalizePath(paths().source.js)} )
    .pipe(gulp.dest(normalizePath(paths().public.js)));
});

// Images copy
gulp.task('pl-copy:img', function () {
  return gulp.src('**/*.*',{cwd: normalizePath(paths().source.images)} )
    .pipe(gulp.dest(normalizePath(paths().public.images)));
});

// Fonts copy
gulp.task('pl-copy:font', function () {
  return gulp.src('**/*', {cwd: normalizePath(paths().source.fonts)})
    .pipe(gulp.dest(normalizePath(paths().public.fonts)));
});

// SVG Icons
gulp.task('icons', function () {
  return gulp.src('**/*.svg', {cwd: normalizePath(paths().source.icons)})
    .pipe(svgSprite({
      mode: "symbols",
      svgId: "icon-%f",
      svg: {
        sprite: "sprite.svg",
        symbols: "symbols.svg"
      }
    }))
    .pipe(gulp.dest(normalizePath(paths().public.icons)));

});

gulp.task('hexo-icons', function () {
  return gulp.src('**/*.svg', {cwd: normalizePath(paths().source.icons)})
    .pipe(svgSprite({
      mode: "symbols",
      svgId: "icon-%f",
      svg: {
        sprite: "sprite.svg",
        symbols: "symbols.svg"
      }
    }))
    .pipe(gulp.dest(normalizePath(paths().source.icons)));
});

// JS Copy
gulp.task('pl-copy:js', function () {
  return gulp.src([
    normalizePath(paths().source.nodeModules) + '/svg4everybody/dist/svg4everybody.js',
    normalizePath(paths().source.js) + '/application.js'
  ])
  .pipe(concat('application.js'))
  .pipe(gulp.dest(normalizePath(paths().public.js)))
  .pipe(browserSync.stream());
});

// CSS Copy
gulp.task('pl-copy:css', function () {
  return gulp.src([
    normalizePath(paths().source.css) + '/*.css'
  ])
  .pipe(gulp.dest(normalizePath(paths().public.css)))
  .pipe(browserSync.stream());
});

// CSS concat
gulp.task('concat:css', function () {
  return gulp.src([
    normalizePath(paths().public.css) + '/application.css'
  ])
  .pipe(concat('application.css'))
  .pipe(gulp.dest(normalizePath(paths().public.css)))
  .pipe(browserSync.stream());
});

// Scss Compiling
gulp.task('scss', function () {
  return gulp.src(normalizePath(paths().source.scss) + '/*.scss')
    .pipe(sourcemaps.init())
    .pipe(sass.sync().on('error', sass.logError))
    .pipe(sourcemaps.write())
    .pipe(sourcemaps.init({loadMaps: true}))
    .pipe(autoprefixer({
      browsers: ['last 2 versions']
    }))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest(normalizePath(paths().public.css)))
    .pipe(browserSync.stream());
});

// Styleguide Copy everything but css
gulp.task('pl-copy:styleguide', function () {
  return gulp.src(normalizePath(paths().source.styleguide) + '/**/!(*.css)')
    .pipe(gulp.dest(normalizePath(paths().public.root)))
    .pipe(browserSync.stream());
});

// Styleguide Copy and flatten css
gulp.task('pl-copy:styleguide-css', function () {
  return gulp.src(normalizePath(paths().source.styleguide) + '/**/*.css')
    .pipe(gulp.dest(function (file) {
      //flatten anything inside the styleguide into a single output dir per http://stackoverflow.com/a/34317320/1790362
      file.path = path.join(file.base, path.basename(file.path));
      return normalizePath(path.join(paths().public.styleguide, '/css'));
    }))
    .pipe(browserSync.stream());
});


gulp.task('changelog', function () {
  return gulp.src('CHANGELOG.md', {
    buffer: true
  })
    .pipe(conventionalChangelog({
      preset: 'angular',
      releaseCount: 0
    }))
    .pipe(gulp.dest('./'));
});

var knownOptions = {
  string: 'env',
  default: { env: process.env.NODE_ENV }
};
var options = minimist(process.argv.slice(2), knownOptions);

gulp.task('bump-version', function () {
// We hardcode the version change type to 'patch' but it may be a good idea to
// use minimist (https://www.npmjs.com/package/minimist) to determine with a
// command argument whether you are doing a 'major', 'minor' or a 'patch' change.
  return gulp.src(['./package.json'])
    .pipe(bump({type: options.env}).on('error', gutil.log))
    .pipe(gulp.dest('./'));
});

gulp.task('commit-changes', function () {
  return gulp.src('.')
    .pipe(git.add())
    .pipe(git.commit('[Prerelease] Bumped version number'));
});

gulp.task('push-changes', function (cb) {
  git.push('origin', 'master', cb);
});

gulp.task('create-new-tag', function (cb) {
  var version = getPackageJsonVersion();
  git.tag(version, 'Created Tag for version: ' + version, function (error) {
    if (error) {
      return cb(error);
    }
    git.push('origin', 'master', {args: '--tags'}, cb);
  });

  function getPackageJsonVersion () {
    // We parse the json file instead of using require because require caches
    // multiple calls so the version number won't be updated
    return JSON.parse(fs.readFileSync('./package.json', 'utf8')).version;
  };
});

gulp.task('release', gulp.series('bump-version', 'changelog', 'commit-changes', 'push-changes', 'create-new-tag'));


/******************************************************
 * PATTERN LAB CONFIGURATION - API with core library
******************************************************/
//read all paths from our namespaced config file
var config = require('./patternlab-config.json'),
  patternlab = require('patternlab-node')(config);

function paths() {
  return config.paths;
}

function getConfiguredCleanOption() {
  return config.cleanPublic;
}

/**
 * Performs the actual build step. Accomodates both async and sync
 * versions of Pattern Lab.
 * @param {function} done - Gulp done callback
 */
function build(done) {
  const buildResult = patternlab.build(() => {}, getConfiguredCleanOption());

  // handle async version of Pattern Lab
  if (buildResult instanceof Promise) {
    return buildResult.then(done);
  }

  // handle sync version of Pattern Lab
  done();
  return null;
}

gulp.task('pl-assets', gulp.series(
  'pl-copy:js',
  'pl-copy:img',
  'pl-copy:font',
  'icons',
  'scss',
  'concat:css',
  'pl-copy:css',
  'pl-copy:styleguide',
  'pl-copy:styleguide-css'
));

gulp.task('patternlab:version', function (done) {
  patternlab.version();
  done();
});

gulp.task('patternlab:help', function (done) {
  patternlab.help();
  done();
});

gulp.task('patternlab:patternsonly', function (done) {
  patternlab.patternsonly(done, getConfiguredCleanOption());
});

gulp.task('patternlab:liststarterkits', function (done) {
  patternlab.liststarterkits();
  done();
});

gulp.task('patternlab:loadstarterkit', function (done) {
  patternlab.loadstarterkit(argv.kit, argv.clean);
  done();
});

gulp.task('patternlab:build', gulp.series('pl-assets', build));

gulp.task('patternlab:installplugin', function (done) {
  patternlab.installplugin(argv.plugin);
  done();
});

/******************************************************
 * SERVER AND WATCH TASKS
******************************************************/
// watch task utility functions
function getSupportedTemplateExtensions() {
  var engines = require('./node_modules/patternlab-node/core/lib/pattern_engines');
  return engines.getSupportedFileExtensions();
}
function getTemplateWatches() {
  return getSupportedTemplateExtensions().map(function (dotExtension) {
    return normalizePath(paths().source.patterns, '**', '*' + dotExtension);
  });
}

/**
 * Reloads BrowserSync.
 * Note: Exits more reliably when used with a done callback.
 */
function reload(done) {
  browserSync.reload();
  done();
}

/**
 * Reloads BrowserSync, with CSS injection.
 * Note: Exits more reliably when used with a done callback.
 */
function reloadCSS(done) {
  browserSync.reload('*.css');
  done();
}

function watch() {
  const watchers = [
    {
      name: 'CSS',
      paths: [normalizePath(paths().source.css, '**', '*.css')],
      config: { awaitWriteFinish: true },
      tasks: gulp.series('pl-copy:css', 'concat:css', reloadCSS)
    },
    {
      name: 'JS',
      paths: [normalizePath(paths().source.js, '**', '*.js')],
      config: { awaitWriteFinish: true },
      tasks: gulp.series('pl-copy:js', reloadCSS)
    },
    {
      name: 'scss',
      paths: [normalizePath(paths().source.scss, '**', '*.scss')],
      config: { awaitWriteFinish: true },
      tasks: gulp.series('scss', 'concat:css')
    },
    {
      name: 'icons',
      paths: [normalizePath(paths().source.icons, '**', '*')],
      config: { awaitWriteFinish: true },
      tasks: gulp.series('icons')
    },
    {
      name: 'Styleguide Files',
      paths: [normalizePath(paths().source.styleguide, '**', '*')],
      config: { awaitWriteFinish: true },
      tasks: gulp.series('pl-copy:styleguide', 'pl-copy:styleguide-css', reloadCSS)
    },
    {
      name: 'Source Files',
      paths: [
        normalizePath(paths().source.patterns, '**', '*.json'),
        normalizePath(paths().source.patterns, '**', '*.md'),
        normalizePath(paths().source.data, '**', '*.json'),
        normalizePath(paths().source.fonts, '**', '*'),
        normalizePath(paths().source.images, '**', '*'),
        normalizePath(paths().source.js, '**', '*'),
        normalizePath(paths().source.meta, '**', '*'),
        normalizePath(paths().source.icons, '**', '*'),
        normalizePath(paths().source.annotations, '**', '*')
      ].concat(getTemplateWatches()),
      config: { awaitWriteFinish: true },
      tasks: gulp.series(build, reload)
    }
  ];

  watchers.forEach(watcher => {
    console.log('\n' + chalk.bold('Watching ' + watcher.name + ':'));
    watcher.paths.forEach(p => console.log('  ' + p));
    gulp.watch(watcher.paths, watcher.config, watcher.tasks);
  });
  console.log();
}

gulp.task('patternlab:connect', gulp.series(function (done) {
  browserSync.init({
    server: {
      baseDir: normalizePath(paths().public.root)
    },
    snippetOptions: {
      // Ignore all HTML files within the templates folder
      blacklist: ['/index.html', '/', '/?*']
    },
    notify: {
      styles: [
        'display: none',
        'padding: 15px',
        'font-family: sans-serif',
        'position: fixed',
        'font-size: 1em',
        'z-index: 9999',
        'bottom: 0px',
        'right: 0px',
        'border-top-left-radius: 5px',
        'background-color: #1B2032',
        'opacity: 0.4',
        'margin: 0',
        'color: white',
        'text-align: center'
      ]
    }
  }, function () {
    done();
  });
}));

/******************************************************
 * COMPOUND TASKS
******************************************************/
gulp.task('default', gulp.series('patternlab:build'));
gulp.task('watch', gulp.series('patternlab:build', watch));
gulp.task('serve', gulp.series('patternlab:build', 'patternlab:connect', watch));
