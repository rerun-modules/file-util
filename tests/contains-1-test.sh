#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m file-util -p contains [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "contains"

# ------------------------------

it_shows_matching_text_when_contains_string() {
	FILE=$(mktemp "/tmp/it_shows_matching_text_when_contains_string.XXX")

	MATCHING_TEXT="something matching"
cat > $FILE <<EOF
    something not matching
    $MATCHING_TEXT
EOF

	output=($(rerun file-util:contains --file "$FILE" --string "$MATCHING_TEXT"))
	
	test "$MATCHING_TEXT" = "${output[*]}"

	rm $FILE

}

it_fails_when_file_does_not_contain_string() {
	FILE=$(mktemp "/tmp/it_fails_when_file_does_not_contain_string.XXX")

	MATCHING_TEXT="something matching"
cat > $FILE <<EOF
    something not matching
    gobbledeegoop
EOF

	if ! output=($(rerun file-util:contains --file "$FILE" --string "$MATCHING_TEXT"))
	then 
		:; # failed as it should have
	else
		echo "Should have failed when file does not contain string"
		exit 1
	fi
	
	rm $FILE

}

# ------------------------------

