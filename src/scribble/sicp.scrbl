#lang scribble/manual

@(require (for-label racket))
@(require "utils.rkt")

@;{Inject some JavaScript for GA}

@(inject-javascript-src "https://www.googletagmanager.com/gtag/js?id=G-HTGX3RGPVL")
@inject-javascript-inline|{
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-HTGX3RGPVL');
  }|

@;{Begin document}

@title[#:version "" #:style '(toc)]{SICP solutions}
@author{Ramón L. Panadés Barrueta}

Welcome to my solutions to the exercises in Abelson and Sussmand’s
Structure and Interpretation of Computer Programs (@(hyperlink "https://sarabander.github.io/sicp/html/" "SICP")).
As the design of this website suggests, I have used @(hyperlink "https://racket-lang.org/" "Racket") for the task,
with the languages @racket[#, @hash-lang[]] @(hyperlink "https://docs.racket-lang.org/sicp-manual/index.html" "sicp"),
@racket[#, @hash-lang[] #, @racketmodname[racket]], and @racket[#, @hash-lang[]#, @racketmodname[lazy]].

I am a physicist by training, so there may be some areas where my solutions could be improved.
If you find any, please help me avoid embarrassment by submitting a 
@(hyperlink "https://github.com/Panadestein/solved_sicp" "pull request"). If you'd like to compare my solutions
to those of others, you can visit the @(hyperlink "http://community.schemewiki.org/?SICP-Solutions" "Scheme wiki")
and other resources linked there.

@table-of-contents[]

@include-section["chapter_1.scrbl"]
@include-section["chapter_2.scrbl"]
@include-section["chapter_3.scrbl"]
@include-section["chapter_4.scrbl"]
@include-section["chapter_5.scrbl"]
