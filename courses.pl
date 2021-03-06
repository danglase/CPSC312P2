% Course Schedule Bot
% Authors: Reed Esler, Dan Glaser

:-style_check(-discontiguous).
:-  dynamic  lookup/2.

%
% Start of the bot
%

%%%
%%% user access (i.e., log in credentials)
%%%

login() :-
    write("Username:\n"),
    readAtom(Username),
    write("Password:\n"),
    readAtom(Password),
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

database(_, _) :-
    write("The username you entered is invalid. Please try again.\n"),
    login().

users(mark01, password1, [110, 121, 210]).
users(csand, sunflower, [110, 121, 210, 213, 221, 310]).
users(tooth, brush, [110, 121, 210, 213, 221, 310, 313, 320, 312, 406, 410, 417, 422]).
users(mynamejeff, mypassword, []).

askuser(List) :-
    write("What would you like to do?\n"),
    write("1. Create a schedule.\n"),
    write("2. When is a course offered?\n"),
    write("3. Who teaches a specific course?\n"),
    write("4. What are the prerequisites of a course?\n"),
    write("5. What course should I take?\n"),
    write("6. What courses have I taken?\n"),
    write("7. What other classes do I need to complete my degree?\n"),
    write("0. Exit\n"),
    readAtom(Input),
    user_query(Input, List).

%%%%%
%%%%% User Query 6
%%%%% 6. What courses have I taken?
%%%%%

user_query(6, List) :-
    write("The courses you have taken are: \n"),
    print_classes(List, List).

print_classes([], List) :-
    write(".\n\n"),
    askuser(List).

print_classes([H | []], List) :-
    write("and CPSC "),
    write(H),
    print_classes([], List).

print_classes([H | T], List) :-
    write("CPSC "),
    write(H),
    write(", "),
    print_classes(T, List).

print_classes([], []) :-
    write("You have not taken any courses yet.\n\n"),
    askuser([]).

%%%%%
%%%%% User Query 7
%%%%% 7. What other classes do I need to complete my degree?
%%%%%

requirements(science, [110, 121, 210, 213, 310, 313, 320, 340, 402, 406, 425, 426]).
requirements(arts, [110, 121, 210, 213, 221, 310, 313, 320, 312, 406, 410, 417, 422]).

user_query(Input, List) :-
    Input = 7,
    write("Are you interested in the Bachelor of Arts in Computer Science, or the Bachelor of Science in Computer Science?\n"),
    write("Type 1 for arts, and type 2 for science.\n"),
    readAtom(Req),
    findRequirements(Req, List).

findRequirements(Req, List) :-
    Req = 1,
    write("The courses that you still need to take for a Bachelor of Arts are:\n"),
    requirements(arts, X),
    subtract(X, List, Needs),
    findNeeds(Needs, List).

findRequirements(Req, List) :-
    Req = 2,
    write("The courses that you still need to take for a Bachelor of Science are:\n"),
    requirements(science, X),
    subtract(X, List, Needs),
    findNeeds(Needs, List).

findRequirements(_, List) :-
    write("I didn't understand your request. Please try again.\n"),
    user_query(7, List).

findNeeds([], List) :-
    write("You don't need anymore classes! Yay!\n\n"),
    askuser(List).

findNeeds(Needs, List) :-
    print_classes(Needs, List).


%%%%%
%%%%% User Query 0
%%%%% 0. Exit
%%%%%

user_query(0, _) :-
    query(0).

% forward all other queries to the non-user specific query
user_query(Input, List) :-
    query(Input),
    askuser(List).

%%%
%%% non-user access
%%%

ask() :-
    write("Hello! I am here to help you with your computer science scheduling needs. What would you like to do?\n"),
    write("1. Create a schedule.\n"),
    write("2. When is a course offered?\n"),
    write("3. Who teaches a specific course?\n"),
    write("4. What are the prerequisites of a course?\n"),
    write("5. What course should I take?\n"),
    write("0. Exit\n"),
    readAtom(Input),
    handleQuery(Input).

handleQuery(0) :- query(0).
handleQuery(Input) :-
    query(Input),
    ask().

