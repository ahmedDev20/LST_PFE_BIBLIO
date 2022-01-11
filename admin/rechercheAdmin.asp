<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
srchTable = Request.QueryString("search_tab")
srchCateg = Request.QueryString("rechCateg")
srchFiltre = Request.QueryString("filtre")
srchValue = Request.QueryString("valeur")
srchLimit = Session("limit")
sign = Request.QueryString("sign")
date1 = Request.QueryString("date1")
date2 = Request.QueryString("date2")
srchValue = Replace(srchValue, "'", "''")
srchValue = Trim(srchValue)
categLivres = Request.QueryString("categLivres")
champClients = Request.QueryString("champClients")
page = Request.QueryString("page")
reset = Request.QueryString("reset")

If reset = "false" and page = "next" and Session("NextPage") < Session("rc") Then 
  Session("NextPage") = Session("NextPage") + 1
ElseIf reset = "false" and page = "prev" and Session("NextPage") <> 1 Then 
  Session("NextPage") = Session("NextPage") - 1
ElseIf reset = "true" Then
  Session("NextPage") = 1
End If

Select Case srchTable
  Case "TCLIENTS"
    Select Case srchCateg
      Case "Show_Tous":
      query = "ps_rech_all_client_par_filt '"&srchFiltre&"','"&srchValue&"',0,0,0,"&Session("NextPage")
      Case "Show_penal":
      query = "ps_rech_all_client_par_filt '"&srchFiltre&"','"&srchValue&"',1,0,0,"&Session("NextPage")
      Case "Show_inactif":
      query = "ps_rech_all_client_par_filt '"&srchFiltre&"','"&srchValue&"',0,1,0,"&Session("NextPage")
      Case "Show_jamais":
      query = "ps_rech_all_client_par_filt '"&srchFiltre&"','"&srchValue&"',0,0,1,"&Session("NextPage")
    End Select
  Case "TABONNEMENTS"
    If srchFiltre <> "DateAbonnement" Then
      Select Case srchCateg
        Case "Show_Tous":
        query = "ps_rech_all_abonn_par_filt '"&srchFiltre&"','"&srchValue&"',0,0,"&Session("NextPage")
        Case "Show_penal":
        query = "ps_rech_all_abonn_par_filt '"&srchFiltre&"','"&srchValue&"',1,0,"&Session("NextPage")
        Case "Show_inactif":
        query = "ps_rech_all_abonn_par_filt '"&srchFiltre&"','"&srchValue&"',0,1,"&Session("NextPage")
      End Select
    Else
      query = "ps_rech_all_abonn_par_date '"&date1&"','"&date2&"',"&Session("NextPage")
    End If
  Case "TEMPRUNTS"
    If srchFiltre <> "DateEmprunt" Then
      Select Case srchCateg
        Case "Show_Tous":
        query = "ps_rech_all_empr_par_filt '"&srchFiltre&"','"&srchValue&"',0,0,0,"&Session("NextPage")
        Case "Show_finies":
        query = "ps_rech_all_empr_par_filt '"&srchFiltre&"','"&srchValue&"',0,0,1,"&Session("NextPage")
        Case "Show_retard":
        query = "ps_rech_all_empr_par_filt '"&srchFiltre&"','"&srchValue&"',1,0,0,"&Session("NextPage")
        Case "Show_actuelles":
        query = "ps_rech_all_empr_par_filt '"&srchFiltre&"','"&srchValue&"',0,1,0,"&Session("NextPage")
      End Select
    ElseIf srchCateg = "Show_Tous" Then
      query = "ps_rech_all_empr_par_date 0, '"&date1&"','"&date2&"',"&Session("NextPage")
    Else 
      query = "ps_rech_all_empr_par_date 1, '"&date1&"','"&date2&"',"&Session("NextPage")
    End If
  Case "TLIVRES"
    Select Case srchCateg
      Case "Show_Tous":
        query = "ps_rech_livres_dispo '"&srchFiltre&"','"&srchValue&"', '"&categLivres&"',-1,"&Session("NextPage")' AFFCIHER TOUS LES LIVRES
      Case "Show_liv_disp":
        query = "ps_rech_livres_dispo '"&srchFiltre&"','"&srchValue&"', '"&categLivres&"',1,"&Session("NextPage")' AFFCIHER QUE LES LIVRES DISPONIBLES 
      Case "Show_liv_indisp":
        query = "ps_rech_livres_dispo '"&srchFiltre&"','"&srchValue&"', '"&categLivres&"',0,"&Session("NextPage")'AFFCIHER QUE LES LIVRES INDISPONIBLES 
      End Select
