ServerTokens Prod
ServerSignature Off
ServerRoot "/etc/apache2"
LockFile /var/lock/apache2/accept.lock
PidFile /var/run/apache2.pid
User www-data
Group www-data

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

Include /etc/apache2/mods-available/dir.conf
Include /etc/apache2/mods-available/php5.conf

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
TypesConfig /etc/mime.types
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

<IfModule mod_mime.c>
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz

    AddLanguage ca .ca
    AddLanguage cs .cz .cs
    AddLanguage da .dk
    AddLanguage de .de
    AddLanguage el .el
    AddLanguage en .en
    AddLanguage eo .eo
    AddLanguage es .es
    AddLanguage et .et
    AddLanguage fr .fr
    AddLanguage he .he
    AddLanguage hr .hr
    AddLanguage it .it
    AddLanguage ja .ja
    AddLanguage ko .ko
    AddLanguage ltz .ltz
    AddLanguage nl .nl
    AddLanguage nn .nn
    AddLanguage no .no
    AddLanguage pl .po
    AddLanguage pt .pt
    AddLanguage pt-BR .pt-br
    AddLanguage ru .ru
    AddLanguage sv .sv
    AddLanguage zh-CN .zh-cn
    AddLanguage zh-TW .zh-tw
</IfModule>

<IfModule mod_negotiation.c>
    LanguagePriority en ca cs da de el eo es et fr he hr it ja ko ltz nl nn no pl pt pt-BR ru sv zh-CN zh-TW
    ForceLanguagePriority Prefer Fallback
</IfModule>

<IfModule mod_mime.c>
    AddCharset us-ascii    .ascii .us-ascii
    AddCharset ISO-8859-1  .iso8859-1  .latin1
    AddCharset ISO-8859-2  .iso8859-2  .latin2 .cen
    AddCharset ISO-8859-3  .iso8859-3  .latin3
    AddCharset ISO-8859-4  .iso8859-4  .latin4
    AddCharset ISO-8859-5  .iso8859-5  .cyr .iso-ru
    AddCharset ISO-8859-6  .iso8859-6  .arb .arabic
    AddCharset ISO-8859-7  .iso8859-7  .grk .greek
    AddCharset ISO-8859-8  .iso8859-8  .heb .hebrew
    AddCharset ISO-8859-9  .iso8859-9  .latin5 .trk
    AddCharset ISO-8859-10  .iso8859-10  .latin6
    AddCharset ISO-8859-13  .iso8859-13
    AddCharset ISO-8859-14  .iso8859-14  .latin8
    AddCharset ISO-8859-15  .iso8859-15  .latin9
    AddCharset ISO-8859-16  .iso8859-16  .latin10
    AddCharset ISO-2022-JP .iso2022-jp .jis
    AddCharset ISO-2022-KR .iso2022-kr .kis
    AddCharset ISO-2022-CN .iso2022-cn .cis
    AddCharset Big5        .Big5       .big5 .b5
    AddCharset cn-Big5     .cn-big5
    # For russian, more than one charset is used (depends on client, mostly):
    AddCharset WINDOWS-1251 .cp-1251   .win-1251
    AddCharset CP866       .cp866
    AddCharset KOI8      .koi8
    AddCharset KOI8-E      .koi8-e
    AddCharset KOI8-r      .koi8-r .koi8-ru
    AddCharset KOI8-U      .koi8-u
    AddCharset KOI8-ru     .koi8-uk .ua
    AddCharset ISO-10646-UCS-2 .ucs2
    AddCharset ISO-10646-UCS-4 .ucs4
    AddCharset UTF-7       .utf7
    AddCharset UTF-8       .utf8
    AddCharset UTF-16      .utf16
    AddCharset UTF-16BE    .utf16be
    AddCharset UTF-16LE    .utf16le
    AddCharset UTF-32      .utf32
    AddCharset UTF-32BE    .utf32be
    AddCharset UTF-32LE    .utf32le
    AddCharset euc-cn      .euc-cn
    AddCharset euc-gb      .euc-gb
    AddCharset euc-jp      .euc-jp
    AddCharset euc-kr      .euc-kr
    #Not sure how euc-tw got in - IANA doesn't list it???
    AddCharset EUC-TW      .euc-tw
    AddCharset gb2312      .gb2312 .gb
    AddCharset iso-10646-ucs-2 .ucs-2 .iso-10646-ucs-2
    AddCharset iso-10646-ucs-4 .ucs-4 .iso-10646-ucs-4
    AddCharset shift_jis   .shift_jis .sjis

    AddHandler type-map var
    AddType text/html .shtml
    AddOutputFilter INCLUDES .shtml
</IfModule>

<IfModule mod_setenvif.c>
    BrowserMatch "Mozilla/2" nokeepalive
    BrowserMatch "MSIE 4\.0b2;" nokeepalive downgrade-1.0 force-response-1.0
    BrowserMatch "RealPlayer 4\.0" force-response-1.0
    BrowserMatch "Java/1\.0" force-response-1.0
    BrowserMatch "JDK/1\.0" force-response-1.0

    BrowserMatch "Microsoft Data Access Internet Publishing Provider" redirect-carefully
    BrowserMatch "MS FrontPage" redirect-carefully
    BrowserMatch "^WebDrive" redirect-carefully
    BrowserMatch "^WebDAVFS/1.[012]" redirect-carefully
    BrowserMatch "^gnome-vfs/1.0" redirect-carefully
    BrowserMatch "^XML Spy" redirect-carefully
    BrowserMatch "^Dreamweaver-WebDAV-SCM1" redirect-carefully
</IfModule>

Include /etc/apache2/httpd.conf