%%%%%
%%%%% Query 1
%%%%% 1. Create a schedule
%%%%%

query(1) :-
    findSchedule().

%%%%%
%%%%% Query 2
%%%%% 2. When is a course offered?
%%%%%

query(2) :-
    write("What class? "),
    readAtom(Class),
    offered(Class).

offered(X) :-
    write("CPSC "),
    write(X),
    write(" is offered at these times:\n"),
    findall(S, prop(X, S, section, S), Sections),
    find_times(X, Sections).

find_times(_, []) :-
    write("\n\n").

find_times(X, [SH | ST]) :-
    prop(X, SH, day, A),
    A = mwf,
    write("Section "),
    write(SH),
    write(" is offered on "),
    write("Monday, Wednesday, and Friday from "),
    prop(X, SH, sTime, B),
    convertTime(B),
    write(" to "),
    prop(X, SH, eTime, C),
    convertTime(C),
    write(" in term "),
    prop(X, SH, term, D),
    write(D),
    write(".\n"),
    find_times(X, ST).

find_times(X, [SH | ST]) :-
    prop(X, SH, day, A),
    A = tth,
    write("Section "),
    write(SH),
    write(" is offered on "),
    write("Tuesday, and Thursday from "),
    prop(X, SH, sTime, B),
    convertTime(B),
    write(" to "),
    prop(X, SH, eTime, C),
    convertTime(C),
    write(" in term "),
    prop(X, SH, term, D),
    write(D),
    write(".\n"),
    find_times(X, ST).

%%%%%
%%%%% Query 3
%%%%% 3. Who teaches a specific course?
%%%%%

query(3) :-
    write("What class? "),
    readAtom(Class),
    write("Specific section? (Type section number, or N for all sections) "),
    readAtom(Section),
    findTeacher(Class, Section).

findTeacher(X, 'N') :-
    findall(T, prop(X, _, instructor, T), R),
    write("The professors for CPSC "),
    write(X),
    write(" are: "),
    write(R),
    write("\n\n").

findTeacher(X, Y) :-
    findall(T, prop(X, Y, instructor, T), R),
    write("The professor for CPSC "),
    write(X),
    write(" is "),
    write(R),
    write("\n\n").

%%%%%
%%%%% Query 4
%%%%% 4. What are the prerequisites of a course?
%%%%%

query(4) :-
    write("What class? "),
    readAtom(Class),
    findPreReqs(Class).

findPreReqs(X) :-
    findall(P, prop(X, _, prereq, P), R),
    write("The prerequisites for CPSC "),
    write(X),
    write(" are: "),
    write(R),
    write("\n\n").

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
    readAtom(In),
    write("What is the highest course you have taken in this field? (N for none)\n"),
    readAtom(High),
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

find_field(In, 'N') :-
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




%%%%%
%%%%% Query 0
%%%%% 0. Exit
%%%%%
query(0).




%%%%%%% Schedule building logic


% findSchedule creates a schedule out of user inputted courses
findSchedule() :-
    write("What courses do you want to take?\n"), flush_output(current_output),
    readLine(Courses),
    findall(Sections, findCompatableSections(Courses, Sections), L),
    handleSchedules(L, [1,2,3]).

% where there is no combination of courses
handleSchedules([], _) :-
    write("There is no possible schedule with these courses.\n").

% when one schedule is found
handleSchedules([A], _) :-
    write("Schedule found:\n"),
    printSections(A).

% when there are no more options left, show the first schedule
handleSchedules([A | _], []) :-
    write("Schedule found:\n"),
    printSections(A).

% when there are more than one schedules left, the user can pick a criteria
% to filter down the list of schedules
handleSchedules(L, AvailableOptions) :-
    length(L, Length),
    Length > 1,
    write(Length),
    write(" schedules found. To narrow it down, choose a criteria.\n"),
    printOptions(AvailableOptions),
    readAtom(N),
    filterList(L, N, R),
    delete(AvailableOptions, N, NewOptions),
    handleSchedules(R, NewOptions).

printOptions([]).
printOptions([H | T]) :-
    option(H, O),
    write(O),
    printOptions(T).

