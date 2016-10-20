local mail_update_interval_=10000
local function mail_update()
    local pipe_ = io.popen(home_.."/bin/scripts/mail/mail_count.zsh", "r")
    local mail_cnt = pipe_:read("*l") pipe_:close()
    dmain.mail = mail_cnt
    dzen_update()
    mail_timer:set(mail_update_interval_, mail_update)
end

mail_timer = notioncore.create_timer()
mail_timer:set(12000, mail_update)
