:- dynamic low/2.
:- dynamic medium/2.
:- dynamic high/2.
:- dynamic very_high/2.

covidTester :- format('~n*** Gravidade de Covid ***~n~n'),
  get_nome(Name),
  get_temperatura(Temperature,Name),
  get_heart_rate(HeartRate,Name),
  get_respiratory_rate(RespiratoryRate,Name),
  get_PA_sis(PASis,Name),
  get_Sa02(Sa02,Name),
  get_dyspnea(Dyspnea,Name),
  get_idade(Age,Name),
  get_comorbidades(Comorbidities,Name),
  verify_temperatura(Temperature,Name),
  verify_heart_rate(HeartRate,Name),
  verify_respiratory_rate(RespiratoryRate,Name),
  verify_PA_sis(PASis,Name),
  verify_Sa02(Sa02,Name),
  verify_dyspnea(Dyspnea,Name),
  verify_idade(Age,Name),
  verify_comorbidades(Comorbidities,Name),
  define_low_gravity(Name),
  define_medium_gravity(Name),
  define_high_gravity(Name),
  define_very_high_gravity(Name),
  !,
  salva(parametro,'paciente.bd').

get_nome(Name) :-
  format('~nDigite o nome do paciente?'),
  gets(Name),
  asserta(rec_nome(Name)).

get_temperatura(Temperature,Name) :-
  rec_nome(Name),
  format('~nQual a temperatura atual do paciente ~w?', [Name]),
  gets(Temperature),
  asserta(get_temperatura(Temperature)).

get_heart_rate(HeartRate,Name) :-
  rec_nome(Name),
  format('~nQual a frequÃªncia cardÃ­aca do paciente ~w?', [Name]),
  gets(HeartRate),
  asserta(get_heart_rate(HeartRate)).

get_respiratory_rate(RespiratoryRate,Name) :-
  rec_nome(Name),
  format('~nQual a frequÃªncia respiratÃ³ria do paciente ~w?', [Name]),
  gets(RespiratoryRate),
  asserta(get_respiratory_rate(RespiratoryRate)).

get_PA_sis(PASis,Name) :-
  rec_nome(Name),
  format('~nQual a PA SistÃ³lica (%) do paciente ~w?', [Name]),
  gets(PASis),
  asserta(get_PA_sis(PASis)).

get_dyspnea(Dyspnea,Name) :-
  rec_nome(Name),
  format('~nPaciente possui dispnÃ©ia ~w?', [Name]),
  gets(Dyspnea),
  asserta(get_dyspnea(Dyspnea)).

get_idade(Age,Name) :-
  rec_nome(Name),
  format('~nQunatos anos o paciente ~w?', [Name]),
  gets(age),
  asserta(get_idade(Age)).

get_comorbidades(Comorbidities,Name) :-
  rec_nome(Name),
  format('~nQual a quantidade de comorbidities do paciente ~w?', [Name]),
  gets(Comorbidities),
  asserta(get_comorbidades(Comorbidities)).

get_Sa02(Sa02,Name) :-
  rec_nome(Name),
  format('~nQual Sa02 tem o paciente ~w?', [Name]),
  gets(Sa02),
  asserta(get_Sa02(Sa02)).

verify_temperatura(Temperature,Name) :-
  35 =< Temperature -> low(Name,Temperature),
  37 =< Temperature -> medium(Name,Temperature),
  Temperature > 39 -> high(Name,Temperature).

verify_heart_rate(HeartRate,Name) :-
  HeartRate < 18 -> low(Name,HeartRate),
  19 < HeartRate -> medium(Name,HeartRate),
  HeartRate > 30 -> very_high(Name,HeartRate).

verify_respiratory_rate(RespiratoryRate,Name) :-
  HeartRate < 100 -> low(Name,RespiratoryRate),
  HeartRate > 100 -> medium(Name,RespiratoryRate).

verify_dyspnea(Dyspnea,Name) :-
  Dyspnea == 'NÃ£o' -> low(Name,Dyspnea) ; very_high(Name,Dyspnea).

verify_comorbidades(Comorbidities,Name) :-
  Comorbidities = 0 -> low(Name,Comorbidities),
  Comorbidities = 1 -> medium(Name,Comorbidities),
  Comorbidities >= 2 -> high(Name,Comorbidities).

verify_idade(Age,Name) :-
  Age < 60 -> low(Name,Age),
  60 < Age -> medium(Name,Age),
  Age > 80 -> high(Name,Age).

verify_Sa02(Sa02,Name) :-
  Sa02 >= 95 -> low(Sa02,Name),
  Sa02 < 95 -> very_high(Sa02,Name).

verify_PA_sis(PASis,Name) :-
  PASis > 100 -> low(PASis,Name),
  PASis > 90 -> high(PASis,Name),
  PASis < 90 -> very_high(PASis,Name).

define_low_gravity(Name) :-
  low(Name),
  !,
  format('Caso leve de COVID. ~w deve ficar em casa, em observaÃ§Ã£o por 14 dias.~n', [Name]).

define_medium_gravity(Name) :-
  medium(Name),
  !,
  format('Caso mÃ©dio de COVID. ~w deve ficar em casa, em observaÃ§Ã£o por 14 dias.~n', [Name]).

define_high_gravity(Name) :-
  high(Name),
  !,
  format('Caso grave de COVID. ~w deve deve ser encaminhado para o hospital.~n', [Name]).

define_very_high_gravity(Name) :-
  very_high(Name),
  !,
  format('Caso muito gravde de COVID. ~w deve deve ser encaminhado para o hospital.~n', [Name]).

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

