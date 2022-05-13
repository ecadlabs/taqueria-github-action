#!/bin/bash
echo "$2"
echo "$TASK_NAME"
if [ -z "$INPUT_PROJECT_NAME" ] && [ -z "$TASK_NAME" ];then
    echo "No project name or task name provided"
    exit 1
fi


PROJECT_DIR=$RUNNER_WORKSPACE/${GITHUB_REPOSITORY#*/}/$INPUT_PROJECT_NAME
# When the taq command is init
if [ "$TASK_NAME" == "init" ]; then
    taq -p "$INPUT_PROJECT_NAME" "$TASK_NAME"
    cd "$INPUT_PROJECT_NAME" || exit 1
    ls -la
    npm init -y
else
    echo "$PROJECT_DIR"
    taq -p "$INPUT_PROJECT_NAME" "$2"
fi