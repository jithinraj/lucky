# https://www.juandebravo.com/2017/12/02/git-filter-smudge-and-clean
class Enigma::Clean < LuckyCli::Task
  banner "Task used for git clean on checkin (file encryption)"

  def call
    pp! ARGV.inspect
    puts "ENIGMA encrypt file: #{ARGV.first}"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
