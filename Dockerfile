#FROM clouddood/rhel7.9
FROM registry.access.redhat.com/ubi7/ubi:7.9 

ENV HOME /root

# enable ssh
# ssh server
# Don't forget to run '/usr/sbin/sshd -D' if you actually want to ssh into this container
RUN yum install -y openssh-server openssh-clients
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
#RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_dsa_key -N ''
#ADD files/sshd/sshd_config /etc/ssh/sshd_config 
RUN echo root:welcome1 | chpasswd

RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22 8080
CMD ["/usr/sbin/sshd", "-D"]

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
## RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
## CMD ["/sbin/my_init"]

## RUN apt-get update

## RUN apt-get install -y openssh-server wget lsb-release sudo
## RUN \
##     export release=`lsb_release -cs` \
##     && wget http://apt.puppetlabs.com/puppetlabs-release-$release.deb -O puppetlabs-release-$release.deb \
##     && dpkg -i puppetlabs-release-$release.deb \
##     && apt-get update \
##     && apt-get install puppet -y

EXPOSE 22

#RUN mkdir -p /var/run/sshd
#RUN chmod 0755 /var/run/sshd

# Create and configure vagrant user
RUN useradd --create-home -s /bin/bash vagrant
WORKDIR /home/vagrant

# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant: /home/vagrant/.ssh
RUN echo -n 'vagrant:vagrant' | chpasswd

# Enable passwordless sudo for the "vagrant" user
RUN mkdir -p /etc/sudoers.d
RUN install -b -m 0440 /dev/null /etc/sudoers.d/vagrant
RUN echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers.d/vagrant


# Clean up APT when done.

## RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
