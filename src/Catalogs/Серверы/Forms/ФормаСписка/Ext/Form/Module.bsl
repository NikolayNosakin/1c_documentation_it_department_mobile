﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УстановитьПараметрДинамисческогоСписка();
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрДинамисческогоСписка()
	Список.Параметры.УстановитьЗначениеПараметра("Клиент", Клиент);
КонецПроцедуры

&НаКлиенте
Процедура Клиент1ПриИзменении(Элемент)
	УстановитьПараметрДинамисческогоСписка();
	ОтборПоКлиенту = Клиент;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СобытияФормКлиент.ПриОткрытии(ЭтаФорма, Отказ);
	Клиент = ОтборПоКлиенту;	
	УстановитьПараметрДинамисческогоСписка();
КонецПроцедуры
