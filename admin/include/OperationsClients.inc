<form name="srchForm" id="srchForm" method="post" action="">
  <table id="rechOper">
    <tr>
      <td>Recherche :</td>
      <td>
        <input name="search" id="search" type="text" onkeyup="showData('true',
        '')" value="<% =Session("rechVal") %>" placeholder="rechercher">
        <select class="selected" id="sel_col" onchange="showData()">
          <option value="NomClient">Nom</option>
          <option value="PrenomClient">Prénom</option>
          <option value="NPIClient">NPI</option>
          <option value="AdresseClient">Adresse</option>
          <option value="EmailClient">Email</option>
          <option value="TelClient">Téléphone</option>
          <option value="PaysClient">Pays</option>
          <option value="VilleClient">Ville</option>
        </select>
      </td>
      <td>
        <button type="button" id="ajout" onclick="goForward()">
          Ajouter un client
        </button>
      </td>
    </tr>
    <tr>
      <td>Catégorie de recherche :</td>

      <td colspan="2">
        <div class="categRech">
          <input
            type="radio"
            value="Show_Tous"
            name="categRech"
            onchange="showData('true', '')"
          />
          <label for="">Tous</label>
          <br />
          <input
            type="radio"
            value="Show_penal"
            name="categRech"
            onchange="showData('true', '')"
          />
          <label for="">Les clients pénalisés</label>
          <br />
          <input
            type="radio"
            value="Show_inactif"
            name="categRech"
            onchange="showData('true', '')"
          />
          <label for="">Les clients qui ont un abonnement inactif</label>
          <br />
          <input
            type="radio"
            value="Show_jamais"
            name="categRech"
            onchange="showData('true', '')"
          />
          <label for="">Les clients qui n'ont jamais empruntés</label>
        </div>
      </td>
    </tr>
    <% If prio = 1 then %>
    <tr>
      <td>Opérations:</td>
      <td>
        <select id="operations">
          <option value="delete"
            >Supprimer le(s) client(s) sélectioné(s)</option
          >
          <option value="assocAbonn"
            >Associer une offre au(x) client(s) sélectioné(s)</option
          >
        </select>
      </td>
      <td>
        <button type="button" id="valider" onclick="operate()">
          Valider l'opération
        </button>
      </td>
    </tr>
    <% End If %>
    <tr>
      <td>
        <input
          type="button"
          value="&#10094;&#10094;"
          class="navBtn"
          onclick="showData('false', 'prev');"
        />
      </td>
      <td style="text-align: center; font-size: 22px;">Pagination</td>
      <td>
        <input
          type="button"
          value="&#10095;&#10095;"
          class="navBtn"
          onclick="showData('false', 'next');"
        />
      </td>
    </tr>
  </table>
</form>
