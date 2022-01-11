<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query = "select C.IdCategorie,C.DesignationCategorie, COUNT(L.IDLIVRE) AS NBRLIVRE FROM TCATEGORIES C LEFT JOIN  TLIVRES L ON L.IdCategorie = C.IdCategorie GROUP BY C.IdCategorie, DesignationCategorie"
rS.Open query, connection, 3, 3
Session("nomTable") = "TCATEGORIES"
Session("nomId") = rs(0).name
 
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="../img/fsts_logo.png">
  <title>Catégories</title>
  <link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_rech_ope.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>
<!-- #include file="include/menu_admin.inc" -->

<!-- #include file="include/errorHandler.asp"-->
  <div class="container">
    <!-- #include file="include/OperationsCategs.inc" -->
    <form method="post" id="cbForm" >
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>ID Catégorie</th>
              <th>Designation Catégorie</th>
              <th>Nbr Livres</th>
              <% if prio <> 2 then %>
              <th>
                <input class="checkbox-custom" type="checkbox" name="sel-all" id="sel-all">
              </th>
              <% end if %>
            </tr>
          </thead>
          <tbody>
          <% while not rS.EOF  %>
          <tr>
            <td><%=rs("IdCategorie") %></td>
            <td><%=rS("DesignationCategorie")%></td>
            <td><%=rS("NBRLIVRE")%></td>
            <% if prio <> 2 then %>
            <td>
              <input type="checkbox" class="checkbox-custom" name="cb[]" id="cb<%=rs("IdCategorie") %>"
                value="<%=rs("IdCategorie") %>">
            </td>
            <% end if %>
          </tr>
          <% rS.movenext : wend %>
          </tbody>
        </table>
      </div>
    </form>
  </div>
  <script>
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