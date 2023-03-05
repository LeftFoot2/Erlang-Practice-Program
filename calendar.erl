% Both module and export are very important in the Erlang language.

-module(calendar).

-export([calendar_stuff/0, guards/0, list_stuff/0]).

% This is the program that allows the user to input a date and get the day of the week from that date.

calendar_stuff() ->

    intro(),
    get_date().

    % Simply introduces the program.

    intro()->

        io:format("In this program you will enter a date and it will return the day of week that was in that year.\n").
   
    
    get_date() ->

        % Gets the users input.
        Year = io:get_line("Enter year (1800 and after) (yyyy): "),
        Day = io:get_line("Enter day (dd): "),
        Month = io:get_line("Enter month (mm): "),
        
        % Changes the string to and integer.
        {Year_int, _} = string:to_integer(Year),
        {Day_int, _} = string:to_integer(Day),
        {Month_int, _} = string:to_integer(Month),
        Starting_year = 1800,
        X_ = 0,

        % Some functions are called to get the information.
        Your_leap = your_year_leap(Year_int),
        Your_days = your_year_days(Your_leap, Day_int, Month_int),
        Bonus_days = bonus_days(Year_int, Starting_year, X_),
        total_days(Bonus_days, Your_days).

    % Figures out the leap year for the year that was chosen by the user.
    your_year_leap(Year_int) ->
        Extra_day = leap_year(Year_int),
        Extra_day.

    % Figures out the number of days from the date given.
    your_year_days(Your_leap, Day_int, Month_int) ->
        if Month_int == 1 -> Day_int
        ;Month_int == 2 -> 31 + Day_int
        ;Month_int == 3 -> 59 + Day_int + Your_leap
        ;Month_int == 4 -> 90 + Day_int + Your_leap
        ;Month_int == 5 -> 120 + Day_int + Your_leap
        ;Month_int == 6 -> 151 + Day_int + Your_leap
        ;Month_int == 7 -> 181 + Day_int + Your_leap
        ;Month_int == 8 -> 212 + Day_int + Your_leap
        ;Month_int == 9 -> 243 + Day_int + Your_leap
        ;Month_int == 10 -> 273 + Day_int + Your_leap
        ;Month_int == 11 -> 304 + Day_int + Your_leap
        ;Month_int == 12 -> 334 + Day_int + Your_leap
        end.

    % Gets the number of days from 1800 too the date given.
    bonus_days(Year_int, Starting_year, X_) ->
        Bonus_years = leap_year(Starting_year),
        X_x = X_ + Bonus_years,

        Year_mult = Starting_year - 1800,

        Num_year = Starting_year + 1,  

        if Year_int /= Starting_year -> bonus_days(Year_int, Num_year, X_x)
        ;Year_int == Starting_year -> ((Year_mult * 365) + X_x)
        end.
        

    % Determines if a year is a leap year.
    leap_year(Year_int) -> 
        if Year_int rem 4 /= 0 -> 0
        ;Year_int rem 400 == 0 -> 1
        ;Year_int rem 4 == 0, Year_int rem 100 /= 0 -> 1
        ;Year_int rem 100 == 0 -> 0
        end.
    
    % Gets the total days and gets the day of the week.
    total_days(Bonus_days, Your_days) -> 
        
        All_the_days = (Bonus_days + Your_days),

        Day_of_week = All_the_days rem 7,

        if Day_of_week == 0 -> io:format("This day was Tuesday.\n")
        ;Day_of_week == 1 -> io:format("This day was Wednesday.\n")
        ;Day_of_week == 2 -> io:format("This day was Thursday.\n")
        ;Day_of_week == 3 -> io:format("This day was Friday.\n")
        ;Day_of_week == 4 -> io:format("This day was Saturday.\n")
        ;Day_of_week == 5 -> io:format("This day was Sunday.\n")
        ;Day_of_week == 6 -> io:format("This day was Monday.\n")
        end.



% Uses guards to determine if the function should run.
guards() ->
    
    is_1(1),
    is_2(2),
    is_3(2).


    is_1(1) when 1 == 1 ->
        io:format("The number is one.\n").

    is_2(2) when 2 == 2 ->
        io:format("The number is two.\n").

    is_3(2) when (2 < 3) ->
        io:format("The number is less then three.\n").




% Work with lists and the fun function to produce different results.
list_stuff() ->
    list_work().

map_some(A) -> A + 2.
filter_some(F) -> F > 6.


    list_work() ->
        Short_list = [1,2],
        Bigger_list = [3,4,5,6,7,8,9],
        Random_list = [5,6,8,1,5],
        lists:map(fun map_some/1, Short_list),
        lists:filter(fun filter_some/1, Bigger_list),
        lists:foldl(fun(L, Sum) -> L + Sum end, 0, Random_list).

