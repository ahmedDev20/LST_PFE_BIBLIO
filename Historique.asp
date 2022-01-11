<!--#include file="include/security.asp"-->
<%
On Error Resume Next
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient 
query ="ps_sel_empr_client "&Session("IdUser")&", 1"
rS.Open query,connection, 3, 3 

If Err.Number <> 0 Then Session("erreur") = "Nous sommes désolé une erreur est survenue.Veuillez réssayer ultérieurement " Else Session("erreur") = "" End If
%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" href="img/fsts_logo.png" />
	<title>Emprunts</title>
	<link rel="stylesheet" href="css/style_abonn&empr&livres.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="css/style_menu.css" />

</head>

<body>

	<!-- #include file="include/menu.inc" -->
	<div class="container">
		<!--#include file="include/errorHandler.asp"-->
		<form name="srchForm" id="srchForm" method="post" action="">
			<div class="rechDiv" border="0">
				<div class="rechDates">
					<span id=" span1">Début</span>
					<input type="date" name="date1" id="date1" onchange="showData()" value="<% =Session("date1") %>"
						required style="height:32px;margin-top:2px">
					<span id="span2">Fin</span>
					<input type="date" name="date2" id="date2" onchange="showData()" value="<% =Session("date2") %>"
						required style="height:32px;">
				</div>
				<input name="search" id="search" type="text" onkeyup="showData()" value="<% =Session("rechVal") %>"
					placeholder="rechercher">
				<select id="sel_col" onchange="showData()">
					<option value="CodeAbonnement" id="abonn" selected>par Abonnement
					</option>
					<option value="DesignationLivre" id="livre">par Livre
					</option>
					<option value="DateEmprunt" id="date">par Date
					</option>
				</select>
			</div>
		</form>

		<div class="table-wrap">
			<table class="data">
				<thead>
					<tr>
						<td>Code Abonnement</td>
						<td>Offre</td>
						<td>Désignation Livre</td>
						<td>Sortie</td>
						<td>Retour</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
	<script>
		function showData() {
			var filtre = document.getElementById('sel_col').value;
			var valeur = document.getElementById('search').value;
			var date1 = document.getElementById('date1').value;
			var date2 = document.getElementById('date2').value;
			if (filtre == 'DateEmprunt') {
				document.getElementById('search').style.display = "none";
				document.querySelector('.rechDates').style.display = "flex";
			} else {
				document.getElementById('search').style.display = "inline";
				document.querySelector('.rechDates').style.display = "none";
			}
			var xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function () {
				if (this.readyState == 4 && this.status == 200) {
					document.querySelector(".data tbody").innerHTML = this.responseText;
				}
			};
			xmlhttp.open("GET", "Recherche.asp?historique=true&filtre=" + filtre + "&valeur=" + valeur + "&retard=" +
				0 + "&date1=" + date1 + "&date2=" + date2, true);
			xmlhttp.send();
		}
	</script>
	<script src="js/responsive.js"></script>
</body>

</html>