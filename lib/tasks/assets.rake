#fetch bower packages before comiling assets
task "assets:precompile" => "bower:install"
