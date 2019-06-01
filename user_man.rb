#encoding: utf-8

# 1) This file read all users information from pospal and update the database
# 2) Should be used before refund to make sure all CustomerUid is available
#

require 'json'
load 'user_api.rb'

##get_all_pospal_users will generate an json file under .\\auto_import\\, such as puser-20190601123011.json
#pusers = get_all_pospal_users

#pusers=JSON.parse IO.readlines(".\\auto_import\\pusers.json")[0]
#update_userdb pusers

p get_uid_by_number '136000600440'
