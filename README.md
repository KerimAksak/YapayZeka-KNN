# KNN SINIFLANDIRILMASI

- S�n�fland�rmada kullan�lan bu algoritmaya g�re s�n�fland�rma s�ras�nda ��kar�lan �zelliklerden (feature extraction), s�n�fland�r�lmak istenen yeni bireyin daha �nceki bireylerden k tanesine yak�nl���na bak�lmas�d�r.
�rne�in k = 3 i�in yeni bir eleman s�n�fland�r�lmak istensin. bu durumda eski s�n�fland�r�lm�� elemanlardan en yak�n 3 tanesi al�n�r. Bu elamanlar hangi s�n�fa dahilse, yeni eleman da o s�n�fa dahil edilir. Mesafe hesab�ndan genelde �klit mesafesi kullan�labilir...[KNN nedir?](http://bilgisayarkavramlari.sadievrenseker.com/2008/11/17/knn-k-nearest-neighborhood-en-yakin-k-komsu/)

- Proje i�erisinde rastgele 3 s�n�f olu�turulmaktad�r.

	![Screenshot](png/3sinif.png)
	
	Olu�turulan s�n�flardan sonra yine rastgele olacak �ekilde bir bilinmeyen (X) nesnesi olu�turulur. Daha sonra bu olu�turulan nesnenin hangi s�n�fa ait oldu�unu bulabilmek i�in ilk �nce k=3 de�eri i�in s�n�flar kontrol edilir.
	
	![Screenshot](png/k3.png)
	
	S�n�fland�rma i�lemini kesinle�tirmek i�in k=5 de�eri i�in de kontrol edilir.
	
	![Screenshot](png/k5.png)
	
	