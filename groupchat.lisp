(in-package :xmpp-muc)

(defclass groupchat ()
  ((jid :initarg :jid :initform nil :accessor jid)
   (participants :initform '() :accessor participants)
   (nickname :initarg :nickname :initform nil :accessor nickname)
   (connection :initarg :connection :initform nil :accessor connection)
   (resource :initarg :resource :accessor resource :initform nil)))

;;  Sends a presence to a groupchat
(defmethod send-presence ((groupchat groupchat))
  (xmpp::with-xml-output ((connection groupchat))
	(cxml:with-element "presence"
	  (cxml:attribute "from" 
					  (concatenate 'string
								   (xmpp:username (connection groupchat))
								   "@"
								   (xmpp:hostname (connection groupchat))
								   "/"
								   (resource groupchat)))
	  (cxml:attribute "to" (concatenate 'string
										(jid groupchat)
										"/"
										(nickname groupchat)))
	  (cxml:with-element "x"
		(cxml:attribute "xmlns" "http://jabber.org/protocol/muc")))))

;;  Sends a message to chatroom or a chatroom participant.
(defmethod send ((groupchat groupchat) &key (recepient nil) (body nil))
  (if body
	  (xmpp::with-xml-output ((connection groupchat))
		(cxml:with-element "message"
		  (cxml:attribute "from" (concatenate 'string
											  (xmpp:username (connection groupchat))
											  "@"
											  (xmpp:hostname (connection groupchat))
											  "/"
											  (resource groupchat)))
		  (cxml:attribute "to" (if (null recepient)
								   (jid groupchat)
								   (concatenate 'string
												(jid groupchat)
												"/"
												recepient)))
		  (cxml:attribute "type" (if (null recepient)
									 "groupchat"
									 "chat"))
		  (cxml:with-element "body"
			(cxml:text body))))
	  (error "No message body")))

(defun join (connection resource room-jid desired-nickname)
  "Creates a groupchat object, sends a presence to MUC, returns
created groupchat object."
  (let ((groupchat (make-instance 'groupchat
								  :connection connection
								  :resource resource
								  :jid room-jid
								  :nickname desired-nickname)))
	(send-presence groupchat)
	groupchat))