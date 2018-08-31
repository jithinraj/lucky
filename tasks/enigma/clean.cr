class Enigma::Clean < LuckyCli::Task
  banner "Task used for clean (Fill in decrypt/encrypt) later"

  def call
    puts "ENIGMA CLEAN"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
