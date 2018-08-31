class Enigma::Smudge < LuckyCli::Task
  banner "Task used for git smudge on checkout (decrypt)"

  def call
    pp! ARGV.inspect
    puts "ENIGMA smudge"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
