% Course Schedule Bot
% Authors: Reed Esler, Dan Glaser

:-style_check(-discontiguous).
 :-  dynamic  lookup/2.

%
% Start of the bot
%

%%%
%%% user information (i.e., log in credentials)
%%%

login() :-
    write("Username:\n"),
    read(Username),
    write("Password:\n"),
    read(Password),
    database(Username, Password).

database(Username, Password) :-
    users(Username, Password, List),
    write("You are now logged in. "),
    askuser(List).

database(Username, Password) :-
    users(Username, X, _),
    X \= Password,
    write("You have entered the wrong password. Please try again\n"),
    login().

database(_, _, _) :-
    write("The username you entered is invalid. Please try again.\n"),
    login().

users(mark01, password1, [110, 121, 210]).
users(csand, sunflower, [110, 121, 210, 213, 221, 310]).

askuser(List) :-
    write("What would you like to do?\n"),
    write("1. When is a course offered?\n"),
    write("2. Who teaches a specific course?\n"),
    write("3. Can I take two specific courses at the same time?\n"),
    write("4. What are the prerequisites of a course?\n"),
    write("5. What course should I take?\n"),
    write("6. What courses have I taken?\n"),
    write("7. What other classes do I need to complete my degree?\n"),
    write("8. Other\n"),
    read(Input),
    user_query(Input, List).

user_query(Input, _) :-
    Input = 1,
    query(Input).
user_query(Input, _) :-
    Input = 2,
    query(Input).
user_query(Input, _) :-
    Input = 3,
    query(Input).
user_query(Input, _) :-
    Input = 4,
    query(Input).

user_query(Input, List) :-
    Input = 5,
    write("Based on the courses that you have taken, a good course to take next would be CPSC "),
%%%%%%%%%% TODO %%%%%%%%%%
    List.

user_query(Input, List) :-
    Input = 6,
    write("The courses you have taken are: \n"),
    print_classes(List, List).

print_classes([H | []], List) :-
    write("and CPSC "),
    write(H),
    write(".\n\n"),
    askuser(List).

print_classes([H | T], List) :-
    write("CPSC "),
    write(H),
    write(", "),
    print_classes(T, List).

print_classes([], []) :-
    write("You have not taken any courses yet.\n\n"),
    askuser([]).


%%%%%%%%%% TODO %%%%%%%%%%
user_query(Input, List) :-
    Input = 7,
    List.

%%%%%%%%%% TODO %%%%%%%%%%
user_query(Input, _) :-
    Input = 8,
    query(Input).

%%%
%%% non-user access
%%%

ask() :-
    write("Hello! I am here to help you with your computer science scheduling needs. What would you like to do?\n"),
    write("1. When is a course offered?\n"),
    write("2. Who teaches a specific course?\n"),
    write("3. Can I take two specific courses at the same time?\n"),
    write("4. What are the prerequisites of a course?\n"),
    write("5. What course should I take?\n"),
    write("6. Other\n"),
    read(Input),
    query(Input).

%%%%%
%%%%% Query 1
%%%%% 1. When is a course offered?
%%%%%

query(Input) :-
    Input = 1,
    write("What class?"),
    read(Class),
    offered(Class).

offered(X) :-
    write("CPSC "),
    write(X),
    write(" is offered at these times: "),
    findall(D, prop(X, _, day, D), R),
    write(R),
    write("\n\n"),
    ask().

%%%%%
%%%%% Query 2
%%%%% 2. Who teaches a specific course?
%%%%%

query(Input) :-
    Input = 2,
    write("What class?"),
    read(Class),
    write("Specific section? (Type section number, or N for all sections)"),
    read(Section),
    findTeacher(Class, Section).

findTeacher(X, Y) :-
    Y = "N",
    findall(T, prop(X, _, instructor, T), R),
    write("The professors for CPSC "),
    write(X),
    write(" are: "),
    write(R),
    write("\n\n"),
    ask().

findTeacher(X, Y) :-
    findall(T, prop(X, Y, instructor, T), R),
    write("The professor for CPSC "),
    write(X),
    write(" is "),
    write(R),
    write("\n\n"),
    ask().

%%%%%
%%%%% Query 3
%%%%% 3. Can I take some courses at the same time?
%%%%%

query(Input) :-
    Input = 3,
    write("Lets take a look and see if you can take the classes at the same time. What is the first class?"),
    read(ClassOne),
    write("What is the second class?"),
    read(ClassTwo),

    printCompatableSections(ClassOne, _, ClassTwo, _),
    ask().

