FROM python:3.9

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gosu \
    openssh-client \
    git \
    && rm -rf /var/lib/apt/lists/*

# Ensure GitHub's public key is added to known_hosts to avoid host verification
# issues.
#
# This is needed because the host's ~/.ssh/known_hosts file (which
# stores the fingerprints of trusted hosts) is not accessible during the build.
# Therefore the host key for github.com cannot be added to the known_hosts
# file. This fetches that host key and adds it to the known_hosts file within
# the context of the build.
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts || exit 1

RUN python -m pip install --upgrade pip

COPY . .

RUN --mount=type=ssh,id=default pip install --no-cache-dir -r requirements.txt

# ADD support user.
RUN adduser --disabled-password support && \
    chown -R support:support /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["python"]
