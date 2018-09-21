FROM ubuntu:bionic
MAINTAINER Fmstrat <fmstrat@NOSPAM.NO>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    # Install all apps
    # The third line is for multi-site config (ping is for testing later)
    apt-get install -y \
        pkg-config curl \
        attr acl samba smbclient ldap-utils winbind libnss-winbind libpam-winbind krb5-user krb5-kdc supervisor \
        openvpn inetutils-ping && \
    rm -rf /var/cache/apt /var/lib/apt/lists

RUN curl -s -S -L -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
    chmod a+x /usr/local/bin/dumb-init

# Set up script and run
COPY init.sh /init.sh
RUN chmod 755 /init.sh

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD [ "/init.sh", "setup" ]
