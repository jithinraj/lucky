# https://www.juandebravo.com/2017/12/02/git-filter-smudge-and-clean
class Enigma::Clean < LuckyCli::Task
  banner "Task used for git clean on checkin (file encryption)"

  def call
    # pp! ARGV.inspect
    # puts "ENIGMA encrypt file: #{ARGV.first}"
    puts "Key is: #{key}"
    contents = STDIN.gets_to_end
    puts encrypt(contents)
  end

  private def encrypt(contents : String) : String
    encryptor = Lucky::MessageEncryptor.new(secret: key)
    encryptor.encrypt_and_sign(contents)
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end
end
