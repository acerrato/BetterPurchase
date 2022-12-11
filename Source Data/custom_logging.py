import logging
import csv
import sys


def do_stuff():
    x=2

    logging.debug(f"The value of x is {x}")
    logging.info(f"Sucessfully Completed step 1") #TODO: maybe a custom handler for state vs general logs   
    logging.info(f"Sucessfully Completed step 2")
    logging.info(f"Sucessfully Completed step 3")



    try:
        1/0
    except Exception as e:
        #logging.error(type(e), exc_info=True)
        logging.exception(type(e))

#Log in INFO completed steps


# Levels:
#     Debug
#     Info
#     WarningError
#     Critical

def getLastState():
    with open('generate_data_log.log') as csv_file:
        csv_reader = csv.reader(csv_file, delimiter=',')
        last_Step = 0
        for row in csv_reader:
            if row[0].split()[0] == 'INFO':
                last_Step = row[0].split(' - ')[1][-1]
    return int(last_Step)

if __name__ =='__main__':
    last_state = 0
    if 'resume' in [x.lower() for x in sys.argv]:
        logging.basicConfig(level=logging.DEBUG, filename='generate_data_log.log',filemode="a",
                    format="%(levelname)s - %(message)s - %(asctime)s")
        try:
            last_state = getLastState()
        except Exception:
            pass #logging.exception("Error while attempting to retrieve last state from log file.")
    
        logging.debug("Resuming from step {}".format(last_state))
    else:
        logging.basicConfig(level=logging.DEBUG, filename='generate_data_log.log',filemode="w",
                    format="%(levelname)s - %(message)s - %(asctime)s")
        
    if last_state == 0:
        pass
    elif last_state == 1:
        pass
    elif last_state == 2:
        pass
    elif last_state == 3:
        pass
    else:
        logging.debug("No last state found. Starting from beginning")
    
    do_stuff()
    
    #TODO: Add an archive function for the current log after a sucessful run
    

    