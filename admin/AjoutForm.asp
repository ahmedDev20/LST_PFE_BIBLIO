<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
Set rS3 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rs.CursorLocation = adUseClient
targetTable = Request.QueryString("table")
value = Request.queryString("value") 'valeur de Idabonnement s'il exsite
multiAbonn = Request.queryString("multiAbonn") 'les Idclients s'ils exsitent
rS.open targetTable, connection, 3, 3

Select Case targetTable
    Case "TCLIENTS":
        nbr_input = 14
    Case "TABONNEMENTS":
        nbr_input = 2
    Case "TOFFRES":
        nbr_input = 4
    Case "TEMPRUNTS":
        nbr_input = 2
    Case "TCATEGORIES":
        nbr_input = 1
    Case "TLIVRES":
        nbr_input = 5
    Case "TAUTEURS":
        nbr_input = 2
End Select
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <link rel="icon" href="../img/fsts_logo.png">
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="css/style_rech_ope.css" />
    <link rel="stylesheet" href="css/style_menu.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AjoutForm</title>
</head>

<body>
    <!-- #include file="include/menu_admin.inc" -->
    <!-- #include file="include/errorHandler.asp"-->
    <% If targetTable = "TLIVRES" Then %>
    <form method="post" enctype="multipart/form-data" id="imgForm">
        <table id="ajoutData">
            <tr>
                <td>Catégorie du livre</td>
                <td>
                    <select class="select" name="data[]">
                        <option value=''>Sélectionner une catégorie </option>
                        <% rS2. open "TCATEGORIES", connection, 3, 3 %>
                        <% while not rS2.EOF %>
                        <option value="<%=rS2("IdCategorie")%>"><%=rS2("DesignationCategorie")%></option>
                        <% rS2.MoveNext : wend %>
                        <% rS2.Close %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Auteur du livre</td>
                <td>
                    <select class="select" name="data[]">
                        <option value=''>Sélectionner un Auteur </option>
                        <% rS3. open "SELECT * FROM TAUTEURS ORDER BY PrenomAuteur ASC", connection, 3, 3 %>
                        <% while not rS3.EOF %>
                        <option value="<%=rS3("IdAuteur")%>"><%=rS3("PrenomAuteur")&" "&rS3("NomAuteur")%></option>
                        <% rS3.MoveNext : wend %>
                        <% rS3.Close %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Titre du livre</td>
                <td><input type="text" name="data[]"></td>
            </tr>
            <tr>
                <td>ISBN du livre</td>
                <td><input type="text" name="data[]"></td>
            </tr>
            <tr>
                <td>Couverture du livre</td>
                <td><input id="Cover" type="file" name="data[]"></td>
            </tr>
            <tr>
                <td>Nombres d'exemplaires</td>
                <td><input type="number" name="data[]" value="1" max="10"></td>
            </tr>
        </table>
    </form>
    <% Else %>
    <form method="post" id="form">
        <table id="ajoutData">
            <% For i = 1 to nbr_input  %>
            <tr>
                <td width=200 align=left style="padding-left:7px"><%=rS(i).name%></td>
                <td width=700 align=left valign=center>

                    <% If  i = 4 and targetTable = "TCLIENTS" Then %>
                    <label style="padding-left:7px">Homme</label>
                    <input type="radio" id="labelHomme" name="data[]" checked value="Homme">
                    <label>Femme</label>
                    <input type="radio" name="data[]" value="Femme">

                    <% ElseIf i = 5 and targetTable = "TCLIENTS" Then %>
                    <input type="date" name="data[]" value="<%=Session("data"&i)%>">

                    <% ElseIf i = 1 and targetTable = "TEMPRUNTS" Then %>
                    <input type="text" name="data[]" value="<%=value%>">

                    <% ElseIf i = 1 and targetTable = "TABONNEMENTS" Then %>
                    <input type="text" name="data[]" value="<%=multiAbonn%>">

                    <% ElseIf i = 2 and targetTable = "TABONNEMENTS" Then %>
                    <% rS2.Open "TOFFRES", connection, 3, 3 %>
                    <select class="select" name="data[]">
                        <option value=''>Sélectionner une Offre</option>
                        <% while not rS2.EOF %>
                        <option value="<%=rS2("IdOffre")%>"><%=rS2("DesignationOffre")%></option>
                        <% rS2.MoveNext : wend %>
                    </select>

                    <% ElseIf targetTable = "TOFFRES" and i <> 1 Then %>
                    <input type="number" name="data[]">

                    <% Else %>
                    <input type="text" name="data[]" value="<%=Session("data"&i)%>">
                    <% End if %>
                </td>
            </tr>
            <% next %>
            <tr>
                <% If targetTable = "TCLIENTS" Then %>
                <td width=200 align=left style="padding-left:7px">Offre</td>
                <td width=700>
                    <select class="select" name="data[]">
                        <option value=''>Sélectionner une Offre</option>
                        <% rS2.Open "TOFFRES", connection, 3, 3 %>
                        <% while not rS2.EOF %>
                        <option value="<%=rS2("IdOffre")%>"><%=rS2("DesignationOffre")%></option>
                        <% rS2.MoveNext : wend %>
                    </select>
                </td>
                <% End If %>
        </table>
    </form>
    <% End If %>
    <div class="add">
        <button type="button" id="retour" onclick="goBack()">retour</button>
        <button type="button" id="ajouter" onclick="add()">Ajouter</button>
    </div>
    <script src="../js/Add&Delete.js"></script>
    <script src="../js/Responsive.js"></script>
    <script>
        const menu_items = document.querySelectorAll('a');
        var prev = lien.searchParams.get('page') || lien.searchParams.get('origin');
        menu_items.forEach(e => { if (e.href.split('/').pop() == prev) e.className += 'active'; })
        function goBack() {
            document.location = document.querySelector('a.active').href;
        }
    </script>
</body>

</html>
<%
Session("msg") = ""
Session("msg_emprunt") = ""
rS.Close
set rS = nothing
set rS2 = nothing
set rS3 = nothing
set connection = nothing
%>