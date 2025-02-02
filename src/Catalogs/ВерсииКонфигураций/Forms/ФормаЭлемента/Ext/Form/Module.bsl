﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	НовыйМассив = Новый Массив();
	НовыйМассив.Добавить(Новый ПараметрВыбора("Отбор.Конфигурация", Объект.Конфигурация));
	НовыеПараметры = Новый ФиксированныйМассив(НовыйМассив);	
	Элементы.ОбновлениеДляВерсий.ПараметрыВыбора = НовыеПараметры;
	
	ТЗ = Объект.ОбновлениеДляВерсий.Выгрузить();
	ОбновлениеДляВерсий.ЗагрузитьЗначения(ТЗ.ВыгрузитьКолонку("Версия"));
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВерсииИзСтроки(Команда)
	
	Оповещение = Новый ОписаниеОповещения("ЗаполнитьВерсииДляОбновленияСтрокой", ЭтотОбъект);
    ПоказатьВводСтроки(Оповещение,, "Введите версии через запятую",0,Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВерсииДляОбновленияСтрокой(Результат, Параметры) Экспорт
 
    Если Не Результат = Неопределено Тогда		
		МассивВерсий = СтрРазделить(Результат, ",");
		ЗаполнитьВерсииИзМассива(МассивВерсий);		
	КонецЕсли;
	 
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВерсииИзМассива(МассивВерсий)
	
	ОбновлениеДляВерсий.Очистить();
	
	Для каждого стр из МассивВерсий Цикл
		стр = СокрЛП(стр);
		Версия = Справочники.ВерсииКонфигураций.ПустаяСсылка();
		
		Запрос = Новый Запрос("ВЫБРАТЬ
		|	ВерсииКонфигураций.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ВерсииКонфигураций КАК ВерсииКонфигураций
		|ГДЕ
		|	ВерсииКонфигураций.Наименование = &Версия");
		Запрос.УстановитьПараметр("Версия",стр);
		ЗВ = Запрос.Выполнить();
		Если ЗВ.Пустой() Тогда
			Сообщить("Не найдена версия " + стр);
		Иначе
			Таб = ЗВ.Выгрузить();
			Если Таб.Количество()=1 Тогда
				Версия = Таб[0].Ссылка;
			Иначе
				Запрос = Новый запрос("ВЫБРАТЬ
				|	ВерсииКонфигураций.Ссылка КАК Ссылка
				|ИЗ
				|	Справочник.ВерсииКонфигураций КАК ВерсииКонфигураций
				|ГДЕ
				|	ВерсииКонфигураций.Конфигурация = &Конфигурация
				|	И ВерсииКонфигураций.Наименование = &Версия");
				Запрос.УстановитьПараметр("Версия",стр);
				Запрос.УстановитьПараметр("Конфигурация",Объект.Конфигурация);
				ЗВ = Запрос.Выполнить();
				Если ЗВ.Пустой() Тогда
					Сообщить("Не найдена версия " + стр);
				Иначе
					Таб = ЗВ.Выгрузить();
					Версия = Таб[0].Ссылка;
				КонецЕсли;	
			КонецЕсли;	
		Конецесли;	
			
		Если НЕ Версия.Пустая() Тогда
			ОбновлениеДляВерсий.Добавить(Версия);
		КонецЕсли;
		
	КонецЦикла;	
	
	ЗаполнитьВерсииДляОбновления();
	
КонецПроцедуры


&НаКлиенте
Процедура ОбновлениеДляВерсий1ПриИзменении(Элемент)
	ЗаполнитьВерсииДляОбновления();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВерсииДляОбновления()
	
	Объект.ОбновлениеДляВерсий.Очистить();
	Для каждого стр из ОбновлениеДляВерсий Цикл
		Строка = Объект.ОбновлениеДляВерсий.Добавить();
		Строка.Версия = стр.Значение;
	КонецЦикла;
	ЭтаФорма.Модифицированность = Истина;	
	
КонецПроцедуры	

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если ЭтаФорма.Модифицированность Тогда
		ОбновлениеДляВерсийСтрока = "";
		Для каждого стр из Объект.ОбновлениеДляВерсий Цикл
			ОбновлениеДляВерсийСтрока = ?(ОбновлениеДляВерсийСтрока="",Строка(стр.Версия),ОбновлениеДляВерсийСтрока + ", " + стр.Версия);
		КонецЦикла;	
		Объект.ОбновлениеДляВерсийСтрока = ОбновлениеДляВерсийСтрока;
	КонецЕсли;	
КонецПроцедуры
