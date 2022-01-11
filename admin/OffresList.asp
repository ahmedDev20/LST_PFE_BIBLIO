<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query = "select * from TOFFRES"
rS.Open query, connection, 3, 3
Session("nomTable") = "TOFFRES"
Session("nomId") = rs(0).name
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Offres</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>

  <!-- #include file="include/menu_admin.inc" -->

  <!-- #include file="include/errorHandler.asp"-->
  <div class="container">
    <!-- #include file="include/OperationsOffres.inc" -->
    <div class="table-wrap">
    <form method="post" id="cbForm">
      <table id="tableOffres">
        <thead>
          <tr>
            <th>Offre</th>
            <th>Nbr_Livres</th>
            <th>Nbr_Jours</th>
            <th>Prix(DH)</th>
            <% if prio = 1 then %>
            <th>
              <input type="checkbox" name="sel-all" class="checkbox-custom" id="sel-all">
            </th>
            <% end if %>
          </tr>
        </thead>
        <tbody>
          <% while not rS.EOF  %>
          <tr id="row<%=rS("IdOffre")%>">
            <td>
              <input type="hidden" value="<%=rS("IdOffre")%>">
              <input ondblclick="modifierOffre()" style="cursor: pointer;" readonly type="text" id="<%=rS("IdOffre")%>"
                value="<%=rS("DesignationOffre")%>">
            </td>
            <td><input type="number" readonly value="<%=rS("NbrLivresOffre")%>"></td>
            <td><input type="number" readonly value="<%=rS("NbrJoursOffre")%>"></td>
            <td><input type="number" readonly value="<%=rS("PrixOffre")%>"></td>
            <% if prio = 1  then %>
            <td>
              <input class="checkbox-custom" type="checkbox" name="cb[]" id="cb<%=rs("IdOffre") %>"
                value="<%=rs("IdOffre") %>">
            </td>
            <% end if %>
          </tr>
          <% rS.movenext : wend %>
        </tbody>
      </table>
      <button type="button" id="back" onclick="window.location.reload()">annuler</button>
      <button type="button" id="modifier" onclick="updateOffre();">changer</button>
    </form>
    </div>
  </div>
  <script>
    //modification de l'offre
    function modifierOffre() {
      const row = document.querySelectorAll('#row' + event.target.id + ' input:not([type=checkbox])');
      for (let i = 1; i < row.length; i++) {
        row[0].name = 'ids[]';
        row[i].name = 'data[]';
        row[i].readOnly = false;
        row[i].style.border = '1px solid black';
        row[i].style.background = 'white';
        row[i].style.cursor = 'text';
      };
      document.getElementById('back').style.display = 'inline';
      document.getElementById('modifier').style.display = 'inline';
      console.log(...row);
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
rS.Close
set rS = nothing
set connection = nothing
%>