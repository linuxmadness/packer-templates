module Support
  module Helpers
    def tcpwait(host, port, timeout = 10)
      require 'socket'

      now = Time.now

      loop do
        begin
          TCPSocket.new(host, port)
          break
        rescue Errno::ECONNREFUSED => e
          raise e if (Time.now - now >= timeout)
          sleep 0.1
        end
      end
    end

    def procwait(proc_pattern, timeout = 10)
      now = Time.now

      loop do
        procs = `ps aux`.split(/\n/).map(&:strip)
        break if procs.grep(proc_pattern).any?
        raise TimesUp if (Time.now - now >= timeout)
        sleep 0.1
      end
    end

    TimesUp = Class.new(StandardError)
  end
end
