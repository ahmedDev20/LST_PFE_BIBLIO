<header>
  <div class="logo">
    <img src="img/fsts_logo.png" alt="fsts_logo" width="60px">
  </div>
  <ul>
    <li class="list-item"><a href="Accueil.asp">Accueil</a></li>
    <li class="list-item"><a id="signUp" href="Inscription.asp">S'inscrire</a></li>
    <li class="list-item"><a href="Login.asp">S'identifier</a></li>
    <li class="list-item"><a href="Contact.asp">Contact</a></li>
  </ul>
</header>
<script>
  let href = window.location.href.split('?');
  href = href.shift();
  document.querySelectorAll('a').forEach(e => { if (e.href === href) e.className += 'active'; });
</script>