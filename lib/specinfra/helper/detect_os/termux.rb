class Specinfra::Helper::DetectOs::Termux < Specinfra::Helper::DetectOs
  def detect
    if run_command('test -d /data/data/com.termux/files/usr').success? &&
       run_command('command -v pkg >/dev/null 2>&1').success?
      release = nil

      if (termux_tools = run_command("dpkg-query -f '${Version}' -W termux-tools")) && termux_tools.success?
        release = termux_tools.stdout.strip
      elsif (termux_version = run_command('echo $TERMUX_VERSION')) && termux_version.success? &&
            termux_version.stdout =~ /([\d\.]+)/
        release = ::Regexp.last_match(1)
      end

      { :family => 'termux', :release => release }
    end
  end
end
