(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(************************************************************************)
(* Coq serialization API/Plugin                                         *)
(* Copyright 2016 MINES ParisTech                                       *)
(************************************************************************)
(* Status: Very Experimental                                            *)
(************************************************************************)

open Sexplib.Std
open Ppx_hash_lib.Std.Hash.Builtin
open Ppx_compare_lib.Builtin

module Names     = Ser_names
module Uint63    = Ser_uint63
module Float64   = Ser_float64
module Sorts     = Ser_sorts
module Constr    = Ser_constr
module Evar      = Ser_evar
module EConstr   = Ser_eConstr
module Glob_term = Ser_glob_term

type patvar =
  [%import: Pattern.patvar]
  [@@deriving sexp,yojson,hash,compare]

type case_info_pattern =
  [%import: Pattern.case_info_pattern]
  [@@deriving sexp,yojson,hash,compare]

let hash_fold_array = hash_fold_array_frozen

(** Can't properly serialize this GADT
    Currently we only expose the derives for constr_pattern so can't occur anyway.
*)
module UninstS = struct
  type 'a t = 'a Pattern.uninstantiated_pattern
  let name = "uninstantiated_pattern"
end
module Uninst = SerType.Opaque1(UninstS)

type 'a uninstantiated_pattern = 'a Uninst.t
  [@@deriving sexp,yojson,hash,compare]

type 'a constr_pattern_r =
  [%import: 'a Pattern.constr_pattern_r]
  [@@deriving sexp,yojson,hash,compare]

type constr_pattern =
  [%import: Pattern.constr_pattern]
  [@@deriving sexp,yojson,hash,compare]
