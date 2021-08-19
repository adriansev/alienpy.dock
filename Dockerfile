FROM registry.fedoraproject.org/fedora-minimal:34

RUN microdnf install -y python3-wheel python3-setuptools python3-pip python3-xrootd && \
pip install alienpy && \
microdnf clean all && rm -rf /var/cache/dnf

CMD ["/usr/local/lib/python3.9/site-packages/alienpy/alien.py"]

LABEL maintainer="Adrian.Sevcenco@spacescience.ro"