option(1, "1. Latest start time\n").
option(2, "2. Earliest end time\n").
option(3, "3. Fewest days\n").

filterList([], _, []).
filterList(L, 1, R) :- getLatestStart(L, R).
filterList(L, 2, R) :- getEarliestEnd(L, R).
filterList(L, 3, R) :- getFewestDays(L, R).

getLatestStart(L, R) :-
    getAllStartTimes(L, Stimes),
    keysort(Stimes, Sorted),
    reverse(Sorted, Descending),
    allResults(Descending, R).

getEarliestEnd(L, R) :-
    getAllEndTimes(L, Stimes),
    keysort(Stimes, Sorted),
    allResults(Sorted, R).

getFewestDays(L, R) :-
    getAllDayCounts(L, Counts),
    keysort(Counts, Sorted),
    allResults(Sorted, R).


% allResults(List, R) is true when R is the first elements of List that have the same key
allResults([], _, []).
allResults([Stime-_ | _], Key, []) :-
    Stime \= Key.
allResults([Stime-Schedule | T], Stime, [Schedule | R]) :-
    allResults(T, Stime, R).
allResults([Key-Schedule | T], [Schedule | R]) :-
    allResults(T, Key, R).


% getAllStartTimes(Schedules, StartTimes) is true when StartTimes is a key-value
% pair of start times and schedules for the given schedules
getAllStartTimes([], []).
getAllStartTimes([Schedule | T], [Stime-Schedule | R]) :-
    startTimeOfSchedule(Schedule, Stime),
    getAllStartTimes(T, R).

startTimeOfSchedule(Schedule, Stime) :-
    startTimes(Schedule, Stimes),
    min_list(Stimes, Stime).

startTimes([], []).
startTimes([course(Course, Sec) | T1], [Stime | T2]) :-
    prop(Course, Sec, sTime, Stime),
    startTimes(T1, T2).


% getAllEndTimes(Schedules, EndTimes) is true when EndTimes is a key-value
% pair of end times and schedules for the given schedules
getAllEndTimes([], []).
getAllEndTimes([Schedule | T], [Etime-Schedule | R]) :-
    endTimeOfSchedule(Schedule, Etime),
    getAllEndTimes(T, R).

endTimeOfSchedule(Schedule, Etime) :-
    endTimes(Schedule, Etimes),
    max_list(Etimes, Etime).

endTimes([], []).
endTimes([course(Course, Sec) | T1], [Etime | T2]) :-
    prop(Course, Sec, eTime, Etime),
    endTimes(T1, T2).


% getAllDayCounts(Schedules, Days) is true when Days is a key-value
% pair of the number of days for each schedule
getAllDayCounts([], []).
getAllDayCounts([Schedule | T], [Days-Schedule | R]) :-
    totalDaysOfSchedule(Schedule, Days),
    getAllDayCounts(T, R).

totalDaysOfSchedule(Schedule, R) :-
    daysOfSchedule(Schedule, [], Days),
    sumDays(Days, R).

daysOfSchedule([], R, R).
daysOfSchedule([Course | T], Seen, R) :-
    dayAndTerm(Course, DT),
    daysOfSchedule(DT, T, Seen, R).
daysOfSchedule(DT, T, Seen, R) :-
    maplist(dif(DT), Seen),
    daysOfSchedule(T, [DT | Seen], R).
daysOfSchedule(DT, T, Seen, R) :-
    member(DT, Seen),
    daysOfSchedule(T, Seen, R).

dayAndTerm(course(Course, Sec), Day-Term) :-
    prop(Course, Sec, day, Day),
    prop(Course, Sec, term, Term).

sumDays([], 0).
sumDays([mwf-_ | T], R) :-
    sumDays(T, R2),
    R is R2 + 3.
sumDays([tth-_ | T], R) :-
    sumDays(T, R2),
    R is R2 + 2.


% findCompatableSections(Courses, Sections) when Sections is a compatable list of
% sections from the given courses
findCompatableSections(Courses, Sections) :-
    courseListToPairs(Courses, Sections),
    allSectionsCompatable(Sections).


% allSectionsCompatable(Courses) is true if all courses in the list are compatable with each other
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

