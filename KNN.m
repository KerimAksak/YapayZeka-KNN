%A,B ve C siniflari icin 10'ar adet nesne olusturuyoruz.
close all
clear
clc

[xa,ya,xb,yb,xc,yc]=SiniflariUret();

%Her sinif icin elemanlari cizdiriyor.
 for k=1:10
        plot(xa(k),ya(k),'.','color','magenta','MarkerSize',15)
        hold on
        plot(xb(k),yb(k),'*','color','blue','MarkerSize',13)
        hold on
        plot(xc(k),yc(k),'+','color','cyan','MarkerSize',13)
 end

%Rastgele 'X' degeri uretiyor.
x=randi([50 200]);
y=randi([50 220]);
plot(x,y,'x','color','black','MarkerSize',15);
hold on

%Her sinifin elemanlarinin X degerine uzakliklarini hesapliyor.
[uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s] = UzaklikHesaplama(x,y,xa,ya,xb,yb,xc,yc);


%X'in sinifini belirlemek icin KNN algoritlarini kullaniyor.

%KNN 3
[siniflar3,xxa,yya,xxb,yyb,xxc,yyc] = KNN3(uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s);
figure('name','KNN3')
KNN3KomsuluklarCiz(xa,ya,xb,yb,xc,yc,xxa,yya,xxb,yyb,xxc,yyc,x,y)
hold on

%KNN 5
[siniflar5,xxaa,yyaa,xxbb,yybb,xxcc,yycc] = KNN5(uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s);
figure('name','KNN5')
KNN5KomsuluklarCiz(xa,ya,xb,yb,xc,yc,xxaa,yyaa,xxbb,yybb,xxcc,yycc,x,y)
hold on

%KNN sinif agirliklari
[sinif] = KNNagirlikli(xa,ya,xb,yb,xc,yc,x,y);

%Sonuclar
fprintf("KNN(3): X deðerinin k=3 için komþuluk sýnýflarý %c, %c ve %c'dir.\n",siniflar3(1),siniflar3(2),siniflar3(3));
fprintf("KNN(5): X deðerinin k=5 için komþuluk sýnýflarý %c, %c, %c, %c ve %c'dir.\n",siniflar5(1),siniflar5(2),siniflar5(3),siniflar5(4),siniflar5(5));
fprintf("KNN(Aðýrlýk Noktasý): X deðerinin 3 sýnýfýn aðrlýk noktalarýna göre sýnýfý %c'dir.\n",sinif);


%---------------------------FONKSIYONLAR-----------------------------------

%----------------------------SINIFLARI URETEN FONKSIYON--------------------
function[xa,ya,xb,yb,xc,yc] = SiniflariUret() 
    clear
    %A sinifi
    xa=randi([50 120],1,10);
    ya=randi([50 120],1,10);
   
    %B sinifi
    xb=randi([50 150],1,10);
    yb=randi([150 220],1,10);

    %C sinifi
    xc=randi([150 200],1,10);
    yc=randi([100 200],1,10);
end
%--------------------------------------------------------------------------


%----------------------UZAKLIKLARI HESAPLAYAN FONKSÝYON--------------------
function [uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s] = UzaklikHesaplama(x,y,xa,ya,xb,yb,xc,yc)
uzaklikA=zeros(size(10));
uzaklikB=zeros(size(10));
uzaklikC=zeros(size(10));
tumUzakliklar=zeros(size(30));


%A sinifinin tum elemanlari icin uzaklik degerleri.
for k=1:10
    uzaklikA(k)=sqrt((xa(k)-x)^2+(ya(k)-y)^2);
    tumUzakliklar(k)=sqrt((xa(k)-x)^2+(ya(k)-y)^2);
end

%B sinifinin tum elemanlari icin uzaklik degerleri.
for k=1:10
    uzaklikB(k)=sqrt((xb(k)-x)^2+(yb(k)-y)^2);
    tumUzakliklar(k+10)=sqrt((xb(k)-x)^2+(yb(k)-y)^2);
end

%C sinifinin tum elemanlari icin uzaklik degerleri.
for k=1:10
    uzaklikC(k)=sqrt((xc(k)-x)^2+(yc(k)-y)^2);
    tumUzakliklar(k+20)=sqrt((xc(k)-x)^2+(yc(k)-y)^2);
end

%Komsuluk dogrulari icin gerekli olan parametreler struct yapisinda tutuluyor.
s=struct;
for i=1:10
    s(i).xa=xa(i);
    s(i).ya=ya(i);
    s(i).xb=xb(i);
    s(i).yb=yb(i);
    s(i).xc=xc(i);
    s(i).yc=yc(i);
    s(i).uzaklikA=uzaklikA(i);
    s(i).uzaklikB=uzaklikB(i);
    s(i).uzaklikC=uzaklikC(i);
