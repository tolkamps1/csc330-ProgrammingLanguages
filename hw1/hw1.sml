(*  Assignment #1 *)

type DATE = (int * int * int)
exception InvalidParameter

(* This file is where your solutions go *)

fun is_older(d1: DATE, d2: DATE): bool =
    if #1 d1 > #1 d2
    then false
    else if #2 d1 > #2 d2 
    then false
    else if #1 d1 >= #1 d2
    then false
    else true
   

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
    ""


fun number_before_reaching_sum(sum: int, ilist: int list): int =
    0

fun what_month(day1: int, day2:int): int =
    0

fun month_range(day1:int, day2:int): int list =
    [0]
