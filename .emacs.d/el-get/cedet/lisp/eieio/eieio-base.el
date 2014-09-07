;;; eieio-base.el --- Base classes for EIEIO.

;;; Copyright (C) 2000-2002, 2004-2005, 2007-2013 Free Software
;;; Foundation, Inc.

;; Author: Eric M. Ludlam  <zappo@gnu.org>
;; Keywords: OO, lisp
;; Package: eieio

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Base classes for EIEIO.  These classes perform some basic tasks
;; but are generally useless on their own.  To use any of these classes,
;; inherit from one or more of them.

;;; Code:

(require 'eieio)
(eval-when-compile (require 'cl))       ;FIXME: Use cl-lib!

;;; eieio-instance-inheritor
;;
;; Enable instance inheritance via the `clone' method.
;; Works by using the `slot-unbound' method which usually throws an
;; error if a slot is unbound.
(defclass eieio-instance-inheritor ()
  ((parent-instance :initarg :parent-instance
		    :type eieio-instance-inheritor-child
		    :documentation
		    "The parent of this instance.
If a slot of this class is referenced, and is unbound, then the parent
is checked for a value.")
   )
  "This special class can enable instance inheritance.
Use `clone' to make a new object that does instance inheritance from
a parent instance.  When a slot in the child is referenced, and has
not been set, use values from the parent."
  :abstract t)

(defmethod slot-unbound ((object eieio-instance-inheritor) class slot-name fn)
  "If a slot OBJECT in this CLASS is unbound, try to inherit, or throw a signal.
SLOT-NAME is the offending slot.  FN is the function signaling the error."
  (if (slot-boundp object 'parent-instance)
      ;; It may not look like it, but this line recurses back into this
      ;; method if the parent instance's slot is unbound.
      (eieio-oref (oref object parent-instance) slot-name)
    ;; Throw the regular signal.
    (call-next-method)))

(defmethod clone ((obj eieio-instance-inheritor) &rest params)
  "Clone OBJ, initializing `:parent' to OBJ.
All slots are unbound, except those initialized with PARAMS."
  (let ((nobj (make-vector (length obj) eieio-unbound))
	(nm (eieio--object-name obj))
	(passname (and params (stringp (car params))))
	(num 1))
    (aset nobj 0 'object)
    (setf (eieio--object-class nobj) (eieio--object-class obj))
    ;; The following was copied from the default clone.
    (if (not passname)
	(save-match-data
	  (if (string-match "-\\([0-9]+\\)" nm)
	      (setq num (1+ (string-to-number (match-string 1 nm)))
		    nm (substring nm 0 (match-beginning 0))))
	  (setf (eieio--object-name nobj) (concat nm "-" (int-to-string num))))
      (setf (eieio--object-name nobj) (car params)))
    ;; Now initialize from params.
    (if params (shared-initialize nobj (if passname (cdr params) params)))
    (oset nobj parent-instance obj)
    nobj))

(defmethod eieio-instance-inheritor-slot-boundp ((object eieio-instance-inheritor)
						slot)
  "Return non-nil if the instance inheritor OBJECT's SLOT is bound.
See `slot-boundp' for details on binding slots.
The instance inheritor uses unbound slots as a way of cascading cloned
slot values, so testing for a slot being bound requires extra steps
for this kind of object."
  (if (slot-boundp object slot)
      ;; If it is regularly bound, return t.
      t
    (if (slot-boundp object 'parent-instance)
	(eieio-instance-inheritor-slot-boundp (oref object parent-instance)
					      slot)
      nil)))


;;; eieio-instance-tracker
;;
;; Track all created instances of this class.
;; The class must initialize the `tracking-symbol' slot, and that
;; symbol is then used to contain these objects.
(defclass eieio-instance-tracker ()
  ((tracking-symbol :type symbol
		    :allocation :class
		    :documentation
		    "The symbol used to maintain a list of our instances.
The instance list is treated as a variable, with new instances added to it.")
   )
  "This special class enables instance tracking.
Inheritors from this class must overload `tracking-symbol' which is
a variable symbol used to store a list of all instances."
  :abstract t)

(defmethod initialize-instance :AFTER ((this eieio-instance-tracker)
				       &rest slots)
  "Make sure THIS is in our master list of this class.
Optional argument SLOTS are the initialization arguments."
  ;; Theoretically, this is never called twice for a given instance.
  (let ((sym (oref this tracking-symbol)))
    (if (not (memq this (symbol-value sym)))
	(set sym (append (symbol-value sym) (list this))))))

(defmethod delete-instance ((this eieio-instance-tracker))
  "Remove THIS from the master list of this class."
  (set (oref this tracking-symbol)
       (delq this (symbol-value (oref this tracking-symbol)))))

;; In retrospect, this is a silly function.
(defun eieio-instance-tracker-find (key slot list-symbol)
  "Find KEY as an element of SLOT in the objects in LIST-SYMBOL.
Returns the first match."
  (object-assoc key slot (symbol-value list-symbol)))

;;; eieio-singleton
;;
;; The singleton Design Pattern specifies that there is but one object
;; of a given class ever created.  The EIEIO singleton base class defines
;; a CLASS allocated slot which contains the instance used.  All calls to
;; `make-instance' will either create a new instance and store it in this
;; slot, or it will just return what is there.
(defclass eieio-singleton ()
  ((singleton :type eieio-singleton
	      :allocation :class
	      :documentation
	      "The only instance of this class that will be instantiated.
Multiple calls to `make-instance' will return this object."))
  "This special class causes subclasses to be singletons.
A singleton is a class which will only ever have one instance."
  :abstract t)

(defmethod constructor :STATIC ((class eieio-singleton) name &rest slots)
  "Constructor for singleton CLASS.
NAME and SLOTS initialize the new object.
This constructor guarantees that no matter how many you request,
only one object ever exists."
  ;; NOTE TO SELF: In next version, make `slot-boundp' support classes
  ;; with class allocated slots or default values.
  (let ((old (oref-default class singleton)))
    (if (eq old eieio-unbound)
	(oset-default class singleton (call-next-method))
      old)))


;;; eieio-persistent
;;
;; For objects which must save themselves to disk.  Provides an
;; `object-write' method to save an object to disk, and a
;; `eieio-persistent-read' function to call to read an object
;; from disk.
;;
;; Also provide the method `eieio-persistent-path-relative' to
;; calculate path names relative to a given instance.  This will
;; make the saved object location independent by converting all file
;; references to be relative to the directory the object is saved to.
;; You must call `eieio-persistent-path-relative' on each file name
;; saved in your object.
(defclass eieio-persistent ()
  ((file :initarg :file
	 :type string
	 :documentation
	 "The save file for this persistent object.
This must be a string, and must be specified when the new object is
instantiated.")
   (extension :type string
	      :allocation :class
	      :initform ".eieio"
	      :documentation
	      "Extension of files saved by this object.
Enables auto-choosing nice file names based on name.")
   (file-header-line :type string
		     :allocation :class
		     :initform ";; EIEIO PERSISTENT OBJECT"
		     :documentation
		     "Header line for the save file.
This is used with the `object-write' method.")
   (do-backups :type boolean
	       :allocation :class
	       :initform t
	       :documentation
	       "Saving this object should make backup files.
Setting to nil will mean no backups are made."))
  "This special class enables persistence through save files
Use the `object-save' method to write this object to disk.  The save
format is Emacs Lisp code which calls the constructor for the saved
object.  For this reason, only slots which do not have an `:initarg'
specified will not be saved."
  :abstract t)

(defmethod eieio-persistent-save-interactive ((this eieio-persistent) prompt
					      &optional name)
  "Prepare to save THIS.  Use in an `interactive' statement.
Query user for file name with PROMPT if THIS does not yet specify
a file.  Optional argument NAME specifies a default file name."
  (unless (slot-boundp this 'file)
      (oset this file
	    (read-file-name prompt nil
			    (if   name
				(concat name (oref this extension))
			      ))))
  (oref this file))

(defun eieio-persistent-read (filename &optional class allow-subclass)
  "Read a persistent object from FILENAME, and return it.
Signal an error if the object in FILENAME is not a constructor
for CLASS.  Optional ALLOW-SUBCLASS says that it is ok for
`eieio-persistent-read' to load in subclasses of class instead of
being pedantic."
  (unless class
    (message "Unsafe call to `eieio-persistent-read'."))
  (when class (eieio--check-type class-p class))
  (let ((ret nil)
	(buffstr nil))
    (unwind-protect
	(progn
	  (with-current-buffer (get-buffer-create " *tmp eieio read*")
	    (insert-file-contents filename nil nil nil t)
	    (goto-char (point-min))
	    (setq buffstr (buffer-string)))
	  ;; Do the read in the buffer the read was initialized from
	  ;; so that any initialize-instance calls that depend on
	  ;; the current buffer will work.
	  (setq ret (read buffstr))
	  (when (not (child-of-class-p (car ret) 'eieio-persistent))
	    (error "Corrupt object on disk: Unknown saved object"))
	  (when (and class
		     (not (or (eq (car ret) class ) ; same class
			      (and allow-subclass
				   (child-of-class-p (car ret) class)) ; subclasses
			      )))
	    (error "Corrupt object on disk: Invalid saved class"))
	  (setq ret (eieio-persistent-convert-list-to-object ret))
	  (oset ret file filename))
      (kill-buffer " *tmp eieio read*"))
    ret))

(defun eieio-persistent-convert-list-to-object (inputlist)
  "Convert the INPUTLIST, representing object creation to an object.
While it is possible to just `eval' the INPUTLIST, this code instead
validates the existing list, and explicitly creates objects instead of
calling eval.  This avoids the possibility of accidentally running
malicious code.

Note: This function recurses when a slot of :type of some object is
identified, and needing more object creation."
  (let ((objclass (nth 0 inputlist))
	(objname (nth 1 inputlist))
	(slots (nthcdr 2 inputlist))
	(createslots nil))

    ;; If OBJCLASS is an eieio autoload object, then we need to load it.
    (eieio-class-un-autoload objclass)

    (while slots
      (let ((name (car slots))
	    (value (car (cdr slots))))

	;; Make sure that the value proposed for SLOT is valid.
	;; In addition, strip out quotes, list functions, and update
	;; object constructors as needed.
	(setq value (eieio-persistent-validate/fix-slot-value
		     objclass name value))

	(push name createslots)
	(push value createslots)
	)

      (setq slots (cdr (cdr slots))))

    (apply 'make-instance objclass objname (nreverse createslots))

    ;;(eval inputlist)
    ))

(defun eieio-persistent-validate/fix-slot-value (class slot proposed-value)
  "Validate that in CLASS, the SLOT with PROPOSED-VALUE is good, then fix.
A limited number of functions, such as quote, list, and valid object
constructor functions are considered valid.
Second, any text properties will be stripped from strings."
  (cond ((consp proposed-value)
	 ;; Lists with something in them need special treatment.
	 (let ((slot-idx (eieio-slot-name-index class nil slot))
	       (type nil)
	       (classtype nil))
	   (setq slot-idx (- slot-idx 3))
	   (setq type (aref (eieio--class-public-type (class-v class))
			    slot-idx))

	   (setq classtype (eieio-persistent-slot-type-is-class-p
			    type))

	   (cond ((eq (car proposed-value) 'quote)
		  (car (cdr proposed-value)))

		 ;; An empty list sometimes shows up as (list), which is dumb, but
		 ;; we need to support it for backward compat.
		 ((and (eq (car proposed-value) 'list)
		       (= (length proposed-value) 1))
		  nil)

		  ;; We have a slot with a single object that can be
		  ;; saved here.  Recurse and evaluate that
		  ;; sub-object.
		 ((and classtype (class-p classtype)
		       (child-of-class-p (car proposed-value) classtype))
		  (eieio-persistent-convert-list-to-object
		   proposed-value))

		 ;; List of object constructors.
		 ((and (eq (car proposed-value) 'list)
		       ;; 2nd item is a list.
		       (consp (car (cdr proposed-value)))
		       ;; 1st elt of 2nd item is a class name.
		       (class-p (car (car (cdr proposed-value))))
		       )

		  ;; Check the value against the input class type.
		  ;; If something goes wrong, issue a smart warning
		  ;; about how a :type is needed for this to work.
		  (unless (and
			   ;; Do we have a type?
			   (consp classtype) (class-p (car classtype)))
		    (error "In save file, list of object constructors found, but no :type specified for slot %S"
			   slot))

		  ;; We have a predicate, but it doesn't satisfy the predicate?
		  (dolist (PV (cdr proposed-value))
		    (unless (child-of-class-p (car PV) (car classtype))
		      (error "Corrupt object on disk")))

		  ;; We have a list of objects here.  Lets load them
		  ;; in.
		  (let ((objlist nil))
		    (dolist (subobj (cdr proposed-value))
		      (push (eieio-persistent-convert-list-to-object subobj)
			    objlist))
		    ;; return the list of objects ... reversed.
		    (nreverse objlist)))
		 (t
		  proposed-value))))

	 ((stringp proposed-value)
	  ;; Else, check for strings, remove properties.
	  (substring-no-properties proposed-value))

	 (t
	  ;; Else, just return whatever the constant was.
	  proposed-value))
  )

(defun eieio-persistent-slot-type-is-class-p (type)
  "Return the class refered to in TYPE.
If no class is referenced there, then return nil."
  (cond ((class-p type)
	 ;; If the type is a class, then return it.
	 type)

	((and (symbolp type) (string-match "-child$" (symbol-name type))
	      (class-p (intern-soft (substring (symbol-name type) 0
					       (match-beginning 0)))))
	 ;; If it is the predicate ending with -child, then return
	 ;; that class.  Unfortunately, in EIEIO, typep of just the
	 ;; class is the same as if we used -child, so no further work needed.
	 (intern-soft (substring (symbol-name type) 0
				 (match-beginning 0))))

	((and (symbolp type) (string-match "-list$" (symbol-name type))
	      (class-p (intern-soft (substring (symbol-name type) 0
					       (match-beginning 0)))))
	 ;; If it is the predicate ending with -list, then return
	 ;; that class and the predicate to use.
	 (cons (intern-soft (substring (symbol-name type) 0
				       (match-beginning 0)))
	       type))

	((and (consp type) (eq (car type) 'or))
	 ;; If type is a list, and is an or, it is possibly something
	 ;; like (or null myclass), so check for that.
	 (let ((ans nil))
	   (dolist (subtype (cdr type))
	     (setq ans (eieio-persistent-slot-type-is-class-p
			subtype)))
	   ans))

	(t
	 ;; No match, not a class.
	 nil)))

(defmethod object-write ((this eieio-persistent) &optional comment)
  "Write persistent object THIS out to the current stream.
Optional argument COMMENT is a header line comment."
  (call-next-method this (or comment (oref this file-header-line))))

(defmethod eieio-persistent-path-relative ((this eieio-persistent) file)
  "For object THIS, make absolute file name FILE relative."
  (file-relative-name (expand-file-name file)
		      (file-name-directory (oref this file))))

(defmethod eieio-persistent-save ((this eieio-persistent) &optional file)
  "Save persistent object THIS to disk.
Optional argument FILE overrides the file name specified in the object
instance."
  (save-excursion
    (let ((b (set-buffer (get-buffer-create " *tmp object write*")))
	  (default-directory (file-name-directory (oref this file)))
	  (cfn (oref this file)))
      (unwind-protect
	  (save-excursion
	    (erase-buffer)
	    (let ((standard-output (current-buffer)))
	      (oset this file
		    (if file
			(eieio-persistent-path-relative this file)
		      (file-name-nondirectory cfn)))
	      (object-write this (oref this file-header-line)))
	    (let ((backup-inhibited (not (oref this do-backups)))
		  (cs (car (find-coding-systems-region
			    (point-min) (point-max)))))
	      (unless (eq cs 'undecided)
		(setq buffer-file-coding-system cs))
	      ;; Old way - write file.  Leaves message behind.
	      ;;(write-file cfn nil)

	      ;; New way - Avoid the vast quantities of error checking
	      ;; just so I can get at the special flags that disable
	      ;; displaying random messages.
	      (write-region (point-min) (point-max)
			    cfn nil 1)
	      ))
	;; Restore :file, and kill the tmp buffer
	(oset this file cfn)
	(setq buffer-file-name nil)
	(kill-buffer b)))))

;; Notes on the persistent object:
;; It should also set up some hooks to help it keep itself up to date.


;;; Named object
;;
;; Named objects use the objects `name' as a slot, and that slot
;; is accessed with the `object-name' symbol.

(defclass eieio-named ()
  ()
  "Object with a name.
Name storage already occurs in an object.  This object provides get/set
access to it."
  :abstract t)

(defmethod slot-missing ((obj eieio-named)
			 slot-name operation &optional new-value)
  "Called when a non-existent slot is accessed.
For variable `eieio-named', provide an imaginary `object-name' slot.
Argument OBJ is the named object.
Argument SLOT-NAME is the slot that was attempted to be accessed.
OPERATION is the type of access, such as `oref' or `oset'.
NEW-VALUE is the value that was being set into SLOT if OPERATION were
a set type."
  (if (memq slot-name '(object-name :object-name))
      (cond ((eq operation 'oset)
	     (if (not (stringp new-value))
		 (signal 'invalid-slot-type
			 (list obj slot-name 'string new-value)))
	     (eieio-object-set-name-string obj new-value))
	    (t (eieio-object-name-string obj)))
    (call-next-method)))

(provide 'eieio-base)

;;; eieio-base.el ends here