% compatableSections(Course1, Sec1, Course2, Sec2) is true if Course1 Sec1
% is compatable with Course2 Sec2
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


printSections([]) :-
    write("\n\n"),!.
printSections([course(Course, Section) | T]) :-
    write("CPSC "),
    write(Course),
    write(" Section "),
    write(Section),
    write(" at "),
    prop(Course, Section, sTime, Stime),
    convertTime(Stime),
    write(" - "),
    prop(Course, Section, eTime, Etime),
    convertTime(Etime),
    write(" "),
    prop(Course, Section, day, Day),
    write(Day),
    write(" in term "),
    prop(Course, Section, term, Term),
    write(Term),
    write("\n"),
    printSections(T).


convertTime(T) :-
    T = 8,
    write("8:00AM").
convertTime(T) :-
    T = 8.5,
    write("8:30AM").
convertTime(T) :-
    T = 9,
    write("9:00AM").
convertTime(T) :-
    T = 9.5,
    write("9:30AM").
convertTime(T) :-
    T = 10,
    write("10:00AM").
convertTime(T) :-
    T = 10.5,
    write("10:30AM").
convertTime(T) :-
    T = 11,
    write("11:00AM").
convertTime(T) :-
    T = 11.5,
    write("11:30AM").
convertTime(T) :-
    T = 12,
    write("12:00PM").
convertTime(T) :-
    T = 12.5,
    write("12:30PM").
convertTime(T) :-
    T = 13,
    write("1:00PM").
convertTime(T) :-
    T = 13.5,
    write("1:30PM").
convertTime(T) :-
    T = 14,
    write("2:00PM").
convertTime(T) :-
    T = 14.5,
    write("2:30PM").
convertTime(T) :-
    T = 15,
    write("3:00PM").
convertTime(T) :-
    T = 15.5,
    write("3:30PM").
convertTime(T) :-
    T = 16,
    write("4:00PM").
convertTime(T) :-
    T = 16.5,
    write("4:30PM").
convertTime(T) :-
    T = 17,
    write("5:00PM").
convertTime(T) :-
    T = 17.5,
    write("5:30PM").
convertTime(T) :-
    T = 18,
    write("6:00PM").
convertTime(T) :-
    T = 18.5,
    write("6:30PM").
convertTime(T) :-
    T = 19,
    write("7:00PM").
convertTime(T) :-
    T = 19.5,
    write("7:30PM").
convertTime(T) :-
    T = 20,
    write("8:00PM").
convertTime(T) :-
    T = 20.5,
    write("8:30PM").
convertTime(T) :-
    T = 21,
    write("9:00PM").
convertTime(T) :-
    T = 21.5,
    write("9:30PM").
convertTime(T) :-
    T = 22,
    write("10:00PM").

% readAtom reads in user input as an atom or a number if possible
readAtom(R) :-
    read_line_to_codes(user_input, Input),
    parseInput(Input, R).

parseInput(Input, R) :-
    string_to_atom(Input,X),
    atom_number(X, R),!.

parseInput(Input, R) :-
    string_to_atom(Input,R).

% readLine reads a line of input as a list of atoms or numbers
readLine(R) :-
  read_line_to_codes(user_input, Input),
  string_to_atom(Input,Atom),
  atomic_list_concat(AtomList,' ',Atom),
  parseAll(AtomList, R).

parseAll([], []).
parseAll([H | T1], [R | R2]) :-
    parseInput(H, R),
    parseAll(T1, R2).

%
% Course Information Database
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
prop(110, 101, section, 110).
prop(110, 101, instructor, "Gregor Kiczales").
prop(110, 101, day, tth).
prop(110, 101, sTime, 12.5).
prop(110, 101, eTime, 14).
prop(110, 101, building, "Woodward").
prop(110, 101, room, 2).

% section 103
prop(110, 103, term, 1).
prop(110, 103, section, 103).
prop(110, 103, instructor, "Oluwakemi Ola").
prop(110, 103, day, mwf).
prop(110, 103, sTime, 16).
prop(110, 103, eTime, 17).
prop(110, 103, building, "Wesbrook").
prop(110, 103, room, 100).

