<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
idClient = Session("IdUser")
filtre = Request.QueryString("filtre") 'mot de rechrche
valRech = Request.QueryString("valeur") 'mot de rechrche
valRech = Trim(valRech) 'mot de rechrche
valRech = replace(valrech, "'", "''''") 'probleme d'apostrophe
date1 = Request.QueryString("date1") 'date de début
date2 = Request.QueryString("date2") 'date de fin
retard = Request.QueryString("retard") 'si la recherche dans les emprunts en retard 
hist = Request.QueryString("historique") 'si la recherche dans l'historique des emprunts 
livre = Request.QueryString("livre") 'si la recherche dans les livres 
categ = Request.QueryString("categ") 'categorie des livres 

if livre = "true" then
	query = "ps_rech_livres_dispo '"&filtre&"','"&valRech&"', '"&categ&"',-1, 1"
Else
	if hist = "true" then
		If filtre <> "DateEmprunt" Then
			query = "ps_rech_empr_par_filt_hist "&idClient&",'"&filtre&"','"&valRech&"'"
		Else
			query = "ps_rech_empr_par_date_hist "&idClient&",'"&date1&"','"&date2&"'"
		End if
	Else
		If filtre <> "DateEmprunt" Then
			query = "ps_rech_empr_par_filt "&idClient&","&filtre&",'"&retard&"','"&valRech&"'"
		Else
			query = "ps_rech_empr_par_date "&idClient&",'"&retard&"','"&date1&"','"&date2&"'"
		End if
	End if
End if
' Response.Write query
' Response.End 
rS.Open query, connection, 3, 3
%>
<% if rS.recordCount = 0 then %>
	<tr>
        <td colspan="8" style="border:none">
            <h1>Pas de résultat trouvé !</h1>
			<img src="img/sadBook.png" width="300px" />
        </td>
    </tr>
<% else %>
	<!-- Si la recherche dans la table des livres -->
	<% If livre = "true" Then %>
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
	<!-- Si la recherche dans la table des emprunts -->
	<% ElseIf hist <> "true" Then %>
			<% while not rS.EOF %>
			<tr>
				<td><%=rS("CodeAbonnement")%></td>
				<td><%=rS("DesignationOffre")%></td>
				<td><%=rS("DesignationLivre")%></td=>
				<td><%=rS("DateEmprunt")%></td>
				<td <% if rS("RETARD") < 0 then %> style="color:tomato" <% end if %>><%=rS("RETARD")%></td>
			</tr>
			<% rS.movenext :wend %>
	<!-- Si la recherche dans la table d'historique -->
	<% Else %>
			<% while not rS.EOF %>
			<tr>
				<td><%=rS("CodeAbonnement")%></td>
				<td><%=rS("DesignationOffre")%></td>
				<td><%=rS("DesignationLivre")%></td=>
				<td><%=rS("DateEmprunt")%></td>
				<td><%=rS("DateRetour")%></td>
			</tr>
			<% rS.movenext :wend %>
	<% End if %>
<% End if %>