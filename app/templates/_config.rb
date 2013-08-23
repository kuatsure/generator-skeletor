# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path         = "/"
assets_path       = '_/'

css_dir           = assets_path + "css"
sass_dir          = assets_path + "sass"
images_dir        = assets_path + "img"
javascripts_dir   = assets_path + "js"
fonts_dir         = assets_path + "fonts"

output_style      = :nested
environment       = :development

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets   = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false
color_output      = false

# For source maps
#sass_options      = { :debug_info => true }

# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass _/sass scss && rm -rf sass && mv scss sass
