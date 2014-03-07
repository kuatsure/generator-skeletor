# Require any additional compass plugins here.


# Project scaffolding
http_path         = "/"
app_path          = "app/"
tmp_path          = ".tmp/"

sass_dir          = app_path + "styles"
images_dir        = app_path + "img"
fonts_dir         = app_path + "fonts"

css_dir           = tmp_path + "styles"
javascripts_dir   = tmp_path + "scripts"

add_import_path     app_path + "bower_components"

output_style      = :nested
environment       = :development

relative_assets   = false

color_output      = false
