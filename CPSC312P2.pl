% Course Schedule Bot
% Authors: Reed Esler, Dan Glaser



% Course Information
% Course(number, name, section, term, instructor, date, start time, end time, building, room, prereq)
% Date should be mwf, tth, etc.

% Issue with courses that are in different buildings each day

% class(110, "Computation, Programs and Programming", 101, 1, "Gregor Kiczales", tth, "12:30", "14:00", "Woodward", 2, none).
prop(110, course, 110).
prop(110, name, "Computation, Programs and Programming").
prop(110, section, 101).
prop(110, term, 1).
prop(110, instructor, "Gregor Kiczales").
prop(110, day, tth).
prop(110, sTime, "12:30").
prop(110, eTime, "14:00").
prop(110, building, "Woodward").
prop(110, room, 2).
prop(110, prereq, none).

% class(110, "Computation, Programs and Programming", 103, 1, "Oluwakemi Ola", mwf, "16:00", "17:00", "Wesbrook", 100, none).
prop(110, course, 110).
prop(110, name, "Computation, Programs and Programming").
prop(110, section, 103).
prop(110, term, 1).
prop(110, instructor, "Oluwakemi Ola").
prop(110, day, mwf).
prop(110, sTime, "16:00").
prop(110, eTime, "17:00").
prop(110, building, "Wesbrook").
prop(110, room, 100).
prop(110, prereq, none).

prop(110, course, 110).
prop(110, name, "Computation, Programs and Programming").
prop(110, section, 201).
prop(110, term, 2).
prop(110, instructor, "Anthony Estey").
prop(110, day, tth).
prop(110, sTime, "15:30").
prop(110, eTime, "17:00").
prop(110, building, "Neville Scarfe").
prop(110, room, 100).
prop(110, prereq, none).

prop(110, course, 110).
prop(110, name, "Computation, Programs and Programming").
prop(110, section, 202).
prop(110, term, 2).
prop(110, instructor, "Oluwakemi Ola").
prop(110, day, mwf).
prop(110, sTime, "15:00").
prop(110, eTime, "16:00").
prop(110, building, "Forest Sciences Centre").
prop(110, room, 1005).
prop(110, prereq, none).

prop(110, course, 110).
prop(110, name, "Computation, Programs and Programming").
prop(110, section, 203).
prop(110, term, 2).
prop(110, instructor, "Anthony Estey").
prop(110, day, tth).
prop(110, sTime, "9:30").
prop(110, eTime, "11:00").
prop(110, building, "Chemical and Biological Engineering Building").
prop(110, room, 101).
prop(110, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 101).
prop(110, term, 1).
prop(121, instructor, "Patrice Belleville").
prop(121, day, tth).
prop(121, sTime, 9:30).
prop(121, eTime, 11:00).
prop(121, building, "Pharmaceutical Sciences Building").
prop(121, room, 1201).
prop(121, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 102).
prop(110, term, 1).
prop(121, instructor, "Frederick Shepherd").
prop(121, day, tth).
prop(121, sTime, 15:30).
prop(121, eTime, 17:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
prop(121, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 103).
prop(110, term, 1).
prop(121, instructor, "Cinda Heeren").
prop(121, day, tth).
prop(121, sTime, 17:00).
prop(121, eTime, 18:30).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
prop(121, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 201).
prop(110, term, 2).
prop(121, instructor, "Cinda Heeren").
prop(121, day, mwf).
prop(121, sTime, 9:00).
prop(121, eTime, 10:00).
prop(121, building, "West Mall Swing Space").
prop(121, room, 121).
prop(121, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 202).
prop(110, term, 2).
prop(121, instructor, "Patrice Belleville").
prop(121, day, mwf).
prop(121, sTime, 12:00).
prop(121, eTime, 13:00).
prop(121, building, "MacMillan").
prop(121, room, 166).
prop(121, prereq, none).

prop(121, course, 121).
prop(121, name, "Models of Computation").
prop(121, section, 203).
prop(110, term, 2).
prop(121, instructor, "Patrice Belleville").
prop(121, day, mwf).
prop(121, sTime, 16:00).
prop(121, eTime, 17:00).
prop(121, building, "Woodward").
prop(121, room, 6).
prop(121, prereq, none).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 101).
prop(110, term, 1).
prop(121, instructor, "Elisa Baniassad").
prop(121, day, mwf).
prop(121, sTime, 12:00).
prop(121, eTime, 13:00).
prop(121, building, "West Mall Swing Space").
prop(121, room, 122).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 102).
prop(110, term, 1).
prop(121, instructor, "Ali Madooei").
prop(121, day, mwf).
prop(121, sTime, 15:00).
prop(121, eTime, 16:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 103).
prop(110, term, 1).
prop(121, instructor, "Michael Feeley").
prop(121, day, mwf).
prop(121, sTime, 14:00).
prop(121, eTime, 15:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 201).
prop(110, term, 2).
prop(121, instructor, "Paul Martin Carter").
prop(121, day, mwf).
prop(121, sTime, 14:00).
prop(121, eTime, 15:00).
prop(121, building, "West Mall Swing Space").
prop(121, room, 121).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 202).
prop(110, term, 2).
prop(121, instructor, "Ali Madooei").
prop(121, day, mwf).
prop(121, sTime, 12:00).
prop(121, eTime, 13:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 210).
prop(121, name, "Software Construction").
prop(121, section, 203).
prop(110, term, 2).
prop(121, instructor, "Paul Martin Carter").
prop(121, day, mwf).
prop(121, sTime, 15:00).
prop(121, eTime, 16:00).
prop(121, building, "West Mall Swing Space").
prop(121, room, 222).
% There are three possible prereqs for 210, either 107, 110, or 260.
% Will use 110 as the prereq as a place holder.
prop(121, prereq, 110).

prop(121, course, 213).
prop(121, name, "Introduction to Computer Systems").
prop(121, section, 101).
prop(110, term, 1).
prop(121, instructor, "Jonatan Schroeder").
prop(121, day, tth).
prop(121, sTime, 14:00).
prop(121, eTime, 15:30).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are two prereqs for 213. Both 121 and 210
% Will use 121 as the prereq as a place holder.
prop(121, prereq, 121).

prop(121, course, 213).
prop(121, name, "Introduction to Computer Systems").
prop(121, section, 102).
prop(110, term, 1).
prop(121, instructor, "Jonatan Schroeder").
prop(121, day, mwf).
prop(121, sTime, 13:00).
prop(121, eTime, 14:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are two prereqs for 213. Both 121 and 210
% Will use 121 as the prereq as a place holder.
prop(121, prereq, 121).

prop(121, course, 213).
prop(121, name, "Introduction to Computer Systems").
prop(121, section, 203).
prop(110, term, 2).
prop(121, instructor, "Michael Feeley").
prop(121, day, mwf).
prop(121, sTime, 13:00).
prop(121, eTime, 14:00).
prop(121, building, "Hugh Dempster Pavilion").
prop(121, room, 310).
% There are two prereqs for 213. Both 121 and 210
% Will use 121 as the prereq as a place holder.
prop(121, prereq, 121).

