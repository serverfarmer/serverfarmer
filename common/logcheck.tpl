^\w{3} [ :0-9]{11} [._[:alnum:]-]+ /USR/SBIN/CRON\[[0-9]+\]: \(CRON\) error \(grandchild #[0-9]+ failed with exit status 1\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: error \(.*\) resolving '[0-9a-z.-]+/(A|AAAA|NS|DS|DNSKEY)/IN': [0-9.]+#53$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: (  )?validating @0x[0-9a-f]+: [0-9a-z.-]+ (NS|SOA): got insecure response; parent indicates it should be secure$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: (  )?validating @0x[0-9a-f]+: [0-9a-z.-]+ (A|AAAA|NS|DS|SOA|NSEC|NSEC3): no valid signature found$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: (  )?validating @0x[0-9a-f]+: [0-9a-z.-]+ DNSKEY: no valid signature found \(DS\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: (  )?validating @0x[0-9a-f]+: [0-9a-z.-]+ (DNSKEY|NSEC3): verify failed due to bad signature \(keyid=[0-9]+\): RRSIG has expired$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: (  )?validating @0x[0-9a-f]+: [0-9a-z.-]+ A: bad cache hit \([0-9a-z.-]+/DNSKEY\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: managed-keys-zone: No DNSKEY RRSIGs found for '\.': success$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: client [0-9.]+#[0-9]+ \([0-9a-z.-]+\): query \(cache\) '[0-9a-z.-]+/(A|AAAA|ANY)/IN' denied$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: clients-per-query (increased|decreased) to [0-9]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: message repeated [0-9]+ times: \[ success resolving '[0-9a-z.-]+/(A|AAAA)' \(in '[0-9a-z.-]+'\?\) after reducing the advertised EDNS UDP packet size to [0-9]+ octets\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: message repeated [0-9]+ times: \[ error \(.*\) resolving '[0-9a-z.-]+/A/IN': [0-9:]+#53\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: DNS format error from [0-9.]+#53 resolving [0-9a-z.-]+/AAAA for client [0-9.]+#[0-9]+: reply has no answer$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: Connection from UDP: \[[.0-9]{7,15}\]:[0-9]{4,5}->\[[.0-9]{7,15}\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: last message repeated [0-9]+ times$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: ipSystemStatsTable node ipSystemStatsOutFragOKs not implemented: skipping$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: subsystem request for sftp by user (hudson|jenkins)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: fatal: Read from socket failed: Connection reset by peer \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: fatal: no matching cipher found: client [-.@[:alnum:]]+ server [-.,@[:alnum:]]+ \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: Accepted publickey for [a-z0-9-]+ from [0-9.]+ port [0-9]+ ssh2: (RSA|DSA) [0-9a-f:]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: .* \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: message repeated [0-9]+ times: \[ Received disconnect from [0-9.]+: [0-9]+: .* \[preauth\]\]
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: message repeated [0-9]+ times: \[ Failed password for root from [0-9.]+ port [0-9]+ ssh2\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: PAM service\(sshd\) ignoring max retries; [0-9]+ > [0-9]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dhclient: DHCPREQUEST of [0-9.]+ on eth0 to [0-9.]+ port [0-9]+ \(xid=0x[0-9a-f]+\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ ntpdate\[[0-9]+\]: (adjust|step) time server [0-9.]{7,15} offset -?[0-9.]+ sec$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sSMTP\[[0-9]+\]: Sent mail for .* \([0-9]+ [0-9.]+ Bye\) uid=[0-9]+ username=[\._[:alnum:]-]+ outbytes=[0-9]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sSMTP\[[0-9]+\]: message repeated [0-9]+ times: \[ Sent mail for .* \([0-9]+ [0-9.]+ Bye\) uid=[0-9]+ username=[\._[:alnum:]-]+ outbytes=[0-9]+\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ /usr/sbin/irqbalance: irq [0-9]+ affinity_hint subset empty$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/smtpd\[[0-9]+\]: warning: hostname [0-9a-z.-]+ does not resolve to address [0-9.]+(: Name or service not known)?$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/discard\[[0-9]+\]: [0-9A-Z]+: to=<[a-z0-9\@.-]+>, (orig_to=<[a-z0-9\@.-]+>, )?relay=none, delay=[0-9.]+, delays=[0-9.]+/[0-9.]+/0/0, dsn=2\.0\.0, status=sent \([a-z0-9.]+\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_set_pch_fifo_underrun_reporting \[[0-9a-z]+\]\] \*ERROR\* uncleared pch fifo underrun on pch transcoder A$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_set_cpu_fifo_underrun_reporting \[[0-9a-z]+\]\] \*ERROR\* uncleared fifo underrun on pipe B$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_pch_fifo_underrun_irq_handler \[[0-9a-z]+\]\] \*ERROR\* PCH transcoder A FIFO underrun$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_cpu_fifo_underrun_irq_handler \[[0-9a-z]+\]\] \*ERROR\* CPU pipe B FIFO underrun$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] sound hdaudioC0D0: HDMI: ELD buf size is 0, force 128$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] sound hdaudioC0D0: HDMI: invalid ELD data byte 0$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ avahi-daemon\[[0-9]+\]: Invalid response packet from host [0-9a-f.:]+.$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ avahi-daemon\[[0-9]+\]: message repeated [0-9]+ times: \[ Invalid response packet from host [0-9a-f.:]+.\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dbus\[[0-9]+\]: \[system\] Activating service name='[0-9a-z.]+' \(using servicehelper\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dbus\[[0-9]+\]: \[system\] Successfully activated service '[0-9a-z.]+'$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ cron-apt: CRON-APT LINE: /usr/bin/apt-get -o quiet=1 dist-upgrade -d -y -o APT::Get::Show-Upgraded=true$
