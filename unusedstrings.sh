#!/bin/bash

remove=0;

while getopts s:r: option
do
	case "${option}"
	in
		s) source=${OPTARG};;
		r) remove=${OPTARG};
	esac
done

# if source path is defined
if [ $source != '' ]; then
	# get .strings files from this directory
	echo "Searching for .strings files in \"$source\" - It may takes a while.";
	
	for filePath in $(find $source -name '*.strings'); do
		unusedStrings=();
		index=0;

		echo "Checking strings in \"$filePath\"";
		
		for singleString in $(grep -oh -E '^".+" =' $filePath); do
			singleString=$(echo $singleString | grep -oh -E '^".+"');
			length=$(echo ${#singleString})
			if [ $length -gt 0 ]; then
				count=$(grep -R --include="*.m" --include="*.mm" $singleString $source | wc -l);
				if [ $count -eq 0 ]; then
					unusedStrings[$index]=$singleString;
					index=$((index + 1));
				fi
			fi
		done
		
		if [ $index -gt 0 ]; then
			echo "Unused strings:";
			countDo=$((index - 1));
			for i in `seq 0 $countDo`; do
				singleString=${unusedStrings[$i]};	
				if [ $remove -eq 0 ]; then
					echo $singleString;
				else
					#
					d="d"; 
					copy="_copy";
					copyFile=$(echo $filePath$copy);
					
					#remove lines
					sed "/$singleString/$d" $filePath > $copyFile;
					if [ $? -ne 0 ]; then
						echo "$singleString cannot remove."
						continue
					fi
					mv $copyFile $filePath;
					rm -f $copyFile;
					echo "$singleString removed.";
				fi
			done
		else
			echo "No unused strings in $filePath";
		fi
		
		echo "Done.";
		echo "";
	done
else
 	echo "Source path not defined.";
fi
