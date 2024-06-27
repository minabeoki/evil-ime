;;; evil-ime.el --- Change the IME state depends on evil mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Oki Minabe

;; Author: Oki Minabe <minabe.oki@gmail.com>
;; Keywords: i18n, input method

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

;;; Code:

(defgroup evil-ime nil
  "Change the IME state depends on evil mode."
  :group 'evil
  :prefix "evil-ime-")

(defcustom evil-ime-ascii-mode "com.apple.keylayout.ABC"
  "The IME mode name when IME is disabled."
  :group 'evil-ime
  :type 'string)

(defvar evil-ime--last-buffer nil)

(defvar-local evil-ime--saved-ime-state nil)

(defun evil-ime--get-mode ()
  "Get the current IME mode."
  (when (fboundp 'mac-input-source)
    (mac-input-source)))

(defun evil-ime--set-mode (mode)
  "Set the IME mode."
  (when (fboundp 'mac-select-input-source)
    (if mode
        (mac-select-input-source mode))))

(defun evil-ime--ascii-mode ()
  "Select ASCII mode."
  (when (fboundp 'mac-select-input-source)
    (mac-select-input-source evil-ime-ascii-mode)))

;;;###autoload
(defun evil-ime-save-ime-state ()
  "Save the current IME mode and select ASCII mode."
  (setq evil-ime--saved-ime-state (evil-ime--get-mode))
  (evil-ime--ascii-mode))

;;;###autoload
(defun evil-ime-restore-ime-state ()
  "Restore the IME mode."
  (evil-ime--set-mode evil-ime--saved-ime-state))

;;;###autoload
(defun evil-ime-adjust-ime-state ()
  "Select the IME mode depends on current evil-mode."
  (unless (eq evil-ime--last-buffer (current-buffer))
    (setq evil-ime--last-buffer (current-buffer))
    (if (memq evil-state '(insert emacs))
        (evil-ime-restore-ime-state)
      (evil-ime--ascii-mode))))

;;;###autoload
(defun evil-ime-change-ime-state ()
  "Save the IME mode when the IME mode is changed."
  (if (memq evil-state '(insert emacs))
      (setq evil-ime--saved-ime-state (evil-ime--get-mode))))

(with-eval-after-load 'evil
  (add-hook 'evil-insert-state-exit-hook #'evil-ime-save-ime-state)
  (add-hook 'evil-insert-state-entry-hook #'evil-ime-restore-ime-state)
  ;(add-hook 'buffer-list-update-hook #'evil-ime-adjust-ime-state)
  ;(add-hook 'window-configuration-change-hook #'evil-ime-adjust-ime-state)
  (add-hook 'mac-selected-keyboard-input-source-change-hook
            #'evil-ime-change-ime-state))

(provide 'evil-ime)
;;; evil-ime.el ends here
