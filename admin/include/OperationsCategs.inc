<form name="srchForm" id="srchForm" method="post" action="">
    <table id="rechOper" border="0">
        <tr>
            <td colspan="3"><button type="button" id="ajout" onclick="goForward()">Ajouter une catégorie</button></td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option value="delete">Supprimer la/les catégorie(s) sélectioné(s)</option>
                </select>
            </td>
            <td>
                <button type="button" id="valider" onclick="operate()">Valider l'opération</button>
            </td>
        </tr>
        <% End If %>
    </table>
</form>