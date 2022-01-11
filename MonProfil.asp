<!--#include file="include/security.asp"-->
<%
On Error Resume Next
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query = "SELECT * FROM TCLIENTS WHERE IdClient = "&Session("IdUser")
rS.Open query, connection, 3, 3


If Err.Number <> 0 Then Session("erreur") = "Nous sommes désolé une erreur est survenue.Veuillez réssayer ultérieurement " Else Session("erreur") = "" End If
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="shortcut icon" href="./img/fsts_logo.png" type="image/x-icon">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Profil</title>
  <link rel="stylesheet" href="css/style_profil.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>


<body <% if LEN(Session("crop")) <> 0 Then %> onload="javascript:load(); afficherStatus();ChangeColor('#0000FF');"
  onkeydown="ChangePos();" <% End If %>>
  <!-- #include file=include/menu.inc -->
  <% if LEN(Session("crop")) <> 0 Then %>
  <!-- #include file=include/modal_crop.inc -->
  <% End If %>
  <div class="profile">
    <!--#include file="include/errorHandler.asp"-->
    <div class="data">
      <div class="profile_pic">
        <form enctype="multipart/form-data" action="uploadImage.asp" method="post" id="form_img">
          <img class="user_image" src="img/Clients/<%=rS("Avatar")%>" alt="Profile__Picture" width="150"
            onerror="this.src='img/Clients/user.png';" style="border: 1px solid #ccc;border-radius:5px;padding:5px;">
          <label class="custom-file-upload">
            <input type="file" name="Profil_img" form="form_img" id="file_img" onchange="uploadImage();">Changer
          </label>
          <p>Taille : 250 x 300</p>
          <h5 style="color:tomato"><%=Session("Alert") %></h5>
        </form>
      </div>

      <form name="Profil" id="Profil" method="post" action="">
        <div class="info">
          <table class="infoTable">
            <tr>
              <th>Nom</th>
              <td><%=rs("NomClient")%></td>
            </tr>
            <tr>
              <th>Prénom</th>
              <td><%=rs("PrenomClient")%></td>
            </tr>
            <tr>
              <th>NPI</th>
              <td><input type="text" name="Tnpi" id="Tnpi" value="<%=rS("NPIClient") %>" readonly></td>
            </tr>
            <tr>
              <th>Date de Naissance</th>
              <td><input type="date" name="Tdate" id="Tdate" value="<%=rS("Datenaissance")%>" readonly></td>
            </tr>
            <tr>
              <th>Email</th>
              <td><%=rS("EmailClient")%></td>
            </tr>
            <tr>
              <th>Adresse</th>
              <td><input type="text" name="Tadresse" id="Tadresse" value="<%=rS("AdresseClient") %>" readonly></td>
            </tr>
            <tr>
              <th>Telephone</th>
              <td><input type="text" name="Ttel" id="Ttel" value="<%=rS("TelClient") %>" readonly></td>
            </tr>
            <tr id="Tconf">
              <th>Confirmation du mot de passe</th>
              <td><input type="password" name="Tconf" style="color: #cf0000;" /></td>
            </tr>
          </table>
        </div>

    </div>
    <div class="edit">
      <button type="button" id="annuler">Annuler</button>
      <a href="ChangerMdp.asp"><button type="button" id="resetPd">Changer le mot de passe</button></a>
      <input type="button" id="valider" value="Valider" disabled>
      <button type="button" id="modifier">Modifier</button>
    </div>
    </form>
  </div>
  <script>
    function uploadImage() {
      var deviceWidth = window.innerWidth;
      if (deviceWidth > 768)
        document.getElementById('form_img').submit();
      else {
        document.getElementById('form_img').action = 'uploadImage.asp?mobile=true';
        document.getElementById('form_img').submit();
      }
    }

  </script>
  <script src="js/Crop.js"></script>
  <script src="js/modifyProfil.js"></script>
  <script src="js/responsive.js"></script>
</body>

</html>
<%
Session("Alert") = ""
Session("msg") = ""
Session("crop") = ""
%>