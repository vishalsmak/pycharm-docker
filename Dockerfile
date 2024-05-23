FROM --platform=${TARGETPLATFORM} debian

RUN apt-get update && apt-get install --no-install-recommends -y \
  python3 python3-dev python3-setuptools python3-pip \
  gcc git openssh-client less curl \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash developer

ARG PYCHARM_VERSION=2024.1
ARG PYCHARM_BUILD=2024.1.1
ARG pycharm_local_dir=.config/JetBrains/PyCharmCE${PYCHARM_VERSION}
ARG pycharm_share_dir=.local/share/JetBrains/PyCharmCE${PYCHARM_VERSION}

WORKDIR /opt/pycharm

RUN echo "Preparing PyCharm ${PYCHARM_BUILD} ..." \
  && export pycharm_source=https://download.jetbrains.com/python/pycharm-community-${PYCHARM_BUILD}.tar.gz \
  && echo "Downloading ${pycharm_source} ..." \
  && curl -fsSL $pycharm_source -o /opt/pycharm/installer.tgz \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz

USER developer
ENV HOME /home/developer

CMD [ "/opt/pycharm/bin/pycharm.sh" ]
