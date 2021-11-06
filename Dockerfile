FROM apiology/circleci:latest
MAINTAINER apiology

COPY Makefile fix.sh requirements_dev.txt Gemfile Gemfile.lock /tmp/
RUN cd /tmp && \
    ./fix.sh && \
    rm -fr /home/circleci/.pyenv/versions/*/lib/python*/test && \
    strip /home/circleci/.pyenv/versions/*/lib/python*/lib-dynload/*.so && \
    strip /home/circleci/.pyenv/versions/*/lib/python*/config-*/*.a && \
    ( find /home/circleci/.pyenv/versions -name __pycache__ | xargs rm -fr ) && \
    chmod 755 /home/circleci/.pyenv/versions/*/lib/*.a && \
    strip /home/circleci/.pyenv/versions/*/lib/*.a && \
    rm -fr /home/circleci/.rbenv/versions/*/share/*