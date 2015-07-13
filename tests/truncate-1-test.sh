#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m file-util -p truncate [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "truncate"

# ------------------------------
it_creates_a_zero_byte_new_file() {
	FILE=$(mktemp "/tmp/it_creates_a_zero_byte_new_file.XXX")

	rerun file-util:truncate --file "$FILE"
	
	# it does exist
	test -f "$FILE"
	# it has zero size
	! test -s "$FILE"

}


it_empties_an_existing_file() {
	FILE=$(mktemp "/tmp/it_empties_an_existing_file.XXX")

cat > $FILE <<EOF
    something text
    another line of content
EOF
	# it does not have zero bytes
	test -s "$FILE"

	# truncate it
	rerun file-util:truncate --file "$FILE"

	# it has zero size
	! test -s "$FILE"

	rm $FILE

}
# ------------------------------

