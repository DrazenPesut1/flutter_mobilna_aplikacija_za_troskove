# Mobilna aplikacija za praćenje troškova

## Opis projekta
Mobilna aplikacija za praćenje projekta omogućit će korisnicima uvid u protok novca i praćenje osobnih troškova s ciljem boljeg raspolaganja financijama. Aplikacija će korisnicima omogućiti da jednostavno unesu troškove i prihode koje kategoriziraju prema nekoj vrsti troška (hrana, računi, automobil, javni prijevoz, zdravstvo...) ili prihoda (plaća, ulaganje, dar...) te mogu postaviti štednju ili dugovanje te pratiti njihov napredak. Pregled troškova će biti omogućen prema različitim vremenskim rasponima (danas, ovaj tjedan, ovaj mjesec ili bilo koji raspon koji korisnik želi), a osim toga aplikacija nudi pregled detalja i analizu troškova i prihoda uz pomoć grafova i izvještaja. Aplikacija će biti izvedena kao aplikacija dostupna na Android i iOS uređajima koristeći tehnologije Flutter, programski jezik Dart, dodatne pakete i eventualno i bazu podataka. Podaci se trenutno lokalno na uređaju pomoću Flutter paketa shared_preferences. 

## Struktura aplikacije
**Naslovna stranica**
- stranica koju korisnik vidi pri prvom pokretanju aplikacije, sadrži ilustraciju,kratak pozdravni tekst i korisniku nudi opcije da stvori račun ili da se prijavi ako već ima postojeći račun


**Stranica za registraciju**
- sadrži ilustraciju i formu za registraciju korisnika


**Stranica za prijavu**
- sadrži ilustraciju i formu za prijavu


**Glavna Stranica**
- stranica koju korisnik vidi prilikom prijave/pokretanja aplikacije
- sadrži kategorije za troškove i primanja te mogućnost dodavanja vlastitih kategorija
- korisnik na ovoj stranici dodaje troškove ili primanja iz/u jednog od stvorenih računa na stranici za račune te ima uvid u ukupno stanje troškova i primanja


**Stranica za račune**
- stranica koja omogućava korisniku da dodaje vlastite račune 
- sastoji se od 3 podstranice za:
  - obične račune (kartice, gotovina, vaučeri, paypall...)
  - štednju 
  - dugove (prema sebi i drugima)
- korisnici će moći dodati račun, postaviti inicijalni iznos i urediti ga
- uređivanje računa podrazumijeva promjenu naziva, ikone, dodavanje ili oduzimanje od stanja računa, prijenos između računa
- računi za štednju i dugove prikazuju napredak do cilja štednje ili vraćanja/primanja duga

**Stranica za transakcije**
- ostavljeno za verziju 2

**Stranica za statistiku**
- ostavljeno za verziju 2

## Tehnologije
Glavne tehnologije korištene za izvedbu aplikacije su Flutter i programski jezik Dart.
Android emulatori pruženi od strane Android Studia se koriste za razvoj i testiranje aplikacije, a glavno razvojno okruženje je VS-Code.

## Resursi
- [Flutter dokumentacija](https://docs.flutter.dev/)
- [Flutter Course](https://www.youtube.com/watch?v=VPvVD8t02U8&t=37026s)

## Tijek Projekta
- **6.11.2024.** - napravljene naslovna stranica, stranice za registraciju i prijavu, trenutno bez funkcionalnosti
- **20.11.2024.** - napravljen izgled računa, trenutno radim na funkcionalnosti dodavanja računa
- **22.11.2024.** - dodan prozor za dodavanje običnih računa, namjeravam isto napraviti za račune za štednju i dugove
- **12.12.2024.** - dodana mogućnost uređivanja uređivanje računa 
- **20.12.2024** - popravljen i nadodan kod za račune, radim na kategorijama za glavnu stranicu
- **14.1.2024** - dodane kategorije za troškove i dodavanje vlastitih kategorija
- **19.1.2024.** - kraj prve verzije projekta

**! Postoji greška na glavnoj stranici (Home Page) gdje se kod izgrađene aplikacije ne prikazuju kategorije, ali u debug verziji se prikazuju zbog pogrešno ugniježđenih komponenata ("widgeta") !**
