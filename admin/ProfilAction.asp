<!--#include file="include/security.asp"-->
<%
IdClient = Request.queryString("id")
previousPage = Request.QueryString("previous")
previousPage = "Profil.asp?idClient="&IdClient&"&page="&previousPage

dim data(15)

i = 1
For each val in Request.Form("data[]")
data(i) = val
Response.Write data(i) &"<br>"
i = i + 1
Next

Set cx = Server.CreateObject("ADODB.Connection")
cx.Open Application("DB")

On Error Resume Next

Req = "UPDATE TCLIENTS SET" &_
"  TelClient = '"&data(1)&"'" &_
", AdresseClient = '"&data(2)&"'" &_
", CodePostalClient = '"&data(3)&"'" &_
", VilleClient = '"&data(4)&"'" &_
", PaysClient = '"&data(5)&"'" &_
" WHERE IdClient = "&IdClient

cx.execute Req

If Err.Number <> 0 Then
    Session("msg") = "Une Erreur est survenue ! <br> Description : "&Err.Description
Else  
    Session("msg") = "Modifié avec succès !"
End If
cx.close()
Set cx = Nothing
Response.redirect previousPage

%>