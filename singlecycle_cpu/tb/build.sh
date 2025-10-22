#!/bin/sh
#
# Compile and run the test bench

echo "---------------------------------------"
echo "---------------------------------------"
echo "---------------------------------------"
date

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