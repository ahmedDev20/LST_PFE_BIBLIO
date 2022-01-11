<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
rs.CursorLocation = adUseClient
connection.Open Application("DB")
On Error Resume Next

IdClient = Session("IdUser")
PassClient = Request.Form("Tconf")

query = "SELECT Password FROM TCLIENTS WHERE IdClient = "&IdClient &" AND Password = CONVERT(NVARCHAR(48), HASHBYTES('SHA2_256','" &PassClient&"'), 2)"
rS.Open query, connection, 3, 3

If Err <> 0 Then
    Session("msg") = "Une Erreur est survenue ! <br> Description : "&Err.Description
Else
    If rS.recordCount = 0 Then
        Session("msg") = "Mot de passe incorrect !"
        Response.redirect "MonProfil.asp?id="&IdClient
    Else
        nom = Request.Form("Tnom")
        prenom = Request.Form("Tprenom")
        npi = Request.Form("Tnpi")
        dateN = Request.Form("Tdate")
        adresse	= Request.Form("Tadresse")
        tel = Request.Form("Ttel")

        Req = "ps_modifier_profil_client " &IdClient&", '"&npi&"', '"&dateN&"', '"&adresse&"', '"&tel&"'"
        connection.Execute Req
        If Err <> 0 Then
            Session("msg") = "Une Erreur est survenue ! <br> Description : "&Err.Description
        Else
            Session("msg") = "Modifié avec succès !"
        End If
        connection.close()
        Set connection = Nothing
        Response.redirect "MonProfil.asp?id="&IdClient
    End If
End If
%>