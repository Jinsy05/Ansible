FROM ubuntu:latest

ARG ANSIBLE_CORE_VERSION_ARG "5.6.0"
ARG ANSIBLE_LINT "6.0.1"
ENV ANSIBLE_LINT ${ANSIBLE_LINT}
ENV ANSIBLE_CORE ${ANSIBLE_CORE_VERSION_ARG}

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y gnupg2 python3-pip sshpass git openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN python3 -m pip install --upgrade pip cffi && \
    pip install ansible==${ANSIBLE_CORE} && \
    pip install mitogen==0.2.10 ansible-lint==${ANSIBLE_LINT} jmespath && \
    pip install --upgrade pywinrm && \
    rm -rf /root/.cache/pip

RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

WORKDIR /ansible
RUN ansible --version
CMD ["sleep", "infinity"]
