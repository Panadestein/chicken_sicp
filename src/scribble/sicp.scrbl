#lang scribble/manual

@(require (for-label racket))

@title[#:version "" #:style '(toc)]{Solutions to the SICP exercises}
@author{Ramón L. Panadés Barrueta}

Welcome to my solutions to the exercises in Abelson and Sussmand’s
Structure and Interpretation of Computer Programs (@(hyperlink "https://sarabander.github.io/sicp/html/" "SICP")). All the exercises are solved using @(hyperlink "https://racket-lang.org/" "Racket") and the @racket[#, @hash-lang[]] @(hyperlink "https://docs.racket-lang.org/sicp-manual/index.html" "sicp") directive.

As a physicist by training, there may be some areas where my solutions could be improved. If you find any, please help me avoid embarrassment by submitting a 
@(hyperlink "https://github.com/Panadestein/solved_sicp" "pull request"). If you'd like to compare my solutions to those of others, you can visit the @(hyperlink "http://community.schemewiki.org/?SICP-Solutions" "Scheme wiki") and other resources linked there.

@table-of-contents[]

@include-section["chapter_1.scrbl"]
@include-section["chapter_2.scrbl"]
@include-section["chapter_3.scrbl"]
@include-section["chapter_4.scrbl"]
@include-section["chapter_5.scrbl"]
