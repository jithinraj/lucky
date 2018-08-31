class Enigma::Raw < LuckyCli::Task
  banner "List files being encrypted by Enigma"

  def call
    # TODO: Check if files is being encypted using Engima::List

    # TODO: Check if committed
    # git ls-tree --name-only --full-name HEAD config/encrypted/encrypted.cr

    # Show raw file
    file_path = ARGV.first? || display_error
    puts `git --no-pager show HEAD:"#{ARGV.first}"`
  end

  private def display_error
    puts "Must pass in a file path".colorize.red
    exit
  end
end
