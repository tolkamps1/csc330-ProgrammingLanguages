(*  Assignment #1 *)

type DATE = (int * int * int)
exception InvalidParameter

(* This file is where your solutions go *)

fun is_older(d1: DATE, d2: DATE): bool =
    if #1 d1 < #1 d2
    then true
    else if #1 d1 = #1 d2 andalso #2 d1 < #2 d2
    then true
    else if #1 d1 = #1 d2 andalso #2 d1 = #2 d2 andalso #3 d1 < #3 d2
    then true
    else false
   

fun number_in_month(dates: DATE list, month: int): int =
    if null dates
    then 0
    else if #2 (hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else 0 + number_in_month(tl dates, month)
      

fun number_in_months(dates: DATE list, months: int list): int =
    if null months
    then 0
    else number_in_month(dates, hd months)+number_in_months(dates, tl months)


fun dates_in_month(dates: DATE list, month: int): DATE list =
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)


fun dates_in_months(dates: DATE list, months: int list): DATE list =
    if null months
    then []
    else dates_in_month(dates,hd months) @ dates_in_months(dates, tl months)


fun get_nth(strings: string list, n: int): string =
    if n < 1
    then raise InvalidParameter
    else if null strings
    then raise InvalidParameter
    else if n = 1
    then hd strings
    else get_nth(tl strings, n - 1)


fun date_to_string(date: DATE): string =
    let
      val months: string list = ["January", "February", "March", "April", "May", "June", 
        "July", "August", "September", "October", "November", "December"]
    in
      get_nth(months, #2 date)^" "^Int.toString(#3 date)^", "^Int.toString(#1 date)
    end


fun number_before_reaching_sum(sum: int, ilist: int list): int =
    if sum <= 0
    then ~1
    else 1 + number_before_reaching_sum(sum-(hd ilist), tl ilist)


fun what_month(day1: int): int =
    let
      val int_months: int list = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
      number_before_reaching_sum(day1, int_months)+1
    end


fun month_range(day1:int, day2:int): int list =
    if day2 < day1
    then []
    else what_month(day1) :: (month_range(day1+1, day2))


fun oldest(dates: DATE list): DATE option =
    if null dates
    then NONE
    else
        let
          fun max_non_empty(dates: DATE list): DATE =
            if null (tl dates)
            then hd dates
            else
              let
                val tl_ans = max_non_empty(tl dates)
              in
                if is_older(hd dates, tl_ans)
                then hd dates
                else tl_ans
              end
        in
          SOME (max_non_empty(dates))
        end


fun reasonable_date(date: DATE): bool =
    if #1 date <= 0
    then false
    else if #2 date <=0
    then false
    else if #2 date > 12
    then false
    else if #3 date <= 0
    then false
    else if #3 date > 31
    then false
    else
        let
          fun leap_year(year: int): bool =
              if year mod 400 = 0
              then true
              else if year mod 4=0 andalso year mod 100 <> 0
              then true
              else false
          fun days_in_month(month: int, mlist: int list): int =
              if month <= 1
              then hd mlist
              else days_in_month(month-1, tl mlist)
        in
          if leap_year(#1 date)
          then
            let
              val lp_month_days = [31,29,31,30,31,30,31,31,30,31,30,31]
            in
              if #3 date <= days_in_month(#2 date,lp_month_days)
              then true
              else false
            end
          else
            let
              val month_days = [31,28,31,30,31,30,31,31,30,31,30,31]
            in
              if #3 date <= days_in_month(#2 date,month_days)
              then true
              else false
            end
        end
    