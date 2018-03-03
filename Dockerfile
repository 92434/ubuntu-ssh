FROM ubuntu:12.04

RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN apt-get -y install unzip
RUN wget https://github.com/viljoviitanen/setup-simple-openvpn/archive/master.zip
RUN unzip master.zip
RUN cd setup-simple-openvpn-master && sudo sh normal-setup.sh
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
