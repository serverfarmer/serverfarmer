ServerTokens Prod
ServerSignature Off
ServerRoot "/etc/apache2"
LockFile /var/lock/apache2/accept.lock
PidFile ${APACHE_PID_FILE}
User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}

LogFormat "%v:%p %V %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" vhost_more
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
LogFormat "%{Referer}i -> %U" referer
LogFormat "%{User-agent}i" agent

ServerName %%host%%
ErrorLog /var/log/apache2/%%host%%.error.log
CustomLog /var/log/apache2/%%host%%.access.log vhost_more
LogLevel warn
HostnameLookups Off

Include /etc/apache2/mods-available/alias.load
Include /etc/apache2/mods-available/auth_basic.load
Include /etc/apache2/mods-available/authn_file.load
Include /etc/apache2/mods-available/authz_default.load
Include /etc/apache2/mods-available/authz_groupfile.load
Include /etc/apache2/mods-available/authz_host.load
Include /etc/apache2/mods-available/authz_user.load
Include /etc/apache2/mods-available/autoindex.load
Include /etc/apache2/mods-available/dir.load
Include /etc/apache2/mods-available/env.load
Include /etc/apache2/mods-available/mime.load
Include /etc/apache2/mods-available/negotiation.load
Include /etc/apache2/mods-available/php5.load
Include /etc/apache2/mods-available/rewrite.load
Include /etc/apache2/mods-available/setenvif.load
Include /etc/apache2/mods-available/status.load

Include /etc/apache2/mods-available/alias.conf
Include /etc/apache2/mods-available/autoindex.conf
Include /etc/apache2/mods-available/dir.conf
Include /etc/apache2/mods-available/mime.conf
Include /etc/apache2/mods-available/negotiation.conf
Include /etc/apache2/mods-available/php5.conf
Include /etc/apache2/mods-available/setenvif.conf
Include /etc/apache2/mods-available/status.conf

Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 15

<IfModule mpm_prefork_module>
    StartServers          2
    MinSpareServers       2
    MaxSpareServers       5
    MaxClients           50
    MaxRequestsPerChild   0
</IfModule>

# <IfModule mpm_prefork_module>
#     StartServers          5
#     MinSpareServers       5
#     MaxSpareServers      10
#     MaxClients          150
#     MaxRequestsPerChild   0
# </IfModule>

<IfModule mpm_worker_module>
    StartServers          2
    MaxClients          150
    MinSpareThreads      25
    MaxSpareThreads      75 
    ThreadsPerChild      25
    MaxRequestsPerChild   0
</IfModule>

AccessFileName .htaccess
DefaultType text/plain

<Files ~ "^\.ht">
    Order allow,deny
    Deny from all
</Files>

<Directory />
    Options FollowSymLinks
    AllowOverride None
    Order deny,allow
    Deny from all
</Directory>

Include /etc/apache2/httpd.conf