% section 201
prop(110, 201, term, 2).
prop(110, 201, section, 201).
prop(110, 201, instructor, "Anthony Estey").
prop(110, 201, day, tth).
prop(110, 201, sTime, 15.5).
prop(110, 201, eTime, 17).
prop(110, 201, building, "Neville Scarfe").
prop(110, 201, room, 100).

% section 202
prop(110, 202, term, 2).
prop(110, 202, section, 202).
prop(110, 202, instructor, "Oluwakemi Ola").
prop(110, 202, day, mwf).
prop(110, 202, sTime, 15).
prop(110, 202, eTime, 16).
prop(110, 202, building, "Forest Sciences Centre").
prop(110, 202, room, 1005).

% section 203
prop(110, 203, term, 2).
prop(110, 203, section, 203).
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
prop(121, 101, section, 101).
prop(121, 101, instructor, "Patrice Belleville").
prop(121, 101, day, tth).
prop(121, 101, sTime, 9.5).
prop(121, 101, eTime, 11).
prop(121, 101, building, "Pharmaceutical Sciences Building").
prop(121, 101, room, 1201).

% section 102
prop(121, 102, term, 1).
prop(121, 102, section, 102).
prop(121, 102, instructor, "Frederick Shepherd").
prop(121, 102, day, tth).
prop(121, 102, sTime, 15.5).
prop(121, 102, eTime, 17).
prop(121, 102, building, "Hugh Dempster Pavilion").
prop(121, 102, room, 310).

% section 103
prop(121, 103, term, 1).
prop(121, 103, section, 103).
prop(121, 103, instructor, "Cinda Heeren").
prop(121, 103, day, tth).
prop(121, 103, sTime, 17).
prop(121, 103, eTime, 18.5).
prop(121, 103, building, "Hugh Dempster Pavilion").
prop(121, 103, room, 310).

% section 201
prop(121, 201, term, 2).
prop(121, 201, section, 201).
prop(121, 201, instructor, "Cinda Heeren").
prop(121, 201, day, mwf).
prop(121, 201, sTime, 9).
prop(121, 201, eTime, 10).
prop(121, 201, building, "West Mall Swing Space").
prop(121, 201, room, 121).

% section 202
prop(121, 202, term, 2).
prop(121, 202, section, 202).
prop(121, 202, instructor, "Patrice Belleville").
prop(121, 202, day, mwf).
prop(121, 202, sTime, 12).
prop(121, 202, eTime, 13).
prop(121, 202, building, "MacMillan").
prop(121, 202, room, 166).

% section 203
prop(121, 203, term, 2).
prop(121, 203, section, 203).
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
prop(210, 101, section, 101).
prop(210, 101, instructor, "Elisa Baniassad").
prop(210, 101, day, mwf).
prop(210, 101, sTime, 12).
prop(210, 101, eTime, 13).
prop(210, 101, building, "West Mall Swing Space").
prop(210, 101, room, 122).

% section 102
prop(210, 102, term, 1).
prop(210, 102, section, 102).
prop(210, 102, instructor, "Ali Madooei").
prop(210, 102, day, mwf).
prop(210, 102, sTime, 15).
prop(210, 102, eTime, 16).
prop(210, 102, building, "Hugh Dempster Pavilion").
prop(210, 102, room, 310).

% section 103
prop(210, 103, term, 1).
prop(210, 103, section, 103).
prop(210, 103, instructor, "Michael Feeley").
prop(210, 103, day, mwf).
prop(210, 103, sTime, 14).
prop(210, 103, eTime, 15).
prop(210, 103, building, "Hugh Dempster Pavilion").
prop(210, 103, room, 310).

% section 201
prop(210, 201, term, 2).
prop(210, 201, section, 201).
prop(210, 201, instructor, "Paul Martin Carter").
prop(210, 201, day, mwf).
prop(210, 201, sTime, 14).
prop(210, 201, eTime, 15).
prop(210, 201, building, "West Mall Swing Space").
prop(210, 201, room, 121).

