#!/usr/bin/env ruby 

require 'highline/import'
require 'mongo'

say "Preparing journal... \n\n"
mongo_client = Mongo::MongoClient.from_uri(ENV['JOURNAL_MONGO_URI'])
db = mongo_client.db()
entries = db.collection('entries')

input_entry = ask "<%= color('What have you just learned? ', ON_BLACK ) %> "
input_tags  = ask "<%= color('Tags? ', ON_BLACK) %> "

tags = []
input_tags.split(',').each do |tag|
  tags.push tag.strip
end

journal_entry = {
  'entry' => input_entry,
  'tags'  => tags,
  'time'  => Time.now
}

say "\n ... saved"
entries.insert(journal_entry)