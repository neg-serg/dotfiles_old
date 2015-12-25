#!/bin/sh
case $1 in
    cr3) notionflux -e 'app.byinstance('cr3', 'Cr3', 'cr3')' ;;
    radare2) notionflux -e 'radare2(ioncore.current())' ;;
    run_mutt) notionflux -e app.byclass\(\'\~/bin/scripts/run_mutt\',\ \'mutt\'\) ;;
    nicotine) notionflux -e app.byinstance\(\'nicotine.py\ \|\|\ nicotine\',\ \'Nicotine.py\',\ \'nicotine.py\'\) ;;
    gdb) notionflux -e 'gdb(ioncore.current())' ;;
    ranger) notionflux -e 'ranger(ioncore.current())' ;;
esac

