#!/usr/bin/env ruby

require 'sensu-plugin/check/cli'

SVSTAT = '/usr/bin/svstat'
SVSTAT_REGEX = /.*: (up|down) \(pid (\d+)\) (\d+) seconds/

class CheckDaemontoolls < Sensu::Plugin::Check::CLI
  option :service_path,
         short: '-s',
         long: '--service-path PATH_TO_SERVICE',
         description: 'Path to service to check'
  option :warn_below_seconds,
         short: '-w',
         long: '--warn-below-seconds SECONDS',
         description: 'Issue a warn when the service has been up for less than this number of seconds',
         default: 120
  option :service_path,
         short: '-s',
         long: '--crit-below-seconds SECONDS',
         description: 'Issue a crit when the service has been up for less than this number of seconds',
         default: 30

  def run
    if config[:service_path]
      service_path = config[:service_path]
    else
      unknown 'No service specified'
    end

    check_service service_path config[:warn_below_seconds] config[:crit_below_seconds]
  end

  def check_service(service_path, warn_below_seconds, crit_below_seconds)
    status = `#{SVSTAT} #{service_path}`
    matchdata = status.match(SVSTAT_REGEX)
    status = matchdata[1]  # up/down
    pid = matchdata[2].to_i  # pid 12345780
    secs = matchdata[3].to_i  # 1234 seconds
    if status != 'up'
        critical "service is down"
    elsif secs < crit_below_seconds
        critical "crit it's not been up long"
    elsif secs < warn_below_seconds
        warning "warn it's not been up long"
    else
        ok "all good mista"
    end
  end
end
