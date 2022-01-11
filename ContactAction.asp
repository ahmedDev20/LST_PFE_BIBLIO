<%
Nom		    = Trim(Request.Form("TNom"))
Prenom		= Trim(Request.Form("TPrenom"))
GSM       = Trim(Request.Form("TGSM"))
Email     = Trim(Request.Form("TEmail"))
Message   = Request.Form("TMessage")

'eliminer les tag HTML 
FUNCTION stripHTML(strHTML)
  Dim objRegExp, strOutput, tempStr
  Set objRegExp = New Regexp
  objRegExp.IgnoreCase = True
  objRegExp.Global = True
  objRegExp.Pattern = "<(.|n)+?>"
  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  stripHTML = strOutput    'Return the value of strOutput
  Set objRegExp = Nothing
END FUNCTION
Nom     = stripHTML(Nom)
Prenom  = stripHTML(Prenom)
GSM     = stripHTML(GSM)
Message = stripHTML(Message)

If((Len(Nom) = 0) Or (Len(Prenom) = 0) Or (Len(Email) = 0) Or (Len(Message) = 0)) Then
  Session("Msg") = "Des informations sont manquantes, prière de remplir tous les champs obligatoires."
  Response.Redirect "Contact.asp"
End If

Session("Nom") = Nom 
Session("Prenom") = Prenom
Session("GSM") = GSM
Session("Email") = Email
Session("Message") = Message

datte = Date
Entete = "<HTML lang=""fr""><HEAD><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /><meta http-equiv=""Content-Language"" content=""fr"" />"
Entete = Entete & "<TITLE>Envoi Automatique de Courrier : FstsBiblio</TITLE></HEAD><BODY bgcolor=""white"">" 

body = "<Table align=center cellspacing=""3"" cellpadding=""5"" width=""600"" style=""FONT-SIZE: 10pt;FONT-FAMILY: Verdana"">"
  
body = body & "<tr><td foreground align=center valign=center colspan=2 style=""border: 1px solid #D2D2D2""><b>Formulaire de Contact FstsBiblio.ma - " & FormatDateTime(datte) & "</b></td></tr>"

body = body & "<tr><td align=left valign=center width=170 style=""border: 1px solid #D2D2D2"">Nom</td>"
body = body & "<td align=left valign=center width=430 style=""border: 1px solid #D2D2D2"">" & Nom & "&nbsp;</td></tr>"

body = body & "<tr><td align=left valign=center  style=""border: 1px solid #D2D2D2"">Prénom</td>"
body = body & "<td align=left valign=center  style=""border: 1px solid #D2D2D2"">" & Prenom & "&nbsp;</td></tr>"	

body = body & "<tr><td align=left valign=center style=""border: 1px solid #D2D2D2"">Email</td>"
body = body & "<td align=left valign=center style=""border: 1px solid #D2D2D2"">" & Email & "&nbsp;</td></tr>"

body = body & "<tr><td align=left valign=center style=""border: 1px solid #D2D2D2"">Gsm</td>"
body = body & "<td align=left valign=center style=""border: 1px solid #D2D2D2"">" & GSM & "&nbsp;</td></tr>"

body = body & "<tr><td align=left valign=center style=""border: 1px solid #D2D2D2"">Message</td>"
body = body & "<td align=left valign=center style=""border: 1px solid #D2D2D2;text-align:justify"">" & Message & "&nbsp;</td></tr>"

body = body & "</Table>"

Bas = "<BR><BR>&nbsp;</BODY></HTML>"


Set Mail = Server.CreateObject("Persits.MailSender")

Mail.Host       = "smtp.gmail.com"
Mail.Username   = "your_email@gmail.com"
Mail.Password   = "your_password" 
Mail.TLS        = True
Mail.Port       = 587

Mail.From			= Email 
Mail.FromName = Nom
Mail.AddAddress "", "Ahmed Balady"
Mail.AddBcc "", "Ahmed Balady"
Mail.Subject			= "Contact : " & Nom & " " & Prenom & " - " & datte
Mail.Body			= Entete & body & Bas
Mail.Body			= body 
Mail.IsHTML			= True
  
On Error Resume Next
Mail.Send

If Err.number <> 0 Then
  Session("msg") = "Votre demande contact n'a pu être prise en charge<br><br>Veuillez effectuer cette opération ultérieurement"
Else
  Session("msg") =  "Votre message a été envoyé ! <br>"
End If
Response.Redirect "Contact.asp"	
%>
