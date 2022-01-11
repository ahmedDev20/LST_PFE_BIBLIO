<form name="srchForm" id="srchForm" method="post" action="">
    <table id="rechOper">
        <tr>
            <td>Recherche :</td>
            <td>
                <input name="search" id="search" type="text" onkeyup="showData()"
                    value="<% =Session("rechVal") %>" placeholder="rechercher">
                <select class="selected" id="sel_col" onchange="showData()">
                    <option value="NomAuteurs">Nom</option>
                    <option value="PrenomAuteurs">Prénom</option>
                </select>
            </td>
            <td><button type="button" id="ajout" onclick="goForward()">Ajouter un auteur</button></td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option>Supprimer le(s) auteur(s) sélectioné(s)</option>
                </select>
            </td>
            <td>
                <button type="button" id="valider">Valider l'opération</button>
            </td>
        </tr>
        <% End If %>
    </table>
</form>