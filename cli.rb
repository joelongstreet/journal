#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'
require 'trollop'
require_relative 'actions.rb'

mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')

opts = Trollop::options do
  version '0.0.1'
  banner 'sup'

  opt :read
end


say "Preparing journal... \n\n"

if opts.read
  Actions.read entries
else
  Actions.write entries
end