<%
if Len(Request.Form("data[]")) = 0 Then 
Session("err") = "Veuillez vous identifier"
Response.redirect "../Login.asp"
End If
%>
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rS.CursorLocation = adUseClient 
rS2.CursorLocation = adUseClient
Session("id") = Session.SessionId
On Error Resume Next

'recuperation des valeurs d'insertion
dim valeursForm(20), i
i = 1
for each valeur in Request.Form("data[]")
    valeursForm(i) = valeur
    valeur = Replace(valeur, "'", "''")
    valeur = Trim(valeur)
    Session("data"&i) = valeur
    i = i + 1
Next
Session("count_data") = i - 1

' Verification d'existance des donnees dans BD
verif = "SELECT * FROM TCLIENTS WHERE EmailClient LIKE '"&Session("data4")&"' OR (CreditCard LIKE '"&Session("data6")&"' AND ExpirationDate LIKE '"&Session("data7")&"' AND CVV LIKE '"&Session("data8")&"')"
rs.open verif,connection,3,3
If Err.number <> 0 Then
    Session("sign_up") = "Nous sommes désolé, Une erreur est survenue lors de l'inscription! <br>"&Err.Description
    rs.close()
    set rs = nothing
    Response.redirect "Inscription.asp"
End If
If rs.recordcount <> 0 Then
    Session("sign_up") = "Cette adresse Email/Carte bancaire est déjà pris.Essayez une autre"
    rs.close()
    set rs = nothing
Else
    rS.close()
    rS.Open "hashedSecretCode", connection, 3, 3 
    Code = rS("CODE")
    Hash = rS("HASH")
    Response.Write Code & "<br>"
    Response.Write Hash
    ' Response.End 

    Set Mail = Server.CreateObject("Persits.MailSender")

    entete = "<html lang=""fr""><head><meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /><meta http-equiv=""Content-Language"" content=""fr"" />"
    entete = entete & "<TITLE>Envoi Automatique de Courrier : FstsBiblio</TITLE></head><BODY bgcolor=""white"">" 
    body = "<center>" 
    body = body&"<h2>"&"Gestion de la Bibiliothèque Numérique de la FST Settat"&"</h2>"
    body = body&"<p style=font-size:22px>"&"Bonne journé Mr/Mme "&Ucase(Session("data3"))&" "&Ucase(Session("data2"))&"</p>"
    body = body&"<p style=font-size:22px>Voici votre code de verification : <b>"&Code&"</b><p>" 
    body = body&"</center>"
    bas = "<br><br>&nbsp;</body></html>" 

    Mail.Host = "smtp.gmail.com"
	Mail.From = ""
	Mail.FromName = "Administration de la Bibliothèque FST Settat "
	Mail.AddAddress  Session("data4")
	Mail.AddBcc ""
	Mail.Subject = "Etape de vérification pour l'inscription à Bibiliothèque"
    Mail.Body = entene & body & bas
	Mail.username = ""
    Mail.password = ""
    Mail.IsHTML = True
    Mail.TLS = True
    Mail.Port = 587
		
	Mail.Send
	If Err.number <> 0 Then
        Session("sign_up") = "Nous sommes désolé, une erreur est survenue lors d'envoi du mail: <br>" & Err.Description
        Response.redirect "Inscription.asp"
    Else
        Session("Hash") = Hash
        Response.redirect "verifCode.asp"
    End If
End If
rS.Close()
connection.Close()
set rS = nothing
set connection = nothing
Response.Redirect "Inscription.asp"
%>