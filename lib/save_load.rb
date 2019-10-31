module SaveLoad
  def select_slot(saves, reason)
    slot = nil
    until slot&.between?(0, 2)
      system 'clear'
      display_saves(saves)
      puts
      puts "Invalid entry\n" if slot
      puts "Which file would you like to #{reason}?"
      slot = gets.to_i - 1
    end

    slot
  end

  def create_savefile
    return if File.exist?('savefile')

    saves = []
    3.times do
      saves << { 'created' => '',
                 'hint' => [],
                 'misses' => [],
                 'data' => nil }
    end
    write_savefile(saves)
  end

  # Expects array of save hashes with serialized data: @game
  def write_savefile(saves)
    File.open('savefile', 'w') { |f| f.write saves.to_msgpack }
  end

  # Returns an array of save hashes with serialized data: @game
  def read_savefile
    file = MessagePack.unpack(File.open('savefile', 'r', &:read))
    file
  end

  # Expects array of save hashes with serialized data: @game
  def display_saves(saves)
    saves.each_with_index do |save, index|
      puts "#{index + 1}) Created: #{save['created']}"
      puts "   Hint: #{save['hint'].join(' ')}"
      puts "   Misses: #{save['misses'].join(' ')}"
      puts
    end
  end

  def pack_save(game)
    save = { 'created' => DateTime.now.strftime('%F %H:%M'),
             'hint' => game.hint,
             'misses' => game.bad_letters }

    save['data'] = game.data.to_msgpack

    save
  end

  # Expects a save hash with serialized data: @game
  def unpack_save(save)
    MessagePack.unpack(save['data']) unless save['data'].nil?
  end
end
