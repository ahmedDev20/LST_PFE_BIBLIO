<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
  <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
  <link rel="icon" href="img/fsts_logo.png">
  <title>Login</title>
  <link rel="stylesheet" href="css/style_login_contact.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_accueil.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="css/style_profil.css" type="text/css" media="screen" />
</head>

<body>
  <!--#include file="include/header.inc"-->
  <div class="container">
    <form name="FormLogin" id="FormLogin" action="LoginAction.asp" method="post" target="_top">
      <h3>Veuillez vous connecter</h3>
      <input type="text" name="TLogin" id="TLogin" placeholder="login" value="<%=Session("Log")%>">
      <input type="password" name="TPasswd" id="TPasswd" placeholder="Password" value="<%=Session("Pas")%>">
      <%If (Len(Session("err")) > 0) Then %>
      <font color="red"><%=Session("err")%></font>
      <%End If%>
      <input type="button" name="BTConnexion" id="BTConnexion" value="Se Connecter" onclick="Verif()">
    </form>
  </div>
  <!--#include file="include/footer.inc"-->
</body>
<script src="js/login.js"></script>

</html>

<%
Session("Log") = ""
Session("Pas") = ""
Session("err") = ""

%>