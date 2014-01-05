#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'

say "Preparing journal... \n\n"
mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')

if ARGV[0] == 'read'
  require_relative 'lib/read.rb'
else
  require_relative 'lib/write.rb'
end
