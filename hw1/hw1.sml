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
    0

fun number_in_months(dates: DATE list, months: int list): int =
    0
