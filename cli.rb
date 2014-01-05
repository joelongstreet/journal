#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'
require_relative 'actions.rb'

say "Preparing journal... \n\n"
mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')

if ARGV[0] == 'read'
  Actions.read entries
else
  Actions.write entries
end
