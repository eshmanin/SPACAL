FROM centos:7
LABEL project="SPACAL"
LABEL maintainer "Abdalaziz Rashid <abdalaiz.rashid@outlook.com>"
ENV DISPLAY=:0
ENV container docker
ENV GEANT4_URL https://cern.ch/geant4-data/releases/lib4.10.5.p01/Linux-g++4.8.5-CC7.tar.gz
ENV GEANT4 Linux-g++4.8.5-CC7.tar.gz
ENV CLHEP_URL http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/clhep-2.0.4.5-1.el6.rf.x86_64.rpm
ENV CLHEP clhep-2.0.4.5-1.el6.rf.x86_64.rpm
ENV G4LEDATA /usr/share/Geant4-10.5.1-Linux/data/G4EMLOW7.7
ENV G4LEDATA /usr/share/Geant4-10.5.1-Linux/data/4ENSDFSTATEDATA/ENSDFSTATE.dat
ADD ${CLHEP_URL} /tmp/
RUN yum -y install epel-release && yum -y update && yum clean all && yum -y install python-pip python3 python3-devel python-devel mesa-dri-drivers which gcc gcc-c++ git wget cmake make libXft  libXpm libSM libXext mesa-libGLU.1686 libGLU libXmu &&\
    rpm -Uvh /tmp/${CLHEP}

RUN ln -sn /usr/lib64/libXmu.so.6 /usr/lib64/libXmu.so     &&   ln -sn  /usr/lib64/libGLU.so.1 /usr/lib64/libGLU.so && \
    ln -sn  /usr/lib64/libGL.so.1 /usr/lib64/libGL.so      &&   ln -sn  /usr/lib64/libSM.so.6 /usr/lib64/libSM.so   && \
    ln -sn  /usr/lib64/libICE.so.6 /usr/lib64/libICE.so    &&   ln -sn  /usr/lib64/libX11.so.6 /usr/lib64/libX11.so && \
    ln -sn  /usr/lib64/libXext.so.6 /usr/lib64/libXext.so  &&   ln -sn  /usr/lib64/libexpat.so.1 /usr/lib64/libexpat.so


RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

ADD ${GEANT4_URL} /tmp/${GEANT4}
ADD http://cern.ch/geant4-data/datasets/G4ENSDFSTATE.2.2.tar.gz /tmp/
ADD http://cern.ch/geant4-data/datasets/G4EMLOW.7.7.tar.gz  /tmp/
ADD https://root.cern/download/root_v6.18.04.Linux-centos7-x86_64-gcc4.8.tar.gz /tmp/
ADD http://cern.ch/geant4-data/datasets/G4PhotonEvaporation.5.3.tar.gz /tmp/
ADD http://cern.ch/geant4-data/datasets/G4PARTICLEXS.1.1.tar.gz /tmp/

RUN tar xf /tmp/${GEANT4}               -C /usr/share/ && mkdir /usr/share/Geant4-10.5.1-Linux/data && \
    tar xf /tmp/G4ENSDFSTATE.2.2.tar.gz -C /usr/share/Geant4-10.5.1-Linux/data/ && \
    tar xf /tmp/G4EMLOW.7.7.tar.gz      -C /usr/share/Geant4-10.5.1-Linux/data/ && \
    tar xf /tmp/root_v6.18.04.Linux-centos7-x86_64-gcc4.8.tar.gz -C /usr/share/ && \
    tar xf /tmp/G4PhotonEvaporation.5.3.tar.gz -C /usr/share/Geant4-10.5.1-Linux/data/ && \
    tar xf /tmp/G4PARTICLEXS.1.1.tar.gz        -C /usr/share/Geant4-10.5.1-Linux/data/ && \
    rm /tmp/*

RUN echo "source /usr/share/root/bin/thisroot.sh"                   >> /root/.bashrc && \
    echo "source /usr/share/Geant4-10.5.1-Linux/bin/geant4.sh"      >> /root/.bashrc && \
    echo "export G4ENSDFSTATEDATA=/usr/share/Geant4-10.5.1-Linux/data/G4ENSDFSTATE2.2/"	    >> /root/.bashrc && \
    echo "export G4LEVELGAMMADATA=/usr/share/Geant4-10.5.1-Linux/data/G4EMLOW7.7/"          >> /root/.bashrc && \
    echo "export G4LEDATA=/usr/share/Geant4-10.5.1-Linux/data/G4EMLOW7.7/"          >> /root/.bashrc && \
    echo "export G4LEVELGAMMADATA=/usr/share/Geant4-10.5.1-Linux/data/PhotonEvaporation5.3/">> /root/.bashrc && \
    echo "export G4PARTICLEXSDATA=/usr/share/Geant4-10.5.1-Linux/data/G4PARTICLEXS1.1/" >> /root/.bashrc

ADD ./ /root/SPACAL/
RUN ["/bin/bash", "-c", "source /usr/share/root/bin/thisroot.sh && source /usr/share/Geant4-10.5.1-Linux/bin/geant4.sh && \
cd /root/SPACAL/ && mkdir -p /root/SPACAL/Build/ && cd /root/SPACAL/Build && cmake .. && make -j && cp ./FibresCalo .. && pip install numpy==1.15  && pip install root_numpy"]


WORKDIR /root/SPACAL









