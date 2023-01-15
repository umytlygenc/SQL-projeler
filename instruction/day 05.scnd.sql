-- GROUP BY
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
​
delete from personel
​
--Isme gore toplam maaslari bulun
SELECT isim,sum(maas) FROM personel
GROUP BY isim
​
-- Personel tablosundaki isimleri gruplayınız
SELECT isim, count(sehir) FROM personel
GROUP BY isim
​
-- HAVING KULLANIMI
/*
Having komutu yanlızca group by komutu ile kullanılır. 
Eğer gruplamadan sonra bir şart varsa having komutu kullanılır
Where kullanımı ile aynı mantıkta çalışır
*/
-- 1) Her sirketin MIN	maaslarini eger 4000’den buyukse goster
SELECT * FROM personel
​
SELECT sirket,min(maas) as en_dusuk_maas FROM personel
GROUP BY sirket
HAVING min(maas)>4000
​
-- Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi  ve toplam maasi gosteren sorgu yaziniz
​
SELECT isim,sum(maas) as toplam_maas FROM personel
GROUP BY isim
HAVING sum(maas)>10000
​
-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
​
SELECT sehir,count(isim) as toplam_personel_sayisi FROM personel
GROUP BY sehir
HAVING count(isim)>1
​
-- Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
​
SELECT sehir,max(maas) as en_yuksek_maas FROM personel
GROUP BY sehir
HAVING max(maas)<5000
​
-- UNION KULLANIMI
​
--Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan  sehirleri	gosteren sorguyu yaziniz
SELECT isim as isim_ve_sehirler,maas FROM personel WHERE maas>4000
union
SELECT sehir,maas FROM personel WHERE maas>5000
​
-- Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
SELECT isim as isim_ve_sehir,maas FROM personel WHERE isim='Mehmet Ozturk'
union
SELECT sehir,maas FROM personel WHERE sehir='Istanbul' 
ORDER BY maas
​
DROP TABLE if exists personel
​
CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
​
CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);
​
select * from personel
select * from personel_bilgi
-- id’si 123456789 olan personelin	Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
SELECT sehir as sehir_ve_tel ,maas as maas_ve_cocuksayisi FROM personel WHERE id=123456789
union
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id=123456789;
​
-- UNION ALL
/*
Union tekrarli verileri teke düşürür ve bize o şekilde sonuç verir
Union All ise tekrarli verilerle birlikte tün sorguları getirir
*/
--Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
​
SELECT isim,maas FROM personel WHERE maas<5000
union all
SELECT isim,maas FROM personel WHERE maas<5000
​
-- INTERSECT (Kesişim)
/*
Farkli iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz
*/
--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
​
SELECT id FROM personel WHERE sehir IN ('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN (2,3)
​
select * from personel
--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
​
SELECT isim FROM personel WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel WHERE sirket='Tofas'
​
-- EXCEPT(MINUS) KULLANIMI
/*
İki sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanılır
*/
​
-- 5000’den az maas alip Honda’da calismayanlari yazdirin
​
SELECT isim,sirket FROM personel WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel WHERE sirket='Honda'