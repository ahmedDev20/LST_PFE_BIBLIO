<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
' On Error Resume Next
connection.Open Application("DB")
rs.CursorLocation = adUseClient

Set Upload = Server.CreateObject("Persits.Upload")
Path = Server.MapPath("/img/Covers")&"/"
Upload.Save Path
Set File = Upload.Files(1)
previousPage = Request.QueryString("previous")

Req = "ps_upload_livre "& Upload.Form(1).value &", "&Upload.Form(2).value &", '"&Replace(Upload.Form(3).value,"'", "''")&"', '"&Upload.Form(4).value&"' ,"&Upload.Form(5).value&""
connection.Execute Req
If Err <> 0 Then
       Session("msg") = "Une Erreur est survenue ! <br> Description : "&Err.Description
       File.Delete
Else
	rS.Open "SELECT IDENT_CURRENT('TLIVRES') AS NEWID", connection, 3, 3
	newID = rS("NEWID")
	rS.Close()
	NewName = newID & ".jpg"
	File.Copy Path & NewName
	File.Delete
	Session("msg") = "Ajouté avec succès !"
End If
connection.close()
Set rS = nothing
Set connection = nothing
Response.Redirect previousPage

%>