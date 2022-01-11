<form name="srchForm" id="srchForm" method="post" action="">
    <table id="rechOper">
        <tr>
            <td>Recherche :</td>
            <td>
                <input name="search" id="search" type="text" onkeyup="showData('true', '')"
                    value="<% =Session("rechVal") %>" placeholder="rechercher">
                <select class="selected" id="sel_col" onchange="showData('false', '')">
                    <option value="DesignationLivre">Titre</option>
                    <option value="ISBN">ISBN</option>
                    <option value="Auteur">Auteur</option>
                </select>
            </td>
            <td><button type="button" id="ajout" onclick="goForward()">Ajouter un livre</button></td>
        </tr>
        <tr>
            <td>Catégorie de Recherche :</td>
            <td colspan="2">
                <div class="categRech">
                    <input type="radio" value="Show_Tous" name="categRech" onchange="showData('false', '')">
                    <label for="">Tous</label>
                    <br>
                    <input type="radio" value="Show_liv_disp" name="categRech" onchange="showData('false', '')">
                    <label for="">Livres disponibles</label>
                    <br>
                    <input type="radio" value="Show_liv_indisp" name="categRech" onchange="showData('false', '')">
                    <label for="">Livres indisponibles</label>
                </div>
            </td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option value="delete">Supprimer le(s) livre(s) sélectioné(s)</option>
                </select>
            </td>
            <td>
                <button type="button" id="valider" onclick="operate()">Valider l'opération</button>
            </td>
        </tr>
        <% End If %>
        <tr>
            <td>
                <input type="button" value="&#10094;&#10094;" class="navBtn" onclick="showData('false', 'prev')">
            </td>
            <td style="text-align: center;font-size: 22px;">Pagination</td>
            <td>
                <input type="button" value="&#10095;&#10095;" class="navBtn" onclick="showData('false', 'next')">
            </td>
        </tr>
    </table>
</form>