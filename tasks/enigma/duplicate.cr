class Enigma::Uninstall < LuckyCli::Task
  banner "Uninstall Enigma"

  # TODO: Generate a super secret key
  def call(key : String = generate_key, io : IO = STDOUT)
    puts "Uninstalling enigma"

    # TODO remove lines from .gitattributes that used enigma

    ([Enigma::Setup::GIT_CONFIG_PATH_TO_KEY] + Enigma::Setup::GIT_CONFIG.keys).each do |key|
      run %(git config --unset #{key})
    end

    puts "Uninstalled"
  end

  private def run(command, io = STDOUT)
    Process.run(command, shell: true, output: io, error: STDERR)
  end
end
