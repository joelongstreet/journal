require 'time'

module Journal
  def self.read(collection)
    print_records collection.find().sort('time')
  end

  def self.search(collection, term)
    msg = "searching your journal for entries containing "
    say "<%= color('#{msg}', REVERSE) %> <%= color('#{term}', BOLD) %>\n\n"
    print_records collection.find({ "entry" => Regexp.new(term) }).sort('time')
  end

  def self.tagged(collection, tag)
    msg = "searching your journal for entries tagged "
    say "<%= color('#{msg}', REVERSE) %> <%= color('#{tag}', BOLD) %>\n\n"
    print_records collection.find({ "tags" => tag }).sort('time')
  end

  def self.write(collection)
    input_entry = ask "<%= color('What have you just learned? ', REVERSE ) %> "
    input_tags  = ask "<%= color('Tags? ', REVERSE) %> "

    tags = []
    input_tags.split(',').each do |tag|
      tags.push tag.strip
    end

    new_record = {
      'entry' => input_entry,
      'tags'  => tags,
      'time'  => "#{Time.now}"
    }

    say "\n ... saved"
    collection.insert(new_record)
  end

  def self.print_records(records)
    records.each do |record|
      parsed_time = Time.parse(record['time'])
      time = parsed_time.strftime("%A, %B %d %H:%M")
      say "<%= color('#{time}', ON_BLACK) %> #{record['entry']}"
    end
  end
end