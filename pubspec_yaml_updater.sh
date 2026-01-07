#!/bin/zsh
#---------------------------------------------------------------------------#
# Author : Angelo Merluccio
# Created: 01/07/2026
# Description: Update flutter pubspec.yaml
#---------------------------------------------------------------------------#
# Check if correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filename> <sdk_version> <cuppertino_icons_version>"
    echo "Example: $0 pubspec.yaml '^3.10.4' '^1.0.8'"
    exit 1
fi

# Assign arguments to meaningful variable names
FILE="$1"
SDK="$2"
CUPICNS="$3"

# Use sed to replace the pattern in the file
# -i "" makes the edit in-place
{
 	# Use grep to find the line number of the first occurrence
  SDK_MATCH_LINE=$(grep -zo "^environment\\:\n" "$FILE" | head -n 1 | cut -d: -f1)
  MATCH_LINE=$(grep "\  cupertino_icons\\:" "$FILE")

	if [ -n "$SDK_MATCH_LINE" ]; then
  # echo "matched on line: $SDK_MATCH_LINE"
		sed -i "" "s/^  sdk[:].*/  sdk\: ^$SDK/" "$FILE"
  else
    echo "no match for enviroment"
	fi

  if [ -n "$MATCH_LINE" ]; then
  # echo "matched on line: $MATCH_LINE"
    sed -i "" "s/^  cupertino_icons[:].*/  cupertino_icons\: ^$CUPICNS/" "$FILE"
  else
    echo "no match for cupertino_icons"
  fi
}

echo "Updated file, $FILE, enviroment sdk version to ^$SDK and cupertino icons version to ^$CUPICNS."
