% Course Schedule Bot
% Authors: Reed Esler, Dan Glaser




%
% Course Information Database
% Course(number, name, type, prereq, section, term, instructor, days, start time, end time, building, room)
% Types can include: ai, core, internet, graphics, etc.
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
prop(110, _, prereq, none).

% section 101
prop(110, 101, term, 1).
prop(110, 101, instructor, "Gregor Kiczales").
prop(110, 101, day, tth).
prop(110, 101, sTime, "12:30").
prop(110, 101, eTime, "14:00").
prop(110, 101, building, "Woodward").
prop(110, 101, room, 2).

% section 103
prop(110, 103, term, 1).
prop(110, 103, instructor, "Oluwakemi Ola").
prop(110, 103, day, mwf).
prop(110, 103, sTime, "16:00").
prop(110, 103, eTime, "17:00").
prop(110, 103, building, "Wesbrook").
prop(110, 103, room, 100).

% section 201
prop(110, 201, term, 2).
prop(110, 201, instructor, "Anthony Estey").
prop(110, 201, day, tth).
prop(110, 201, sTime, "15:30").
prop(110, 201, eTime, "17:00").
prop(110, 201, building, "Neville Scarfe").
prop(110, 201, room, 100).

% section 202
prop(110, 202, term, 2).
prop(110, 202, instructor, "Oluwakemi Ola").
prop(110, 202, day, mwf).
prop(110, 202, sTime, "15:00").
prop(110, 202, eTime, "16:00").
prop(110, 202, building, "Forest Sciences Centre").
prop(110, 202, room, 1005).

% section 203
prop(110, 203, term, 2).
prop(110, 203, instructor, "Anthony Estey").
prop(110, 203, day, tth).
prop(110, 203, sTime, "9:30").
prop(110, 203, eTime, "11:00").
prop(110, 203, building, "Chemical and Biological Engineering Building").
prop(110, 203, room, 101).


% course 121
prop(121, _, course, 121).
prop(121, _, name, "Models of Computation").
prop(121, _, prereq, none).

% section 101
prop(121, 101, term, 1).
prop(121, 101, instructor, "Patrice Belleville").
prop(121, 101, day, tth).
prop(121, 101, sTime, 9:30).
prop(121, 101, eTime, 11:00).
prop(121, 101, building, "Pharmaceutical Sciences Building").
prop(121, 101, room, 1201).

% section 102
prop(121, 102, term, 1).
prop(121, 102, instructor, "Frederick Shepherd").
prop(121, 102, day, tth).
prop(121, 102, sTime, 15:30).
prop(121, 102, eTime, 17:00).
prop(121, 102, building, "Hugh Dempster Pavilion").
prop(121, 102, room, 310).

% section 103
prop(121, 103, term, 1).
prop(121, 103, instructor, "Cinda Heeren").
prop(121, 103, day, tth).
prop(121, 103, sTime, 17:00).
prop(121, 103, eTime, 18:30).
prop(121, 103, building, "Hugh Dempster Pavilion").
prop(121, 103, room, 310).

% section 201
prop(121, 201, term, 2).
prop(121, 201, instructor, "Cinda Heeren").
prop(121, 201, day, mwf).
prop(121, 201, sTime, 9:00).
prop(121, 201, eTime, 10:00).
prop(121, 201, building, "West Mall Swing Space").
prop(121, 201, room, 121).

% section 202
prop(121, 202, term, 2).
prop(121, 202, instructor, "Patrice Belleville").
prop(121, 202, day, mwf).
prop(121, 202, sTime, 12:00).
prop(121, 202, eTime, 13:00).
prop(121, 202, building, "MacMillan").
prop(121, 202, room, 166).

% section 203
prop(121, 203, term, 2).
prop(121, 203, instructor, "Patrice Belleville").
prop(121, 203, day, mwf).
prop(121, 203, sTime, 16:00).
prop(121, 203, eTime, 17:00).
prop(121, 203, building, "Woodward").
prop(121, 203, room, 6).


% course 210
prop(210, _, course, 210).
prop(210, _, name, "Software Construction").
% Pre-reqs: One of CPSC 107, CPSC 110, CPSC 260.
% Will use 110 as the prereq as a place holder.
prop(210, _, prereq, 110).

