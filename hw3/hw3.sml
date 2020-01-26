(* Assign 03 Provided Code *)

(*  Version 1.0 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

(* Description of g:

*)

fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end


(**** put all your code after this line ****)

fun only_capitals xs: string list =
	List.filter (fn str => Char.isUpper(String.sub(str,0))) xs


fun longest_string1 xs: string = 
	List.foldl (fn (str1, str2) => (if String.size(str1) > String.size(str2)
									then str1
									else str2)) "" xs


fun longest_string2 xs: string = 
	List.foldl (fn (str1, str2) => (if String.size(str1) >= String.size(str2)
									then str1
									else str2)) "" xs


fun longest_string_helper f xs =
	List.foldl (fn (str1, str2) => (if f(String.size(str1),String.size(str2))
									then str1
									else str2)) "" xs


fun longest_string3 xs: string = 
	longest_string_helper (fn (x,y) => x > y) xs


fun longest_string4 xs: string =
	longest_string_helper (fn (x,y) => x >= y) xs


fun longest_capitalized xs: string =
	(longest_string1 o only_capitals) xs


fun rev_string str: string = 
	(String.implode o List.rev o String.explode) str