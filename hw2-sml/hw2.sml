(* if you use this function to compare two strings (returns true if the same
   string), then you avoid some warning regarding polymorphic comparison  *)

fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(s: string, slist: string list): string list option =
    case slist of 
        x::xs' => if same_string(s, x)
                  then SOME xs'
                  else 
                    let
                      val result: string list option = all_except_option(s, xs')
                    in
                      if result <> NONE
                      then SOME (x::valOf(result))
                      else NONE
                    end
      | [] => NONE
   

fun get_substitutions1(sllist: string list list, s: string): string list =
    case sllist of
        [] => []
      | x::slist' => let
                         val result: string list option = all_except_option(s, x)
                     in
                         if result <> NONE
                         then valOf(result) @ get_substitutions1(slist',s)
                         else get_substitutions1(slist',s)
                    end


fun get_substitutions2(sllist: string list list, s: string): string list =
    let
       fun aux(xs, acc) =
          case xs of
              [] => acc
            | x::xs' => let
                              val result: string list option = all_except_option(s, x)
                            in
                                if result <> NONE
                                then aux(xs',acc @ valOf(result))
                                else aux(xs',acc)
                            end
    in
        aux(sllist,[])
    end


fun similar_names(slist:string list list, {first:string, middle:string, last:string}): {first:string, last:string, middle:string} list =
    let
        val subs: string list = get_substitutions1(slist,first)
        fun const_names(subs: string list): {first:string, last:string, middle:string} list =
            case subs of
                [] => []
              | sub::subs' => {first=sub, last=last, middle=middle} :: const_names(subs')
    in
        const_names(first::subs)
    end



(************************************************************************)
(* Game  *)

(* you may assume that Num is always used with valid values 2, 3, ..., 10 *)

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw


exception IllegalMove

(* put your solutions for Part 2 here *)
fun card_color(card: card): color =
    case card of
        (suit,rank) => if suit = Clubs orelse suit = Spades
                        then Black
                        else Red


fun card_value(card:card): int =
    case card of
        (s,r) => if r = Ace
                 then 11
                 else if r = Jack orelse r = Queen orelse r = King
                 then 10
                 else 
                   let
                     fun value(r, num:int):int =
                        if r = Num(num) then num
                        else value(r, num-1)
                    in
                      value(r, 10)
                    end
                

fun remove_card(cs: card list, c:card, e:exn): card list =
    case cs of
        [] => raise e
      | s::cs' => if s = c
                 then cs'
                 else s::remove_card(cs', c, e)


fun all_same_color(cs: card list): bool =
    case cs of
        [] => true
      | c::[] => true
      | c::d::cs' => if card_color(c) = card_color(d)
                     then all_same_color(d::cs')
                     else false
