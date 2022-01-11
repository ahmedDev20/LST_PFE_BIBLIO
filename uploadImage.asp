<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
rS.CursorLocation = adUseClient
connection.Open Application("DB")
Set Upload = Server.CreateObject("Persits.Upload")

' On Error Resume Next

' Limit file size to 50000 bytes, throw an exception if file is larger
Upload.SetMaxSize 5000000, True
'les extensions valables
ext1 = "JPG"
ext2 = "JPEG"
ext3 = "PNG"
ext4 = "GIF"

Path = Server.MapPath("./img/Clients")&"/"
Count = Upload.Save(Path)
' Perform upload
Set File = Upload.Files("Profil_img")
mobile = Request.QueryString("mobile")
Session("fname") = File.ExtractFileName

If File.ImageType = ext1 or File.ImageType = ext2 or File.ImageType = ext3 or File.ImageType = ext4 Then
    ' 8 is the number of "File too large" exception
    If Err.Number = 8 Then
        Session("Alert") = "Votre image est large ! <br> Veuillez ressayer"
        File.Delete
    Response.Redirect "MonProfil.asp"
    ElseIf Count <> 1 Then
        Session("Alert") = "Vous devez choisir une image!"
        Response.Redirect "MonProfil.asp"
    ElseIf Err <> 0 Then
        Session("Alert") = "Une erreur est survenue ! <br> Veuillez ressayer"
        File.Delete
        Response.Redirect "MonProfil.asp"
    End If

    ' Create instance of AspJpeg object
    Set jpeg = Server.CreateObject("Persits.Jpeg")

    ' Open uploaded file
    jpeg.Open Path &"\"& Session("fname")

    If jpeg.Width < 250 or jpeg.Height < 300  then
        Session("Alert") = "La taille de votre image est très petite ! <br> Veuillez ressayer"
        File.Delete
        Response.Redirect "MonProfil.asp"
    Else  
        If mobile = "true" Then 'pour les smartphones et tablette
            Jpeg.PreserveAspectRatio = True
            Jpeg.Height = 300
            Jpeg.Sharpen 1, 200
            Jpeg.PNGOutput = True
            'renommer l'image
            newImageName = "small_"&Session("IdUser")&".png"
            'le chemin final
            FinalPath = Path & newImageName
            'Save image name in the database 
            query = "UPDATE TCLIENTS SET Avatar = '"&newImageName&"' WHERE IdClient = "&Session("IdUser")
            connection.execute query
            connection.close
            Set rs = Nothing
            jpeg.Save FinalPath
            File.Delete
        Else 
            Session("Alert") = ""
            Session("crop") = "true"
            Jpeg.Close
            Response.redirect "MonProfil.asp"
        End If
    End If
Else
    Session("Alert") = "Type invalide !"
    File.Delete
    Response.redirect "Monprofil.asp"
End if
Response.redirect "Monprofil.asp"
%>
