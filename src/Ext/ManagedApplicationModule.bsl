﻿#Область ОписаниеПеременных
Перем ОтборПоКлиенту Экспорт; 
#КонецОбласти

Процедура ПередНачаломРаботыСистемы(Отказ)
КонецПроцедуры

Процедура ПриНачалеРаботыСистемы()
КонецПроцедуры

Процедура ПередЗавершениемРаботыСистемы(Отказ, ТекстПредупреждения)
КонецПроцедуры

Процедура ПриЗавершенииРаботыСистемы()
КонецПроцедуры

#Область Инициализация
ОтборПоКлиенту = ПредопределенноеЗначение("Справочник.Клиенты.ПустаяСсылка");
#КонецОбласти