End select
' Response.Write query
' Response.end
rS.Open query, connection, 3, 3
Session("rc") = rS.RecordCount 
%>
<% If rS.RecordCount = 0  Then %>
    <div style="width: 900px;margin: 0 auto;text-align: center !important;background: #e6d3a8;">
      <h1>Pas de résultat trouvé !</h1>
			<img src="../img/sadBook.png" width="300px" />
    </div>
<% Else %>
  <% If srchTable = "TEMPRUNTS" Then %>
    <% while not rS.EOF  %>
      <tr>
        <td ondblclick="showProfil('<%=rS("IdClient")%>')" style="cursor:pointer"><%=rS("NomClient")%></td>
        <td><%=rS("CodeAbonnement")%></td>
        <td><%=rS("DesignationOffre")%></td>
        <td><%=rS("DesignationLivre")%></td>
        <td><%=rS("DateEmprunt")%></td>
        <td><%=rS("DateRetour")%></td>
        <td <% If rS("RETARD") < 0 Then %> style="color:tomato" <% end If %>> <%=rS("RETARD")%></td>
        <% If prio = 1 then %>
        <td>
          <input class="checkbox-custom" type="checkbox" name="cb[]" id="cb<%=rs("IdEmprunt") %>" value="<%=rs("IdEmprunt") %>">
        </td>
        <% end If %>
      </tr>
    <% rS.movenext : wend %>
  <% ElseIf srchTable = "TABONNEMENTS" Then %>
    <% While not rS.EOF %>
      <!--VerIfier Etat Abonnement-->
      <% If (rS("EtatAbonnement") = 0) Then EtatAb = "Désactivé" Else EtatAb = "Activé" End If %>
        <tr>
          <td ondblclick="showProfil('<%=rS("IdCLient")%>')" style="cursor:pointer"><% Response.Write rs("PrenomClient")&" "&rs("NomClient") %></td>
          <td><%=rs("CodeAbonnement") %></td>
          <td><%=rs("DesignationOffre")%></td>
          <td><%=rS("DateAbonnement")%></td>
          <td><%=EtatAb%></td>
          <td><%=rS("DateFinPenalite")%></td>
          <% If prio = 1 then %>
          <td>
            <input class="checkbox-custom" type="checkbox" name="cb[]" id="cb<%=rS("IdAbonnement") %>" value="<%=rs("IdAbonnement") %>">
          </td>
          <% End If %>
        </tr>
    <% rS.movenext: wend %>
  <% ElseIf srchTable = "TLIVRES" Then %>
    <% While not rs.EOF %>
    <tr>
      <td><%=rS("DesignationLivre")%></td>
      <td><%=rS("DesignationCategorie")%></td>
      <td><%=rS("ISBN")%></td>
      <td><%=rS("AUTEUR")%></td>
      <td><%=rS("DISPONIBLE")%></td>
      <% If prio = 1 Then %>
      <td>
        <input class="checkbox-custom" type="checkbox" name="cb[]" id="cb<%=rS("IdLivre")%>" value="<%=rS("IdLivre") %>">
      </td>
      <% End If %>
    </tr>
    <% rs.moveNext : wend %>
  <% ElseIf srchTable = "TCLIENTS" Then %>
    <% while not rS.EOF  %>
      <tr>
          <td  ondblclick="showProfil('<%=rS("IdCLient")%>')" style="cursor:pointer"><%=rS("NomClient") %></td>
          <td><%=rS("PrenomClient") %></td>
          <td><%=rS("NPIClient") %></td>
          <td align="left" style="padding-left: 7px;"><%=rS(champClients) %></td>
          <td align="left" style="padding-left: 7px;"><%=rS("TelClient") %></td>
          <% If prio = 1 then %>
          <td>
            <input class="checkbox-custom" type="checkbox" name="cb[]" id="cb<%=rs("IdClient") %>" value="<%=rs("IdClient") %>">
          </td>
          <% End If %>
        </tr>
      <% rS.movenext : wend %>
  <% End If %>
<% End If %>
<%
rs.close()
set rs = Nothing
%>
