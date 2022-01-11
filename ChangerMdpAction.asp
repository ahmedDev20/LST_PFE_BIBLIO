<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
Session("resultat") = ""
oldP  = Request.Form("oldPwd")
newP  = Request.Form("newPwd")
newP2 = Request.Form("newPwd2")

On Error Resume Next
SQL = "SELECT * FROM TCLIENTS WHERE IdClient = "&Session("IdUser")&" AND Password = CONVERT(NVARCHAR(48), HASHBYTES('SHA2_256','"&oldP&"'), 2)"
rS.Open SQL, connection, 3, 3
If rS.recordcount = 1 Then
    SQL = "UPDATE TCLIENTS SET Password = CONVERT(NVARCHAR(48),HASHBYTES('SHA2_256','"&newP&"'), 2) WHERE IdClient = "&Session("IdUser")
    connection.execute SQL
    If Err <> 0 Then
        Session("msg") = "Une Erreur est survenue ! <br> Déscription : "&Err.Description
        Session("oldPas") = oldP
    Else
        Session("msg") = "Mot de passe changé avec succès !"
        Session("oldPas") = ""
    End If
Else
    rS.Close
    set rS = nothing
    Session("msg")= "Mot de passe invalide !"
    Session("oldPas") = oldP
End if
    
Response.Redirect "ChangerMdp.asp"

%>
