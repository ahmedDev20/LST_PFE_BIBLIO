<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query = "ps_rech_auteurs_par_filt 'PrenomAuteur', ''"
rS.Open query, connection, 3, 3
Session("nomTable") = "TAUTEURS"
Session("nomId") = rs(0).name
Session("limit") = "" 
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Auteurs</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>

  <!-- #include file="include/menu_admin.inc" -->

  <!-- #include file="include/errorHandler.asp"-->
  <div class="container">
    <!-- #include file="include/OperationsAutrs.inc" -->
    <form method=post id="cbForm">
      <div class="table-wrap">
        <table class="data_table">
          <thead>
            <tr>
              <th width=150>Prenom </th>
              <th width=150>Nom </th>
              <th width=50>Livres écrits</th>
              <% if prio = 1 then %>
              <th>
                <input type="checkbox" name="sel-all" id="sel-all">
              </th>
              <% end if %>
            </tr>
          </thead>
          <tbody>
            <% while not rS.EOF %>
              <tr>
                <td><%=rS("PrenomAuteur")%></td>
                <td><%=rS("NomAuteur") %></td>
                <td><%=rS("TOT") %></td>
                <% If Session("Priority") = 1  Then %>
                <td>
                  <input type="checkbox" name="cb[]" value="<%=rS("IdAuteur") %>">
                </td>
                <% End If %>
              </tr>
            <% rS.movenext : wend %>
          </tbody>
        </table>
      </div>
    </form>
  </div>
  <script>
    //AJAX
    function showData() {
      var filtre = document.getElementById('sel_col').value;
      var valeur = document.getElementById('search').value;

      var xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
          document.querySelector(".data_table tbody").innerHTML = this.responseText;
        }
      };

      // alert(rechCateg + '|' + filtre + '|' + valeur + '|');
      xmlhttp.open("GET", "rechercheadmin.asp?search_tab=TAUTEURS&filtre=" + filtre + "&valeur=" + valeur, true);
      xmlhttp.send();
    }
    //memoriser le nom de la page pour le retour
    function goForward() {
      var path = window.location.pathname;
      var page = path.split("/").pop();
      document.location = 'AjoutForm.asp?page=' + page + '&table=<%=Session("nomTable")%>';
    }
  </script>
  <script src="../js/Add&Delete.js"></script>
  <script src="../js/responsive.js"></script>
</body>
</script>
</body>

</html>
<%
Session("msg") = ""
Session("msg_emprunt") = ""
rS.Close
set rS = nothing
set connection = nothing
%>