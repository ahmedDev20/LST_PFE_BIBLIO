<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
 offre = Request.QueryString("offre")
 If Request.QueryString("expired") = "true" then
    Session("sign_up") = "Le code est éxpiré !<br> Veuillez ressayer"
    Session("id") = ""
End If
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="img/fsts_logo.png" />
    <link rel="stylesheet" href="css/style_inscription.css">
    <link rel="stylesheet" href="css/style_accueil.css">
</head>

<body>
    <!--#include file="include/header.inc"-->
    <% If LEN(Session("sign_up")) <> 0 Then %>
        <div class="alert">
            <span class="closebtn"
                onclick="this.parentElement.style.opacity = '0';setTimeout(function(){document.querySelector('.alert').style.display = 'none'; }, 1000);">&times;
            </span>
            <h4>
                <%=Session("sign_up")%>
            </h4>
            <% If Left(Session("sign_up"),1) = "V" Then %>
                <a href="Login.asp"><button id="login">S'identifier</button></a>
            <% End If %>
            <% Session("sign_up") = "" %>
        </div>
    <% End If %>
    <form method="POST" action="">
        <div class="container0">
        <div class="sending" id="sending" style="display:none;">
            <img src="./img/sending.gif" alt="sending" style="position:absolute;left:50%, top:50%;z-index:1;height:100%;width:100%;">
        </div>
            <div class="container1">
                <h3 class="etapes">Etape 1 Sur 2<br>Selectionnez le forfait qui vous convient.</h3>
                <div class="row">
                    <div class="col-25">
                        <label for="offre">Offre</label>
                    </div>
                    <div class="col-75">
                        <select name="data[]" id="offre">
                            <option value="1" <% If offre = "BASIQUE" Then %> Selected <% End If %>>BASIQUE</option>
                            <option value="2" <% If offre = "PREMIUM" Then %> Selected <% End If %>>PREMIUM</option>
                            <option value="3" <% If offre = "LUXE"    Then %> Selected <% End If %>>LUXE</option>
                        </select>
                        <span style="font-size: small;">Plus de détails sur les offres cliquez <a
                                href="Accueil.asp/#list-offres">ici</a> </span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="fname">Nom</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="fname" name="data[]" value="<%=Session("data2")%>" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="lname">Prenom</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="lname" name="data[]" value="<%=Session("data3")%>" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="email">Email</label>
                    </div>
                    <div class="col-75">
                        <input type="email" id="email" name="data[]" value="<%=Session("data4")%>" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="tel">Telephone</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="tel" name="data[]" maxlength="10" value="<%=Session("data5")%>"
                            pattern="^[0-9]{10}$"  placeholder="XX XX XX XX XX">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="numcarte">Numéro de carte bancaire</label>
                    </div>
                    <div class="col-75">
                        <input id="numcarte" name="data[]" type="text" minlength="12" maxlength="20" pattern="\d[0-9]+"
                             placeholder="XXXX XXXX XXXX XXXX" value="<%=Session("data6")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="date-expire">Date d'éxpiration</label>
                    </div>
                    <div class="col-75">
                        <input id="date-expire" name="data[]" type="text" minlength="5" maxlength="5"
                            placeholder="MM/AA" pattern="[0-9]{2}/[0-9]{2}"  value="<%=Session("data7")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="cvv">Code de securité</label>
                    </div>
                    <div class="col-75">
                        <input id="cvv" name="data[]" type="text" placeholder="CVV" maxlength="3" pattern="[0-9]{3}"
                             value="<%=Session("data8")%>">
                    </div>
                </div>
                <div class="row">
                    <button type="button" id="continuer" onclick="verifEtape1();">Continuer</button>
                </div>
            </div>
            <div class="container2">
                <h3 class="etapes">Etape 2 sur 2<br>Complétez vos informations.</h3>
                <div class="row">
                    <div class="col-25">
                        <label for="datenaiss">Date Naissance</label>
                    </div>
                    <div class="col-75">
                        <input id="datenaiss" name="data[]" type="date" value="<%=Session("data9")%>" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="genre">Sexe </label>
                    </div>
                    <div class="col-75">
                        <select name="data[]" id="sexe">
                            <option value="Homme">Homme</option>
                            <option value="Femme">Femme</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="pays">Pays</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="pays" name="data[]"  value="<%=Session("data11")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="ville">Ville</label>
                    </div>
                    <div class="col-75">
                        <input id="ville" name="data[]" type="text"  value="<%=Session("data12")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="adresse">Adresse</label>
                    </div>
                    <div class="col-75">
                        <input id="adresse" name="data[]" type="text"  value="<%=Session("data13")%>">
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col-25">
                        <label for="npi">NPI</label>
                    </div>
                    <div class="col-75">
                        <input id="npi" name="data[]" type="text" maxlength="10" value="<%=Session("data14")%>" 
                            pattern="[a-zA-Z-9 ]{5}">
                    </div>
                </div>
                <div class=" row">
                    <div class="col-25">
                        <label for="codepost">Code Postal</label>
                    </div>
                    <div class="col-75">
                        <input id="codepost" name="data[]" type="tel" maxlength="5" value="<%=Session("data15")%>"
                             pattern="[0-9]{5}">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="mdp1">Mot de passe</label>
                    </div>
                    <div class="col-75">
                        <input id="mdp1" name="data[]" type="password" minlength="8" 
                            placeholder="Plus que 8 caractères" onkeyup="checkPass()" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-75">
                        <span id="msgNew"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="mdp2">Confirmation mot de passe</label>
                    </div>
                    <div class="col-75">
                        <input id="mdp2" name="data[]" type="password" minlength="8" 
                            placeholder="Plus que 8 caractères" onkeyup="checkPass()" >
                    </div>
                </div>
                <div class="row">
                    <button type="button" id="valider" onclick="verifEtape2()">Valider</button>
                    <button type="button" id="retour">Retour</button>
                </div>
            </div>
        </div>
    </form>
    <!--#include file="include/footer.inc"-->
    <script>
        var mail = document.getElementById("email");
        var nom = document.getElementById("fname");
        var prenom = document.getElementById("lname");
        var tele = document.getElementById("tel");
        var carte = document.getElementById("numcarte");
        var dateexpr = document.getElementById("date-expire");
        var cvv = document.getElementById("cvv");
        var pays = document.getElementById("pays");
        var ville = document.getElementById("ville");
        var adresse = document.getElementById("adresse");
        var datenaiss = document.getElementById("datenaiss");
        var genre = document.querySelector("select");
        var npi = document.getElementById("npi");
        var codepost = document.getElementById("codepost");
        var mdp1 = document.getElementById("mdp1");
        var mdp2 = document.getElementById("mdp2");

        var inputs = document.querySelectorAll(".container1 input");
        var continuer = document.querySelector(".row #continuer");
        var retour = document.querySelector("#retour");
        var c1 = document.querySelector(".container1");
        var c2 = document.querySelector(".container2");

        retour.onclick = () => {
            c1.style.left = "0";
            c2.style.left = "100%";
        }

        // Validation mot de passse
        function checkPass() {
            var input = event.target;
            var pass = input.value;
            var span = document.getElementById('msgNew');
            var newPass = document.getElementById('mdp1');
            var newPass2 = document.getElementById('mdp2');
            var inputs1 = document.querySelectorAll('#mdp1, #mdp2');
            var valid = (pass.length >= 8) ? true : false;
            if (valid) {
                input.style.border = '2px solid lightgreen';
                input.checked = true;
            } else {
                input.style.border = '2px solid tomato';
                input.checked = false;
            }

            if ((newPass.value != newPass2.value)) {
                span.innerHTML = '&#9888; Mots de passe ne sont pas identiques !';
                inputs1[0].checked = inputs1[1].checked = false;
            } else if (newPass.value.length < 8) {
                span.innerHTML = '&#9888; Mots de passe très faible!';
                inputs1[0].checked = inputs1[1].checked = false;
            } else {
                span.innerHTML = '';
                inputs1[0].checked = inputs1[1].checked = true;
            }

            // si la validation est passee on active le button valider
            if (inputs1[0].checked && inputs1[1].checked) {
                document.getElementById('valider').disabled = false;
                document.getElementById('valider').style.opacity = '100%';
            } else {
                document.getElementById('valider').disabled = true;
                document.getElementById('valider').style.opacity = '30%';
            }
        }
        // verification des donnes
        function verifEtape1() {
            var inputs = document.querySelectorAll(".container1 input");
            if (areEmpty(inputs)) {
                if (VerifName(nom.value) && VerifName(prenom.value) && VerifEmail(mail.value) && VerifTel(tele.value) &&
                    validateCardNumber(carte.value) && isExpireDate(dateexpr.value) && isCvv(cvv.value)) {
                    c1.style.left = "-100%";
                    c2.style.left = "0";
                } else {
                    return;
                }
            }

        }
        function verifEtape2() {
            var inputs = document.querySelectorAll(".container2 input");
            if (areEmpty(inputs)) {
                if (VerifAlpha(pays.value) && VerifAlpha(ville.value) && VerifDate(datenaiss.value) && VerifAlphaNum(npi.value) && VerifNum(codepost.value) && (mdp1.value == mdp2.value)) {
                    document.forms[0].action = "inscriptionAction.asp";
                    document.forms[0].submit();
                    document.getElementById('sending').style.display = "";
                } else {
                    alert("Veuillez vérifier les informations saisis!");
                    return;
                }
            }
        }

        // Verfiier si un des champs est vide
        function areEmpty(arr) {
            for (let i = 0; i < arr.length; i++) {
                if (arr[i].value.length == 0) {
                    alert("Veuillez remplir tous les champs!");
                    arr[i].focus();
                    return false;
                }
            }
            return true;
        }
    </script>
    <script src="js/form_validation.js"></script>
</body>

</html>

<% 
Session("erreur") = ""
Session("msg") = ""
Session("sign_up") =""
%>