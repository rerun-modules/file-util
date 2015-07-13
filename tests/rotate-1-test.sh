#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m file-util -p rotate [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "rotate"

# ------------------------------
it_creates_a_copy_and_truncates_file() {
	FILE=$(mktemp "${TMPDIR:-/tmp}/it_creates_a_copy_and_truncates_file.XXX")

cat > $FILE <<EOF
    log message 1
    log message 2
    log message 3
EOF
	original_size=($(wc -c <"$FILE"))
	tstamp_specifier="+%Y"

	rerun file-util:rotate --file "$FILE" --tstamp-format "$tstamp_specifier"

	# it truncated the original file
	! test -s "$FILE"

	# It created a copy
	tstamp="$(date $tstamp_specifier)"
	test -f "$FILE.$tstamp"

	# the copy has same size as original
	copy_size=($(wc -c "$FILE.$tstamp"))
	test "$original_size" -eq "$copy_size"

	rm $FILE $FILE.$tstamp
}

it_creates_gzip_for_copy() {
	FILE=$(mktemp "${TMPDIR:-/tmp}/it_creates_gzip_for_copy.XXX")

cat > $FILE <<EOF
    log message 1
    log message 2
    log message 3
EOF

	tstamp_specifier="+%Y"

	TSTAMP=$(date "$tstamp_specifier")

	rerun file-util:rotate --file "$FILE" --tstamp-format "$tstamp_specifier" --compress gzip

	
	test -f "$FILE.$TSTAMP.gz"

}
# ------------------------------

