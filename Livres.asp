<!--#include file="include/security.asp"-->
<%
On Error Resume Next
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
query2 ="TCATEGORIES"
rS.Open "ps_rech_livres_dispo 'DesignationLivre', '', '' ,-1, 1",connection, 3,3
rS2.Open query2,connection, 3,3

If Err.Number <> 0 Then Session("erreur") = "Nous sommes désolé une erreur est survenue.Veuillez réssayer ultérieurement " Else Session("erreur") = "" End If
%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="icon" href="img/fsts_logo.png" />
	<title>Livres</title>
	<link rel="stylesheet" href="css/style_abonn&empr&livres.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="css/style_menu.css" />
</head>

<body>

	<!-- #include file=include/menu.inc -->
	<div class="container" >
		<!--#include file="include/errorHandler.asp"-->
		<form name="srchForm" id="srchForm" method="post" action="">
			<div class="rechDiv">
				<input name="search" id="search" type="text" onkeyup="showData()" value="<% =Session("rechVal") %>"
					placeholder="tapez pour rechercher...">

				<select name="categ" id="categLivres" onchange="showData()">
					<option value="">Catégorie</option>
					<% while not rS2.EOF %>
					<option value="<%=rS2("DesignationCategorie")%>"><%=rS2("DesignationCategorie")%></option>
					<% rS2.MoveNext : wend %>
				</select>

				<select id="sel_col" onchange="showData()">
					<option value="DesignationLivre" selected>par Titre
					</option>
					<option value="Auteur">par Auteur
					</option>
					<option value="ISBN">par ISBN
					</option>
				</select>
			</div>
		</form>
		<div class="table-wrap">
			<% While not rS.EOF %>
				<div class="details-livre">
					<img src="img/Covers/<%=rS("Cover")%>" />
					<ul>
						<li><b>Titre : </b> <%=rS("DesignationLivre")%></li>
						<li><b>Catégorie : </b><%=rS("DesignationCategorie")%></li>
						<li><b>Auteur : </b><%=rS("AUTEUR")%></li>
						<li><b>ISBN : </b><%=rS("ISBN")%></li>
						<li><b>Quantité disponible : </b><%=rS("DISPONIBLE")%></li>
					</ul>
				</div>
			<% rS.movenext: Wend %>
		</div>
		<script>
			function showData() {
				var filtre = document.getElementById('sel_col').value;
				var valeur = document.getElementById('search').value;
				var categ = document.getElementById('categLivres').value;

				var xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange = function () {
					if (this.readyState == 4 && this.status == 200) {
						document.querySelector(".table-wrap").innerHTML = this.responseText;
					}
				};
				xmlhttp.open("GET", "Recherche.asp?categ=" + categ + "&livre=true&filtre=" + filtre + "&valeur=" + valeur, true);
				xmlhttp.send();
			}
		</script>
		<script src="js/responsive.js"></script>
</body>

</html>