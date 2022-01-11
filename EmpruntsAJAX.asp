<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient 


if Request("cb[]").Count = 1 Then
    sql = " = "&Request("cb[]")(1)&" "
Else
    sql = "IN ("
    for i = 1 to Request("cb[]").Count
        if i = Request("cb[]").Count Then
            sql = sql &Request("cb[]")(i)&") "
        Else
            sql = sql &Request("cb[]")(i)&", "
        End If
    Next
End If

query ="SELECT E.*, DesignationLivre, DesignationOffre, CodeAbonnement,"&_
"DATEDIFF(DAY, GETDATE(), DATEADD(DAY, NbrJoursOffre, DateEmprunt)) AS RETARD "&_
"FROM TEMPRUNTS E, TLIVRES L, TEXEMPLAIRES EX, TABONNEMENTS A, TOFFRES O "&_
"WHERE E.IdExemplaire = EX.IdExemplaire AND "&_
"EX.IdLivre = L.IdLivre AND "&_
"A.IdOffre = O.IdOffre AND "&_
"E.IdAbonnement = A.IdAbonnement "&_
"AND E.DateRetour IS NOT NULL "&_
"AND A.IdClient = "&Session("IdUser")&" "&_
"AND A.IdAbonnement "&sql&_
"ORDER BY DateEmprunt DESC"
rS.Open query,connection, 3, 3 
%>

<% If rS.RecordCount <> 0 then %>
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
                <% while not rS.EOF %>
                <tr>
                    <td><% =rS("CodeAbonnement") %></td>
                    <td><%=rS("DesignationOffre")%></td>
                    <td><%=rS("DesignationLivre")%></td=>
                    <td><%=rS("DateEmprunt")%></td>
                    <td><%=rS("DateRetour")%></td>
                </tr>
                <% rS.movenext : wend %>
            </tbody>
        </table>
    </div>
<% Else %>
    <h1>Pas d'emprunts pour cet(s) abonnement(s) !</h1>
<% End If %>