end

    tumUzakliklar=sort(tumUzakliklar);
    uzaklikA=sort(uzaklikA);
    uzaklikB=sort(uzaklikB);
    uzaklikC=sort(uzaklikC);
end
%--------------------------------------------------------------------------



%--------------------KNN k=3 ICIN COZUM YAPAN FONKSIYON--------------------
function [siniflar,xxa,yya,xxb,yyb,xxc,yyc] = KNN3(uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s)

    %K 3 degeri icin komsuluk degerleri bulunmasi
    yakinlikDerecesi1=[uzaklikA(1),uzaklikB(1),uzaklikC(1)];
    yakinlikDerecesi2=[uzaklikA(2),uzaklikB(2),uzaklikC(2)];
    yakinlikDerecesi3=[uzaklikA(3),uzaklikB(3),uzaklikC(3)];
    
    yakinlikDerecesi1=sort(yakinlikDerecesi1);
    yakinlikDerecesi2=sort(yakinlikDerecesi2);
    yakinlikDerecesi3=sort(yakinlikDerecesi3);
  
   
    for i=1:3
        for k=1:3
            if(tumUzakliklar(i)==uzaklikA(k))
                siniflar(i)='A';
            elseif(tumUzakliklar(i)==uzaklikB(k))
                siniflar(i)='B';
            elseif(tumUzakliklar(i)==uzaklikC(k))
                siniflar(i)='C';
            end
        end
    end
    
    %zeros(size(3)) yapinca geri dönüs degeri olarak 1x1 boyutlu [0]
    %   donduruyor.
    xxa=[0 0 0]; 
    yya=[0 0 0]; 
    xxb=[0 0 0];  
    yyb=[0 0 0]; 
    xxc=[0 0 0]; 
    yyc=[0 0 0]; 
   
    for k=1:3
        for i=1:10
            if(s(i).uzaklikA==tumUzakliklar(k))
                xxa(k)=s(i).xa;
                yya(k)=s(i).ya;
            elseif(s(i).uzaklikB==tumUzakliklar(k))
                xxb(k)=s(i).xb;
                yyb(k)=s(i).yb;
            elseif(s(i).uzaklikC==tumUzakliklar(k))
                xxc(k)=s(i).xc;
                yyc(k)=s(i).yc;
            end
        end
    end
 
   
end
%--------------------------------------------------------------------------


%--------------------KNN k=5 ICIN COZUM YAPAN FONKSIYON--------------------
function [siniflar,xxaa,yyaa,xxbb,yybb,xxcc,yycc] = KNN5(uzaklikA,uzaklikB,uzaklikC,tumUzakliklar,s)

    %K 5 degeri icin komsuluk degerleri bulunmasi
    yakinlikDerecesi1=[uzaklikA(1),uzaklikB(1),uzaklikC(1)];
    yakinlikDerecesi2=[uzaklikA(2),uzaklikB(2),uzaklikC(2)];
    yakinlikDerecesi3=[uzaklikA(3),uzaklikB(3),uzaklikC(3)];
    
    yakinlikDerecesi1=sort(yakinlikDerecesi1);
    yakinlikDerecesi2=sort(yakinlikDerecesi2);
    yakinlikDerecesi3=sort(yakinlikDerecesi3);
  
  
    for i=1:5
        for k=1:5
            if(tumUzakliklar(i)==uzaklikA(k))
                siniflar(i)='A';
            elseif(tumUzakliklar(i)==uzaklikB(k))
                siniflar(i)='B';
            elseif(tumUzakliklar(i)==uzaklikC(k))
                siniflar(i)='C';
            end
        end
    end
    
    xxaa=[0 0 0 0 0]; 
    yyaa=[0 0 0 0 0]; 
    xxbb=[0 0 0 0 0];  
    yybb=[0 0 0 0 0]; 
    xxcc=[0 0 0 0 0]; 
    yycc=[0 0 0 0 0]; 
   
    for k=1:5
        for i=1:10
            if(s(i).uzaklikA==tumUzakliklar(k))
                xxaa(k)=s(i).xa;
                yyaa(k)=s(i).ya;
            elseif(s(i).uzaklikB==tumUzakliklar(k))
                xxbb(k)=s(i).xb;
                yybb(k)=s(i).yb;
            elseif(s(i).uzaklikC==tumUzakliklar(k))
                xxcc(k)=s(i).xc;
                yycc(k)=s(i).yc;
            end
        end
    end
 
   
end
%--------------------------------------------------------------------------


