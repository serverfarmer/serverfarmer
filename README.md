[![Build Status](https://travis-ci.org/serverfarmer/serverfarmer.png?branch=master)](https://travis-ci.org/serverfarmer/serverfarmer)

Server Farmer is a lightweight server management framework, designed for companies, that **manage many servers for different customers**, where:

- each customer has separate employees, permissions, compliance requirements, end users etc.
- typical customer has between 1 and 15-20 servers
- each server has different purpose, users and set of services
- many servers are "snowflakes" (that still need to be automatically managed, where possible)
- connecting them to a single Ansible or Puppet instances would be either completely impossible, or way too expensive
- maintaining separare Ansible or Puppet instances for each customer would be too expensive for most customers

It is useful mainly for:

- IT outsourcing companies
- software houses and similar companies that manage particular servers as part of bigger project

As of 2022, Server Farmer has over 14 years of history of managing production servers, including over 7 years of being successful open source project.

It was used just by its author to manage the infrastructure:

- for over 250 customers
- consisted of almost 2000 physical/virtual servers and containers
- located in over 30 countries (including cloud instances in all major public cloud providers)

## Documentation

You can find a lot more information at http://serverfarmer.org/ project page and in extension repositories:

##### less technical

1. [Home page](http://serverfarmer.org/)
2. [Business overview (for non-technical users)](http://serverfarmer.org/basics.html)
3. [Project history](http://serverfarmer.org/history.html)

##### for the beginners

1. [Getting started](http://serverfarmer.org/getting-started.html)
2. [Configuration settings](http://serverfarmer.org/configuration.html)
3. [gpg/ssh key configuration details](https://github.com/serverfarmer/sf-keys)
4. [List of extensions](http://serverfarmer.org/extensions.html)

##### more advanced

1. [Farm management](https://github.com/serverfarmer/sm-farm-manager)
2. [Backup architecture (local part)](https://github.com/serverfarmer/sf-backup)
3. [Backup architecture (storage part)](https://github.com/serverfarmer/sm-backup-collector)
4. [Monitoring features](http://serverfarmer.org/monitoring.html)
5. [Heartbeat subproject (client)](https://github.com/serverfarmer/heartbeat-linux)
6. [Heartbeat subproject (server)](https://github.com/serverfarmer/heartbeat-server)

##### DNS / DHCP management

1. [Zone Manager tool](https://github.com/zonemanager/zonemanager)

If you have any technical or non-technical questions about Server Farmer, for
which you can't find an answer on the project home page, feel free to write
to support@serverfarmer.org. We will try either to respond you directly, or
publish an answer on the page, or directly fix any reported issues.

## Advantages of Server Farmer over managing individual servers

No matter if you manage just a single server, or hundreds of them, installing
Server Farmer gives you many advantages over default OS configuration:

- consistent and reliable tools to manage many servers at once (or one by one)
- improved server security in various areas
- several monitoring and alerting capabilities
- automatic, possibly encrypted backups
- working MTA configuration (your servers are now able to send emails)
- central logging configuration (all logs are stored and processed in one place, enhancing security of your infrastructure)
- hardened network stack, immune from participation in DDoS attacks

## Differences between Server Farmer and competitive tools

The main difference between Server Farmer and the competitive tools (mostly
Puppet, Chef, Ansible, Salt and CFEngine) is that **Server Farmer is designed
to manage a completely heterogeneous environment**, where servers:

- are owned by many different companies
- have different operating systems
- have different configurations
- have different installed services and applications
- have different system users, groups and permissions
- have different roles and purposes

To achieve that, Server Farmer is mainly focused on low-level server security
aspects, and doesn't try to cover the application level at all. As opposite,
most mentioned tools mentioned tools focus mainly on the application level,
providing more-or-less complete "Infrastructure As Code" frameworks.

## Advantages of Server Farmer over competitive tools

Most server management tools (Puppet, Chef etc.) are designed with corporate
mindset ("where the money is"), and follow "one managed application/customer - one
instance" model, which is suitable mainly for big companies, with lots of servers
and big applications. Such model is however obviously too expensive for companies
that have 1-5 servers overall.

As opposite to that model, Server Farmer is built from ground up to manage many
customers, applications etc. using only one instance shared across all customers,
which is much cheaper, in both technical resources (servers, repositories etc.),
and man-hours.

Server Farmer basic configuration can be set up just in a few minutes and then
extended, when your server farm is growing. You can also implement your own
functional extensions (just like Ansible playbooks or Chef recipes, but much
more simple), that will cover completely new functionalities - or you can use
Server Farmer with Ansible, whichever better fits your needs.

## How to install Server Farmer on your first server

Server Farmer consists of over 80 Git repositories. But don't worry, you will
need to fork only 2 of them (this one and `sf-keys`), and start with editing
small files in `config` directory.

After forking, clone this repository to `/opt/farm` directory on your server:

```
git clone https://github.com/your-github-login/serverfarmer /opt/farm
```

Then run `setup.sh` script and just follow the simple on-screen instructions:

```
/opt/farm/setup.sh
```

## Integration with cloud

Server Farmer uses [Polynimbus](https://github.com/polynimbus/polynimbus)
multi-cloud infrastructure management tool to launch and manage cloud instances,
and `sm-farm-provisioning` extension to provision them.

It supports:

- Alibaba Cloud
- Amazon Web Services
- Beyond e24cloud.com
- Google Cloud Platform
- Hetzner Cloud (and also Hetzner "classic" dedicated servers)
- Microsoft Azure
- Rackspace Cloud
- any cloud service based on OpenStack (including public, private and hybrid clouds)

### How to deploy Server Farmer into cloud

Initial setup:

- choose a server for the *farm manager* role (no special requirements, except that all management extensions are tested mainly on Ubuntu 14.04 LTS, 16.04 LTS and 18.04 LTS)
- install Server Farmer on it ([basic installation](http://serverfarmer.org/getting-started.html) is enough)
- install Polynimbus on it and configure it, providing your cloud API keys and other details (interactively):

```
git clone https://github.com/polynimbus/polynimbus /opt/polynimbus
/opt/polynimbus/install.sh
/opt/polynimbus/api/v1/account/setup.sh aws myaccount
```

Launch new cloud instance:

```
/opt/polynimbus/api/v1/instance/launch.sh aws myaccount test_key1 m5.xlarge
```

Install Server Farmer on new instance:

```
sf-provision ec2-54-123-45-67.compute-1.amazonaws.com /etc/polynimbus/ssh/id_aws_test_key1 test_profile
```

List cloud instances:

```
/opt/polynimbus/api/v1/instance/list.sh aws myaccount
```

## Compatible operating systems

The below list contains only distribution versions with 100% compatibility. If
your OS is not on this list, but is any Debian/RHEL derivative, Server Farmer
will most probably support it at least partially.

- Debian:
  - Debian 4.x (Etch)
  - Debian 5.x (Lenny)
  - Debian 6.x (Squeeze)
  - Debian 7.x (Wheezy)
  - Debian 8.x (Jessie)
  - Debian 9.x (Stretch)
  - Debian 10.x (Buster)
  - Debian 11.x (Bullseye)

- Ubuntu:
  - Ubuntu 8.04 LTS (Hardy Heron)
  - Ubuntu 9.04 (Jaunty Jackalope)
  - Ubuntu 10.04 LTS (Lucid Lynx)
  - Ubuntu 10.10 (Maverick Meerkat)
  - Ubuntu 12.04 LTS (Precise Pangolin)
  - Ubuntu 13.10 (Saucy Salamander)
  - Ubuntu 14.04 LTS (Trusty Tahr)
  - Ubuntu 15.04 (Vivid Vervet)
  - Ubuntu 16.04 LTS (Xenial Xerus)
  - Ubuntu 18.04 LTS (Bionic Beaver)
  - Ubuntu 20.04 LTS (Focal Fossa)
  - Ubuntu 22.04 LTS (Jammy Jellyfish)

- Debian/Ubuntu clones:
  - Devuan Jessie (based on Debian 8.x)
  - Devuan ASCII (based on Debian 9.x)
  - DirectAdmin installed on Debian 8.x (Jessie)
  - Linux Mint 17.x (based on Ubuntu 14.04 LTS)
  - openATTIC 1.2 (based on Debian 7.x)
  - Proxmox VE 2.x (based on Debian 6.x)
  - Proxmox VE 3.x (based on Debian 7.x)
  - Zentyal Server 3.4 (based on Ubuntu 13.10)
  - Zentyal Server 4.1 (based on Ubuntu 14.04 LTS)
  - Zentyal Server 5.0 (based on Ubuntu 16.04 LTS)

- RHEL and direct clones:
  - Red Hat Enterprise Linux 5.x
  - Red Hat Enterprise Linux 6.x
  - Red Hat Enterprise Linux 7.x
  - Red Hat Enterprise Linux 8.x
  - CentOS 5.x
  - CentOS 6.x
  - CentOS 7.x
  - Oracle Linux 6.x - tested with Oracle Database 10g2, 11g, 11g2, 12c
  - Oracle Linux 7.x - tested with Oracle Database 11g2, 12c

- specialized RHEL clones:
  - cPanel / WHM 11.x (based on CentOS 6.4-6.6)
  - Elastix 2.5 (based on CentOS 5.x)
  - Elastix 4.0 (based on CentOS 7.x)
  - Elastix MT 3.0 (based on CentOS 6.x)

- hardware appliances:
  - Raspbian 8.x (Jessie) on Raspberry Pi
  - Debian all versions listed above since 6.x (Squeeze) on QNAP with ARM CPU
  - QNAP QTS 4.x (limited compatilibty, without central management)

- other systems:
  - FreeBSD 9.x
  - FreeBSD 10.x
  - NetBSD 6.x
  - openSUSE 13.x

## How to contribute

We are welcome to contributions of any kind: bug fixes, added code comments,
support for new operating system versions or hardware etc.

If you want to contribute:
- fork this repository and clone it to your machine
- create a feature branch and do the change inside it
- push your feature branch to github and create a pull request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2008-2022 Tomasz Klim          |
| **License:**         | MIT                                      |

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
