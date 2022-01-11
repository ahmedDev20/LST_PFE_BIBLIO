<form name="srchForm" id="srchForm" method="post" action="">
    <table id="rechOper">
        <tr>
            <td colspan="3" align="center"><button type="button" id="ajout" onclick="goForward()">Ajouter une
                    offre</button></td>
        </tr>
        <% If prio = 1 then %>
        <tr>
            <td>Opérations: </td>
            <td>
                <select id="operations">
                    <option value="delete">Supprimer l'/les offre(s) sélectionée(s)</option>
                </select>
            </td>
            <td>
                <button type="button" id="valider" onclick="operate()">Valider l'opération</button>
            </td>
        </tr>
        <% End If %>
    </table>
</form>