printCompatableSections(Course1, Sec1, Course2, Sec2) :-
    differentTerms(Course1, Sec1, Course2, Sec2),
    write("Yes, you can take these two courses, as CPSC "),
    write(Course1),
    write(" Sec: "),
    write(Sec1),
    write(" and CPSC "),
    write(Course2),
    write(" Sec: "),
    write(Sec2),
    write(" are in different terms.\n\n").

printCompatableSections(Course1, Sec1, Course2, Sec2) :-
    differentDays(Course1, Sec1, Course2, Sec2),
    write("Yes, you can take these two courses, as CPSC "),
    write(Course1),
    write(" Sec: "),
    write(Sec1),
    write(" and CPSC "),
    write(Course2),
    write(" Sec: "),
    write(Sec2),
    write(" are on different days.\n\n").

printCompatableSections(Course1, Sec1, Course2, Sec2) :-
    differentTimes(Course1, Sec1, Course2, Sec2),
    write("Yes, you can take these two courses, as CPSC "),
    write(Course1),
    write(" Sec: "),
    write(Sec1),
    write(" and CPSC "),
    write(Course2),
    write(" Sec: "),
    write(Sec2),
    write(" are at different times on the same day.\n\n").

printCompatableSections(Course1, _, Course2, _) :-
    write("Unfortunately you are not able to take the courses CPSC "),
    write(Course1),
    write(" and CPSC "),
    write(Course2),
    write(" at the same time as either the schedules overlap, or at least one of the courses do not exist.\n\n"),
    ask().

compatableSections(Course1, Sec1, Course2, Sec2) :-
    differentTerms(Course1, Sec1, Course2, Sec2).

compatableSections(Course1, Sec1, Course2, Sec2) :-
    \+ differentTerms(Course1, Sec1, Course2, Sec2),
    differentDays(Course1, Sec1, Course2, Sec2).

compatableSections(Course1, Sec1, Course2, Sec2) :-
    \+ differentTerms(Course1, Sec1, Course2, Sec2),
    \+ differentDays(Course1, Sec1, Course2, Sec2),
    differentTimes(Course1, Sec1, Course2, Sec2).

differentTerms(Course1, Sec1, Course2, Sec2) :-
    prop(Course1, Sec1, term, Term1),
    prop(Course2, Sec2, term, Term2),
    Term1 \= Term2.

differentDays(Course1, Sec1, Course2, Sec2) :-
    prop(Course1, Sec1, day, Day1),
    prop(Course2, Sec2, day, Day2),
    Day1 \= Day2.

differentTimes(Course1, Sec1, Course2, Sec2) :-
    prop(Course1, Sec1, sTime, Stime1),
    prop(Course1, Sec1, eTime, Etime1),
    prop(Course2, Sec2, sTime, Stime2),
    prop(Course2, Sec2, eTime, Etime2),
    (
        Stime1 >= Etime2;
        Stime2 >= Etime1
    ).

%
% 4. What are the prerequisites of a course?
%
query(Input) :-
    Input = 4,
    write("What class?"),
    read(Class),
    findPreReqs(Class).

findPreReqs(X) :-
    findall(P, prop(X, _, prereq, P), R),
    write("The prerequisites for CPSC "),
    write(X),
    write(" are: "),
    write(R),
    write("\n\n"),
    ask().

%
% 5. What course should I take?
%
query(Input) :-
    Input = 5,
    write("Which field are you interested in?\n"),
    write("1. Fundamentals\n"),
    write("2. Internet Programming\n"),
    write("3. Computer Graphics\n"),
    write("4. Artificial Intelligence\n"),
    write("5. Ethics\n"),
    read(In),
    write("What is the highest course you have taken in this field? (N for none)\n"),
    read(High),
    fields(In, High).

fields(In, High) :-
    In = 1,
    find_field("fundamental", High).
fields(In, High) :-
    In = 2,
    find_field("internet", High).
fields(In, High) :-
    In = 3,
    find_field("graphics", High).
fields(In, High) :-
    In = 4,
    find_field("ai", High).
fields(In, High) :-
    In = 5,
    find_field("ethics", High).

find_field(In, High) :-
    High = "N",
    write("You should start with CPSC "),
    findall(C, prop(C, _, type, In), R),
    list_min(R, Min),
    write(Min),
    write("\n\n").

find_field(In, High) :-
    findall(C, prop(C, _, type, In), R),
    filter(High, R, Z),
    list_min(Z, Min),
    write("The next course in the field of "),
    write(In),
    write(" is CPSC "),
    write(Min),
    write("\n\n").

% Not working currently
% find_field(In, High) :-
%     findall(C, prop(C, _, type, In), R),
%     filter(High, R, Z),
%     list_min(Z, Min),
%     write("There are not anymore higher level courses in the field of "),
%     write(In),
%     write(".\n\n").

