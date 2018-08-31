class Enigma::Smudge < LuckyCli::Task
  banner "Task used for git smudge on checkout (decrypt)"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA smudge"
    STDERR.puts "ENIGMA SMUDDDDGG"
    contents = STDIN.gets.to_s.chomp
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    puts String.new(encryptor.verify_and_decrypt(contents))
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end
end
