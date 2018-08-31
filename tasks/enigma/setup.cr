class Enigma::Setup < LuckyCli::Task
  banner "Setup encrypted configuration with Engima"

  # TODO: Generate a super secret key
  def call(key : String = "", io : IO = STDOUT)
    run "git config lucky.enigma.key #{key}", io
  end

  private def run(command, io)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