filter(N, Y, Z) :-
    findall(X, (member(X, Y), X > N), Z).

filter(_, [], _) :-
    write("error").

list_min([Min], Min).
list_min([H0, H1|T], Min) :-
    H0 =< H1,
    list_min([H0|T], Min).
list_min([H0, H1|T], Min) :-
    H0 > H1,
    list_min([H1|T], Min).

%
% 6. Other
%
query(Input) :-
    Input = 6,
    write("What would you like to know?\n"),
    read(Question),
    q(Question, End, Ans),
    member(End, [[], ['?'], ['.']]).

q(['Is' | T0], T2, Obj) :-
    nounp(T0, T1, Obj),
    mp(T1, T2, Obj).
q(['What', is | T0], T1, Obj) :-
    mp(T0, T1, Obj).
q(['What', is | T0], T1, Obj) :-
    nounp(T0, T1, Obj).
q(['What' | T0], T2, Obj) :-
    nounp(T0, T1, Obj),
    mp(T1, T2, Obj).

nounp(T0, T4, In) :-
    determiner(T0, T1, In),
    adjective(T1, T2, In),
    noun(T2, T3, In),
    mp(T3, T4, In).

mp(T0, T2, Sub) :-
    related(T0, T1, Sub, Ob),
    nounp(T1, T2, Ob).
mp([that | T0], T2, Sub) :-
    related(T0, T1, Sub, Ob),
    nounp(T1, T2, Ob).
mp(T, T, _).

determiner([the | T], T, _).
determiner([a | T], T, _).
determiner(T, T, _).

adjective(T0, T2, In) :-
    adj(T0, T1, In),
    adjective(T1, T2, In).
adjective(T, T, _).

%
% Dictionary
%
noun([cpsc   | T], T, X) :- prop(X, _, course, X).
noun([course | T], T, X) :- prop(X, _, course, X).
noun([class  | T], T, X) :- prop(X, _, course, X).

noun([professor  | T], T, X) :- prop(_, _, instructor, X).
noun([prof       | T], T, X) :- prop(_, _, instructor, X).
noun([teacher    | T], T, X) :- prop(_, _, instructor, X).
noun([instructor | T], T, X) :- prop(_, _, instructor, X).

noun([day | T], T, X) :- prop(_, _, day, X).

noun([building | T], T, X) :- prop(_, _, building, X).

noun([type | T], T, X) :- prop(_, _, type, X).

noun([room | T],T,Obj) :- prop(_, _, room, Obj).

related([the, professor, of | T], T, X, Y) :- prop(Y, _, instructor, X).
related([the, prof, of | T], T, X, Y) :- prop(Y, _, instructor, X).
related([the, teacher, of | T], T, X, Y) :- prop(Y, _, instructor, X).
related([the, instructor, of | T], T, X, Y) :- prop(Y, _, instructor, X).

adj([large | T],T,Obj) :- large(Obj).
adj([Lang,speaking | T],T,Obj) :- speaks(Obj,Lang).









prop(test1, 101, sTime, 11).
prop(test1, 101, eTime, 12).
prop(test1, 101, day, mwf).

prop(test1, 102, sTime, 16).
prop(test1, 102, eTime, 17).
prop(test1, 102, day, mwf).

prop(test2, 101, sTime, 14).
prop(test2, 101, eTime, 15).
prop(test2, 101, day, mwf).

prop(test2, 102, sTime, 10).
prop(test2, 102, eTime, 11.5).
prop(test2, 102, day, mwf).

prop(test3, 101, sTime, 8).
prop(test3, 101, eTime, 9).
prop(test3, 101, day, mwf).

% compatableSections(test1, 101, test2, 101). % should be true
% compatableSections(test1, 101, test3, 101). % should be true

prop(test4, 101, sTime, 10).
prop(test4, 101, eTime, 11.5).
prop(test4, 101, day, mwf).

% compatableSections(test1, 101, test4, 101). % should be false

prop(test5, 101, sTime, 11.5).
prop(test5, 101, eTime, 13).
prop(test5, 101, day, mwf).

% compatableSections(test1, 101, test5, 101). % should be false

prop(test6, 101, sTime, 11.5).
prop(test6, 101, eTime, 13).
prop(test6, 101, day, tth).

% compatableSections(test1, 101, test6, 101). % should be true


% allSectionsCompatable([course(test1,101),course(test2,101),course(test3,101)]). should be true
% allSectionsCompatable([course(test1,101),course(test2,101),course(test3,101),course(test5,101)]). should be false