% section 202
prop(210, 202, term, 2).
prop(210, 202, section, 202).
prop(210, 202, instructor, "Ali Madooei").
prop(210, 202, day, mwf).
prop(210, 202, sTime, 12).
prop(210, 202, eTime, 13).
prop(210, 202, building, "Hugh Dempster Pavilion").
prop(210, 202, room, 310).

% section 203
prop(210, 203, term, 2).
prop(210, 203, section, 203).
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
prop(213, 101, section, 101).
prop(213, 101, instructor, "Jonatan Schroeder").
prop(213, 101, day, tth).
prop(213, 101, sTime, 14).
prop(213, 101, eTime, 15.5).
prop(213, 101, building, "Hugh Dempster Pavilion").
prop(213, 101, room, 310).

% section 102
prop(213, 102, term, 1).
prop(213, 102, section, 102).
prop(213, 102, instructor, "Jonatan Schroeder").
prop(213, 102, day, mwf).
prop(213, 102, sTime, 13).
prop(213, 102, eTime, 14).
prop(213, 102, building, "Hugh Dempster Pavilion").
prop(213, 102, room, 310).

% section 203
prop(213, 203, term, 2).
prop(213, 203, section, 203).
prop(213, 203, instructor, "Michael Feeley").
prop(213, 203, day, mwf).
prop(213, 203, sTime, 13).
prop(213, 203, eTime, 14).
prop(213, 203, building, "Hugh Dempster Pavilion").
prop(213, 203, room, 310).

% section 204
prop(213, 204, term, 2).
prop(213, 204, section, 204).
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
prop(221, 101, section, 101).
prop(221, 101, instructor, "Geoffrey Tien").
prop(221, 101, day, mwf).
prop(221, 101, sTime, 14).
prop(221, 101, eTime, 15).
prop(221, 101, building, "West Mall Swing Space").
prop(221, 101, room, 221).

% section 102
prop(221, 102, term, 1).
prop(221, 102, section, 102).
prop(221, 102, instructor, "Cinda Heeren").
prop(221, 102, day, tth).
prop(221, 102, sTime, 9.5).
prop(221, 102, eTime, 11).
prop(221, 102, building, "Hugh Dempster Pavilion").
prop(221, 102, room, 310).

% section 201
prop(221, 201, term, 2).
prop(221, 201, section, 201).
prop(221, 201, instructor, "Geoffrey Tien").
prop(221, 201, day, mwf).
prop(221, 201, sTime, 17).
prop(221, 201, eTime, 18).
prop(221, 201, building, "Pharmaceutical Sciences Building").
prop(221, 201, room, 1201).

% section 202
prop(221, 202, term, 2).
prop(221, 202, section, 202).
prop(221, 202, instructor, "William Evans").
prop(221, 202, day, mwf).
prop(221, 202, sTime, 16).
prop(221, 202, eTime, 17).
prop(221, 202, building, "Wesbrook").
prop(221, 202, room, 100).

% section 203
prop(221, 203, term, 2).
prop(221, 203, section, 203).
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
prop(310, 101, section, 101).
prop(310, 101, instructor, "Anthony Estey").
prop(310, 101, day, tth).
prop(310, 101, sTime, 12.5).
prop(310, 101, eTime, 14).
prop(310, 101, building, "West Mall Swing Space").
prop(310, 101, room, 122).

% section 102
prop(310, 102, term, 1).
prop(310, 102, section, 102).
prop(310, 102, instructor, "Reid Holmes").
prop(310, 102, day, tth).
prop(310, 102, sTime, 9.5).
prop(310, 102, eTime, 11).
prop(310, 102, building, "West Mall Swing Space").
prop(310, 102, room, 221).

% section 201
prop(310, 201, term, 2).
prop(310, 201, section, 201).
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
prop(312, 101, section, 101).
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
prop(313, 101, section, 101).
prop(313, 101, instructor, "Jonatan Schroeder").
prop(313, 101, day, mwf).
prop(313, 101, sTime, 11).
prop(313, 101, eTime, 12).
prop(313, 101, building, "Hugh Dempster Pavilion").
prop(313, 101, room, 310).

