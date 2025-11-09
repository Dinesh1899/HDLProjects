#!/bin/sh
#


echo "----------------------------------------------"
echo "----------------------------------------------"
echo "----------------------------------------------"

date

# Ensure build and logs directories exist, create them if missing
if [ -d build ]; then
    echo "Directory 'build' exists."
else
    echo "Directory 'build' not found. Creating 'build'..."
    if mkdir -p build; then
        echo "'build' created."
    else
        echo "Failed to create 'build'." >&2
        exit 1
    fi
fi

if [ -d logs ]; then
    echo "Directory 'logs' exists."
else
    echo "Directory 'logs' not found. Creating 'logs'..."
    if mkdir -p logs; then
        echo "'logs' created."
    else
        echo "Failed to create 'logs'." >&2
        exit 1
    fi
fi

# Compile and run the test bench

echo "----------------------------------------------"
echo "-----Compiling and running the test bench-----"
echo "----------------------------------------------"

[ -x "$(command -v iverilog)" ] || { echo "Install iverilog"; exit 1; }

# Clear out existing log file
rm -f cpu_tb.log 

file='tb_files.txt'

while read line; do
    #Reading each line.
    echo "\nUsing directory : $line"
    echo "Compiling sources"

    iverilog -DTESTDIR=\"$line\" -o cpu_tb.out -c program_file.txt
    if [ $? != 0 ]; then
        echo "*** Compilation error! Please fix."
        exit 1;
    fi
    ./cpu_tb.out
done < $file

retval=$(grep -c FAIL cpu_tb.log)
if [ $retval -eq 0 ];
then
    echo "Passed"
else
    echo "Failed $retval cases"
fi

mv *.out build
mv *.log logs

mv cpu_tb.vcd build

# if [ -f "myfile.txt" ]; then
#     mv cpu_tb.vcd build
# fi


exit $retval 

## ./run.sh >> cpu_tb_run.log 2>&1