#!/bin/bash

TPMS () {
	source ../dev-shell-essentials/dev-shell-essentials.sh
	echo ''
	date
	echo ''

	###################-GET INPUT-######################

	DUMP_FILE=$(zenity --file-selection --filename=$PWD)

	zenity --text-info --filename=$DUMP_FILE --editable | egrep 'time|model|id |ID|pressure' | highlight blue 'id' | highlight blue 'ID' | highlight yellow 'time' | highlight red 'model' | highlight green 'pressure'

	BLACK_LIST=$(zenity --entry --text='Enter TPMS ID.')

	zenity --info --no-wrap --text='Set decibels like:   -0.5'

	NOISE_LEVEL=$(zenity --entry --text='Enter minimum level to detect in db.')



	#################-BEGIN WHILE LOOP-######################

	while :
	do

		####################-INITIALIZE LISTENER-############################
		
		CMD_OUT=$(rtl_433 -v -M level -C si -R 89 -R 90 -R 93 -R 82 -R 59 -R 60 -R 88 -R 95 -R 110 -R 123 -R 156 -R 168 -R 64 -R 93 -R 140 -Y minlevel=$NOISE_LEVEL -T 20)

		if [[ "$CMD_OUT" =~ "$BLACK_LIST" ]];
		then
		
			##############-ALERT ACTION-#################
			
			echo -e '\n\-----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight green '-'
			play ../SOUNDS/gqrx_20221012_004616_101100000.wav

			
		else
			
			#####################-DEFUALT ACTION-########################
			
			echo -e '\n\n----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight red '-'
		fi
	done

}

ADS_B () {
		source ../dev-shell-essentials/dev-shell-essentials.sh
	echo ''
	date
	echo ''

	###################-GET INPUT-######################

	#DUMP_FILE=$(zenity --file-selection --filename=$PWD)

	#zenity --text-info --filename=$DUMP_FILE --editable | egrep 'time|model|id |ID' | highlight blue 'id' | highlight blue 'ID' | highlight yellow 'time' | highlight red 'model'

	BLACK_LIST=$(zenity --entry --text='Enter Tail Number or ICAO. ')

	#zenity --info --no-wrap --text='Set decibels like:   -0.5'

	#NOISE_LEVEL=$(zenity --entry --text='Enter minimum level to detect in db.')



	#################-BEGIN WHILE LOOP-######################

	while :
	do
	
		#####################-SET TIMER VARIABLES-###########################
		
		runtime="30 second"
		endtime=$(date -ud "$runtime" +%s)

		#########################-START TIMER-############################################
		
		cd ~/dump1090
		
		while [[ $(date -u +%s) -le $endtime ]]
		do
		
			
			CMD_OUT=$(./dump1090 --onlyaddr)
	
		done

		

		if [[ "$CMD_OUT" =~ "$BLACK_LIST" ]];
		then
		
			##############-ALERT ACTION-#################
			
			echo -e '\n\-----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight green '-'
			play ~/gqrx_20221012_004616_101100000.wav

			
		else
			
			#####################-DEFUALT ACTION-########################
			
			echo -e '\n\n----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight red '-'
		fi
	done
	
	
	
	
	
}

PAGER () {
	
	PAGER_SEARCH () {
		
		
		
		
		}
		
		
	PAGER_LIVEMON () {
		
		
		
		
		}
		
		
	PAGER_REC () {
		
		
		
		
		
		}
	
	
	
}
