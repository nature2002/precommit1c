
#Использовать cmdline
#Использовать tempfiles

Функция НастроитьПарсер()
    
	Парсер = Новый ПарсерАргументовКоманднойСтроки();
    Команда = Парсер.ОписаниеКоманды("install", "Установка precommit в текущий git репозиторий");
    Парсер.ДобавитьКоманду(Команда);
    
    Возврат Парсер;

КонецФункции // НастроитьПарсер()

Процедура ВыполнитьОбработку(Знач Парсер, Знач МассивАргументов)
    
    Успех = Ложь;

    Результат = Парсер.Разобрать(МассивАргументов);
    Если ТипЗнч(Результат) = Тип("Структура") Тогда
		Если Результат.Команда = "install" Тогда
            УстановитьВКаталог(ТекущийКаталог());
            Успех = Истина;
        КонецЕсли;
    КонецЕсли;

	Если Не Успех Тогда
		Сообщить("Не удалось выполнить команду. Обратитесь к разработчикам");
        ЗавершитьРаботу(1);
    КонецЕсли;

КонецПроцедуры

Процедура УстановитьВКаталог(Знач Каталог)
	
	КаталогПрекоммита = ТекущийСценарий().Каталог;
	ФайлЛога = ВременныеФайлы.НовоеИмяФайла();
    ФайлСкрипта = ВременныеФайлы.НовоеИмяФайла("cmd");

	ЗаписьТекста = Новый ЗаписьТекста(ФайлСкрипта, "cp866");
	ЗаписьТекста.ЗаписатьСтроку("@echo off");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\ibService """+Каталог+"""\.git\hooks\ibService\ /Y /E /F");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\pre-commit """+Каталог+"""\.git\hooks\ /Y /F");
	ЗаписьТекста.ЗаписатьСтроку("mkdir """+Каталог+"""\.git\hooks\v8Reader");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\v8Reader\V8Reader.epf """+Каталог+"""\.git\hooks\v8Reader\ /Y /F");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\v8files-extractor.os """+Каталог+"""\.git\hooks\ /Y /F");
	ЗаписьТекста.ЗаписатьСтроку("mkdir """+Каталог+"""\.git\hooks\tools");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\tools\v8unpack.exe """+Каталог+"""\.git\hooks\tools\ /Y /F");
	ЗаписьТекста.ЗаписатьСтроку("xcopy """ + КаталогПрекоммита + """\tools\v8unpack.exe """+Каталог+"""\.git\hooks\tools\ /Y /F");
	ЗаписьТекста.ЗаписатьСтроку("cd """+Каталог+"""\");
	ЗаписьТекста.ЗаписатьСтроку("git config --local core.quotepath false");
	ЗаписьТекста.Закрыть();

	КомандаЗапуска = СтрШаблон("cmd /C ""%1"" > %2 2>&1",
    	ОбъединитьПути(КаталогПрекоммита, ФайлСкрипта),
        ФайлЛога);

    ЗапуститьПриложение(КомандаЗапуска,,Истина);

    ЧтениеТекста = Новый ЧтениеТекста(ФайлЛога, "cp866");
    Текст = ЧтениеТекста.Прочитать();
    ЧтениеТекста.Закрыть();
    Сообщить(Текст);

	Сообщить("Установка завершена");

КонецПроцедуры

////////////////////////////////////////////////////////////////////////////

Попытка
    Парсер = НастроитьПарсер();
    ВыполнитьОбработку(Парсер, АргументыКоманднойСтроки);
Исключение
	ВременныеФайлы.Удалить();
    ВызватьИсключение;
КонецПопытки;

ВременныеФайлы.Удалить();