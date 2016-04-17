#!/bin/zsh
curl -u \
    $(gpg -dq ${XDG_CONFIG_HOME}/.gmail_pass.gpg) \
    --silent "https://mail.google.com/mail/feed/atom" \
    -o ~/tmp/gmail.xml && \
    xmllint --format ~/tmp/gmail.xml \
    > ~/tmp/gmail_parsed.xml
