class Enigma::Smudge < LuckyCli::Task
  banner "Task used for smudge (Fill in decrypt/encrypt) later"

  def call
    puts "ENIGMA smudge"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
