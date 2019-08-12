#!/usr/bin/env python3

sdk_path = "$ANDROID_HOME"

repo_url = "https://efreak.github.io/tachiyomi-extensions/fdroid/repo"
repo_name = "Unofficial Tachiyomi Extensions F-Droid Repo"
repo_icon = "fdroid-icon.png"
repo_description = """
This is a repository of source extensions to be used with Tachiyomi.
Applications in this repository are official binaries built and
signed by the developers of Tachiyomi and copied to this directory.
"""

archive_older = 1
archive_url = "https://efreak.github.io/tachiyomi-extensions/fdroid/archive"
archive_name = "Unofficial Tachiyomi Extensions F-Droid Archive"
archive_icon = "fdroid-icon.png"
archive_description = """
The repository of older versions of source extensions to be used with Tachiyomi.
Applications in this repository are official binaries built and
signed by the developers of Tachiyomi and copied to this directory.
"""

make_current_version_link = False

# current_version_name_source = 'packageName'

# The ID of a GPG key for making detached signatures for apks. Optional.
# gpgkey = '1DBA2E89'

repo_keyalias = "Lenovo.localdomain"
keystore = "$KEYSTORE"
keystorepass = "$KEYSTOREPASS"
keypass = "$KEYPASS"
keydname = "CN=Lenovo.localdomain, OU=F-Droid"

# Set this to true to always use a build server. This saves specifying the
# --server option on dedicated secure build server hosts.
# build_server_always = True

# Limit in number of characters that fields can take up
# Only the fields listed here are supported, defaults shown
# char_limits = {
#     'author': 256,
#     'name': 30,
#     'summary': 80,
#     'description': 4000,
#     'video': 256,
#     'whatsNew': 500,
# }
