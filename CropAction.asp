<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
Dim Jpeg, pos_x, pos_y, w, h, r
w = 250
h = 300

r = Request.Form("ratio")
r = Replace(r,",",".")
pos_x = Request.Form("pos_x")
pos_y = Request.Form("pos_y")

ON ERROR RESUME NEXT
Set fs=Server.CreateObject("Scripting.FileSystemObject")

Set Jpeg = Server.CreateObject("Persits.Jpeg")
Jpeg.Open Server.MapPath("./img/Clients/" & Session("fname"))

If(Err.Number <> 0) Then
	Session("alert") = "Une erreur est survenue !<br>"
	Jpeg.Close
	set fs=nothing
	Response.Redirect "MonProfil.asp"
End If

Jpeg.ResolutionX = 72
Jpeg.ResolutionY = 72
Jpeg.PreserveAspectRatio = True
Jpeg.Width = Jpeg.Width * r

Jpeg.Crop pos_x, pos_y, pos_x + w, pos_y + h

' Output as PNG
Jpeg.PNGOutput = True

newImageName = "small_"&Session("Iduser")&".png"
' Save
Jpeg.Save Server.MapPath("./img/Clients/")&"/"&newImageName
Jpeg.Close

' Supprimer le premier fichier telechargé 
if fs.FileExists(Server.MapPath("./img/Clients/" & Session("fname"))) then
	fs.DeleteFile(Server.MapPath("./img/Clients/" & Session("fname")))
end if

query = "UPDATE TCLIENTS SET Avatar = '"&newImageName&"' WHERE IdClient = "&Session("IdUser")
connection.execute query
connection.close
Set connection = Nothing	
Set fs = nothing
Session("fname") = ""
Response.Redirect "MonProfil.asp"
%>