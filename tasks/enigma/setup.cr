# https://git-scm.com/docs/gitattributes
class Enigma::Setup < LuckyCli::Task
  GIT_CONFIG_PATH_TO_KEY = "lucky.enigma.key"
  GIT_CONFIG             = {
    "filter.enigma.clean"    => "lucky enigma.clean %f",
    "filter.engima.smudge"   => "lucky enigma.smudge",
    "diff.enigma.textconv"   => "lucky enigma.textconv",
    "filter.enigma.required" => "true",
    "diff.enigma.binary"     => "true",
    # To prevent these unnecessary merge conflicts, Git can be told to run a
    # virtual check-out and check-in of all three stages of a file when
    # resolving a three-way merge by setting the merge.renormalize
    # configuration variable. This prevents changes caused by check-in
    # conversion from causing spurious merge conflicts when a converted file is
    # merged with an unconverted file.
    "merge.renormalize" => "true",
  }

  banner "Setup encrypted configuration with Engima"

  def call(key : String = generate_key, io : IO = STDOUT)
    if not_installed_yet?
      run "git config --local #{GIT_CONFIG_PATH_TO_KEY} #{key}", io

      # TODO Only add top line
      # config/encrypted/* filter=crypt diff=crypt
      File.write ".gitattributes", <<-TEXT
      config/encrypted/* filter=enigma diff=enigma

      TEXT

      GIT_CONFIG.each do |key, value|
        run %(git config #{key} '#{value}')
      end

      puts "Enigma is set up."
    else
      puts "Enigma is already set up."
    end
  end

  private def run(command, io = STDOUT)
    Process.run(command, shell: true, output: io, error: STDERR)
  end

  private def not_installed_yet? : Bool
    key_from_git = `git config #{GIT_CONFIG_PATH_TO_KEY}`
    key_from_git.blank?
  end

  @_key : String?

  private def key : String
    @_key ||= `git config #{Enigma::Setup::GIT_CONFIG_PATH_TO_KEY}`
  end

  private def generate_key : String
    Random::Secure.base64(32)
  end
end
