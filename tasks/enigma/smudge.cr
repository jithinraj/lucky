class Enigma::Smudge < LuckyCli::Task
  banner "Task used for git smudge on checkout (decrypt)"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA smudge"
    filename = ARGV.first
    contents = File.read(filename)
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    puts encryptor.verify_and_decrypt(contents).to_s
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end
end
