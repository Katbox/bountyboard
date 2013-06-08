#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
	echo -e "
prepare-jquery-ui-stylesheet.sh stylesheet-path

Prepares the specified jQuery-UI stylesheet for use in a Rails project. By
default jQuery-UI's stylesheets reference images by relative paths, but Rails'
asset compilation breaks these paths. This script updates references to image
resources in the stylesheet to work correctly under the Rails asset pipeline.
When this script is finished, place the jQuery-UI stylesheet in the project's
vendor/assets/stylesheets/ folder.
WARNING: this script modifies the original file!

arguments:

	stylesheet-path: path to the stylesheet to be made Rails compatible. This
		file's contents will be overwritten.
"
	exit 1
fi

FILE="$1"
if [ -e "$FILE" ]; then
	sed -i 's/url(images\//url(/g' "$FILE"
else
	echo -e "\"$FILE\" not found." >&2
	exit 1
fi

