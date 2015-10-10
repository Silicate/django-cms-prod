## content of /config/settings-append.py will be appended to website1/settings.py by djangocms-installer
# 
# many ways to extend & modularize Django settings: https://code.djangoproject.com/wiki/SplitSettings

## set production settings:
#SECRET_KEY = 'some_randomly_generated_string_of_ascii'

## add more apps:
INSTALLED_APPS +=  ('djangocms_snippet',
)

## add more modules: (merging 2 dictionaries)
MIGRATION_MODULES_ADD =    {'djangocms_snippet': 'djangocms_snippet.migrations_django',
}
MIGRATION_MODULES.update(MIGRATION_MODULES_ADD) 

# --- docker-entrypoint will append ALLOWED_HOSTS below --- #