% section 101
prop(210, 101, term, 1).
prop(210, 101, instructor, "Elisa Baniassad").
prop(210, 101, day, mwf).
prop(210, 101, sTime, 12:00).
prop(210, 101, eTime, 13:00).
prop(210, 101, building, "West Mall Swing Space").
prop(210, 101, room, 122).

% section 102
prop(210, 102, term, 1).
prop(210, 102, instructor, "Ali Madooei").
prop(210, 102, day, mwf).
prop(210, 102, sTime, 15:00).
prop(210, 102, eTime, 16:00).
prop(210, 102, building, "Hugh Dempster Pavilion").
prop(210, 102, room, 310).

% section 103
prop(210, 103, term, 1).
prop(210, 103, instructor, "Michael Feeley").
prop(210, 103, day, mwf).
prop(210, 103, sTime, 14:00).
prop(210, 103, eTime, 15:00).
prop(210, 103, building, "Hugh Dempster Pavilion").
prop(210, 103, room, 310).

% section 201
prop(210, 201, term, 2).
prop(210, 201, instructor, "Paul Martin Carter").
prop(210, 201, day, mwf).
prop(210, 201, sTime, 14:00).
prop(210, 201, eTime, 15:00).
prop(210, 201, building, "West Mall Swing Space").
prop(210, 201, room, 121).

% section 202
prop(210, 202, term, 2).
prop(210, 202, instructor, "Ali Madooei").
prop(210, 202, day, mwf).
prop(210, 202, sTime, 12:00).
prop(210, 202, eTime, 13:00).
prop(210, 202, building, "Hugh Dempster Pavilion").
prop(210, 202, room, 310).

% section 203
prop(210, 203, term, 2).
prop(210, 203, instructor, "Paul Martin Carter").
prop(210, 203, day, mwf).
prop(210, 203, sTime, 15:00).
prop(210, 203, eTime, 16:00).
prop(210, 203, building, "West Mall Swing Space").
prop(210, 203, room, 222).


% course 213
prop(213, _, course, 213).
prop(213, _, name, "Introduction to Computer Systems").
% Pre-reqs: All of CPSC 121, CPSC 210.
prop(213, _, prereq, 121).
prop(213, _, prereq, 210).

% section 101
prop(213, 101, term, 1).
prop(213, 101, instructor, "Jonatan Schroeder").
prop(213, 101, day, tth).
prop(213, 101, sTime, 14:00).
prop(213, 101, eTime, 15:30).
prop(213, 101, building, "Hugh Dempster Pavilion").
prop(213, 101, room, 310).

% section 102
prop(213, 102, term, 1).
prop(213, 102, instructor, "Jonatan Schroeder").
prop(213, 102, day, mwf).
prop(213, 102, sTime, 13:00).
prop(213, 102, eTime, 14:00).
prop(213, 102, building, "Hugh Dempster Pavilion").
prop(213, 102, room, 310).

% section 203
prop(213, 203, term, 2).
prop(213, 203, instructor, "Michael Feeley").
prop(213, 203, day, mwf).
prop(213, 203, sTime, 13:00).
prop(213, 203, eTime, 14:00).
prop(213, 203, building, "Hugh Dempster Pavilion").
prop(213, 203, room, 310).

% section 204
prop(213, 204, term, 2).
prop(213, 204, instructor, "Anthony Estey").
prop(213, 204, day, mwf).
prop(213, 204, sTime, 9:00).
prop(213, 204, eTime, 10:00).
prop(213, 204, building, "Hugh Dempster Pavilion").
prop(213, 204, room, 310).


% course 221
prop(221, _, course, 221).
prop(221, _, name, "Basic Algorithms and Data Structures").
% Pre-reqs: One of CPSC 210, EECE 210, CPEN 221 and one of CPSC 121, MATH 220.
% We will only use cpsc prereqs for simplicity
prop(221, _, prereq, 210).
prop(221, _, prereq, 121).

% section 101
prop(221, 101, term, 1).
prop(221, 101, instructor, "Geoffrey Tien").
prop(221, 101, day, mwf).
prop(221, 101, sTime, 14:00).
prop(221, 101, eTime, 15:00).
prop(221, 101, building, "West Mall Swing Space").
prop(221, 101, room, 221).

