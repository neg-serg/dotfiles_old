Introduction
==============
>   use you gmail as your note place.
>   when you use this plugin, your can send the current text to your mailbox(~~gmail~~), within the default inbox named "gnote",    
the subject of your note will be your filename without suffix by default, so same filename(without suffix) will be in same dialogue. Just have a try, you'll get the effect.

Why I write this plugin
=======================
I'd like to write note in my vim. I cannot imagine there is no vim when I am noting.  
So I write this.
  
Requirements
===============
* vim python2 support: vim-gnote is based on python2, so your vim should be builded with python2 support.  
* mail account  
>    ~~gmail account~~~   
>	mail account which supports imap protocol  
  
Configuration
===============
* account settings  
>   ~~let g:gnote_gmail_username="your gmail username"~~  
>   ~~let g:gnote_gmail_password="your gmail password"~~  
```
let g:gnote_mail_host="imap host of your mail" (default is imap.google.com)
let g:gnote_mail_port="imap port of your mail" (default is 993)
let g:gnote_mail_username="your mail username"
let g:gnote_mail_password="your mail password"
```
  
* change the default mailbox name (default is 'gnote')
>   ~~let g:gnote_gmail_mailbox="NOTES"~~  
```
let g:gnote_mail_mailbox="NOTES"
```
  
* keybord (you can also set the short cuts in your vim config), for example:
```
map <leader>gn <esc>: call Gnote() <cr>
```

Config Example
==============
* assume you'd like to use google  mail
```
let g:gnote_mail_username = "xxx@gmail.com"
let g:gnote_mail_password = "your google mail password"
let g:gnote_gmail_mailbox = "mailbox name you prefer"
```
  
* assume you'd like to use qq mail
```
let g:gnote_mail_host = "imap.exmail.qq.com"
let g:gnote_mail_username = "xxxx@qq.com"
let g:gnote_mail_password = "your qq mail password"
let g:gnote_gmail_mailbox = "mailbox name you prefer"
```
  
* other email
```
just take below examples as reference, the imap settings can be found at the related official website
```

TODO
=======
* markdown support
* attchment support

vim:tw=78:ts=8:ft=help:norl:noet:fen:fdl=0

