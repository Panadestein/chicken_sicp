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

@image["../../img/my_sicp_logo.png" #:scale 0.1]

Welcome to my personal collection of solutions for the exercises in Abelson and Sussmand’s iconic
Structure and Interpretation of Computer Programs (@(hyperlink "https://sarabander.github.io/sicp/html/" "SICP")).
As evidenced by the design of this website, my chosen instrument to tackle these problems is @(hyperlink "https://racket-lang.org/" "Racket"),
with the languages @racket[#, @hash-lang[]] @(hyperlink "https://docs.racket-lang.org/sicp-manual/index.html" "sicp"),
@racket[#, @hash-lang[] #, @racketmodname[racket]], and @racket[#, @hash-lang[]#, @racketmodname[lazy]].

My academic background is in physics, so it's entirely plausible there exist areas where my solutions could benefit
from refinement. Should you stumble upon any such opportunities, I'd appreciate you sparing me the blunder by submitting a
@(hyperlink "https://github.com/Panadestein/solved_sicp" "pull request"). For those interested in contrasting my solutions
with others, you're welcome to visit the @(hyperlink "http://community.schemewiki.org/?SICP-Solutions" "Scheme wiki")
and other resources linked there.

@table-of-contents[]

@include-section["chapter_1.scrbl"]
@include-section["chapter_2.scrbl"]
@include-section["chapter_3.scrbl"]
@include-section["chapter_4.scrbl"]
@include-section["chapter_5.scrbl"]
