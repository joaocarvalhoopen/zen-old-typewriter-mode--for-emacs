;;; zen-old-typewriter-mode.el ---  zen-old-typewriter mode for Doom Emacs and maybe Emacs  -*- lexical-binding: t; -*-

;; Author: João Carvalho
;; A reimplementation heavilly inspaired by selectric-mode for Emacs.
;; by Author: Ricardo Bánffy <rbanffy@gmail.com>
;; URL: https://github.com/rbanffy/selectric-mode
;; Keywords: multimedia, convenience, typewriter, zen-old-typewriter
;; Version: 1.0

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

;; This minor mode plays the sound of an Zen Old TypeWriter as
;; you type. It doesn't interfere with the other modes out of the insert Evil VIM mode.
;; It plays a sound for a normal key press, for a space key, for a backspace and for
;; the carriage return.
;; It doesn't use or mess with the key bindings, it does all with a non intrusive hook.

;;; Code:

(defconst zen-old-typewriter-files-path (file-name-directory load-file-name))

(defun zen-old-typewriter-make-sound (sound-file-name)
  "Play sound from file SOUND-FILE-NAME using platform-appropriate program."
  (if (eq system-type 'darwin)
      (start-process "*Messages*" nil "afplay" sound-file-name)
    (start-process "*Messages*" nil "aplay" sound-file-name)))

(defun zen-old-typewriter-type-sound ()
  "Play the sound of the typo hitting the papel and cilinder."
  (progn
    (zen-old-typewriter-make-sound (format "%skey_old_02.wav" zen-old-typewriter-files-path))
    (unless (minibufferp)
      (if (= (current-column) (current-fill-column))
            (zen-old-typewriter-make-sound (format "%sbell_02.wav" zen-old-typewriter-files-path))))))

(defun zen-old-typewriter-backspace-sound()
  "Play the sound of the backspace."
  (zen-old-typewriter-make-sound (format "%smove_back.wav" zen-old-typewriter-files-path)))

(defun zen-old-typewriter-carriage-return-sound()
  "Play the sound of the carriage return."
  (zen-old-typewriter-make-sound (format "%scarrige_return_01.wav" zen-old-typewriter-files-path)))

(defun zen-old-typewriter-space-key-sound ()
  "Play the sound of the space key."
  (zen-old-typewriter-make-sound (format "%sspace_key_02.wav" zen-old-typewriter-files-path)))


(defun my-post-command-function()
  (progn
     ; Print to the message buffer with the last command.
     ;(message "Current command: %s" this-command)

     (cond
        ;; RET key
        ((or (eq this-command 'newline)
             (eq this-command 'newline-and-indent)) 
         (zen-old-typewriter-carriage-return-sound))
         
        ;; Backspace key
        ((or (eq this-command 'delete-backward-char)
             (eq this-command 'evil-delete-backward-char-and-join))
         (zen-old-typewriter-backspace-sound))

        ;; Checking if it was a writable key
        ((eq this-command 'self-insert-command)
           (cond
           
              ;; Space key
              ((eq last-command-event ?\ )
                 (zen-old-typewriter-space-key-sound))

              ;; Other writable keys
              (t
                 (zen-old-typewriter-type-sound))))
     )
  )   
)



;;;###autoload
(define-minor-mode zen-old-typewriter-mode
  "Toggle zen-old-typewriter mode.
Interactively with no argument, this command toggles the mode.  A
positive prefix argument enables the mode, any other prefix
argument disables it.  From Lisp, argument omitted or nil enables
the mode, `toggle' toggles the state.

When zen-old-typewriter mode is enabled, your Emacs will sound like an IBM
zen-old-typewriter typewriter."
  :global t
  ;; The initial value.
  :init-value nil
  ;; The indicator for the mode line.
  :lighter " zen-old-typewriter"
  :group 'zen-old-typewriter
  ; :keymap zen-old-typewriter-mode-map

  (if zen-old-typewriter-mode
       
     ;; Quando entra no modo adiciona o hook para o processamento do post-command-hook .
     (add-hook 'post-command-hook 'my-post-command-function nil t)
     
     ; ELSE    
     ; Quando sai do modulo retira o processamento do hook post-command-hook .
     (remove-hook 'post-command-hook 'my-post-command-function t)
   ) 
)

(provide 'zen-old-typewriter-mode)
;;; zen-old-typewriter-mode.el ends here


