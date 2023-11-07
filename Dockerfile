# Use SUSE Linux as the base image
FROM opensuse/tumbleweed

# Set the working directory inside the container
WORKDIR /app

# Install the GCC compiler and necessary build tools
RUN zypper --non-interactive install -t pattern devel_basis
RUN zypper --non-interactive in gcc autoconf automake patch\
	gettext-tools git vim python3 awk device-mapper-devel\
	flex freetype2-devel fuse-devel help2man\
	makeinfo openssl pesign-obs-integration xz-devel rpm-build\
	dejavu-fonts fdupes gcc-32bit glibc-devel-32bit gnu-unifont\
	update-bootloader-rpm-macros python310 python39 

RUN mkdir ./patch
RUN mkdir ./grub
COPY 00* ./patch/
COPY *.src.rpm .

# Set the username and email for Git
RUN git config --global credential.helper 'store --file=/git-credentials'
RUN git config --global user.name "Mukesh-Chaurasiya" \
    && git config --global user.email "docker@build.com"

RUN rpm -ivv *.src.rpm --define "_topdir $PWD"
# RUN rpmbuild -ba grub/SPECS/grub2.spec --define "_topdir $PWD"

# Set the entry point for the container
CMD ["/bin/bash"]
