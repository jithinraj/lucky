class Enigma::Textconv < LuckyCli::Task
  banner "Task used for textconv"

  def call
    contents = STDIN.to_s
    puts "CONTENTS"
    puts contents
    puts "FILENAME"
    puts filename
    contents = File.read(filename)
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    puts encryptor.verify_and_decrypt(contents).to_s
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
