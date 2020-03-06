#!/usr/bin/env bash
#######################################################################
#
# Generate new lab from template
#
#######################################################################
set -e

function help {
# Display helping message
cat <<EOF
usage: $0 [<args>]

Setup a new lab from existing templates

Arguments:
    --template          the template to use (default to base)
    --lab-group         the destination group to host the lab (oslo.labs, oslo.cache...)
                        Must exist before usage.
                        (master, stein, rocky, queens, etc...)(default=master)
    -l, --list          list available templates and exit
    -d, --debug         Turn on the debug mode
    -h, --help          show this help message and exit
examples:
    $0 --template=oslo-example --lab-group=oslo.cache
EOF
}

TEMPLATE_DIR=templates
TEMPLATE_BASE=${TEMPLATE_DIR}/base
TEMPLATE=${TEMPLATE_BASE}
BASE_LABS_PATH=$(dirname "$0")/labs
LAB_GROUP=oslo.labs
# Parse command line user inputs
for i in "$@"
do
    case $i in
        # Turn on the debug mode
        -d|--debug)
        set -x
        shift 1
        ;;
        # The template to use
        --template=*)
        TEMPLATE="${i#*=}"
        if [ ! -d "${TEMPLATE_DIR}/${TEMPLATE}"]; then
            echo "Template not found (${TEMPLATE})..."
            help
            exit 1
        fi
        TEMPLATE=${TEMPLATE_DIR}/${TEMPLATE}
        shift 1
        ;;
        # The labs category to use
        --lab-group=*)
        LAB_GROUP="${i#*=}"
        if [ ! -d "${BASE_LABS_PATH}/${LAB_GROUP}"]; then
            echo "Group not found (${LAB_GROUP})..."
            help
            exit 1
        fi
        shift 1
        ;;
        # Turn on the debug mode
        -l|--list)
        for dir in $(ls ${TEMPLATE_DIR});
        do
            echo ${dir}
        done
        exit 0
        ;;
        # Display the helping message
        -h|--help)
        help
        exit 0
        ;;
    esac
done

if [ -z $1 ]; then
    echo "Template name is mandatory"
    exit 1
fi
NAME=$1



cp -r ${TEMPLATE} ${BASE_LABS_PATH}/${LAB_GROUP}/${NAME}
echo "=============================================================="
echo "New lab successfully initialized from template!"
echo "=============================================================="
echo "Start your lab by using:"
echo -e "\t./run.sh ${LAB_GROUP}/${NAME}"
echo "=============================================================="
