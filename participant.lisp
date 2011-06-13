(in-package :xmpp-muc)

(defclass participant ()
  ((nickname :accessor nickname :initform nil :initarg :nickname)
   (affiliation :accessor affiliation :initform nil :initarg :affiliation)
   (jid :accessor participant-jid :initform nil :initarg :jid)))

(defmethod equal-participant ((a participant) (b participant))
  (equal (participant-jid a) (participant-jid b)))
