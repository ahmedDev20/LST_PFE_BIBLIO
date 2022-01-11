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
                    <option value="NomClient">NomClient</option>
                    <option value="CodeAbonnement">Code Abonnement</option>
                    <option value="DesignationOffre">Offre</option>
                    <option value="DesignationLivre">Exemplaire</option>
                    <option value="DateEmprunt">Date Emprunt</option>
                </select>
            </td>
            <td>
                <button type="button" id="ajout" onclick="goForward()">Emprunter un exemplaire</button>
                <button type="button" id="retourner" onclick="goForward()">Retourner un exemplaire</button>
            </td>
        </tr>
        <tr>
            <td>Catégorie de recherche :</td>
            <td colspan="2">
                <div class="categRech">
                    <input type="radio" value="Show_Tous" name="categRech" onchange="showData('true', '')">
                    <label for="">Tous</label>
                    <br>
                    <input type="radio" value="Show_finies" name="categRech" onchange="showData('true', '')">
                    <label for="">Emprunts complets</label>
                    <br>
                    <input type="radio" value="Show_actuelles" name="categRech" onchange="showData('true', '')">
                    <label for="">Emprunts en cours</label>
                    <br>
                    <input type="radio" value="Show_retard" name="categRech" onchange="showData('true', '')">
                    <label for="">Emprunts en retard</label>
                </div>
            </td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option value="delete">Supprimer le(s) emprunts(s) sélectionné(s)</option>
                    <option value="RetourEx">Retourner l'exemplaire sélectionné</option>
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