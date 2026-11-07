class Specinfra::Command::Termux::Base::Service < Specinfra::Command::Linux::Base::Service
  class << self
    def check_is_enabled(service, _level = nil)
      "test -e \"$PREFIX/var/service/#{escape(service)}\""
    end

    def check_is_running(service)
      "sv status #{escape(service)} | grep -q '^run:'"
    end

    def enable(service)
      "sv-enable #{escape(service)}"
    end

    def disable(service)
      "sv-disable #{escape(service)}"
    end

    def start(service)
      "sv up #{escape(service)}"
    end

    def stop(service)
      "sv down #{escape(service)}"
    end

    def restart(service)
      "sv restart #{escape(service)}"
    end

    def reload(service)
      "sv hup #{escape(service)}"
    end
  end
end
