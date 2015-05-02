Feeling overwhelmed by complexity of Puppet, Chef, Ansible or other server configuration
tools?

Scared of complex and possibly buggy software, that might become an attack vector?

Manage many different servers for many different customers, where storing passwords etc.
in single repository for all customers is not an option?

Great. Me too.


Me and my company manage many servers with high-risk confidential data (mostly medical)
and simply can't manage them via Puppet/Chef, at least via single Puppet/Chef instance
shared between customers. And having multiple instances of such software is expensive.

Also, Puppet is production ready since 2011, and Chef since 2013.

Farmer was used semi-commercially since 2008, and proving its usefulness, was released
in 2015 as open source.


# Advantages over Puppet, Chef etc.

1. Featherweight.
2. No customer passwords, private keys etc. in repository. All customer-specific or
machine-specific configuration done by runtime dialogs, so base Farmer can be easily
deployed everywhere.
3. Diff friendly: all configuration templates based on default configuration files
from each Linux distribution, therefore it's easy to track changes.
4. Tight integration with Cacti monitoring software.


# Supported operating systems

Farmer was built around Debian/Ubuntu Linux. It currently supports:

- Debian 4.x (Etch)
- Debian 5.x (Lenny)
- Debian 6.x (Squeeze)
- **Debian 7.x (Wheezy)**
- **Debian 8.x (Jessie) - current as of 2015**
- Ubuntu 9.04 (Jaunty Jackalope)
- Ubuntu 10.04 LTS (Lucid Lynx)
- Ubuntu 10.10 (Maverick Meerkat)
- Oracle Linux 6.3 (also Red Hat Enterprise Linux 6.3 and CentOS 6.3)
- CentOS 6.6 (will also work at least from 6.3)
- CentOS 6.x cPanel edition (at least from 6.3 up to 6.6)
- **CentOS 7.1**


# Adding support for new OS/distro

Support for more distributions can ba added very easily. To do it yourself, look at
latest dist subdirectory:

- dist/debian-jessie for Debian-based distributions
- dist/redhat-centos71 for Red Hat-based distributions

Each subdirectory contains set of configuration files taken from distribution's
/etc directory, with our patches applied. Now create and install two small virtual
machines:

- first with supported distribution, e.g. Debian Jessie
- second with your new distribution

On first VM you can view exact differences between default configuration files
and ones from repository, by running e.g.:

```
diff -u /etc/postfix/main.cf /opt/farm/dist/debian-jessie/postfix.tpl
```

On second VM you can replicate these changes. Note that you don't have to add
all files for all services. If you don't want to configura Postfix on your
distribution, just don't add postfix.tpl file. That's all.


# Owner-specific data

Farmer repository contains no customer passwords, private keys etc. However it
contains sensitive files related to the owner (Tomasz Klim or Klim Baron Business
Solutions Sp. z o.o.). If you want to fork this repository, you probably will
want to change them:

- grep for "tomaszklim.pl" and replace it with other domain with **enabled catch-all**
- scripts/setup/backup.sh - ssh public keys
- common/backup.pub - gpg key used to encrypt all backups
- common/standby.conf - list of standby devices
- dist/*/snmpd.tpl, scripts/cacti/send.sh, scripts/setup/monitoring.sh - Cacti addresses


# Commercial support

You can buy commercial support at http://fajne.it

We can help you adjust Farmer to your needs, or we can manage your servers for
you (including 24/7 telephone support and monitoring).
