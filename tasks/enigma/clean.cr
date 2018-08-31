class Enigma::Clean < LuckyCli::Task
  banner "Task used for git clean (file decryption)"

  def call
    puts "ENIGMA decrypt file: #{ARGV.first}"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