allSectionsCompatable([]).
allSectionsCompatable([course(Course, Sec) | T]) :-
    sectionCompatableWithAll(Course, Sec, T),
    allSectionsCompatable(T).

sectionCompatableWithAll(_, _, []).
sectionCompatableWithAll(Course1, Sec1, [course(Course2, Sec2) | T]) :-
    compatableSections(Course1, Sec1, Course2, Sec2),
    sectionCompatableWithAll(Course1, Sec1, T).

courseSectionPair(Course, Section, course(Course, Section)) :-
    prop(Course, Section, day, _).

courseListToPairs([], []).
courseListToPairs([Course | T1], [course(Course, Sec) | T2]) :-
    courseSectionPair(Course, Sec, course(Course, Sec)),
    courseListToPairs(T1, T2).

findCompatableSections(Courses, Sections) :-
    courseListToPairs(Courses, Sections),
    allSectionsCompatable(Sections).

startTimes([], []).
startTimes([course(Course, Sec) | T1], [Stime | T2]) :-
    prop(Course, Sec, sTime, Stime),
    startTimes(T1, T2).


%
% Course Information Database
% Course(number, name, type, prereq, section, term, instructor, days, start time, end time, building, room)
% Types can include: ai, fundamental, internet, graphics, etc.
%
% Problems:
% Issue with courses that are in different buildings each day
%
% Courses with more than one section won't be able to show which prof teachers which section
% possible solution: prop(course, section, _, _). <-- will be using this
%

% course 110
prop(110, _, course, 110).
prop(110, _, name, "Computation, Programs and Programming").
% fundamental
prop(110, _, type, "fundamental").
prop(110, _, prereq, none).

% section 101
prop(110, 101, term, 1).
prop(110, 101, instructor, "Gregor Kiczales").
prop(110, 101, day, tth).
prop(110, 101, sTime, 12.5).
prop(110, 101, eTime, 14).
prop(110, 101, building, "Woodward").
prop(110, 101, room, 2).

% section 103
prop(110, 103, term, 1).
prop(110, 103, instructor, "Oluwakemi Ola").
prop(110, 103, day, mwf).
prop(110, 103, sTime, 16).
prop(110, 103, eTime, 17).
prop(110, 103, building, "Wesbrook").
prop(110, 103, room, 100).

% section 201
prop(110, 201, term, 2).
prop(110, 201, instructor, "Anthony Estey").
prop(110, 201, day, tth).
prop(110, 201, sTime, 15.5).
prop(110, 201, eTime, 17).
prop(110, 201, building, "Neville Scarfe").
prop(110, 201, room, 100).

% section 202
prop(110, 202, term, 2).
prop(110, 202, instructor, "Oluwakemi Ola").
prop(110, 202, day, mwf).
prop(110, 202, sTime, 15).
prop(110, 202, eTime, 16).
prop(110, 202, building, "Forest Sciences Centre").
prop(110, 202, room, 1005).

% section 203
prop(110, 203, term, 2).
prop(110, 203, instructor, "Anthony Estey").
prop(110, 203, day, tth).
prop(110, 203, sTime, 9.5).
prop(110, 203, eTime, 11).
prop(110, 203, building, "Chemical and Biological Engineering Building").
prop(110, 203, room, 101).


% course 121
prop(121, _, course, 121).
prop(121, _, name, "Models of Computation").
% fundamental
prop(121, _, type, "fundamental").
prop(121, _, prereq, none).

% section 101
prop(121, 101, term, 1).
prop(121, 101, instructor, "Patrice Belleville").
prop(121, 101, day, tth).
prop(121, 101, sTime, 9.5).
prop(121, 101, eTime, 11).
prop(121, 101, building, "Pharmaceutical Sciences Building").
prop(121, 101, room, 1201).

% section 102
prop(121, 102, term, 1).
prop(121, 102, instructor, "Frederick Shepherd").
prop(121, 102, day, tth).
prop(121, 102, sTime, 15.5).
prop(121, 102, eTime, 17).
prop(121, 102, building, "Hugh Dempster Pavilion").
prop(121, 102, room, 310).

% section 103
prop(121, 103, term, 1).
prop(121, 103, instructor, "Cinda Heeren").
prop(121, 103, day, tth).
prop(121, 103, sTime, 17).
prop(121, 103, eTime, 18.5).
prop(121, 103, building, "Hugh Dempster Pavilion").
prop(121, 103, room, 310).

% section 201
prop(121, 201, term, 2).
prop(121, 201, instructor, "Cinda Heeren").
prop(121, 201, day, mwf).
prop(121, 201, sTime, 9).
prop(121, 201, eTime, 10).
prop(121, 201, building, "West Mall Swing Space").
prop(121, 201, room, 121).