% section 203
prop(313, 203, term, 2).
prop(313, 203, section, 203).
prop(313, 203, instructor, "Jonatan Schroeder").
prop(313, 203, day, mwf).
prop(313, 203, sTime, 14).
prop(313, 203, eTime, 15).
prop(313, 203, building, "Leonard S. Klinck").
prop(313, 203, room, 200).

% section 204
prop(313, 204, term, 2).
prop(313, 204, section, 204).
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
prop(314, 101, section, 101).
prop(314, 101, instructor, "Michael van der Panne").
prop(314, 101, day, mwf).
prop(314, 101, sTime, 10).
prop(314, 101, eTime, 11).
prop(314, 101, building, "Hugh Dempster Pavilion").
prop(314, 101, room, 110).

% section 201
prop(314, 201, term, 2).
prop(314, 201, section, 201).
prop(314, 201, instructor, "Dinesh Pai").
prop(314, 201, day, mwf).
prop(314, 201, sTime, 10).
prop(314, 201, eTime, 11).
prop(314, 201, building, "Hugh Dempster Pavilion").
prop(314, 201, room, 310).


% course 317
prop(317, _, course, 317).
prop(317, _, name, "Internet Computing").
prop(317, _, type, "internet").
prop(317, _, prereq, 213).
prop(317, _, prereq, 221).

% section 101
prop(317, 101, term, 1).
prop(317, 101, section, 101).
prop(317, 101, instructor, "Alan Wagner").
prop(317, 101, day, mwf).
prop(317, 101, sTime, 11).
prop(317, 101, eTime, 12).
prop(317, 101, building, "West Mall Swing Space").
prop(317, 101, room, 121).

% section 203
prop(317, 201, term, 2).
prop(317, 201, section, 203).
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
prop(319, 201, section, 201).
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
prop(320, 101, section, 101).
prop(320, 101, instructor, "Anne Condon").
prop(320, 101, day, mwf).
prop(320, 101, sTime, 14).
prop(320, 101, eTime, 15).
prop(320, 101, building, "Hennings").
prop(320, 101, room, 200).

% section 102
prop(320, 102, term, 1).
prop(320, 102, section, 102).
prop(320, 102, instructor, "Patrice Belleville").
prop(320, 102, day, mwf).
prop(320, 102, sTime, 16).
prop(320, 102, eTime, 17).
prop(320, 102, building, "Hennings").
prop(320, 102, room, 200).

% section 201
prop(320, 201, term, 2).
prop(320, 201, section, 201).
prop(320, 201, instructor, "Geoffrey Tien").
prop(320, 201, day, mwf).
prop(320, 201, sTime, 10).
prop(320, 201, eTime, 11).
prop(320, 201, building, "Hennings").
prop(320, 201, room, 200).

% section 202
prop(320, 202, term, 2).
prop(320, 202, section, 202).
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
prop(322, 101, section, 101).
prop(322, 101, instructor, "Jordan Johnson").
prop(322, 101, day, tth).
prop(322, 101, sTime, 17).
prop(322, 101, eTime, 18.5).
prop(322, 101, building, "Pharmaceutical Sciences Building").
prop(322, 101, room, 1201).

% section 201
prop(322, 201, term, 2).
prop(322, 201, section, 201).
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
prop(340, 101, section, 101).
prop(340, 101, instructor, "Mark Schmidt").
prop(340, 101, day, mwf).
prop(340, 101, sTime, 16).
prop(340, 101, eTime, 17).
prop(340, 101, building, "MacMillan").
prop(340, 101, room, 166).

% section 103
prop(340, 103, term, 1).
prop(340, 103, section, 103).
prop(340, 103, instructor, "Michael Gelbart").
prop(340, 103, day, mwf).
prop(340, 103, sTime, 12).
prop(340, 103, eTime, 13).
prop(340, 103, building, "Hugh Dempster Pavilion").
prop(340, 103, room, 110).

% section 201
prop(340, 201, term, 2).
prop(340, 201, section, 201).
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
prop(410, 101, section, 101).
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
prop(418, 101, section, 101).
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
prop(420, 101, section, 101).
prop(420, 101, instructor, "Alan Hu").
prop(420, 101, day, mwf).
prop(420, 101, sTime, 9).
prop(420, 101, eTime, 10).
prop(420, 101, building, "Hugh Dempster Pavilion").
prop(420, 101, room, 110).

