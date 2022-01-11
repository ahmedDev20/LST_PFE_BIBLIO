<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient

rS.Open "TCATEGORIES", connection, 3, 3
Session("nomTable") = "TLIVRES"
Session("nomId") = "IdLivre"
Session("NextPage") = 1 
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Livres</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>
  <!-- #include file="include/menu_admin.inc" -->

  <!-- #include file="include/errorHandler.asp"-->
  <div class="container">
    <!-- #include file="include/OperationsLivres.inc" -->
    <div class="table-wrap">
      <form method=post id="cbForm">
        <table class="data_table" id="tableLivres">
          <thead>
            <tr>
              <th>Titre</th>
              <th>
                <select name="categ" id="categLivres" onchange="showData('true', '')">
                  <option value="">Catégorie</option>
                  <% while not rS.EOF %>
                  <option value="<%=rS("DesignationCategorie")%>"><%=rS("DesignationCategorie")%></option>
                  <% rS.MoveNext : wend %>
                </select>
              </th>
              <th>ISBN</th>
              <th>Auteur</th>
              <th>Quantité diponible</th>
              <% If prio = 1 Then %>
              <th><input type="checkbox" name="sel-all" class="checkbox-custom" id="sel-all"></th>
              <% End If %>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </form>
      </div>
  </div>
  <script>
    //AJAX
    function showData(reset, pg) {
      var rechCateg = document.querySelector('input[type="radio"]:checked').value;
      var filtre = document.getElementById('sel_col').value;
      var valeur = document.getElementById('search').value;
      var categLivres = document.getElementById('categLivres').value;

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

      // alert(rechCateg + '|' + filtre + '|' + valeur + '|');
      xmlhttp.open("GET", "rechercheadmin.asp?search_tab=TLIVRES&categLivres="+categLivres+"&rechCateg=" + rechCateg + "&filtre=" + filtre + "&valeur=" + valeur+ "&page="+pg+"&reset="+reset, true);
      xmlhttp.send();
    }
    //si je double clique sur le nom du client 
    function showProfil(id) {
      var path = window.location.pathname;
      var page = path.split("/").pop();
      document.location = "Profil.asp?page="+page+"&idClient=" + id;
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
</script>
</body>

</html>
<%
Session("msg") = ""
Session("msg_emprunt") = ""
connection.Close()
set connection = nothing
%>