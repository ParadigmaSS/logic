:- dynamic sim/1, nao/1, analisaResposta/2.

hipotese('Provavelmente o paciente possui Zika') :- zika, !.
hipotese('Provavelmente o paciente possui Chinkungunya') :- chikungunya, !.
hipotese('Provavelmente o paciente possui Dengue') :- dengue, !.
hipotese('Nao foi possivel concluir o diagnostico').

zika :- doresLevesNasArticulacoes,
		manchasVermelhasNaPeleNasPrimeiras24Horas,
		coceiraIntensa,
		vermelhidaoNosOlhos.

chikungunya :- febreAlta,
			   doresIntensasNasArticulacoes,
			   manchasVermelhasNaPeleNasPrimeiras48Horas,
			   conceiraLeve,
			   vermelhidaoNosOlhos.

dengue :- febreAlta,
		  doresModeradasNasArticulacoes,
		  conceiraLeve.

doresLevesNasArticulacoes :- verifica('O paciente possui dores leves nas articulacoes '), !.
manchasVermelhasNaPeleNasPrimeiras24Horas :- verifica('As manchas no paciente se manifestaram nas primeiras 24hrs '), !.
coceiraIntensa :- verifica('O paciente possui coceira intensa '), !.
vermelhidaoNosOlhos :- verifica('O paciente possui vermelhidao nos olhos '), !.
febreAlta :- verifica('O paciente possui febre alta '), !.
doresIntensasNasArticulacoes :- verifica('O paciente possui dores intensas nas articulacoes '), !.
manchasVermelhasNaPeleNasPrimeiras48Horas :- verifica('As manchas no paciente se manifestaram nas primeiras 48hrs '), !.
doresModeradasNasArticulacoes :- verifica('O paciente possui dores moderadas nas articulacoes '), !.
conceiraLeve :- verifica('O paciente possui coceira leve '), !.

verifica(X) :-
	(sim(X)	->	true ;	(nao(X)	 ->	 fail ;	 mostraMessagem(X))).

limpaBase(X):- limpaBase1(X), fail.
limpaBase(X).

limpaBase1(X):- retract(X).
limpaBase1(X).

main :- limpaBase(sim(Sintoma)),
		hipotese(Doenca),
		new(D, dialog('Resultado')),
		send(D, size, size(300, 100)),
		new(T, text(Doenca)),
    	send(D, display, T, point(80,40)),
    	send(D, open).
		nl.

mostraMessagem(Pergunta) :- use_module(library(pce)),
    new(D, dialog('Pergunta')),
    send(D, size, size(500,100)),
    send(D, append(new(NameItem, text_item(Pergunta)))),
    send(D, append(button(ok, message(D, return, NameItem?selection)))),
    send(D, append(button(cancel, message(D, return, @nil)))),
    send(D, default_button(ok)),
    get(D, confirm, Rval),
    free(D),
    Rval \== @nil,
    Resposta = Rval, 
    nl,
	( (Resposta == sim ; Resposta == s)
		->
		assert(sim(Pergunta)) ;
		assert(nao(Pergunta)), fail).
