class Enigma::Smudge < LuckyCli::Task
  banner "Task used for git smudge on checkout (decrypt)"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA smudge"
    contents = STDIN.to_s
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    p encryptor.verify_and_decrypt(contents)
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
