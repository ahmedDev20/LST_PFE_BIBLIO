<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
Session("nomTable") = "TEMPRUNTS"
Session("nomId") = "IdEmprunt"

Session("NextPage") = 1
%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Emprunts</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>

  <!-- #include file="include/menu_admin.inc" -->

  <div class="container">
    <!-- #include file="include/OperationsEmprs.inc" -->
    <!-- #include file="include/errorHandler.asp"-->
    <form method="post" id="cbForm">
      <div class="table-wrap">
        <table id="tableEmpr" class="data_table">
          <thead>
            <tr>
              <th>Client</th>
              <th>Code Abonnement</th>
              <th>Offre</th>
              <th>Exemplaire</th>
              <th>Date Emprunt</th>
              <th>Date Retour</th>
              <th>Jours Restants/Retard</th>
              <% If prio = 1 then %>
              <th><input class="checkbox-custom" type="checkbox" name="sel-all" id="sel-all"></th>
              <% end if %>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </form>
  </div>
  <script>
    var sign = '>'
    //AJAX
    function showData(reset, pg) {
      var rechCateg = document.querySelector('input[type="radio"]:checked').value;
      var filtre = document.getElementById('sel_col').value;
      var valeur = document.getElementById('search').value;
      var date1 = document.getElementById('date1').value;
      var date2 = document.getElementById('date2').value;
      //si on change la categorie de recherche on supprime l'option de la date
      if (rechCateg == "Show_actuelles")
        document.querySelector('#sel_col option:last-child').style.display = "none";
      else
        document.querySelector('#sel_col option:last-child').style.display = "inline";

      //on affiche/masque les dates selon le filtre
      if (filtre == 'DateEmprunt') {
        document.getElementById('search').style.display = "none";
        document.querySelector('.rechDates').style.display = "inline";
      } else {
        document.getElementById('search').style.display = "inline";
        document.querySelector('.rechDates').style.display = "none";
      }
      var xmlhttp;
      if (window.XMLHttpRequest) {// code pour IE7+, Firefox, Chrome, Opera, Safari
          xmlhttp = new XMLHttpRequest();
      }
      else {// code pour IE6, IE5
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".data_table tbody").innerHTML = this.responseText;
        }
      };

      xmlhttp.open("GET", "rechercheadmin.asp?search_tab=TEMPRUNTS&rechCateg=" + rechCateg + "&filtre=" + filtre + "&valeur=" + valeur + "&date1=" + date1 + "&date2=" + date2 + "&sign=" + sign);
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
      if (event.target.id == 'ajout') {
        document.location = 'AjoutForm.asp?page=' + page + '&table=<%=Session("nomTable")%>';
      } else {
        document.location = 'AjoutForm.asp?page=' + page + '&table=<%=Session("nomTable")%>&retourEmp=true';
      }
    }
    </script>
  <script src="../js/checkBoxes.js"></script>
  <script src="../js/Add&Delete.js"></script>
  <script src="../js/responsive.js"></script>
</body>
</script>
</body>

</html>
<%
Session("msg") = ""
Session("msg_emprunt") = ""
connection.close()
set connection = nothing
%>