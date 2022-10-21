#!/bin/bash


TPMS () {
	
	###########################-DEFINE FUNCTIONS-#############################
	
	TPMS_ALERT () {
		
		
		
		

		source dev-shell-essentials/dev-shell-essentials.sh
		echo ''
		date
		echo ''

		###################-GET INPUT-######################

		#DUMP_FILE=$(zenity --file-selection --filename=$PWD)

		#zenity --text-info --filename=$DUMP_FILE --editable | egrep 'time|model|id |ID|pressure|Pressure' | highlight blue 'id' | highlight blue 'ID' | highlight yellow 'time' | highlight red 'model' | highlight green 'pressure' | highlight green 'Pressure'

		BLACK_LIST=$(zenity --entry --text='Enter TPMS ID.')
		
		FREQ_2=$(zenity --entry --text="Select Frequency In Hz." --entry-text='-f 315e6')		
		
		NOISE_LEVEL=$(zenity --entry --text='Enter minimum level to detect in db.' --entry-text='-Y minlevel=-0.5')



		#################-BEGIN WHILE LOOP-######################

		while :
		do

			####################-INITIALIZE LISTENER-############################
			
			CMD_OUT=$(rtl_433 -v -M level -C si -R 89 -R 90 -R 93 -R 82 -R 59 -R 60 -R 88 -R 95 -R 110 -R 123 -R 156 -R 168 -R 64 -R 93 -R 140 $FREQ_2 $NOISE_LEVEL -T 20)

			if [[ "$CMD_OUT" =~ "$BLACK_LIST" ]];
			then
			
				##############-ALERT ACTION-#################
				
				echo -e '\n\-----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight green '-'
				play SOUNDS/gqrx_20221012_004616_101100000.wav

				
			else
				
				#####################-DEFUALT ACTION-########################
				
				echo -e '\n\n----------------------------------------------------------------------------------------------------------------------------------------\n\n' | highlight red '-'
			fi
		done
	
	}

	TPMS_LIVEMON () {
		
		FREQ_1=$(zenity --entry --text='Select Frequency In Hz.' --entry-text='-f 315e6')
		LEVEL_2=$(zenity --entry --text='Enter minimum level to detect in db.' --entry-text='-Y minlevel=-0.5')
		rtl_433 -v -M level -C si -R 89 -R 90 -R 93 -R 82 -R 59 -R 60 -R 88 -R 95 -R 110 -R 123 -R 156 -R 168 -R 64 -R 93 $FREQ_1 $LEVEL_2
		
		
		}
				
	TPMS_REC () {
		
		FREQ_2=$(zenity --entry --text='Select Frequency In Hz.' --entry-text='-f 315e6')
		rtl_433 -v -M level -C si -R 89 -R 90 -R 93 -R 82 -R 59 -R 60 -R 88 -R 95 -R 110 -R 123 -R 156 -R 168 -R 64 -R 93 $FREQ_2 >> DUMP-FILES/TPMS-DUMP.txt
		
		
		}
		
	TPMS_FOLDER () {
		
		roxterm -d ~/app/TPMS
		exit
		
		
		
		}	
	
	
	
	############################-SELECT MODE-################################

	OPT_SELECT_TPMS=$(zenity --list --title='Chose An Option' --column='Option' --column='Name' 1 'Live Moniter' 2 'Set Alerts' 3 'Record To File' 4 'Open Folder') 
	
	if [ $OPT_SELECT_TPMS = '1' ];
	then
		TPMS_LIVEMON

		
	elif [ $OPT_SELECT_TPMS = '2' ];
	then
		TPMS_ALERT
		
		
	elif [ $OPT_SELECT_TPMS = '3' ];
	then
	
		TPMS_REC
		
	elif [ $OPT_SELECT_TPMS = '4' ];
	then
		TPMS_FOLDER
		
	
		
	fi


}