% section 202
prop(121, 202, term, 2).
prop(121, 202, instructor, "Patrice Belleville").
prop(121, 202, day, mwf).
prop(121, 202, sTime, 12).
prop(121, 202, eTime, 13).
prop(121, 202, building, "MacMillan").
prop(121, 202, room, 166).

% section 203
prop(121, 203, term, 2).
prop(121, 203, instructor, "Patrice Belleville").
prop(121, 203, day, mwf).
prop(121, 203, sTime, 16).
prop(121, 203, eTime, 17).
prop(121, 203, building, "Woodward").
prop(121, 203, room, 6).


% course 210
prop(210, _, course, 210).
prop(210, _, name, "Software Construction").
% fundamental
prop(210, _, type, "fundamental").
% Pre-reqs: One of CPSC 107, CPSC 110, CPSC 260.
% Will use 110 as the prereq as a place holder.
prop(210, _, prereq, 110).

% section 101
prop(210, 101, term, 1).
prop(210, 101, instructor, "Elisa Baniassad").
prop(210, 101, day, mwf).
prop(210, 101, sTime, 12).
prop(210, 101, eTime, 13).
prop(210, 101, building, "West Mall Swing Space").
prop(210, 101, room, 122).

% section 102
prop(210, 102, term, 1).
prop(210, 102, instructor, "Ali Madooei").
prop(210, 102, day, mwf).
prop(210, 102, sTime, 15).
prop(210, 102, eTime, 16).
prop(210, 102, building, "Hugh Dempster Pavilion").
prop(210, 102, room, 310).

% section 103
prop(210, 103, term, 1).
prop(210, 103, instructor, "Michael Feeley").
prop(210, 103, day, mwf).
prop(210, 103, sTime, 14).
prop(210, 103, eTime, 15).
prop(210, 103, building, "Hugh Dempster Pavilion").
prop(210, 103, room, 310).

% section 201
prop(210, 201, term, 2).
prop(210, 201, instructor, "Paul Martin Carter").
prop(210, 201, day, mwf).
prop(210, 201, sTime, 14).
prop(210, 201, eTime, 15).
prop(210, 201, building, "West Mall Swing Space").
prop(210, 201, room, 121).

% section 202
prop(210, 202, term, 2).
prop(210, 202, instructor, "Ali Madooei").
prop(210, 202, day, mwf).
prop(210, 202, sTime, 12).
prop(210, 202, eTime, 13).
prop(210, 202, building, "Hugh Dempster Pavilion").
prop(210, 202, room, 310).

% section 203
prop(210, 203, term, 2).
prop(210, 203, instructor, "Paul Martin Carter").
prop(210, 203, day, mwf).
prop(210, 203, sTime, 15).
prop(210, 203, eTime, 16).
prop(210, 203, building, "West Mall Swing Space").
prop(210, 203, room, 222).


% course 213
prop(213, _, course, 213).
prop(213, _, name, "Introduction to Computer Systems").
% fundamental
prop(213, _, type, "fundamental").
% Pre-reqs: All of CPSC 121, CPSC 210.
prop(213, _, prereq, 121).
prop(213, _, prereq, 210).

% section 101
prop(213, 101, term, 1).
prop(213, 101, instructor, "Jonatan Schroeder").
prop(213, 101, day, tth).
prop(213, 101, sTime, 14).
prop(213, 101, eTime, 15.5).
prop(213, 101, building, "Hugh Dempster Pavilion").
prop(213, 101, room, 310).

% section 102
prop(213, 102, term, 1).
prop(213, 102, instructor, "Jonatan Schroeder").
prop(213, 102, day, mwf).
prop(213, 102, sTime, 13).
prop(213, 102, eTime, 14).
prop(213, 102, building, "Hugh Dempster Pavilion").
prop(213, 102, room, 310).

% section 203
prop(213, 203, term, 2).
prop(213, 203, instructor, "Michael Feeley").
prop(213, 203, day, mwf).
prop(213, 203, sTime, 13).
prop(213, 203, eTime, 14).
prop(213, 203, building, "Hugh Dempster Pavilion").
prop(213, 203, room, 310).

% section 204
prop(213, 204, term, 2).
prop(213, 204, instructor, "Anthony Estey").
prop(213, 204, day, mwf).
prop(213, 204, sTime, 9).
prop(213, 204, eTime, 10).
prop(213, 204, building, "Hugh Dempster Pavilion").
prop(213, 204, room, 310).


