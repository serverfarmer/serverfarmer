^\w{3} [ :0-9]{11} [._[:alnum:]-]+ /USR/SBIN/CRON\[[0-9]+\]: \(CRON\) error \(grandchild #[0-9]+ failed with exit status 1\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: validating @0x[0-9a-f]+: [0-9a-z.-]+ (A|AAAA): no valid signature found$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ named\[[0-9]+\]: error \(no valid RRSIG\) resolving '[0-9a-z.-]+/DS/IN': 8\.8\.8\.8#53$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: Connection from UDP: \[[.0-9]{7,15}\]:[0-9]{4,5}->\[[.0-9]{7,15}\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: last message repeated [0-9]+ times$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ snmpd\[[0-9]+\]: ipSystemStatsTable node ipSystemStatsOutFragOKs not implemented: skipping$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: fatal: Read from socket failed: Connection reset by peer \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: fatal: no matching cipher found: client [-.@[:alnum:]]+ server [-.,@[:alnum:]]+ \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: Accepted publickey for [a-z0-9-]+ from [0-9.]+ port [0-9]+ ssh2: (RSA|DSA) [0-9a-f:]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: disconnect \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: (Closed due to user request\.)? \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: com\.jcraft\.jsch\.JSchException: Auth fail \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: java\.net\.SocketTimeoutException: Read timed out \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: (error: )?Received disconnect from [0-9.]+: [0-9]+: Normal Shutdown, Thank you for playing \[preauth\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: message repeated [0-9]+ times: \[ Received disconnect from [0-9.]+: [0-9]+: Bye Bye \[preauth\]\]
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: message repeated [0-9]+ times: \[ Failed password for root from [0-9.]+ port [0-9]+ ssh2\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sshd\[[0-9]+\]: PAM service\(sshd\) ignoring max retries; [0-9]+ > [0-9]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dhclient: DHCPREQUEST of [0-9.]+ on eth0 to [0-9.]+ port [0-9]+ \(xid=0x[0-9a-f]+\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ ntpdate\[[0-9]+\]: (adjust|step) time server [0-9.]{7,15} offset -?[0-9.]+ sec$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sSMTP\[[0-9]+\]: Sent mail for .* \([0-9]+ [0-9.]+ Bye\) uid=[0-9]+ username=[\._[:alnum:]-]+ outbytes=[0-9]+$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ sSMTP\[[0-9]+\]: message repeated [0-9]+ times: \[ Sent mail for .* \([0-9]+ [0-9.]+ Bye\) uid=[0-9]+ username=[\._[:alnum:]-]+ outbytes=[0-9]+\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ /usr/sbin/irqbalance: irq [0-9]+ affinity_hint subset empty$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/smtp\[[0-9]+\]: certificate verification failed for smtp.gmail.com\[[0-9]+.[0-9]+.[0-9]+.[0-9]+\]:587: untrusted issuer /C=ZA/ST=Western Cape/L=Cape Town/O=Thawte Consulting cc/OU=Certification Services Division/CN=Thawte Premium Server CA/emailAddress=premium-server@thawte.com$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/smtp\[[0-9]+\]: certificate verification failed for smtp.gmail.com\[[0-9]+.[0-9]+.[0-9]+.[0-9]+\]:587: untrusted issuer /C=US/O=Equifax/OU=Equifax Secure Certificate Authority$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/smtp\[[0-9]+\]: [a-zA-Z0-9]+: to=<[a-z0-9\@.-]+>, orig_to=<[a-z0-9\@.-]+>, relay=smtp.gmail.com\[[0-9]+.[0-9]+.[0-9]+.[0-9]+\]:587, delay=[0-9.]+, delays=[0-9.]+/[0-9.]+/[0-9.]+/[0-9.]+, dsn=4.7.1, status=deferred \(SASL authentication failed; server smtp.gmail.com\[[0-9]+.[0-9]+.[0-9]+.[0-9]+\] said: 535-5.7.1 Username and Password not accepted. Learn more at                   \?535 5.7.1 http://mail.google.com/support/bin/answer.py\?answer=14257 [a-z0-9.]+\)
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/error\[[0-9]+\]: [a-zA-Z0-9]+: to=<[a-z0-9\@.-]+>, (orig_to=<[a-z0-9\@.-]+>, )?relay=none, delay=[0-9.]+, delays=[0-9.]+/[0-9.]+/[0-9.]+/[0-9.]+, dsn=4.7.1, status=deferred \(delivery temporarily suspended: SASL authentication failed; server smtp.gmail.com\[[0-9]+.[0-9]+.[0-9]+.[0-9]+\] said: 535-5.7.1 Username and Password not accepted. Learn more at                   \?535 5.7.1 http://mail.google.com/support/bin/answer.py\?answer=14257 [a-z0-9.]+\)
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ postfix/discard\[[0-9]+\]: [0-9A-Z]+: to=<[a-z0-9\@.-]+>, (orig_to=<[a-z0-9\@.-]+>, )?relay=none, delay=[0-9.]+, delays=[0-9.]+/[0-9.]+/0/0, dsn=2\.0\.0, status=sent \([a-z0-9.]+\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_set_pch_fifo_underrun_reporting \[[0-9a-z]+\]\] \*ERROR\* uncleared pch fifo underrun on pch transcoder A$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_set_cpu_fifo_underrun_reporting \[[0-9a-z]+\]\] \*ERROR\* uncleared fifo underrun on pipe B$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_pch_fifo_underrun_irq_handler \[[0-9a-z]+\]\] \*ERROR\* PCH transcoder A FIFO underrun$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ kernel: \[[ .0-9]+\] \[drm:intel_cpu_fifo_underrun_irq_handler \[[0-9a-z]+\]\] \*ERROR\* CPU pipe B FIFO underrun$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ avahi-daemon\[[0-9]+\]: Invalid response packet from host [0-9a-f.:]+.$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ avahi-daemon\[[0-9]+\]: message repeated [0-9]+ times: \[ Invalid response packet from host [0-9a-f.:]+.\]$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dbus\[[0-9]+\]: \[system\] Activating service name='[0-9a-z.]+' \(using servicehelper\)$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ dbus\[[0-9]+\]: \[system\] Successfully activated service '[0-9a-z.]+'$
^\w{3} [ :0-9]{11} [._[:alnum:]-]+ cron-apt: CRON-APT LINE: /usr/bin/apt-get -o quiet=1 dist-upgrade -d -y -o APT::Get::Show-Upgraded=true$