%-----------KNN SINIF AGIRLIKLARINA GORE COZUM YAPAN FONKSIYON-------------
function [sinif] = KNNagirlikli(xa,ya,xb,yb,xc,yc,x,y)
    
    %A sinifi
    maxxa=max(xa);
    minxa=min(xa);
    maxya=max(ya);
    minya=min(ya);

    xaAgirlik=((maxxa-minxa)/2)+minxa;
    yaAgirlik=((maxya-minya)/2)+minya;

    %B sinifi
    maxxb=max(xb);
    minxb=min(xb);
    maxyb=max(yb);
    minyb=min(yb);

    xbAgirlik=((maxxb-minxb)/2)+minxb;
    ybAgirlik=((maxyb-minyb)/2)+minyb;

    %C sinifi
    maxxc=max(xc);
    minxc=min(xc);
    maxyc=max(yc);
    minyc=min(yc);

    xcAgirlik=((maxxc-minxc)/2)+minxc;
    ycAgirlik=((maxyc-minyc)/2)+minyc;

    
    uzaklik=struct;
    uzaklik(1).Agirlik=sqrt((xaAgirlik-x)^2+(yaAgirlik-y)^2);
    uzaklik(2).Agirlik=sqrt((xbAgirlik-x)^2+(ybAgirlik-y)^2);
    uzaklik(3).Agirlik=sqrt((xcAgirlik-x)^2+(ycAgirlik-y)^2);

    uzaklik(1).sinif='A';
    uzaklik(2).sinif='B';
    uzaklik(3).sinif='C';
    
    minUzaklik=[uzaklik(1).Agirlik uzaklik(2).Agirlik uzaklik(3).Agirlik];
    minnUzaklik=min(minUzaklik);

    for i=1:3
        if(minnUzaklik==uzaklik(1).Agirlik)
            sinif=uzaklik(1).sinif;
        elseif(minnUzaklik==uzaklik(2).Agirlik)
            sinif=uzaklik(2).sinif;
        elseif(minnUzaklik==uzaklik(3).Agirlik)
            sinif=uzaklik(3).sinif;
        end
    end
    
end
%--------------------------------------------------------------------------


%-------------------KNN K=3 ICIN KOMSULUK CIZEN FONKSIYON------------------
function [] = KNN3KomsuluklarCiz(xa,ya,xb,yb,xc,yc,xxa,yya,xxb,yyb,xxc,yyc,x,y)
for k=1:10
        plot(xa(k),ya(k),'.','color','magenta','MarkerSize',15)
        hold on
        plot(xb(k),yb(k),'*','color','blue','MarkerSize',13)
        hold on
        plot(xc(k),yc(k),'+','color','cyan','MarkerSize',13)
end
 plot(x,y,'x','color','black','MarkerSize',15);
hold on
for i=1:3
    if(xxa(i)==0 || yya(i)==0)
        
    else
        line([x xxa(i)],[y,yya(i)],'color','green','MarkerSize',13)
        hold on
    end
end
for i=1:3
    if(xxb(i)==0 || yyb(i)==0)
        
    else
        line([x xxb(i)],[y,yyb(i)],'color','green','MarkerSize',13)
        hold on
    end
end
for i=1:3
    if(xxc(i)==0 || yyc(i)==0)
        
    else
        line([x xxc(i)],[y,yyc(i)],'color','green','MarkerSize',13)
        hold on
    end
end
end
%--------------------------------------------------------------------------



%-------------------KNN K=5 ICIN KOMSULUK CIZEN FONKSIYON------------------
function [] = KNN5KomsuluklarCiz(xa,ya,xb,yb,xc,yc,xxa,yya,xxb,yyb,xxc,yyc,x,y)

%Siniflarin elemanlari
for k=1:10
        plot(xa(k),ya(k),'.','color','magenta','MarkerSize',15)
        hold on
        plot(xb(k),yb(k),'*','color','blue','MarkerSize',13)
        hold on
        plot(xc(k),yc(k),'+','color','cyan','MarkerSize',13)
end

% X deðeri 
plot(x,y,'x','color','black','MarkerSize',15);
hold on

%Komsuluk dogrulari
for i=1:5
    if(xxa(i)==0 || yya(i)==0)
        
    else
        line([x xxa(i)],[y,yya(i)],'color','green','MarkerSize',13)
        hold on
    end
end
for i=1:5
    if(xxb(i)==0 || yyb(i)==0)
        
    else
        line([x xxb(i)],[y,yyb(i)],'color','green','MarkerSize',13)
        hold on
    end
end
for i=1:5
    if(xxc(i)==0 || yyc(i)==0)
        
    else
        line([x xxc(i)],[y,yyc(i)],'color','green','MarkerSize',13)
        hold on
    end
end
end
%--------------------------------------------------------------------------



