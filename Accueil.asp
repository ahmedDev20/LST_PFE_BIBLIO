<%@ language="vbscript" codepage="65001"%>
<%
Set connection = Server.CreateObject("ADODB.Connection")
connection.Open Application("DB")
id = Session("IdUser")
prenom = Session("prenom")
set rS = Server.CreateObject("ADODB.RecordSet")
set rS2 = Server.CreateObject("ADODB.RecordSet")
query = "SELECT TOP(10) * FROM TLIVRES ORDER BY NEWID()"
query2 = "SELECT * FROM TOFFRES ORDER BY IdOffre"
rS.Open query, connection, 3, 3
rS2.Open query2, connection, 3, 3

%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="img/fsts_logo.png">
  <title>Accueil</title>
  <link rel="stylesheet" href="css/style_accueil.css" type="text/css" media="screen" />
</head>

<body onload="slide()">
  <!--#include file="include/header.inc"-->

  <div class="container">
    <section class="presentation">
      <div class="horaire">
        <div class="8am">
          <img src="img/Clock-8.png" alt="8am" width="100px">
          <h4>Heure d'ouverture <br>08:00</h4>
        </div>
        <div class="6pm">
          <img src="img/Clock-6.png" alt="6pm" width="100px">
          <h4>Heure de fermeture<br>18:00</h4>
        </div>
      </div>
      <h1>Bienvenue à la Bibliothèque numérique</h1>
    </section>

    <section class="list-livres">
      <h2><span>&#10070;</span>Nouveautés<span>&#10070;</span></h2>
      <div class="livres">
        <% while not rS.EOF  %>
        <div class="cover">
          <img src="img/Covers/<%=rS("Cover")%>" alt="cover" width="150px" height="250px">
          <h3><%=rS("DesignationLivre") %></h3>
        </div>
        <% rS.moveNext
      wend %>
      </div>
    </section>

    <section class="list-offres" id="list-offres">
      <h2><span>&#10070;</span> Offres Disponibles <span>&#10070;</span></h2>
      <div class="pricing-table">
        <% while not rS2.EOF  %>
        <div class="card<%=rS2("IdOffre")%>">
          <h4 class="type"><%=rS2("DesignationOffre")%></h4>
          <div class="price"><%=rS2("PrixOffre")%>DH</div>
          <h5 class="plan">plan</h5>
          <ul class="details">
            <li><span></span><%=rS2("NbrLivresOffre")%>Livres</li>
            <li><span></span><%=rS2("NbrJoursOffre")%>Jours</li>
            <li><span></span>Support 24/7</li>
            <li><a href="Inscription.asp?offre=<%=rS2("DesignationOffre")%>"><button>Je m'inscris</button></a></li>
          </ul>
        </div>
        <% rS2.moveNext
          wend %>
      </div>
    </section>

  </div>
  <!--#include file="include/footer.inc"-->
  <script>
    var livres = document.querySelector('.livres');
    var speed = 1;
    function slide() {
      livres.scrollLeft += speed;
      if (livres.scrollLeft > 300 || livres.scrollLeft == 0) {
        speed *= -1;
      }
      setTimeout(slide, 20);
    }
  </script>
  <script src="js/responsive.js"></script>
</body>

</html>