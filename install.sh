#!/bin/bash

REMOVE="false"
OPERANDS=()

for ARG in "$@"
do
    if [ "$ARG" == "-r" ]
    then
        REMOVE="true"
    else
        OPERANDS+=("$ARG")
    fi
done

for OPERAND in "${OPERANDS[@]}"
do
    if [ "$REMOVE" == "true" ]
    then
        sudo rm -i "/bin/$OPERAND"
    else
        sudo cp "src/$OPERAND.sh" "/bin/$OPERAND"
        sudo chmod +x "/bin/$OPERAND"
    fi
done
