<!--#include file="include/security.asp"-->
<%
Server.ScriptTimeout=5
On Error Resume Next
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query = "ps_sel_abonn_client "&Session("IdUser")
rS.Open query, connection, 3, 3

If Err.Number <> 0 Then Session("erreur") = "Nous sommes désolé une erreur est survenue.Veuillez réssayer ultérieurement " Else Session("erreur") = "" End If
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="img/fsts_logo.png">
  <title>Abonnements</title>
  <link rel="stylesheet" href="css/style_abonn&empr&livres.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_menu.css">
</head>

<body>

  <!-- #include file=include/menu.inc -->

  <div class="container">
    <!--#include file="include/errorHandler.asp"-->
    <!--#include file="include/OperationsAbonns.asp"-->
    <div class="table-wrap">
      <table class="dataAbonn">
        <thead>
          <tr>
            <th>Code Abonnement</th>
            <th>Offre</th>
            <th>Date Abonnement</th>
            <th>Etat Abonnement</th>
            <th>DateFinPenalite</th>
            <th>
              <input type="checkbox" name="sel-all" value="test" id="sel-all" onchange="SelectAll()">
            </th>
          </tr>
        </thead>
        <tbody>
          <% while not rS.EOF %>
          <% If rS("EtatAbonnement") = true Then EtatAb = "Activé" Else EtatAb = "Désactivé" End If %>
          <tr>
            <td><%=rS("CodeAbonnement")%></td>
            <td><%=rS("DesignationOffre")%></td>
            <td><%=rS("DateAbonnement")%></td>
            <td><%=EtatAb%></td>
            <td><%=rs("DateFinPenalite")%></td>
            <td>
              <input type="checkbox" name="cb[]" onchange="isAllchecked()" value="<%=rs("IdAbonnement") %>">
            </td>
          </tr>
          <% rS.movenext: wend %>
        </tbody>
      </table>
    </div>
  </div>
  <div style="text-align: center;">
    <button id="retour" onclick="document.location ='MesAbonnements.asp';" style="display: none;">Retour</button>
  </div>
  <script>
    function afficherEmprunts() {
      let CBchecked = document.querySelectorAll('tbody input[type=checkbox]:checked');
      let values = [];
      CBchecked.forEach(e => {
        values.push('cb[]=' + e.value);
      });
      if (CBchecked.length == 0) {
        alert("Veuillez Choisir au moins un champ !");
      }
      else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
          if (this.readyState == 4 && this.status == 200) {
            document.querySelector(".container").innerHTML = this.responseText;
            document.querySelector("#retour").style.display = 'inline';
          }
        }
        var url = 'EmpruntsAJAX.asp?';
        for (const value of values) {
          url += value;
          url += '&'
        }
        xmlhttp.open("GET", url);
        xmlhttp.send();
      }
    }
  </script>
  <script src="js/responsive.js"></script>
  <script>
    function SelectAll() {
      var checkAll = document.querySelector('#sel-all');
      var boxes = document.querySelectorAll('input[type=checkbox]');

      (event.target.checked) ? boxes.forEach(element => { element.checked = true; }) : boxes.forEach(element => { element.checked = false; })
    }

    function isAllchecked() {
      var checkAll = document.querySelector('#sel-all');
      var boxes = document.querySelectorAll('tbody input[type=checkbox]');
      var checkedBoxes = document.querySelectorAll('tbody input[type=checkbox]:checked');
      checkAll.checked = (checkedBoxes.length === boxes.length) ? true : false;
    }

  </script>
</body>


</html>