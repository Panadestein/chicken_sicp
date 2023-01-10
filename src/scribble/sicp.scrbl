#lang scribble/manual

@(require (for-label racket))

@title[#:version "" #:style '(toc)]{Solutions to the SICP exercises}
@author{Ramón L. Panadés Barrueta}

The following solutions to the @(hyperlink "https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html" "SICP") problems were tested using @(hyperlink "https://racket-lang.org/" "Racket") and the @racket[#, @hash-lang[] #,
@racketmodname[scribble/base]] directive. Since at the moment of writing these lines I consider myself a novice schemer, I cannot ensure that my solutions are optimal. If you want to compare with other people's work, feel free to visit the Scheme @(hyperlink "http://community.schemewiki.org/?SICP-Solutions" "wiki"), and the references therein.

@local-table-of-contents[]

@include-section["chapter_1.scrbl"]
@include-section["chapter_2.scrbl"]
@include-section["chapter_3.scrbl"]
@include-section["chapter_4.scrbl"]
@include-section["chapter_5.scrbl"]
