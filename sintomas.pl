:- dynamic sim/1, nao/1.

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
			   vermelhidaoNosOlhos.

dengue :- febreAlta.

doresLevesNasArticulacoes :- verifica('O paciente possui dores leves nas articulacoes '), !.
manchasVermelhasNaPeleNasPrimeiras24Horas :- verifica('As manchas no paciente se manifestaram nas primeiras 24hrs '), !.
coceiraIntensa :- verifica('O paciente possui coceira intensa '), !.
vermelhidaoNosOlhos :- verifica('O paciente possui vermelhidao nos olhos '), !.
febreAlta :- verifica('O paciente possui febre alta '), !.
doresIntensasNasArticulacoes :- verifica('O paciente possui dores intensas nas articulacoes '), !.
manchasVermelhasNaPeleNasPrimeiras48Horas :- verifica('As manchas no paciente se manifestaram nas primeiras 48hrs '), !.

perguntar(Pergunta) :-
	write(Pergunta),
	write('(Responda sim ou nao) ? '),
	read(Resposta),
	nl,
	( (Resposta == sim ; Resposta == s)
		->
		assert(sim(Pergunta)) ;
		assert(nao(Pergunta)), fail).

verifica(X) :-
	(sim(X)	->	true ;	(nao(X)	 ->	 fail ;	 perguntar(X))).

limpaBase(X):- limpaBase1(X), fail.
limpaBase(X).

limpaBase1(X):- retract(X).
limpaBase1(X).

main :- limpaBase(sim(Sintoma)),
		hipotese(Doenca),
		write(Doenca),
		nl.