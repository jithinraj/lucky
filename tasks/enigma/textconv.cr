class Enigma::Textconv < LuckyCli::Task
  banner "Task used for textconv"

  def call
    puts "ENIGMA textconv"
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
