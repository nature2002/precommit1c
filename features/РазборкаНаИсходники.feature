# language: ru

Функционал: Выполнение операций по разборке на исходники
    Как Пользователь
    Я хочу иметь возможность разбирать внешние файлы на исходники
    Чтобы я мог проще следить за изменениями в коде

Контекст:
    Допустим я создаю временный каталог и сохраняю его в контекст
    И я сохраняю каталог проекта в контекст
    И я устанавливаю временный каталог как рабочий каталог
    И я установил рабочий каталог как текущий каталог

Сценарий: Разборка файла из заданной папки
    Когда я выполняю команду "oscript" c параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <КаталогПроекта>/tests/Fixture.epf <РабочийКаталог>"
    Тогда в рабочем каталоге существует каталог "Fixture"
    И в подкаталоге "Fixture" рабочего каталога существует файл "renames.txt"
    И в подкаталоге "Fixture" рабочего каталога существует каталог "Form"
    И в подкаталоге "Fixture" рабочего каталога существует каталог "Макеты"
    И в подкаталоге "Fixture" рабочего каталога существует каталог "und"

Сценарий: Разборка каталога с вложенными каталогами
    Когда я создаю каталог "bin" в рабочем каталоге
    И я создаю каталог "1" в подкаталоге "bin" рабочего каталога
    И я копирую файл "Fixture.epf" из каталога "tests" проекта в подкаталог "bin/1" рабочего каталога
    И я создаю каталог "src" в рабочем каталоге
    И я выполняю команду "oscript" c параметрами "<КаталогПроекта>/v8files-extractor.os --decompile <РабочийКаталог>/bin <РабочийКаталог>/src"
    Тогда в рабочем каталоге существует каталог "src/1/Fixture"
    И в подкаталоге "src/1/Fixture" рабочего каталога существует файл "renames.txt"
    И в подкаталоге "src/1/Fixture" рабочего каталога существует каталог "Form"
    И в подкаталоге "src/1/Fixture" рабочего каталога существует каталог "Макеты"
    И в подкаталоге "src/1/Fixture" рабочего каталога существует каталог "und"
