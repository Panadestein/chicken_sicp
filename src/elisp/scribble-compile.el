;;; scribble-compile.el --- Compile and browse Scribble project   -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Dr. Ramón L. Panadés Barrueta

;; Author: Dr. Ramón L. Panadés Barrueta
;; Keywords: lisp, racket, scribble

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Eliminate the hassle of having to open a terminal and creating an httpd

;;; Code:

(defvar my/httpd-server-dir "path/to/build/"
  "Directory to serve with `httpd'.")

(defun my/scribble-compile-and-browse (&optional browse)
  "Compile and start the `httpd'.  If BROWSE open the system browser."
  (interactive "P")
  (shell-command "scribble --htmls ++xref-in setup/xref load-collections-xref --redirect-main 'https://docs.racket-lang.org/' --dest build/ sicp.scrbl")

  ;; If `httpd' is not running, start it.
  (unless (httpd-running-p)
    (setq httpd-root my/httpd-server-dir)
    (httpd-start))

  ;; If BROWSE open in external browser
  (if browse
    (browse-url "http://localhost:8080")))

(global-set-key (kbd "C-c r") 'my/scribble-compile-and-browse)

(provide 'scribble-compile)
;;; scribble-compile.el ends here
