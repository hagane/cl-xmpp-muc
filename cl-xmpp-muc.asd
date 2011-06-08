(defpackage :cl-xmpp-muc-system
  (:use :cl :asdf))
(in-package :cl-xmpp-muc-system)

(asdf:defsystem :cl-xmpp-muc
  :version "20110608"
  :author "Dmitriy Savichev <deemson@gmail.com>"
  :license "BSD License"
  :description "XEP-0045 realization for cl-xmpp."
  :depends-on (cl-xmpp cxml)
  :components ((:file "package")
			   (:file "groupchat" :depends-on ("package"))))