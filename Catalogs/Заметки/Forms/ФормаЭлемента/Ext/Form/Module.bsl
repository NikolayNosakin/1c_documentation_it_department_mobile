﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Предмет") Тогда 
		Объект.Предмет = Параметры.Предмет;
		Объект.ПредставлениеПредмета = Строка(Объект.Предмет);
	КонецЕсли;
	
	Элементы.Предмет.Заголовок = Объект.ПредставлениеПредмета;
	//Элементы.ГруппаПредмет.Видимость = ЗначениеЗаполнено(Объект.Предмет);
	
	Если Объект.Ссылка.Пустая() Тогда
		ФорматированныйТекст = Параметры.ЗначениеКопирования.Содержание.Получить();
		
		Элементы.ДатаЗаметки.Заголовок = НСтр("ru = 'Не записано'")
	Иначе
		Элементы.ДатаЗаметки.Заголовок = НСтр("ru = 'Записано'") + ": " + Формат(Объект.ДатаИзменения, "ДЛФ=DDT");
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ФорматированныйТекст = ТекущийОбъект.Содержание.Получить();

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.Содержание = Новый ХранилищеЗначения(ФорматированныйТекст, Новый СжатиеДанных(9));
	
	ТекстHTML = "";
	Вложения = Новый Структура;
	ФорматированныйТекст.ПолучитьHTML(ТекстHTML, Вложения);
	
	ТекущийОбъект.ТекстСодержания = СтроковыеФункцииКлиентСервер.ИзвлечьТекстИзHTML(ТекстHTML);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	Элементы.ДатаЗаметки.Заголовок = НСтр("ru = 'Записано'") + ": " + Формат(Объект.ДатаИзменения, "ДЛФ=DDT");
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ОповеститьОбИзменении(Объект.Ссылка);
	Если ЗначениеЗаполнено(Объект.Предмет) Тогда
		ОповеститьОбИзменении(Объект.Предмет);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПредметНажатие(Элемент)
	ПоказатьЗначение(,Объект.Предмет);
КонецПроцедуры

&НаКлиенте
Процедура АвторНажатие(Элемент)
	ПоказатьЗначение(,Объект.Автор);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
