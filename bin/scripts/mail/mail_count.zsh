#!/bin/zsh
mail_key_="$(gpg -dq ~/.mail_.gpg)"
mail_pas_="$(pass show gmail)"

~/bin/scripts/mail/mail_count.py "${mail_key_}" "${mail_pas_}"
