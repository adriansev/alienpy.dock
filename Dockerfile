FROM registry.fedoraproject.org/fedora-minimal:34

ARG ALIENPY_VERSION="master"

ADD http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo /etc/yum.repos.d/
COPY alien-cas-master/alien-ca/ /etc/grid-security/certificates/

RUN rpm --import http://repository.egi.eu/sw/production/cas/1/current/GPG-KEY-EUGridPMA-RPM-3 && \
microdnf install -y git python3-wheel python3-setuptools python3-pip python3-xrootd ca-policy-egi-core ca-policy-lcg openssl && \
microdnf clean all && rm -rf /var/cache/dnf && \
openssl rehash /etc/grid-security/certificates/

RUN python3 -m pip install git+https://github.com/adriansev/jalien_py.git@${ALIENPY_VERSION}

CMD [ "python3", "/usr/local/lib/python3.9/site-packages/alienpy/alien.py" ]

LABEL maintainer="Adrian.Sevcenco@spacescience.ro"

