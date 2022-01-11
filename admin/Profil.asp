<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
idClient = Request.QueryString("idClient")
query = "SELECT * FROM TCLIENTS WHERE IdClient = "&idClient
rS.Open query, connection, 3, 3
targetTable = Session("nomTable")
%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Profil</title>
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>
  <!-- #include file="include/menu_admin.inc" -->

  <div class="container">
    <!--#include file="include/errorHandler.asp"-->
    <form name="DataClient" id="DataClientForm" method="POST" action="">
      <table id="dataProfil">
        <% for i = 1 to rs.Fields.Count - 6 %>
        <tr>
          <th><% =rs(i).name %></th>
          <% If i = 6 or i > 7  Then %>
          <td>
            <input type="text" name="data[]" class="DataClientForm" value="<% =rs(rs(i).name) %>" readonly>
          </td>
          <% Else %>
          <td>
            <input type="text" class="DataClientForm" value="<% =rs(rs(i).name) %>" readonly>
          </td>
          <% End If %>
        </tr>
        <% next %>
      </table>
      <button type="button" id="retour" onclick="goBack()">retour</button>
      <button type="button" id="annuler">annuler</button>
      <button type="button" id="modif">Modifier</button>
      <button type="button" id="valider">Valider</button>
    </form>
  </div>
  <script>
    //ajouter la classe active au menu
      let lien = new URL(window.location.href);
      let page = lien.searchParams.get("page");
      const menu_items = document.querySelectorAll('a');
      menu_items.forEach(e => { if (e.href.split('/').pop() == page) e.className += 'active'; })
    //memoriser le nom de la page pour le retour
    function goBack() {
      document.location = page;
    }
  </script>
  <script>
    let fields = document.getElementsByTagName("input");
    let modif = document.getElementById("modif");
    let valid = document.getElementById("valider");
    let anul = document.getElementById("annuler");
    let ret = document.getElementById("retour");
    let id = lien.searchParams.get("idClient");

    anul.style.display = 'none';
    modif.onclick = function modifier() {
      let i = 0;
      while(i < 11){
        if(i == 5 || i > 6){
          fields[i].style.background = "white";
          fields[i].style.border = "1px solid black";
          fields[i].style.color = "black";
          fields[i].style.paddingLeft = "3px";
          fields[i].readOnly = false;
        }
        i++;
      };
      modif.style.display = "none";
      anul.style.display = '';
      ret.style.display = 'none';
      valid.style.display = "inline-block";

      valid.onclick = function () {
        document.getElementById('DataClientForm').action = 'ProfilAction.asp?id=' + id+"&previous=" + page;
        document.getElementById('DataClientForm').submit();
      }
      anul.onclick = () => {window.location.reload();}
    }
  </script>
  <script src="../js/responsive.js"></script>
</body>
<%
rs.close()
Set rs = nothing
connection.close()
Set connection = Nothing
Session("msg") = ""
%>

</html>