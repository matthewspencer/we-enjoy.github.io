#!/bin/bash

# function exists check
is_function() {
    declare -f -F $1 > /dev/null
    return $?
}

echo "Resize new images"
sleep 0.5

# where are we
pushd `dirname $0` > /dev/null
	DIR=`pwd`
popd > /dev/null

# cd original assets directory
cd "$DIR"/../assets/_

# find file modified today
for file in $(find . -type f  \( -iname \*.png -o -iname \*.jpg -o -iname \*.jpeg -o -iname \*.gif \)); do
	# echo $file
	echo ${file##./}

	# copy to parent assets directory
	# cp $file ../$file

	# get image width
	# w=$( mdls "$file" | grep kMDItemPixelWidth | tail -n1 | cut -d= -f2 )

	# if larger than 500px wide
	# if (("$w" > 500)); then
		# sips is super lossy
		# sips --resampleWidth 500 ../$file
	# fi
	
	# if cli imageOptim is installed
	# https://github.com/JamieMason/ImageOptim-CLI
	# if [ "$(type -t imageOptim)" = "file" ]; then
		# imageOptim --jpeg-mini --image-alpha --quit --directory ../$file
	# fi


	# resize to 500px with image magick
	# save to parent assets directory
	convert \
		$file \
		-coalesce \
		-resize 500 \
		../$file

	open -a ImageOptim ../$file
done

cd ../..