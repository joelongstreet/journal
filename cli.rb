#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'
require 'trollop'
require_relative 'actions.rb'

mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')

opts = Trollop::options do
  opt :read, "read the most recent entries from your journal"
  opt :search, "text search through your entire journal", :type => :string
  opt :tagged, "find journal entries which match a tag", :type => :string
end


say "Preparing journal... \n\n"

case
when opts.read
  Actions.read entries
when opts.search
  Actions.search opts.search
when opts.tagged
  Actions.tagged opts.tagged
else
  Actions.write entries
end