% section 102
prop(221, 102, term, 1).
prop(221, 102, instructor, "Cinda Heeren").
prop(221, 102, day, tth).
prop(221, 102, sTime, 9:30).
prop(221, 102, eTime, 11:00).
prop(221, 102, building, "Hugh Dempster Pavilion").
prop(221, 102, room, 310).

% section 201
prop(221, 201, term, 2).
prop(221, 201, instructor, "Geoffrey Tien").
prop(221, 201, day, mwf).
prop(221, 201, sTime, 17:00).
prop(221, 201, eTime, 18:00).
prop(221, 201, building, "Pharmaceutical Sciences Building").
prop(221, 201, room, 1201).

% section 202
prop(221, 202, term, 2).
prop(221, 202, instructor, "William Evans").
prop(221, 202, day, mwf).
prop(221, 202, sTime, 16:00).
prop(221, 202, eTime, 17:00).
prop(221, 202, building, "Wesbrook").
prop(221, 202, room, 100).

% section 203
prop(221, 203, term, 2).
prop(221, 203, instructor, "Cinda Heeren").
prop(221, 203, day, mwf).
prop(221, 203, sTime, 12:00).
prop(221, 203, eTime, 13:00).
prop(221, 203, building, "Pharmaceutical Sciences Building").
prop(221, 203, room, 1101).


% course 310
prop(310, _, course, 310).
prop(310, _, name, "Introduction to Software Engineering").
% Pre-reqs: CPSC 210.
prop(310, _, prereq, 210).

% section 101
prop(310, 101, term, 1).
prop(310, 101, instructor, "Anthony Estey").
prop(310, 101, day, tth).
prop(310, 101, sTime, 12:30).
prop(310, 101, eTime, 14:00).
prop(310, 101, building, "West Mall Swing Space").
prop(310, 101, room, 122).

% section 102
prop(310, 102, term, 1).
prop(310, 102, instructor, "Reid Holmes").
prop(310, 102, day, tth).
prop(310, 102, sTime, 9:30).
prop(310, 102, eTime, 11:00).
prop(310, 102, building, "West Mall Swing Space").
prop(310, 102, room, 221).

% section 201
prop(310, 201, term, 2).
prop(310, 201, instructor, "Elisa Baniassad").
prop(310, 201, day, tth).
prop(310, 201, sTime, 12:30).
prop(310, 201, eTime, 14:00).
prop(310, 201, building, "Hugh Dempster Pavilion").
prop(310, 201, room, 310).


% course 313
prop(313, _, course, 313).
prop(313, _, name, "Computer Hardware and Operating Systems").
% Pre-reqs: Either (a) all of CPSC 213, CPSC 221 or (b) all of CPSC 210, CPSC 213, CPSC 260, EECE 320.
% will use case (a) for simplicity
prop(313, _, prereq, 213).
prop(313, _, prereq, 221).

% section 101
prop(313, 101, term, 1).
prop(313, 101, instructor, "Jonatan Schroeder").
prop(313, 101, day, mwf).
prop(313, 101, sTime, 11:00).
prop(313, 101, eTime, 12:00).
prop(313, 101, building, "Hugh Dempster Pavilion").
prop(313, 101, room, 310).

% section 203
prop(313, 203, term, 2).
prop(313, 203, instructor, "Jonatan Schroeder").
prop(313, 203, day, mwf).
prop(313, 203, sTime, 14:00).
prop(313, 203, eTime, 15:00).
prop(313, 203, building, "Leonard S. Klinck").
prop(313, 203, room, 200).

% section 204
prop(313, 204, term, 2).
prop(313, 204, instructor, "Donald Acton").
prop(313, 204, day, tth).
prop(313, 204, sTime, 12:30).
prop(313, 204, eTime, 14:00).
prop(313, 204, building, "Friedman Building").
prop(313, 204, room, 153).


% course 320
prop(320, _, course, 320).
prop(320, _, name, "Intermediate Algorithm Design and Analysis").
% Pre-reqs: Either (a) CPSC 221 or (b) all of CPSC 260, EECE 320. (In addition to above pre-requisites, at least 3 credits from COMM 291, BIOL 300, MATH or STAT at 200 level or above.)
% will use case (a) for simplicity
prop(320, _, prereq, 221).