% course 221
prop(221, _, course, 221).
prop(221, _, name, "Basic Algorithms and Data Structures").
% fundamental
prop(221, _, type, "fundamental").
% Pre-reqs: One of CPSC 210, EECE 210, CPEN 221 and one of CPSC 121, MATH 220.
% We will only use cpsc prereqs for simplicity
prop(221, _, prereq, 210).
prop(221, _, prereq, 121).

% section 101
prop(221, 101, term, 1).
prop(221, 101, instructor, "Geoffrey Tien").
prop(221, 101, day, mwf).
prop(221, 101, sTime, 14).
prop(221, 101, eTime, 15).
prop(221, 101, building, "West Mall Swing Space").
prop(221, 101, room, 221).

% section 102
prop(221, 102, term, 1).
prop(221, 102, instructor, "Cinda Heeren").
prop(221, 102, day, tth).
prop(221, 102, sTime, 9.5).
prop(221, 102, eTime, 11).
prop(221, 102, building, "Hugh Dempster Pavilion").
prop(221, 102, room, 310).

% section 201
prop(221, 201, term, 2).
prop(221, 201, instructor, "Geoffrey Tien").
prop(221, 201, day, mwf).
prop(221, 201, sTime, 17).
prop(221, 201, eTime, 18).
prop(221, 201, building, "Pharmaceutical Sciences Building").
prop(221, 201, room, 1201).

% section 202
prop(221, 202, term, 2).
prop(221, 202, instructor, "William Evans").
prop(221, 202, day, mwf).
prop(221, 202, sTime, 16).
prop(221, 202, eTime, 17).
prop(221, 202, building, "Wesbrook").
prop(221, 202, room, 100).

% section 203
prop(221, 203, term, 2).
prop(221, 203, instructor, "Cinda Heeren").
prop(221, 203, day, mwf).
prop(221, 203, sTime, 12).
prop(221, 203, eTime, 13).
prop(221, 203, building, "Pharmaceutical Sciences Building").
prop(221, 203, room, 1101).


% course 310
prop(310, _, course, 310).
prop(310, _, name, "Introduction to Software Engineering").
% fundamental
prop(310, _, type, "fundamental").
% Pre-reqs: CPSC 210.
prop(310, _, prereq, 210).

% section 101
prop(310, 101, term, 1).
prop(310, 101, instructor, "Anthony Estey").
prop(310, 101, day, tth).
prop(310, 101, sTime, 12.5).
prop(310, 101, eTime, 14).
prop(310, 101, building, "West Mall Swing Space").
prop(310, 101, room, 122).

% section 102
prop(310, 102, term, 1).
prop(310, 102, instructor, "Reid Holmes").
prop(310, 102, day, tth).
prop(310, 102, sTime, 9.5).
prop(310, 102, eTime, 11).
prop(310, 102, building, "West Mall Swing Space").
prop(310, 102, room, 221).

% section 201
prop(310, 201, term, 2).
prop(310, 201, instructor, "Elisa Baniassad").
prop(310, 201, day, tth).
prop(310, 201, sTime, 12.5).
prop(310, 201, eTime, 14).
prop(310, 201, building, "Hugh Dempster Pavilion").
prop(310, 201, room, 310).


% course 312
prop(312, _, course, 312).
prop(312, _, name, "Functional and Logic Programming").
% fundamental
prop(312, _, type, "fundamental").
prop(312, _, prereq, 210).

% section 101
prop(312, 101, term, 1).
prop(312, 101, instructor, "David Poole").
prop(312, 101, day, mwf).
prop(312, 101, sTime, 12).
prop(312, 101, eTime, 13).
prop(312, 101, building, "Hugh Dempster Pavilion").
prop(312, 101, room, 310).


% course 313
prop(313, _, course, 313).
prop(313, _, name, "Computer Hardware and Operating Systems").
% fundamental
prop(313, _, type, "fundamental").
% Pre-reqs: Either (a) all of CPSC 213, CPSC 221 or (b) all of CPSC 210, CPSC 213, CPSC 260, EECE 320.
% will use case (a) for simplicity
prop(313, _, prereq, 213).
prop(313, _, prereq, 221).

% section 101
prop(313, 101, term, 1).
prop(313, 101, instructor, "Jonatan Schroeder").
prop(313, 101, day, mwf).
prop(313, 101, sTime, 11).
prop(313, 101, eTime, 12).
prop(313, 101, building, "Hugh Dempster Pavilion").
prop(313, 101, room, 310).

% section 203
prop(313, 203, term, 2).
prop(313, 203, instructor, "Jonatan Schroeder").
prop(313, 203, day, mwf).
prop(313, 203, sTime, 14).
prop(313, 203, eTime, 15).
prop(313, 203, building, "Leonard S. Klinck").
prop(313, 203, room, 200).

