ARG branch=docker
# Use SUSE Linux as the base image
FROM suse/sle15

# Set the working directory inside the container
WORKDIR /app

# Install the GCC compiler and necessary build tools
RUN zypper --non-interactive install -t pattern devel_basis
RUN zypper --non-interactive in gcc autoconf automake patch gettext-tools git vim python3 awk

# Set the username and email for Git
RUN git config --global credential.helper 'store --file=/git-credentials'
RUN git config --global user.name "Mukesh-Chaurasiya" \
    && git config --global user.email "docker@build.com"

RUN git clone --single-branch --branch retry https://github.com/mchauras-linux/grub-mchauras.git

RUN cd grub-mchauras && ./bootstrap && ./configure --prefix=/app/grub-mchauras/__install
RUN cd grub-mchauras && make -j$(nproc) && make install -j$(nproc)

# Copy the source code from your host machine to the container
#COPY *.src.rpm .

# Compile the C program

# Set the entry point for the container
CMD ["/bin/bash"]
