module Actions
  def self.read(entries)
    puts 'read'
  end

  def self.write(entries)
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
  end
end