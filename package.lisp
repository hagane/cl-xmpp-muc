(defpackage :cl-xmpp-muc
  (:nicknames :xmpp-muc :muc)
  (:use :cl :xmpp :cxml)
  (:export "join" "add-participant" "send"))