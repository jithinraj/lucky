class Enigma::Textconv < LuckyCli::Task
  banner "Task used for textconv"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA smudge"
    contents = STDIN.gets_to_end.chomp
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    puts String.new(encryptor.verify_and_decrypt(contents))
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end
end
