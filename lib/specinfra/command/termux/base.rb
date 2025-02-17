class Specinfra::Command::Termux::Base < Specinfra::Command::Base
  class << self
    def check_installed(package, _version = nil)
      "pkg list-installed | grep -q '^#{escape(package)} '"
    end

    def install(package)
      "pkg install -y #{escape(package)}"
    end

    def remove(package)
      "pkg uninstall -y #{escape(package)}"
    end

    def update
      'pkg update -y'
    end

    def upgrade
      'pkg upgrade -y'
    end

    def check_service_is_running(service)
      "ps aux | grep -v grep | grep -q '#{escape(service)}'"
    end
  end
end
