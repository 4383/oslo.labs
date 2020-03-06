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

Deploy openstack by using brucejr

Arguments:
    --host              the host to deploy on
    -r, --release       the openstack release to deploy
                        (master, stein, rocky, queens, etc...)(default=master)
    -s, --scenario      the scenario to use
                        (simple, upgrade, iha, etc...)(default=simple)
    -d, --debug         Turn on the debug mode
    -h, --help          show this help message and exit
examples:
    $0 --host=hab-100 --release=stein --scenario=upgrade
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
        GROUP_NAME=${LAB_GROUP}
        LAB_GROUP=${BASE_LABS_PATH}/${LAB_GROUP}
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
        # Turn on the debug mode
        -d|--debug)
        set -x
        shift 1
        ;;
        # Display the helping message
        -h|--help)
        help
        exit 0
        ;;
    esac
done

if [ -z $1 ]; then
do
    echo "Template name is mandatory"
    exit 1
done
NAME=$1

cp -r ${TEMPLATE} ${LAB_GROUP}
echo "=============================================================="
echo "New lab successfully initialized from template!"
echo "=============================================================="
echo "Start your lab by using:"
echo -e "\t./run.sh ${GROUP_NAME}/${NAME}"
echo "=============================================================="
