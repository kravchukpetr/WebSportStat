import ParseResultsLib as prl
import os

fname = os.path.dirname(os.path.realpath(__file__)).replace("\\","/") + '/' + 'DB.config'
log_dir = os.path.dirname(os.path.realpath(__file__)).replace("\\","/")
WF_ID = 2

prl.ParseResultsDaily(fname, log_dir, WF_ID, 0)