(* ****** ****** *)
(*
** HX-2018-01:
** Hangman:
** a word-guessing game
*)
(* ****** ****** *)
//
abst@ype state
abst@ype input
//
(* ****** ****** *)

datatype
status =
| STATUSsolved of ()
| STATUStimeup of ()
| STATUSasking of ()

(* ****** ****** *)
//
extern
fun
state_check
(&state): status

extern
fun
state_update
(&state >> _, input): int

extern
fun
state_initize
( state: &state? >> _
, ntime: int, word0: string): int

(* ****** ****** *)
//
extern
fun
GameLoop
(&state >> _, stream_vt(input)): int
and
GameLoop_solved
(&state >> _, stream_vt(input)): int
and
GameLoop_timeup
(&state >> _, stream_vt(input)): int
and
GameLoop_asking
(&state >> _, stream_vt(input)): int
//
(* ****** ****** *)

implement
GameLoop
(state, xs) = let
//
val
status = state_check(state)
//
in
  case+ status of
  | STATUSsolved() => GameLoop_solved(state, xs)
  | STATUStimeup() => GameLoop_timeup(state, xs)
  | STATUSasking() => GameLoop_asking(state, xs)
end // end of [GameLoop]

(* ****** ****** *)

#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"

(* ****** ****** *)

local

assume
state = @{
  ntime= int
,
  word0= string
,
  guess= list0(char)
}

assume input = char

fun
is_guessed
( c0: char
, guess: list0(char)
) : bool =
(guess).exists()(lam(c1) => c0=c1)
fun
is_contained
( c0: char
, word0: string
) : bool =
(word0).exists()(lam(c1) => c0=c1)

fun
is_solved
( w0: string
, guess: list0(char)
) : bool =
(w0).forall()
(lam(c0) => is_guessed(c0, guess))


fun
word_display
( word0: string
, guess: list0(char)
) : void =
(
(word0).foreach()
(lam(c0) =>
 print_char
 (if is_guessed(c0, guess) then c0 else '_')
)
) (* end of [word_display] *)

in (* in-of-local *)

implement
state_check
  (state) = let
//
val word0 = state.word0
val guess = state.guess
//
in
//
(
ifcase
| is_solved
  (word0, guess) => STATUSsolved()
| state.ntime = 0 => STATUStimeup()
| _ (*otherwise*) => STATUSasking()
)
//
end // end of [state_check]

implement
state_update
(state, input) = let
//
val c0 = input
val nt = state.ntime
val w0 = state.word0
val cs = state.guess
//
in
//
ifcase
| is_guessed
    (c0, cs) => (0)
| is_contained
    (c0, w0) =>
    (state.guess := list0_cons(c0, cs); 0)
| _ (* otherwise *) =>
    (state.ntime := nt-1;
     state.guess := list0_cons(c0, cs); 1)
//
end // end of [state_update]

implement
state_initize
( state
, ntime, word0) = (0) where
{
//
val () = (state.ntime := ntime)
val () = (state.word0 := word0)
val () = (state.guess := list0_nil())
//
} // end of [state_initize]

implement
GameLoop_solved
  (state, xs) =
  state.ntime where
{
  val () = free(xs)
  val () = println! ("You solved it: ", state.word0)
}

implement
GameLoop_timeup
  (state, xs) =
  state.ntime where
{
  val () = free(xs)
  val () = println! ("Sorry, you have no more chances.")
}

implement
GameLoop_asking
  (state, xs) = let
//
val () =
println!
("Chances: ", state.ntime)
val () =
println!
("Guessed: ", state.guess)
val () =
word_display
(state.word0, state.guess)
//
val () = println!((*void*))
//
in
//
case+ !xs of
| ~stream_vt_nil() => (~1) where
  {
    val () =
    println!
    ("ERROR: no input from the player!!!")
  }
| ~stream_vt_cons(x0, xs) =>
  let
    val err =
    state_update(state, x0) in GameLoop(state, xs)
  end
//
end // end of [GameLoop_asking]

end // end of [local]

(* ****** ****** *)

implement
main0() = () where
{
//
val nt = 6
val w0 = "camouflage"
//
val () = println!("Start!")
//
var
state: state
val err =
state_initize(state, nt, w0)
//
val lines =
streamize_fileref_line(stdin_ref)
val chars = auxmain(lines) where
{
//
fun
auxmain
(
xs:
stream_vt(string)
) : stream_vt(char) = $ldelay
(
(
case+ !xs of
| ~stream_vt_nil() =>
   stream_vt_nil()
| ~stream_vt_cons(x0, xs) => let
    val x0 = g1ofg0(x0)
  in
    if
    iseqz(x0)
    then !(auxmain(xs))
    else stream_vt_cons(x0[0], auxmain(xs)) 
  end // end of [stream_vt_cons]
)
, (lazy_vt_free(xs))
)
}
//
val ntime =
GameLoop(state, chars) where { reassume input }
//
val ((*void*)) = println! ("Game Over: ", ntime)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Hangman.dats] *)
