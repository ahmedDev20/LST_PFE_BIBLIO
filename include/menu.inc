<div class="topnav" id="myTopnav">
  <a href="MonProfil.asp">Mon Profil</a>
  <a href="MesEmprunts.asp">Livres Empruntés</a>
  <a href="Historique.asp">Historique des Emprunts</a>
  <a href="MesAbonnements.asp">Mes Abonnements</a>
  <a href="Livres.asp">Livres</a>
  <a href="LoginAction.asp?id=-1">Se déconnecter</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <span id="show">&#9776;</span>
  </a>
</div>

<script>
  var href = window.location.href;
  var deviceWidth = window.innerWidth;

  //activer l'element du menu lors du clique
  document.querySelectorAll('a').forEach(e => { if (e.href === href) e.className += 'active'; });

  //dans la version mobile => activer la page visitee dans le menu
  const items = document.querySelectorAll('.topnav a');
  const active = document.querySelector('a.active');
  if (deviceWidth < 768)
    active.parentNode.insertBefore(active, items[0]);
</script>