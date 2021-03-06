rodzice(jan,ewa,adam,m).
rodzice(jan,ewa,maria,k).
rodzice(adam,halina,monika,k).
rodzice(adam,halina,norbert,m).
rodzice(piotr,maria,krzysztof,m).
ojciec(edward,halina,k).
matka(monika,maciej,m).

%podkreslenie _ oznacza dowolna literke
dziecko(ImieDziecka,ImieRodzica):-
    rodzice(ImieRodzica,_,ImieDziecka,_).
dziecko(ImieDziecka,ImieRodzica):-
    rodzice(_,ImieRodzica,ImieDziecka,_).
dziecko(ImieDziecka,ImieRodzica):-
    ojciec(ImieRodzica,ImieDziecka,_).
dziecko(ImieDziecka,ImieRodzica):-
    matka(ImieRodzica,ImieDziecka,_).

syn(ImieDziecka,ImieOjca,ImieMatki):-
    rodzice(ImieOjca,ImieMatki,ImieDziecka,m).
syn(ImieDziecka,ImieOjca):-
    ojciec(ImieOjca,ImieDziecka,m).
syn(ImieDziecka,ImieMatki):-
    matka(ImieMatki,ImieDziecka,m).

córka(ImieDziecka,ImieOjca,ImieMatki):-
    rodzice(ImieOjca,ImieMatki,ImieDziecka,k).
córka(ImieDziecka,ImieOjca):-
    ojciec(ImieOjca,ImieDziecka,k).
córka(ImieDziecka,ImieMatki):-
    matka(ImieMatki,ImieDziecka,k).

zona(ImieZony,ImieMeza):-
    rodzice(ImieMeza,ImieZony,_,_).

maz(ImieMeza,ImieZony):-
    rodzice(ImieMeza,ImieZony,_,_).

dziadek(ImieDziadka,ImieWnuczenta):-
    ojciec(ImieDziadka,ImieRodzica,_),
    rodzice(_,ImieRodzica,ImieWnuczenta,_).
dziadek(ImieDziadka,ImieWnuczenta):-
    ojciec(ImieDziadka,ImieRodzica,_),
    rodzice(ImieRodzica,_,ImieWnuczenta,_).
dziadek(ImieDziadka,ImieWnuczenta):-
    rodzice(ImieDziadka,_,ImieRodzica,_),
    dziecko(ImieWnuczenta,ImieRodzica).

babcia(ImieBabci,ImieWnuczenta):-
    matka(ImieBabci,ImieRodzica,_),
    rodzice(_,ImieRodzica,ImieWnuczenta,_).
babcia(ImieBabci,ImieWnuczenta):-
    matka(ImieBabci,ImieRodzica,_),
    rodzice(ImieRodzica,_,ImieWnuczenta,_).
babcia(ImieBabci,ImieWnuczenta):-
    rodzice(_,ImieBabci,ImieRodzica,_),
    dziecko(ImieWnuczenta,ImieRodzica).

%brat i siostra maja takich samych rodzicow
brat(ImieBrata,Imie):-
    rodzice(ImieOjca,ImieMatki,ImieBrata,m),
    rodzice(ImieOjca,ImieMatki,Imie,_).

siostra(ImieSiostry,Imie):-
    rodzice(ImieOjca,ImieMatki,ImieSiostry,k),
    rodzice(ImieOjca,ImieMatki,Imie,_).

stryj(ImieStryja,ImieSiostrzenca):-
    rodzice(ImieOjca,_,ImieSiostrzenca,_),
    brat(ImieStryja,ImieOjca).
stryj(ImieStryja,ImieSiostrzenca):-
    ojciec(ImieOjca,ImieSiostrzenca,_),
    brat(ImieStryja,ImieOjca).

wuj(ImieWuja,ImieSiostrzenca):-
    rodzice(_,ImieMatki,ImieSiostrzenca,_),
    brat(ImieWuja,ImieMatki).
wuj(ImieWuja,ImieSiostrzenca):-
    matka(ImieMatki,ImieSiostrzenca,_),
    brat(ImieWuja,ImieMatki).

tesciowa(ImieTesciowej,ImiePoszkodowanego):-
    maz(ImiePoszkodowanego,ImieZony),
    dziecko(ImieZony,ImieTesciowej).


bratanek(ImieBratanka,Imie):-
    brat(ImieOjca,Imie),
    ojciec(ImieOjca,ImieBratanka,m).
bratanek(ImieBratanka,Imie):-
    brat(ImieOjca,Imie),
    rodzice(ImieOjca,_,ImieBratanka,m).

potomek(ImiePotomka,ImiePrzodka):-
    dziecko(ImiePotomka,ImiePrzodka).

potomek(ImiePotomka,ImiePrzodka):-
    dziecko(ImiePotomka,ImieRodzica),
    potomek(ImieRodzica,ImiePrzodka).

przodek(ImiePrzodka,ImiePotomka):-
    potomek(ImiePotomka,ImiePrzodka).

kuzyn(ImieKuzyna1,ImieKuzyna2):-
    dziadek(ImieDziadka,ImieKuzyna1),
    dziadek(ImieDziadka,ImieKuzyna2).

krewni(ImieKrewnego1,ImieKrewnego2):-
    przodek(ImiePrzodka,ImieKrewnego1),
    przodek(ImiePrzodka,ImieKrewnego2).

%zliczajacy meta predykat
%P - formula zwracajaca wyniki
%Count zmienna przetrzymujaca zliczenie wynikow
%L - lista wynikow
count(P,Count) :-
        findall(1,P,L),
        length(L,Count).

liczba_przodkow(Licznik,ImiePotomka):-
    count(przodek(_,ImiePotomka),Licznik).

matka_troj(Odp,ImieMatki,ImieDziecka) :-
    rodzice(_,ImieMatki,ImieDziecka,_),
    string_chars(Odp,[t,a,k]).

matka_troj(Odp,ImieMatki,ImieDziecka) :-
    matka(ImieMatki,ImieDziecka,_),
    string_chars(Odp,[t,a,k]).

matka_troj(Odp,ImieMatki,ImiePrzodka) :-
    przodek(ImiePrzodka,ImieMatki),
    string_chars(Odp,[n,i,e]).

matka_troj(Odp,_,ImieDziecka) :-
     dziecko(ImieDziecka,_) ->
        string_chars(Odp,[n,i,e]) ; string_chars(Odp,[b,r,a,k,' ',d,a,n,y,c,h]).



siostra_troj(Odp,ImieSiostry,ImieCzlonkaRodziny):-
    siostra(ImieSiostry,ImieCzlonkaRodziny) ->
       string_chars(Odp,[t,a,k]) ;
          count(siostra(_,ImieCzlonkaRodziny),LicznikSiostry), %czy ten gość ma jakąkolwiek siostrę?
          LicznikSiostry > 0 -> string_chars(Odp,[n,i,e]) ; string_chars(Odp,[b,r,a,k,' ',d,a,n,y,c,h]).












