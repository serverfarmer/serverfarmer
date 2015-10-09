# See /usr/share/postfix/main.cf.dist for a commented, more complete version

myhostname = %%host%%
myorigin = %%domain%%
mydestination = %%host%%, localhost.$mydomain, localhost
relayhost = [%%smtp%%]:587
mynetworks = 127.0.0.1, 192.168.0.0/16, 10.0.0.0/8

inet_interfaces = all
inet_protocols = ipv4
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
recipient_delimiter = +

smtp_generic_maps  = hash:/etc/postfix/sender_address_rewriting
sender_bcc_maps    = hash:/etc/postfix/sender_bcc_notifications
recipient_bcc_maps = hash:/etc/postfix/recipient_bcc_notifications
virtual_alias_maps = hash:/etc/postfix/virtual_aliases
transport_maps     = hash:/etc/postfix/transport

############

biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

# TLS parameters
smtp_tls_session_cache_database = btree:${queue_directory}/smtp_scache

# See /usr/share/doc/postfix/TLS_README.gz in the postfix-doc package for
# information on enabling SSL in the smtp client.

mailbox_size_limit = 0

# http://www.bensbits.com/2005/09/06/postfix_smtp_auth_support_for_relayhost
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl/passwd
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes

#smtp_sasl_mechanism_filter = plain, login
