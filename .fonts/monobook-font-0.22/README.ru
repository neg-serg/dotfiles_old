I. Сборка
  a) tar xjvf monobook-font-<version>.tar.bz2
  b) cd monobook-font-<version>
  c) make
     Команда make сгенерирует шрифты pcf.gz, psf.gz и raw (для bsd). Шрифты PCF
     генерируются в кодировке ISO10646-1, а PSF и RAW - в KOI8-R. Если вам нужны
     шрифты в другой кодировке, закомментируйте соответствующую строку в Makefile и
     раскомментируйте другую. Вы можете запустить "make pcf", "make psf" или "make
     raw" чтобы собрать только то, что нужно.

II. Установка
  1. X Window System
    a) Удостоверьтесь, что вы - root.
    b) Перейдите в каталог, где хранятся шрифты X (/usr/share/fonts, или
       /usr/share/X11/fonts, или что-то ещё, зависит от ОС), и создайте новый
       подкаталог, например:
       cd /usr/share/fonts
       mkdir monobook
    c) Скопируйте все файлы из monobook-font-<version>/pcf в созданный каталог. Затем
    перейдите в этот каталог и запустите mkfontdir.
    d) Добавьте строку в секцию "Files" xorg.conf. Например:
       Section "Files"
          <всякая ерунда>
          FontPath	"/usr/share/fonts/monobook/"
          <всякая ерунда>
       EndSection
    e) Перезапустите X.
  2. Linux console
    a) Скопируйте все файлы из monobook-font-<version>/psf в /usr/share/consolefonts.
    b) Чтобы узнать как настроить установку шрифта при загрузке, смотрите
    документацию к дистрибутиву.
  3. Консоль *BSD
    a) Я не пользуюсь BSD.
    b) Если вы ей пользуетесь, то вам, наверное, лучше знать куда положить шрифты и
    как их потом загрузить.

III. Лицензия
Monobook font распространяется в соответствии с GNU General Public License (GPL)
version 3. Подробнее смотрите в COPYING.

IV. Контакты
<dclxvi at xakep dot ru>
