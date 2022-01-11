<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
  <link rel="icon" href="img/fsts_logo.png">
  <title>Contact</title>
  <link rel="stylesheet" href="css/style_login_contact.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_accueil.css" type="text/css" media="screen" />
</head>

<body>
  <!-- #include file="include/header.inc" -->
  <div class="container">
  <!--#include file="include/errorHandler.asp"-->
    <form name="FormContact" id="FormContact" action="ContactAction.asp" method="post">
      <h3 id="header">Contactez nous</h3>
      <input type="text" name="TNom" id="TNom" placeholder="Nom(*)" required value="<%=Session("Nom")%>">
      <input type="text" name="TPrenom" id="TPrenom" placeholder="Prenom(*)" value="<%=Session("Prenom")%>">
      <input type="tel" name="TGSM" id="TGSM" placeholder="N°GSM" value="<%=Session("GSM")%>">
      <input type="email" name="TEmail" id="TEmail" placeholder="Email(*)" value="<%=Session("Email")%>">
      <textarea name="TMessage" id="Message" cols="30" rows="10" placeholder="Message..." value="<%=Session("Message")%>"></textarea>
      <button type="button" name="BTEnvoi" id="BTConnexion" onclick="verifContact(event)">Envoyer</button>
      <img id="load" src="./img/loading.gif" alt="loading" width="80" style="display: none;">
      <p id="oblig">* Champ Obligatoire</p>
    </form>
  </div>
  <!--#include file="include/footer.inc"-->
  <script>
    function verifContact(event) {
      var inputs = document.querySelectorAll('input:not([type="tel"]), textarea');
      for (var e of inputs) {
        if (e.value === '') {
          alert('le ' + e.placeholder + ' est obligatoire !');
          e.focus();
          return;
        }
      }
      document.getElementById('FormContact').submit();
      event.target.style.display = "none";
      document.getElementById('load').style.display = "";
    }
  </script>
</body>

</html>
<%
	Session("Msg") = ""
	Session("Log") = ""
	Session("Pas") = ""
%>