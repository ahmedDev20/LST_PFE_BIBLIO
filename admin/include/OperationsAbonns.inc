<form name="srchForm" id="srchForm" method="post" action="">
    <table id="rechOper">
        <tr>
            <td>Recherche :</td>
            <td>
                <div class="rechDates" style="height:35px;display:none;">
                    <span id="span1">Début</span>
                    <input type="date" name="date1" id="date1" onchange="showData('true', '')">
                    <span id="span2">Fin</span>
                    <input type="date" name="date2" id="date2" onchange="showData('true', '')">
                </div>
                <input name="search" id="search" type="text" onkeyup="showData('true', '')" placeholder="rechercher">
                <select class="selected" id="sel_col" onchange="showData('true', '')">
                    <option value="NomClient">Nom Client</option>
                    <option value="CodeAbonnement">Code Abonnement</option>
                    <option value="DesignationOffre">Offre</option>
                    <option value="DateAbonnement">Date Abonnement</option>
                </select>
            </td>
            <td><button type="button" id="ajout" onclick="goForward()">Ajouter un abonnement</button></td>
        </tr>
        <tr>
            <td>Catégorie de recherche</td>
            <td colspan="2">
                <div class="categRech">
                    <input type="radio" value="Show_Tous" name="categRech" onchange="showData('true', '')">
                    <label for="">Tous</label>
                    <br>
                    <input type="radio" value="Show_penal" name="categRech" onchange="showData('true', '')">
                    <label for="">Les abonnements pénalisés</label>
                    <br>
                    <input type="radio" value="Show_inactif" name="categRech" onchange="showData('true', '')">
                    <label for="">Les abonnements inactifs</label>
                </div>
            </td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option value="enableAb">Activer le(s) abonnement(s) sélectionné(s)</option>
                    <option value="disableAb">Désactiver le(s) abonnement(s) sélectionné(s)</option>
                    <option value="delete">Supprimer le(s) abonnement(s) sélectionné(s)</option>
                    <option value="EmpruntAb">Emprunter un exemplaire pour l'abonnement sélectionné</option>
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