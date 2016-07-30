[![Build Status](https://travis-ci.org/serverfarmer/serverfarmer.png?branch=master)](https://travis-ci.org/serverfarmer/serverfarmer)

Server Farmer is a lightweight framework designed for companies, that manage
many servers and services belonging to many different customers, but connected
into a single managed platform.

As of 2016, Server Farmer has over 8 years of history of managing, production
servers (which is longer than in competing Chef framework), including over
1 year of being successful open source project. It was used to manage the
infrastructure for over 100 customers, consisted of over 400 physical/virtual
servers, and OpenVZ containers, located in multiple data centers, in almost
10 major cities in Poland, and at least 1 city in Germany.

## Documentation

You can find a lot more information at http://serverfarmer.org/ project page:

1. [Main page](http://serverfarmer.org/)
2. [Key concepts](http://serverfarmer.org/key-concepts.html)
3. [Monitoring features](http://serverfarmer.org/monitoring.html)
4. [Project history](http://serverfarmer.org/history.html)
5. [Getting started](http://serverfarmer.org/getting-started.html)
6. [Cloud integration](http://serverfarmer.org/cloud-integration.html)
7. [Configuration settings](http://serverfarmer.org/configuration.html)
8. [List of extensions](http://serverfarmer.org/extensions.html)

If you have any technical or non-technical questions about Server Farmer, for
which you can't find an answer on the project home page, feel free to write
to support@serverfarmer.org. We will try either to respond you directly, or
publish an answer on the page, or directly fix any reported issues.

## Advantages of Server Farmer over manual server management

No matter if you manage just a single server, or hundreds of them, installing
Server Farmer gives you many advantages over default OS configuration:

- consistent and reliable tools to manage many servers at once (or one by one)
- several monitoring capabilities
- automatic, possibly encrypted backups
- working MTA configuration (your servers are now able to send emails)
- central logging configuration (all logs are stored and processed in one place, enhancing security of your infrastructure)
- more secure configurations of several system components (depending on OS version)

## Advantages of Server Farmer over competitive tools

There are many similar solutions: Puppet, Chef, Ansible, cfengine are the most
popular ones. What they have in common is that all of them:

- require much more resources just to be run
- utilize much more resources to handle typical tasks
- have way more steep learning curve
- are way more expensive to set up and use

Server Farmer basic configuration can be set up just in a few minutes and then
extended, when your server farm is growing. You can also implement your own
functional extensions (just like Ansible playbooks or Chef recipes, but much
more simple), that will cover completely new functionalities.

Server Farmer is the ideal tool to manage customers, who have 1-3 servers each
(up to let's say 1-20 servers), where most of such servers run well-known
applications and their configuration is similar to each other and close to
OS defaults where possible.

## How to install Server Farmer on your first server

([see the full manual](http://serverfarmer.org/getting-started.html))

- fork this repository
- clone it to your server, exactly to the /opt/farm directory:

```
git clone https://github.com/your-github-login/serverfarmer /opt/farm
```

- customize it (and commit your changes into repository, if you want to reuse them on more servers):

```
cd /opt/farm
vi scripts/functions.custom
git add scripts/functions.custom
git ci
git push
```

- begin setup and just follow the simple on-screen instructions:

```
/opt/farm/setup.sh
```

## How to deploy Server Farmer into Amazon cloud

([see the full manual](http://serverfarmer.org/cloud-integration.html))

- install awscli and configure your account details
- install Cloud Farmer and configure it:

```
git clone https://github.com/serverfarmer/cloudfarmer /opt/cloud
vi /opt/cloud/credentials/variables.sh
vi /opt/cloud/credentials/ec2.sh
```

- create a new EC2 instance:

```
/opt/cloud/providers/ec2/ec2-create-simple.sh aws-test-key1 m4.xlarge
```

- deploy Server Farmer on it:

```
/opt/cloud/deploy.sh ec2-hostname.compute.amazonaws.com /path/to/initial/ssh.key
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

- Ubuntu:
  - Ubuntu 8.04 LTS (Hardy Heron)
  - Ubuntu 9.04 (Jaunty Jackalope)
  - Ubuntu 10.04 LTS (Lucid Lynx)
  - Ubuntu 10.10 (Maverick Meerkat)
  - Ubuntu 12.04 LTS (Precise Pangolin)
  - Ubuntu 13.10 (Saucy Salamander)
  - Ubuntu 14.04 LTS (Trusty Tahr) - server/desktop/cloud
  - Ubuntu 15.04 (Vivid Vervet)
  - Ubuntu 16.04 LTS (Xenial Xerus)

- Debian/Ubuntu clones:
  - Linux Mint 17.x (based on Ubuntu 14.04 LTS)
  - openATTIC 1.2 (based on Debian 7.x)
  - Proxmox VE 2.x (based on Debian 6.x)
  - Proxmox VE 3.x (based on Debian 7.x)
  - Zentyal Server 3.4 (based on Ubuntu 13.10)
  - Zentyal Server 4.1 (based on Ubuntu 14.04 LTS)

- RHEL and direct clones:
  - Red Hat Enterprise Linux 5.x
  - Red Hat Enterprise Linux 6.x
  - Red Hat Enterprise Linux 7.x
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

## How to contribute

We are welcome to contributions of any kind: bug fixes, added code comments,
support for new operating system versions, GPG keys in sf-gpg extension etc.

If you want to contribute:
- fork this repository and clone it to your machine
- create a feature branch and do the change inside it
- push your feature branch to github and create a pull request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Tomasz Klim (<opensource@tomaszklim.pl>) |
| **Copyright:**       | Copyright 2008-2016 Tomasz Klim          |
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
