require 'time'

module Actions
  def self.read(records)
    records.find().each do |record|
      parsed_time = Time.parse(record['time'])
      time = parsed_time.strftime("%A, %B %d %H:%M")
      say "<%= color('#{time}', ON_BLACK) %> #{record['entry']}"
    end
  end

  def self.search(term)
    msg = "searching your journal for entries containing "
    say "<%= color('#{msg}', ON_BLACK) %> <%= color('#{term}', BOLD) %>\n\n"
  end

  def self.tagged(tag)
    msg = "searching your journal for entries tagged "
    say "<%= color('#{msg}', ON_BLACK) %> <%= color('#{tag}', BOLD) %>\n\n"
  end

  def self.write(records)
    input_entry = ask "<%= color('What have you just learned? ', ON_BLACK ) %> "
    input_tags  = ask "<%= color('Tags? ', ON_BLACK) %> "

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
    records.insert(new_record)
  end
end