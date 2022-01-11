<%
Set connection = Server.CreateObject("ADODB.connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
'LoginForm Informations 
id = Request("id")
loginUser = Request.Form("Tlogin")
loginPass = Request.Form("Tpasswd")

Response.Write loginUser
Response.Write loginPass
' Response.end

if id = "-1" or Len(loginUser) = 0 or Len(loginPass) = 0 then
    Session.abandon
    Response.Redirect("Login.asp")
end if
query = "SELECT * FROM TADMINS WHERE LoginAdmin LIKE '"&loginUser&"' AND PassAdmin = CONVERT(NVARCHAR(48), HASHBYTES('SHA2_256','" &loginPass&"'), 2)"
rS.open query, connection, 3,3

'if the user is a Client
if(rs.RecordCount = 0) then
    rs.close
    query = "SELECT * FROM TCLIENTS WHERE EmailClient LIKE '" & loginUser & "' AND Password = CONVERT(NVARCHAR(48), HASHBYTES('SHA2_256','" &loginPass&"'), 2)"
    rs.open query, connection, 3,3
    if(rs.RecordCount = 1) then
        Session("user") = "client"
        Session("IdUser") = rs("IdClient") 
        Session("prenom") = rs("PrenomClient")
        Response.Redirect("MonProfil.asp")
    else
        Session("IdUser") = ""
        Session("Log") = loginUser
		Session("Pas") = loginPass
        Session("err") = "login ou/et mot de passe incorrects"
        Response.Redirect("Login.asp")
    end if
else
'if the user is a admin
    Session("user") = "admin"
    Session("IdUser") = rs("IdAdmin") 
    Session("prenomAdmin") = rs("PrenomAdmin")
    Session("nomAdmin") = rs("NomAdmin")
    Session("IdAdmin") = rs("ID")
    Session("priority") = rs("Priority")
    Session("avatar") = rs("Avatar")
    Response.Redirect("admin/ClientsList.asp")
end if

rs.close()
set rs = nothing
connection.close()
set connection = nothing
%>

