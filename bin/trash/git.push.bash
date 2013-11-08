#!/bin/bash

#Параметры------------
REPOPATH="$HOME/.repo" #Место хранения репозитория
REPOINIT="git init" #Команда инициализации репозитория
ADDCMD="git add" #Команда на добавление файла в репозиторий
CHECKOUTCMD="git checkout master" #Комманда переключения на текущую ветку
COMMITCMD="git commit -a" #Комманда для коммита
COMMITCOMMENT="-m" #Добавление комментария к коммиту
PUSHCMD="git push" #Выгрузка изменений в удалённый репозиторий
#---------------------

CURDIR="$PWD" #Сохраняем текущий путь для дальнейшего использования
cmd='echo "$PWD"|sed "s=$HOME=="'
CURDIR_=`eval $cmd`


#Инициализация нового репозитория
function init_repo(){
eval "mkdir -p $REPOPATH" #создаём дирректорию
eval "touch $REPOPATH/.files" #Создаём файл с исходными путями
cd "$REPOPATH"
eval "$REPOINIT" #Инициализируем репозиторий
eval "$ADDCMD .files" #Добавляем в него .files
eval "$COMMITCMD $COMMITCOMMENT 'Iitial commit'" #Делаем первый коммит
return 0
}

#Коммит сделанных изменений
function commit(){
if test ! -z "$1" #Если комментарий указан в параметрах
then
COMMENT="$COMMITCOMMENT '$1'" #то добавляем автоматически
else
COMMENT="" #Иначе будет вызвано стандартное добавление комменатрия
fi
eval "$COMMITCMD $COMMENT"
}

#Разворачивание конфигов на новой системе
function makeInstall(){
echo "Not implemented"
}

#Если дирректории с репозиторием не существует
if test ! -d "$REPOPATH"
then
init_repo #То создаём и инициализируем
fi

#Если указан первый параметр
if ! test -z "$1"
then
ACTION="$1" #То он является необходимой операцией
else
echo "No Action!" #Иначе выходим. Без указания операции нам нечего делать
exit 2
fi

# Если указан второй параметр
if test ! -z "$2"
then
TARGET="$2" #То это цель для операции

#Если указан ещё и третий параметр
if test ! -z "$3"
then
TARGET_="$3" #То это имя файла для хранения в репозитории, при добавлении нового файла
else
TARGET_=`basename "$TARGET"|sed "s/^\.//"` #Иначе именем файла будет имя добавляемого файла без предшедствующей точки (если есть такая)
fi
else
#Если второй параметр не указан и операция - добавление файла в репозиторий
if test "$ACTION" == "add"
then
echo "No targret!"
exit 3 #То выходим, т.к. не указано, что добавлять
else
TARGET="" #Для других операций - просто создаём пустую переменную.
fi
fi


cd "$REPOPATH" #Переходим в репозиторий

case "$ACTION" in
"commit") #Commit
commit "$TARGET"
;;

"push") #Push
eval "$PUSHCMD"
;;

"add") #Adding
eval "$CHECKOUTCMD" #Переключаемся в основной репозиторий

#Если файл с указанным именем уже сущестует в репозитории
if test -f "$REPOPATH/$TARGET_"
then
#Предлагаем его переименовать
echo "File exists! Rename? (Blank for cancel):"
read TARGET_
if test -z "$TARGET_" #Если нет нового имени
then
exit 4 #Выходим
fi
fi

COMMENT="Added $CURDIR/$TARGET as $TARGET_" #Создаём комментарий для будущего коммита
eval "mv '$CURDIR/$TARGET' '$REPOPATH/$TARGET_'" #Перемещаем файл в дирректорию репозитория
eval "ln -s '$REPOPATH/$TARGET_' '$CURDIR/$TARGET'" #Создаём на него ссылку по исходному пути
eval "$ADDCMD $TARGET_" #Добавляем файл в репозиторий
echo "$TARGET_||$CURDIR_/$TARGET">>$REPOPATH/.files #Записываем в файл исходный путь для файла
eval "$COMMITCMD $COMMITCOMMENT '$COMMENT'" #Коммитим изменения

;;

"install") #Разворачивание конфигов на новой машине
makeInstall
;;

*)
echo "No action!"
exit 5
;;
esac


exit 0
