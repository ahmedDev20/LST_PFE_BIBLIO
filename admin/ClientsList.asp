<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient

Session("nomTable") ="TCLIENTS"
Session("nomId") = "IdClient"
Session("NextPage") = 1
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>ClientList</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>
  <!-- #include file="include/menu_admin.inc" -->

  <div class="container">
    <!--#include file="include/OperationsClients.inc"-->
    <!-- #include file="include/errorHandler.asp"-->
    <div class="table-wrap">
      <form method="post" id="cbForm" action="">
        <table id="tableClients" class="data_table">
          <thead>
            <tr>
              <th style="word-wrap: break-word">Nom</th>
              <th>Prénom</th>
              <th>NPI</th>
              <th>
                <select name="champsClient" id="champClients" onchange="showData()">
                  <option value="EmailClient" selected>Email</option>
                  <option value="AdresseClient">Adresse</option>
                  <option value="PaysClient">Pays</option>
                  <option value="VilleClient">Ville</option>
                  <option value="CodePostalClient">Code Postal</option>
                </select>
              </th>
              <th>Téléphone</th>
              <% if prio = 1 then %>
              <th><input type="checkbox" name="sel-all" class="checkbox-custom" id="sel-all"></th>
              <% end if %>
            </tr>
          </thead>
          <tbody>
          <!-- Donnees a partir de BDD -->
          </tbody>
        </table>
      </form>
    </div>
  </div>
  <script>
    //AJAX
    function showData(reset, pg) {
      var rechCateg = '' || document.querySelector('input[type="radio"]:checked').value ;
      var champ = document.querySelector('#champClients').value;
      var filtre = document.getElementById('sel_col').value;
      var valeur = document.getElementById('search').value;
      var xmlhttp;
      if (window.XMLHttpRequest) { // code pour IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
      } else { // code pour IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".data_table tbody").innerHTML = this.responseText;
        }
      };

      xmlhttp.open("GET", "rechercheadmin.asp?search_tab=TCLIENTS&rechCateg=" + rechCateg + "&champClients=" + champ +
        "&filtre=" + filtre + "&valeur=" + valeur + "&page="+pg+"&reset="+reset, true);
      xmlhttp.send();
    }

    //si je double clique sur le nom du client 
    function showProfil(id) {
      var path = window.location.pathname;
      var page = path.split("/").pop();
      document.location = "Profil.asp?page=" + page + "&idClient=" + id;
    }
    //memoriser le nom de la page pour le retour
    function goForward() {
      var path = window.location.pathname;
      var page = path.split("/").pop();
      document.location = 'AjoutForm.asp?page=' + page + '&table=<%=Session("nomTable")%>';
    }
    
  </script>
  <script src="../js/checkBoxes.js"></script>
  <script src="../js/Add&Delete.js"></script>
  <script src="../js/responsive.js"></script>

</body>
<%
Session("msg") = ""
Session("msg_emprunt") = ""
connection.close()
Set connection = Nothing
%>

</html>