% section 204
prop(313, 204, term, 2).
prop(313, 204, instructor, "Donald Acton").
prop(313, 204, day, tth).
prop(313, 204, sTime, 12.5).
prop(313, 204, eTime, 14).
prop(313, 204, building, "Friedman Building").
prop(313, 204, room, 153).


% course 314
prop(314, _, course, 314).
prop(314, _, name, "Computer Graphics").
prop(314, _, type, "graphics").
prop(314, _, prereq, 221).

% section 101
prop(314, 101, term, 1).
prop(314, 101, instructor, "Michael van der Panne").
prop(314, 101, day, mwf).
prop(314, 101, sTime, 10).
prop(314, 101, eTime, 11).
prop(314, 101, building, "Hugh Dempster Pavilion").
prop(314, 101, room, 110).

% section 201
prop(314, 201, term, 2).
prop(314, 201, instructor, "Dinesh Pai").
prop(314, 201, day, mwf).
prop(314, 201, sTime, 10).
prop(314, 201, eTime, 11).
prop(314, 201, building, "Hugh Dempster Pavilion").
prop(314, 201, room, 310).


% course 317
prop(317, _, course, 317).
prop(317, _, name, "Internet Computing").
prop(317, _, type, "fundamental").
prop(317, _, prereq, 213).
prop(317, _, prereq, 221).

% section 101
prop(317, 101, term, 1).
prop(317, 101, instructor, "Alan Wagner").
prop(317, 101, day, mwf).
prop(317, 101, sTime, 11).
prop(317, 101, eTime, 12).
prop(317, 101, building, "West Mall Swing Space").
prop(317, 101, room, 121).

% section 203
prop(317, 201, term, 2).
prop(317, 201, instructor, "Alan Wagner").
prop(317, 201, day, mwf).
prop(317, 201, sTime, 15).
prop(317, 201, eTime, 16).
prop(317, 201, building, "MacMillan").
prop(317, 201, room, 166).


% course 319
prop(319, _, course, 319).
prop(319, _, name, "Software Engineering Project").
prop(319, _, type, "fundamental").
prop(319, _, prereq, 310).

% section 201
prop(319, 201, term, 2).
prop(319, 201, instructor, "Jerry Jim").
prop(319, 201, day, tth).
prop(319, 201, sTime, 12.5).
prop(319, 201, eTime, 14).
prop(319, 201, building, "Hugh Dempster Pavilion").
prop(319, 201, room, 110).


% course 320
prop(320, _, course, 320).
prop(320, _, name, "Intermediate Algorithm Design and Analysis").
% fundamental
prop(320, _, type, "fundamental").
% Pre-reqs: Either (a) CPSC 221 or (b) all of CPSC 260, EECE 320. (In addition to above pre-requisites, at least 3 credits from COMM 291, BIOL 300, MATH or STAT at 200 level or above.)
% will use case (a) for simplicity
prop(320, _, prereq, 221).

% section 101
prop(320, 101, term, 1).
prop(320, 101, instructor, "Anne Condon").
prop(320, 101, day, mwf).
prop(320, 101, sTime, 14).
prop(320, 101, eTime, 15).
prop(320, 101, building, "Hennings").
prop(320, 101, room, 200).

% section 102
prop(320, 102, term, 1).
prop(320, 102, instructor, "Patrice Belleville").
prop(320, 102, day, mwf).
prop(320, 102, sTime, 16).
prop(320, 102, eTime, 17).
prop(320, 102, building, "Hennings").
prop(320, 102, room, 200).

% section 201
prop(320, 201, term, 2).
prop(320, 201, instructor, "Geoffrey Tien").
prop(320, 201, day, mwf).
prop(320, 201, sTime, 10).
prop(320, 201, eTime, 11).
prop(320, 201, building, "Hennings").
prop(320, 201, room, 200).

% section 202
prop(320, 202, term, 2).
prop(320, 202, instructor, "Anne Condon").
prop(320, 202, day, mwf).
prop(320, 202, sTime, 8).
prop(320, 202, eTime, 9).
prop(320, 202, building, "Hennings").
prop(320, 202, room, 200).


% course 322
prop(322, _, course, 322).
prop(322, _, name, "Introduction to Artificial Intelligence").
% artificial
prop(322, _, type, "ai").
% Pre-reqs: Either (a) CPSC 221 or (b) all of CPSC 260, EECE 320 and one of CPSC 210, EECE 210, EECE 309.
% will use (a) for simplicity
prop(322, _, prereq, 221).

