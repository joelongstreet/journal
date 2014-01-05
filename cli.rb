#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'

say "Preparing journal... \n\n"
mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')


input_entry = ask "What have you just learned?"
input_tags  = ask "Tags?"

tags = []
input_tags.split(',').each do |tag|
  tags.push tag.strip
end

journal_entry = {
  :entry  => input_entry,
  :tags   => tags,
  :time   => Time.now
}

entries.insert(journal_entry)