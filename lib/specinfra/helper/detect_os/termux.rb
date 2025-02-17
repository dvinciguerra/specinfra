class Specinfra::Helper::DetectOs::Termux < Specinfra::Helper::DetectOs
  def detect
    if (termux_version = run_command('echo $TERMUX_VERSION')) && termux_version.success?
      distro = nil

      if (pkg_found = run_command('file /data/data/com.termux/files/usr/bin/pkg')) && pkg_found.success?
        distro ||= 'termux'
      end

      if termux_version.stdout =~ /([\d\.]+)/
        { family: distro, release: ::Regexp.last_match(1) }
      else
        { family: distro, release: nil }
      end
    end
  end
end
