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

Server Farmer was used semi-commercially since 2008, and proving its usefulness, was
released in 2015 as open source.


# Advantages over Puppet, Chef etc.

1. Featherweight.
2. No customer passwords, private keys etc. in repository. All customer-specific or
machine-specific configuration done by runtime dialogs, so base Server Farmer can be
easily deployed everywhere.
3. Diff friendly: all configuration templates based on default configuration files
from each Linux distribution, therefore it's easy to track changes.
4. Tight integration with Cacti monitoring software.


# Market positioning

![Market positioning of Server Farmer, Puppet and Chef](https://raw.githubusercontent.com/tomaszklim/serverfarmer/master/common/positioning.png)


# Supported operating systems

Server Farmer was built around Debian/Ubuntu Linux. It currently supports:

- Debian-based distributions:
  - Debian 4.x (Etch)
  - Debian 5.x (Lenny)
  - Debian 6.x (Squeeze)
  - **Debian 7.x (Wheezy)**
  - **Debian 8.x (Jessie) - current as of 2015**
  - Ubuntu 8.04 LTS (Hardy Heron)
  - Ubuntu 9.04 (Jaunty Jackalope)
  - Ubuntu 10.04 LTS (Lucid Lynx)
  - Ubuntu 10.10 (Maverick Meerkat)
  - Ubuntu 12.04 LTS (Precise Pangolin)
  - Ubuntu 13.10 (Saucy Salamander)
  - **Ubuntu 14.04 LTS (Trusty Tahr)**
  - Ubuntu 15.04 (Vivid Vervet)
- Red Hat-based distributions:
  - Oracle Linux 6.3 - tested with Oracle Database 10g2, 11g, 11g2
  - **Oracle Linux 6.6 - tested with Oracle Database 10g2, 11g, 11g2, 12c**
  - **Oracle Linux 7.1 - tested with Oracle Database 11g2, 12c**
  - Red Hat Enterprise Linux 5.x
  - **Red Hat Enterprise Linux 6.6** - latest from 6.x series
  - **Red Hat Enterprise Linux 7.1** - latest from 7.x series, current
  - CentOS 5.11 - latest from 5.x series
  - CentOS 6.6 - latest from 6.x series
  - CentOS 7.1 - latest from 7.x series, current
- specialized distributions:
  - cPanel / WHM 11.x on CentOS 6.x (at least 6.3-6.6)
  - Elastix 2.5 and 4.0, Elastix MT 3.0
  - openATTIC 1.x - either VM or installed on Debian Wheezy
  - Proxmox VE 3.x - either standalone or installed on Debian Wheezy
  - Zentyal Server 4.1 - both commercial and development editions


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

Server Farmer repository contains no customer passwords, private keys etc. However it
contains sensitive files related to the owner (Tomasz Klim or Klim Baron Business
Solutions Sp. z o.o.). If you want to fork this repository, you probably will
want to change them:

- scripts/functions.custom - custom gpg / ssh keys, paths, names etc., including
  "tomaszklim.pl" domain name, which can be replaced with your own domain with
  **enabled catch-all**
- common/gpg/*.pub - gpg keys used to encrypt backups
- common/standby.conf - list of standby devices
- scripts/check/security.sh - directories to protect with custom access rights


# Commercial support

You can buy commercial support at http://fajne.it

We can help you adjust Server Farmer to your needs, or we can manage your servers for
you (including 24/7 telephone support and monitoring).
