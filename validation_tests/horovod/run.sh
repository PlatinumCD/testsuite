#!/bin/bash
. ./setup.sh

TMPFILE=$(mktemp ./tmp.XXXXXXX)

BRED='\033[1;31m'
BGREEN='\033[1;32m'

NC='\033[0m'

if [ $(nvidia-smi >& /dev/null; echo $?) == 0 ]; then
    HARD=GPU
    BRAND=NVIDIA
elif [ $(rocminfo >& /dev/null; echo $?) == 0 ]; then
    HARD=GPU
    BRAND=AMD
else    
    HARD=CPU
    BRAND=NA
fi

#VERSION=$(python -c "import torch; print(torch.__version__ )"| grep -o '^[^.]')

echo "Running: python horovodTest.py $HARD $BRAND $VERSION"
mpirun -np 2 python horovodTest.py --HARD $HARD --BRAND $BRAND > $TMPFILE

if [ $? -ne 0 ]
then
  echo "The script failed" >&2
  exit 1
fi

echo $(grep -E "Total" $TMPFILE)

if [ $(grep "PASSED" $TMPFILE | wc -l) -ne 0 ]; then
    echo -e "${BGREEN}[PASSED]${NC}"
else
    echo -e "${BRED}[FAILED]${NC}"
fi

