<div class="topnav" id="myTopnav">
  <a href="ClientsList.asp">Clients</a>
  <a href="AbonnementsList.asp">Abonnements</a>
  <a href="EmpruntsList.asp">Emprunts</a>
  <a href=" OffresList.asp">Offres</a>
  <a href="LivresList.asp">Livres</a>
  <a href="CategoriesList.asp">Catégories</a>
  <a href=" AuteursList.asp">Auteurs</a>
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <span id="show">&#9776;</span>
  </a>
  <a href="../LoginAction.asp?id=-1" id="logout">Se déconnecter</a>
</div>
<script>
  let href = window.location.href.split('?');
  href = href.shift();
  document.querySelectorAll('a').forEach(e => { if (e.href === href) e.className += 'active'; });

  //dans la version mobile => activer la page visitee dans le menu
  const deviceWidth = window.innerWidth;
  const items = document.querySelectorAll('.topnav a');
  const active = document.querySelector('a.active');
  if (deviceWidth < 768)
    active.parentNode.insertBefore(active, items[0]);
</script>