% section 201
prop(420, 201, term, 2).
prop(420, 201, section, 201).
prop(420, 201, instructor, "Hu Fu").
prop(420, 201, day, mwf).
prop(420, 201, sTime, 13).
prop(420, 201, eTime, 14).
prop(420, 201, building, "Hugh Dempster Pavilion").
prop(420, 201, room, 110).


% course 430
prop(430, _, course, 430).
prop(430, _, name, "Computers and Society").
prop(430, _, type, "ethics").

% section 101
prop(430, 101, term, 1).
prop(430, 101, section, 101).
prop(430, 101, instructor, "Kevin Leyton-Brown").
prop(430, 101, day, tth).
prop(430, 101, sTime, 14).
prop(430, 101, eTime, 15.5).
prop(430, 101, building, "Hugh Dempster Pavilion").
prop(430, 101, room, 110).


% course 436D
prop(436, _, course, 436).
prop(436, _, name, "Topics in Computer Science").
prop(436, _, type, "fundamental").

% section 201
prop(436, 201, term, 2).
prop(436, 201, instructor, "Hu Fu").
prop(436, 201, day, mwf).
prop(436, 201, sTime, 15).
prop(436, 201, eTime, 17).
prop(436, 201, building, "Hugh Dempster Pavilion").
prop(436, 201, room, 301).


% course 425
prop(425, _, course, 425).
prop(425, _, name, "Computer Vision").
prop(425, _, type, "graphics").

% section 101
prop(425, 101, term, 1).
prop(425, 101, instructor, "Leonid Sigal").
prop(425, 101, day, mwf).
prop(425, 101, sTime, 15).
prop(425, 101, eTime, 16).
prop(425, 101, building, "West Mall Swing Space").
prop(425, 101, room, 122).

% section 201
prop(425, 201, term, 2).
prop(425, 201, instructor, "Leonid Sigal").
prop(425, 201, day, tth).
prop(425, 201, sTime, 12.5).
prop(425, 201, eTime, 14).
prop(425, 201, building, "Pharmaceutical Sciences Building").
prop(425, 201, room, 1201).


% course 426
prop(426, _, course, 426).
prop(426, _, name, "Computer Animation").
prop(426, _, type, "graphics").

% section 201
prop(426, 201, term, 2).
prop(426, 201, instructor, "Michiel Van De Panne").
prop(426, 201, day, mwf).
prop(426, 201, sTime, 8).
prop(426, 201, eTime, 9).
prop(426, 201, building, "Hugh Dempster Pavilion").
prop(426, 201, room, 110).


% course 522
prop(522, _, course, 522).
prop(522, _, name, "Artificial Intelligence II").
prop(522, _, type, "ai").

% section 201
prop(522, 201, term, 2).
prop(522, 201, instructor, "David Poole").
prop(522, 201, day, tth).
prop(522, 201, sTime, 9.5).
prop(522, 201, eTime, 11).
prop(522, 201, building, "Institute for Computing (ICICS/CS)").
prop(522, 201, room, 246).


% course 524
prop(524, _, course, 524).
prop(524, _, name, "Computer Graphics: Modeling").
prop(524, _, type, "graphics").

% section 201
prop(524, 201, term, 2).
prop(524, 201, instructor, "Alla Sheffer").
prop(524, 201, day, tth).
prop(524, 201, sTime, 10.5).
prop(524, 201, eTime, 12).
prop(524, 201, building, "Institute for Computing (ICICS/CS)").
prop(524, 201, room, 246).


% course 301
prop(301, _, course, 301).
prop(301, _, name, "Computing in the Life Sciences").
prop(301, _, type, "ethics").

% section 101
prop(301, 101, term, 1).
prop(301, 101, instructor, "Jerry Jim").
prop(301, 101, day, tth).
prop(301, 101, sTime, 15.5).
prop(301, 101, eTime, 17).
prop(301, 101, building, "Geography").
prop(301, 101, room, 100).
