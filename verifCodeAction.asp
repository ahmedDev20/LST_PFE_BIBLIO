<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
If Session("id") <> Session.SessionId  Then
    Session("Msg") = "Veuillez vous identifier"
    Response.redirect "./Login.asp"
End If

Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rS.CursorLocation = adUseClient

'PARTIE AJAX POUR LA VALIDATION DU CODE
If Request.QueryString("AJAX") = "true" Then
    verif = Request.Form("verif")
    query = "SELECT CONVERT(NVARCHAR(MAX),HASHBYTES('SHA2_256',CONVERT(NVARCHAR(MAX),'"&verif&"',2)),2) AS HASH"
    rS.Open query, connection, 3, 3
    hash = rS("HASH")
    Response.Write hash
    Response.End 
End If 

On Error Resume Next

'Insertion informations
query = "INSERT INTO TCLIENTS([NomClient],[PrenomClient],[EmailClient],[TelClient],[CreditCard],[ExpirationDate],[CVV],[DateNaissance],[Genre],[PaysClient],[VilleClient],[AdresseClient],[NPIClient],[CodePostalClient],[Password]) VALUES('"&Session("data2")&"','"&Session("data3")&"','"&Session("data4")&"','"&Session("data5")&"','"&Session("data6")&"','"&Session("data7")&"','"&Session("data8")&"','"&Session("data9")&"','"&Session("data10")&"','"&Session("data11")&"','"&Session("data12")&"','"&Session("data13")&"','"&Session("data14")&"','"&Session("data15")&"',CONVERT(NVARCHAR(48), HASHBYTES('SHA2_256','"&Session("data16")&"'), 2))"

connection.execute query
' Ajout d'un abonnement
rS.Open "SELECT IDENT_CURRENT('TCLIENTS') AS NEWID", connection
newID = rS("NEWID")
rS.Close
rS.Open "TABONNEMENTS", connection, 3, 3
rS.AddNew
rS("IdClient") = newID
rS("IdOffre") = Session("data1")
rS.Update
rS.Close()
set rs = nothing
set connection = nothing

If Err.number <> 0 Then
    Session("sign_up") = "Nous sommes désolé, une erreur est survenue lors de l'inscription! <br> Description : "&Err.Description
Else
    Session("sign_up") = "Votre Inscription est bien enregistrée!"
    Session("Log") = Session("data4")
    '  Vider les variables sessions
    for i=1 to Session("count_data")
        if i <> 4 Then
            Session("data"&i) = ""
        End If
    Next
    Session("count_data") = ""
End If
Session("id") = ""
Response.redirect("Inscription.asp")
%>