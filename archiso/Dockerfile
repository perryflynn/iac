FROM archlinux/archlinux:latest
SHELL [ "/usr/bin/bash", "-c" ]

RUN pacman --noconfirm --needed -Sy archlinux-keyring && \
    pacman -Syu --noconfirm && \
    pacman --noconfirm --needed -Sy archiso

RUN rm -rf bootstrapiso && \
    mkdir -p /archiso-tmp /archiso /output && \
    cp -r /usr/share/archiso/configs/releng /archiso/bootstrapiso

COPY root/ /

WORKDIR /archiso
RUN cat additional_packages >> bootstrapiso/packages.x86_64

ENV IAC_SSH_ROOT_KEY=""
ENV IAC_REPO_URL="github.com/perryflynn/iac.git"
ENV IAC_REPO_TOKEN=""
ENV IAC_REPO_BRANCH="dev"

VOLUME ["/output"]
ENTRYPOINT [ "/usr/local/sbin/docker-entrypoint.sh" ]
CMD [ "mkarchiso", "-v", "-w", "/archiso-tmp", "-o", "/output", "bootstrapiso" ]
