:- dynamic sim/1, nao/1.

main :- hypothesis(Caso),
	write('Acho que o caso de que estah falando eh: '),
	write(Caso), nl,
	undo.

hypothesis('Caim e Abel') :- caim, !.
hypothesis('Nao encontrado').

caim :- assassino,
		biblico,
		irmaos,
		verify('Estamos falando de Caim e Abel ').

assassino :- verify('O assassino eh um homem ').
biblico :- verify('O caso eh uma historia biblica ').
irmaos :- verify('O caso tem haver com irmaos ').

ask(Pergunta) :- 
	write(Pergunta),
	write('(Digite Sim ou Nao)? '),
	read(Resposta), nl,
	((Resposta == sim) 
		-> 
		assert(sim(Pergunta));
		assert(nao(Pergunta)), fail).

verify(X) :-
	(sim(X)	->	true ;	(nao(X)	 ->	 fail ;	 ask(X))).

undo :- retract(sim(_)), fail.
undo :- retract(nao(_)), fail.
undo.