PAGER () {
	
	PAGER_SEARCH () {
		
		
		
		source dev-shell-essentials/dev-shell-essentials.sh
		
		NAME=$(whoami)
		
		SEARCH_FILE=$(zenity --file-selection --filename='/home/monitor/app/DUMP-FILES/PAGER-DUMP.txt' --text='Select dump file')
		
		SEARCH_TERM=$(zenity --entry --text='Enter search term. ' )
		CONTEXT_B=$(zenity --entry --text='Enter context lines before' )
		CONTEXT_A=$(zenity --entry --text='Enter context lines after' )

		egrep -i -B $CONTEXT_B -A $CONTEXT_A $SEARCH_TERM $SEARCH_FILE | highlight magenta $SEARCH_TERM |highlight green '\[.........\]'| highlight green '\[..........\]' | highlight cyan 'FLEX' | highlight blue 'ALN' | highlight blue 'NUM ' | highlight blue 'TON' | highlight blue '-' | highlight blue ':' | highlight red 'Msg' | highlight red 'Subj' | highlight yellow 'SMS' | highlight yellow 'google' | highlight yellow 'Google' | highlight  magenta 'UNK' | highlight blue '[/]' | highlight blue '[.]' | highlight blue '_' > temp-dump.txt
		 
		
		terminator -e 'cat temp-dump.txt && sleep 99999999999999'
		
		PAGER_SEARCH
		
		
		}
		
		
	PAGER_LIVEMON () {
		
		zenity --info --no-wrap --text='           Start gqrx and turn on UDP streaming before continuing           '
		source dev-shell-essentials/dev-shell-essentials.sh
		nc -l -u localhost 7355 | sox -t raw -esigned-integer -b 16 -r 48000 - -esigned-integer -b 16 -r 22050 -t raw - | multimon-ng -t raw -a FLEX -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha - | highlight green '\[' | highlight green '\]' | highlight cyan 'FLEX' | highlight blue 'ALN' | highlight blue 'NUM ' | highlight blue 'TON' | highlight blue '-' | highlight blue ':' | highlight red 'Msg*' | highlight red 'Subj' | highlight yellow 'SMS' | highlight yellow 'google' | highlight yellow 'Google' | highlight  magenta 'UNK' | highlight blue '[/]' | highlight blue '[.]' | highlight blue '_'

		
		
		}
		
		
	PAGER_REC () {
		
		zenity --info --no-wrap --text='            Start gqrx and turn on UDP streaming before continuing.      '
		nc -l -u localhost 7355 | sox -t raw -esigned-integer -b 16 -r 48000 - -esigned-integer -b 16 -r 22050 -t raw - | multimon-ng -t raw -a FLEX -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha - >> DUMP-FILES/PAGER-DUMP.txt
		
		
		
		}
	
	OPEN_P_FOLDER () {
		
		roxterm -d ~/app/PAGER
		exit
		
		}
	
	##################-FUNC INIT-###########################
	
	############################-SELECT MODE-################################
		
		
	#zenity --info --text='         1 Live Intercept.    2 Search DB.    3 Record Pager data to file.          ' --no-wrap

	OPT_SELECT_PAGER=$(zenity --list --title='Chose An Option' --column='Option' --column='Name' 1 'Live Monitor' 2 'Search DB' 3 'Record' 4 'Open Folder') 
	
	if [ $OPT_SELECT_PAGER = '1' ];
	then
		PAGER_LIVEMON

		
	elif [ $OPT_SELECT_PAGER = '2' ];
	then
		PAGER_SEARCH
		
		
	elif [ $OPT_SELECT_PAGER = '3' ];
	then
		PAGER_REC
		
	elif [ $OPT_SELECT_PAGER = '4' ];
	then
		OPEN_P_FOLDER
		
	fi
	
	########################################################
	
}

ADS_B () {
	
	ADS_B_LIVEMON () {


		zenity --info --text='         Open Your Browser And Go to:      http://localhost:8080/           ' --no-wrap
		cd ADS-B/dump1090
		./dump1090 --interactive --net --net-http-port 8080

		
		
		}
	
	ADS_B_ONLINE () {
		
		firefox https://www.flightradar24.com/
		
		
		}
	
	ADS_B_DUMP () {
		
		cd ADS-B/dump1090
		./dump1090 >> /home/monitor/app/DUMP-FILES/ADS-B-DUMP.txt
		
		
		}
		
		
		
	
	#zenity --info --text='            1 Live ADS-B Moniter.    2 Flight Radar Online.    3 Record ADS-B data to file.             ' --no-wrap

	#OPT_SELECT_TPMS=$(zenity --entry --text='Select an option. ')
	
	OPT_SELECT_TPMS=$(zenity --list --title='Chose An Option' --column='Option' --column='Name' 1 LiveMon 2 Online 3 Record)
	
	if [ $OPT_SELECT_TPMS = '1' ];
	then
		ADS_B_LIVEMON

		
	elif [ $OPT_SELECT_TPMS = '2' ];
	then
		ADS_B_ONLINE
		
		
	else [ $OPT_SELECT_TPMS = '3' ];
	
		ADS_B_DUMP
		
	fi
		
	
	}

DIGI_VOICE () {

	cd sdrtrunk/
	cd bin/
	./sdr-trunk
	cd ../..
	
	
	}

REFRENCE () {
	
	ASK_REF=$(zenity --question --text='Would you like to see refrences?' --no-wrap)
	RET_VAL=$?
	if [ $RET_VAL = 0 ];
	then
		open ~/app/REFRENCES
	fi
	
	}





#############-MAIN MENU-#############


#MAIN_SELECT=$(zenity --entry --text='   Chose An Option:   TPMS,   PAGER,   TRUNKED,   ADSB,   REFRENCE.   ')

MAIN_SELECT=$(zenity --list --radiolist --title="Choose An Option" --column="Choose" --column="Description" 1 Tpms 2 Pager 3 ADSB 4 Trunked 5 Refrence)


if [ ${MAIN_SELECT^^} = 'TPMS' ];
then
	TPMS
	
	zenity --question --text="         Would you like to exit?          " --no-wrap
	EXIT=$?
	if [ $EXIT = 1 ];
	then
		./app.sh
		pwd
	fi
	
elif [ ${MAIN_SELECT^^} = 'PAGER' ];
then
	PAGER
	
	zenity --question --text="        Would you like to exit?          " --no-wrap
	EXIT=$?
	if [ $EXIT = 1 ];
	then
		./app.sh
		pwd
	fi
	
elif [ ${MAIN_SELECT^^} = 'ADSB' ];
then
	ADS_B
	
	zenity --question --text="         Would you like to exit?         " --no-wrap
	EXIT=$?
	if [ $EXIT = 1 ];
	then
		./app.sh
		pwd
	fi
	


elif [ ${MAIN_SELECT^^} = 'TRUNKED' ];
then
	DIGI_VOICE
	
	zenity --question --text="         Would you like to exit?          " --no-wrap
	EXIT=$?
	if [ $EXIT = 1 ];
	then
		./app.sh
		pwd
	fi
	
	
elif [ ${MAIN_SELECT^^} = 'REFRENCE' ];
then
	REFRENCE
	
	zenity --question --text="         Would you like to exit?          " --no-wrap
	EXIT=$?
	if [ $EXIT = 1 ];
	then
		./app.sh
		pwd
	fi



else
	zenity --warning --text='           Invalid Input             ' --no-wrap
	./app.sh
fi

#####################################
































