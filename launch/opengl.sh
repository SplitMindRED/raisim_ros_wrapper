#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${SCRIPT_DIR}
./../raisimLib/raisimUnityOpengl/linux/raisimUnity.x86_64

exit 0
