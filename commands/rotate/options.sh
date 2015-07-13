# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Sat Jul 11 06:22:33 PDT 2015
#
#/ usage: file-util:rotate  --file <> [ --compress <gzip>]  --tstamp-format <%Y%m%d> 

# _rerun_options_parse_ - Parse the command arguments and set option variables.
#
#     rerun_options_parse "$@"
#
# Arguments:
#
# * the command options and their arguments
#
# Notes:
# 
# * Sets shell variables for any parsed options.
# * The "-?" help argument prints command usage and will exit 2.
# * Return 0 for successful option parse.
#
rerun_options_parse() {

    while [ "$#" -gt 0 ]; do
        OPT="$1"
        case "$OPT" in
            --file) rerun_option_check $# $1; FILE=$2 ; shift ;;
            --compress) rerun_option_check $# $1; COMPRESS=$2 ; shift ;;
            --tstamp-format) rerun_option_check $# $1; TSTAMP_FORMAT=$2 ; shift ;;
            # help option
            -|--*?)
                rerun_option_usage
                exit 2
                ;;
            # end of options, just arguments left
            *)
              break
        esac
        shift
    done

    # Set defaultable options.
    [ -z "$COMPRESS" ] && COMPRESS="$(rerun_property_get $RERUN_MODULE_DIR/options/compress DEFAULT)"
    [ -z "$TSTAMP_FORMAT" ] && TSTAMP_FORMAT="$(rerun_property_get $RERUN_MODULE_DIR/options/tstamp-format DEFAULT)"
    # Check required options are set
    [ -z "$FILE" ] && { echo >&2 "missing required option: --file" ; return 2 ; }
    [ -z "$TSTAMP_FORMAT" ] && { echo >&2 "missing required option: --tstamp-format" ; return 2 ; }
    # If option variables are declared exportable, export them.

    #
    return 0
}


# If not already set, initialize the options variables to null.
: ${FILE:=}
: ${COMPRESS:=}
: ${TSTAMP_FORMAT:=}


