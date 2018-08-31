# https://www.juandebravo.com/2017/12/02/git-filter-smudge-and-clean
class Enigma::Clean < LuckyCli::Task
  banner "Task used for git clean on checkin (file encryption)"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA encrypt file: #{ARGV.first}"
    puts "ENIGMA ENCRYPT CLEAN"
    contents = STDIN.to_s
    puts "CONTENTS"
    puts contents
    filename = ARGV.first
    puts "FILENAME"
    puts filename
    contents = File.read(filename)
    puts encrypt(contents)
  rescue e
    puts e.inspect
    exit 1
  end

  private def encrypt(contents : String) : String
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    encryptor.encrypt_and_sign(contents)
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
