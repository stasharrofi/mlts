module run.
% This is the harness for testing and examples.

accumulate spy, control, lists.
accumulate eval.
accumulate typing.
%accumulate datatypes.
accumulate progs_gen.


%testall :- (test N V, term_to_string N Str, print "Value for ", print Str, print ": ",
%                      term_to_string V Vstr, print Vstr, print "\n", fail);
%           (prog Name Prog, print "Type of ", print Name, print " is: ", typeof Prog Type,
%	                    term_to_string Type Tscr, print Tscr, print "\n", fail).
%testall.

all P L :-
    all_aux P [] L.

all_aux P Acc L :-
    (P N, not (member N Acc), !),
    all_aux P (N::Acc) L.

all_aux _ L L.

run S :- print "running", prog Name Prog, eval Prog V,
	    term_to_string Name Str,
            term_to_string V S',
	    S is (Name ^" > " ^ S').



run_all L :- all (run) L.