% section 101
prop(320, 101, term, 1).
prop(320, 101, instructor, "Anne Condon").
prop(320, 101, day, mwf).
prop(320, 101, sTime, 14:00).
prop(320, 101, eTime, 15:00).
prop(320, 101, building, "Hennings").
prop(320, 101, room, 200).

% section 102
prop(320, 102, term, 1).
prop(320, 102, instructor, "Patrice Belleville").
prop(320, 102, day, mwf).
prop(320, 102, sTime, 16:00).
prop(320, 102, eTime, 17:00).
prop(320, 102, building, "Hennings").
prop(320, 102, room, 200).

% section 201
prop(320, 201, term, 2).
prop(320, 201, instructor, "Geoffrey Tien").
prop(320, 201, day, mwf).
prop(320, 201, sTime, 10:00).
prop(320, 201, eTime, 11:00).
prop(320, 201, building, "Hennings").
prop(320, 201, room, 200).

% section 202
prop(320, 202, term, 2).
prop(320, 202, instructor, "Anne Condon").
prop(320, 202, day, mwf).
prop(320, 202, sTime, 8:00).
prop(320, 202, eTime, 9:00).
prop(320, 202, building, "Hennings").
prop(320, 202, room, 200).


% course 322
prop(322, _, course, 322).
prop(322, _, name, "Introduction to Artificial Intelligence").
% artificial
prop(322, _, type, ai).
% Pre-reqs: Either (a) CPSC 221 or (b) all of CPSC 260, EECE 320 and one of CPSC 210, EECE 210, EECE 309.
% will use (a) for simplicity
prop(322, _, prereq, 221).

% section 101
prop(322, 101, term, 1).
prop(322, 101, instructor, "Jordan Johnson").
prop(322, 101, day, tth).
prop(322, 101, sTime, 17:00).
prop(322, 101, eTime, 18:30).
prop(322, 101, building, "Pharmaceutical Sciences Building").
prop(322, 101, room, 1201).

% section 201
prop(322, 201, term, 2).
prop(322, 201, instructor, "TBA").
prop(322, 201, day, tth).
prop(322, 201, sTime, 9:30).
prop(322, 201, eTime, 11:00).
prop(322, 201, building, "Hugh Dempster Pavilion").
prop(322, 201, room, 310).


% course 340
prop(340, _, course, 340).
prop(340, _, name, "Machine Learning and Data Mining").
% artificial
prop(340, _, type, ai).
% Pre-reqs: One of MATH 152, MATH 221, MATH 223 and one of MATH 200, MATH 217, MATH 226, MATH 253, MATH 263 and one of STAT 200, STAT 203, STAT 241, STAT 251, COMM 291, ECON 325, ECON 327, PSYC 218, PSYC 278, PSYC 366, MATH 302, STAT 302, MATH 318, BIOL 300; and either (a) CPSC 221 or (b) all of CPSC 260, EECE 320 and one of CPSC 210, EECE 210, EECE 309.
% will just use cpsc 221 for simplicity
prop(340, _, prereq, 221).

% section 101
prop(340, 101, term, 1).
prop(340, 101, instructor, "Mark Schmidt").
prop(340, 101, day, mwf).
prop(340, 101, sTime, 16:00).
prop(340, 101, eTime, 17:00).
prop(340, 101, building, "MacMillan").
prop(340, 101, room, 166).

% section 103
prop(340, 103, term, 1).
prop(340, 103, instructor, "Michael Gelbart").
prop(340, 103, day, mwf).
prop(340, 103, sTime, 12:00).
prop(340, 103, eTime, 13:00).
prop(340, 103, building, "Hugh Dempster Pavilion").
prop(340, 103, room, 110).

% section 201
prop(340, 201, term, 2).
prop(340, 201, instructor, "Frank Wood").
prop(340, 201, day, mwf).
prop(340, 201, sTime, 13:00).
prop(340, 201, eTime, 14:00).
prop(340, 201, building, "MacMillan").
prop(340, 201, room, 166).
