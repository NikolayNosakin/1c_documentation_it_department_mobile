﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТипБДСервер();	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ВидимостьWebСервер();
	ИспользуетсяХранилищеКонфигурации();
КонецПроцедуры   
   
&НаКлиенте
Процедура ИспользуетсяХранилищеКонфигурацииПриИзменении(Элемент)
	ИспользуетсяХранилищеКонфигурации();
КонецПроцедуры

&НаКлиенте
Процедура ИспользуетсяХранилищеКонфигурации()
	Элементы.ГруппаПользователиХранилища.Видимость = Объект.ИспользуетсяХранилище;
	Элементы.ПутьКХранилищу.Видимость = Объект.ИспользуетсяХранилище;
КонецПроцедуры

&НаКлиенте
Процедура ТипБДПриИзменении(Элемент)
	ТипБДСервер();
КонецПроцедуры

&НаСервере
Процедура ТипБДСервер()	
	Если НЕ Объект.ТипБД.Пустая() Тогда 
		Элементы.ИмяИБ.Видимость = НЕ Объект.ТипБД = Перечисления.ТипБД.Файловая;
		Элементы.ПутьК_БД.Видимость = Объект.ТипБД = Перечисления.ТипБД.Файловая;
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура ОпубликованаНаWebСервереПриИзменении(Элемент)
	ВидимостьWebСервер();
КонецПроцедуры

&НаКлиенте
Процедура ВидимостьWebСервер()	
	Элементы.WebСервер.Видимость = Объект.ОпубликованаНаWebСервере;
	Элементы.АдресПубликации.Видимость = Объект.ОпубликованаНаWebСервере;
КонецПроцедуры