% section 101
prop(322, 101, term, 1).
prop(322, 101, instructor, "Jordan Johnson").
prop(322, 101, day, tth).
prop(322, 101, sTime, 17).
prop(322, 101, eTime, 18.5).
prop(322, 101, building, "Pharmaceutical Sciences Building").
prop(322, 101, room, 1201).

% section 201
prop(322, 201, term, 2).
prop(322, 201, instructor, "TBA").
prop(322, 201, day, tth).
prop(322, 201, sTime, 9.5).
prop(322, 201, eTime, 11).
prop(322, 201, building, "Hugh Dempster Pavilion").
prop(322, 201, room, 310).


% course 340
prop(340, _, course, 340).
prop(340, _, name, "Machine Learning and Data Mining").
% artificial
prop(340, _, type, "ai").
% Pre-reqs: One of MATH 152, MATH 221, MATH 223 and one of MATH 200, MATH 217, MATH 226, MATH 253, MATH 263 and one of STAT 200, STAT 203, STAT 241, STAT 251, COMM 291, ECON 325, ECON 327, PSYC 218, PSYC 278, PSYC 366, MATH 302, STAT 302, MATH 318, BIOL 300; and either (a) CPSC 221 or (b) all of CPSC 260, EECE 320 and one of CPSC 210, EECE 210, EECE 309.
% will just use cpsc 221 for simplicity
prop(340, _, prereq, 221).

% section 101
prop(340, 101, term, 1).
prop(340, 101, instructor, "Mark Schmidt").
prop(340, 101, day, mwf).
prop(340, 101, sTime, 16).
prop(340, 101, eTime, 17).
prop(340, 101, building, "MacMillan").
prop(340, 101, room, 166).

% section 103
prop(340, 103, term, 1).
prop(340, 103, instructor, "Michael Gelbart").
prop(340, 103, day, mwf).
prop(340, 103, sTime, 12).
prop(340, 103, eTime, 13).
prop(340, 103, building, "Hugh Dempster Pavilion").
prop(340, 103, room, 110).

% section 201
prop(340, 201, term, 2).
prop(340, 201, instructor, "Frank Wood").
prop(340, 201, day, mwf).
prop(340, 201, sTime, 13).
prop(340, 201, eTime, 14).
prop(340, 201, building, "MacMillan").
prop(340, 201, room, 166).


% course 410
prop(410, _, course, 410).
prop(410, _, name, "Advanced Software Engineering").
prop(410, _, type, "fundamental").
prop(410, _, prereq, 310).

% section 101
prop(410, 101, term, 1).
prop(410, 101, instructor, "Elisa Baniassad").
prop(410, 101, day, tth).
prop(410, 101, sTime, 11).
prop(410, 101, eTime, 12.5).
prop(410, 101, building, "Hugh Dempster Pavilion").
prop(410, 101, room, 110).


% course 418
prop(418, _, course, 418).
prop(418, _, name, "Parallel Computation").
prop(418, _, type, "fundamental").
prop(418, _, prereq, 313).
prop(418, _, prereq, 320).

% section 101
prop(418, 101, term, 1).
prop(418, 101, instructor, "Mark Greenstreet").
prop(418, 101, day, mwf).
prop(418, 101, sTime, 13).
prop(418, 101, eTime, 14).
prop(418, 101, building, "Hugh Dempster Pavilion").
prop(418, 101, room, 301).


% course 420
prop(420, _, course, 420).
prop(420, _, name, "Advanced Algorithms Design and Analysis").
prop(420, _, type, "fundamental").
prop(420, _, prereq, 320).

% section 101
prop(420, 101, term, 1).
prop(420, 101, instructor, "Alan Hu").
prop(420, 101, day, mwf).
prop(420, 101, sTime, 9).
prop(420, 101, eTime, 10).
prop(420, 101, building, "Hugh Dempster Pavilion").
prop(420, 101, room, 110).

% section 201
prop(420, 201, term, 2).
prop(420, 201, instructor, "Hu Fu").
prop(420, 201, day, mwf).
prop(420, 201, sTime, 13).
prop(420, 201, eTime, 14).
prop(420, 201, building, "Hugh Dempster Pavilion").
prop(420, 201, room, 110).


% course 436D
prop(cpsc436D, _, course, "436D").
prop(cpsc436D, _, name, "Topics in Computer Science").
prop(cpsc436D, _, type, "fundamental").

% section 201
prop(cpsc436D, 201, term, 2).
prop(cpsc436D, 201, instructor, "Hu Fu").
prop(cpsc436D, 201, day, mwf).
prop(cpsc436D, 201, sTime, 15).
prop(cpsc436D, 201, eTime, 17).
prop(cpsc436D, 201, building, "Hugh Dempster Pavilion").
prop(cpsc436D, 201, room, 301).
