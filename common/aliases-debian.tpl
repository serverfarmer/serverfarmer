# /etc/aliases
mailer-daemon: postmaster
postmaster: root
nobody: root
hostmaster: root
usenet: root
news: root
webmaster: root
www: root
ftp: root
abuse: root
noc: root
security: root
logcheck: root
root: %%host%%@tomaszklim.pl

# na ten alias maja byc wysylane wszystkie maile
# z crona - nalezy go dopisac do /etc/crontab
# i w crontabach poszczegolnych uzytkownikow
cron-rcpt: cron-%%host%%@tomaszklim.pl
