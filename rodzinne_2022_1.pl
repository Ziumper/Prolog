rodzice(jan,ewa,[adam],[maria]).
rodzice(adam,halina,[norbert],[monika]).
rodzice(piotr,maria,[krzysztof]).
ojciec(edward,[],[halina]).
matka(monika,[maciej],[]).

% element(b,[a,b,c]). %odpowiedz true
% element(X,[a,b,c]). %wszystkie wartosci spelniajace zapytanie x=a, x=b
% , x=c

%element(E,[G|O]):- E == G. rownoazne jest temu co ponizej
element(E,[E|_]). %_ podkreslnik dowolna literka
element(E,[_|O]):- element(E,O).


%zliczajacy meta predykat
%P - formula zwracajaca wyniki
%Count zmienna przetrzymujaca zliczenie wynikow
%L - lista wynikow
count(P,Count) :-
        findall(1,P,L),
        length(L,Count).

liczba_przodkow(Licznik,ImiePotomka):-
    count(przodek(_,ImiePotomka),Licznik).


kuzyn(ImieKuzyna1,ImieKuzyna2):-
    dziadek(ImieDziadka,ImieKuzyna1),
    dziadek(ImieDziadka,ImieKuzyna2),
    ImieKuzyna1 \== ImieKuzyna2,
    \+brat(ImieKuzyna1,ImieKuzyna2),
    \+siostra(ImieKuzyna1,ImieKuzyna2),
    \+brat(ImieKuzyna2,ImieKuzyna1),
    \+siostra(ImieKuzyna2,ImieKuzyna1).

krewni(ImieKrewnego1,ImieKrewnego2):-
    przodek(ImiePrzodka,ImieKrewnego1),
    przodek(ImiePrzodka,ImieKrewnego2),
    ImieKrewnego1 \== ImieKrewnego2.


przodek(ImiePrzodka,ImiePotomka):-
    potomek(ImiePotomka,ImiePrzodka).

potomek(ImiePotomka,ImiePrzodka):-
    dziecko(ImiePotomka,ImiePrzodka).

potomek(ImiePotomka,ImiePrzodka):-
    dziecko(ImiePotomka,ImieRodzica),
    potomek(ImieRodzica,ImiePrzodka).

bratanek(ImieBratanka,ImieStryja):-
    stryj(ImieStryja,ImieBratanka).


tesciowa(ImieTesciowej,ImieMeza):-
    maz(ImieMeza,Zona),
    plec(ImieTesciowej,k),
    rodzic(ImieTesciowej,Zona).

maz(ImieMeza,ImieZony):-
    zona(ImieZony,ImieMeza).

zona(ImieZony,ImieMeza):-
    rodzice(ImieMeza,ImieZony,_,_).
zona(ImieZony,ImieMeza):-
    rodzice(ImieMeza,ImieZony,_).

wuj(Wuj,Siostrzeniec):-
    plec(Wuj,m),
    rodzic(Rodzic,Siostrzeniec),
    plec(Rodzic,k),
    brat(Wuj,Rodzic).

stryj(Stryj,Siostrzeniec):-
    plec(Stryj,m),
    rodzic(Rodzic,Siostrzeniec),
    plec(Rodzic,m),
    brat(Rodzic,Stryj).

dziadek(Dziadek,Wnuk):-
    rodzic(Dziadek,Rodzic),
    rodzic(Rodzic,Wnuk),
    plec(Dziadek,m).

babcia(Babcia,Wnuk):-
    rodzic(Babcia,Rodzic),
    rodzic(Rodzic,Wnuk),
    plec(Babcia,k).

syn(Syn,Rodzic):-
    rodzic(Rodzic,Syn),
    plec(Syn,m).

corka(Corka,Rodzic):-
    rodzic(Rodzic,Corka),
    plec(Corka,k).


%dziecko
dziecko(Dziecko,Rodzic) :- rodzic(Rodzic,Dziecko),
    Dziecko \== Rodzic.


brat(ImieBrata,Y):-
    rodzic(R,ImieBrata),
    rodzic(R,Y),
    plec(ImieBrata,m),
    ImieBrata \== Y.

siostra(ImieSiostra,Y):-
    rodzic(R,ImieSiostra),
    rodzic(R,Y),
    plec(ImieSiostra,k),
    ImieSiostra \== Y.

plec(X,m) :-
    rodzice(_,_,Lista_s),
    element(X,Lista_s).
plec(X,m) :-
    rodzice(_,_,Lista_s,_),
    element(X,Lista_s).
plec(X,m):-
    ojciec(_,Lista_s,_),
    element(X,Lista_s).
plec(X,m):-
    matka(_,Lista_s,_),
    element(X,Lista_s).
plec(X,m):-
    ojciec(X,_,_).
plec(X,m):-
    rodzice(X,_,_,_).

plec(X,k):-
    rodzice(_,_,_,Lista_s),
    element(X,Lista_s).
plec(X,k):-
    rodzice(_,X,_,_).
plec(X,k):-
    ojciec(_,_,Lista_c),
    element(X,Lista_c).
plec(X,k):-
    matka(_,_,Lista_c),
    element(X,Lista_c).
plec(X,k):-
    matka(X,_,_).


%synowie
rodzic(X,Y):- ojciec(X,Lista_s,_),
    element(Y,Lista_s),
    X \== Y.
rodzic(X,Y):- matka(X,Lista_s,_),
    element(Y,Lista_s),
    X \== Y.
%ojciec/syn
rodzic(X,Y):- rodzice(X,_,Lista_s,_),
    element(Y,Lista_s),
    X \==Y.
rodzic(X,Y):- rodzice(X,_,Lista_s),
    element(Y,Lista_s),
    X \==Y.

%matka/syn
rodzic(X,Y):- rodzice(_,X,Lista_s),
    element(Y,Lista_s),
    X \== Y.
rodzic(X,Y):- rodzice(_,X,Lista_s,_),
    element(Y,Lista_s),
    X \== Y.

%matka corka
rodzic(X,Y):- rodzice(_,X,_,Lista_c),
    element(Y,Lista_c),
    X \== Y.


rodzic(X,Y):- rodzice(X,_,_,Lista_c),
    element(Y,Lista_c),
    X \== Y.

%ojciec corka
rodzic(X,Y):- ojciec(X,_,Lista_c),
    element(Y,Lista_c),
    X \== Y.

rodzic(X,Y):- matka(X,_,Lista_c),
    element(Y,Lista_c),
    X \== Y.




