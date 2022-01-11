<!--#include file="include/security.asp"-->
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" href="img/fsts_logo.png">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Changer le mot de passe</title>
    <link rel="stylesheet" href="css/style_profil.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="css/style_menu.css">
    <link rel="stylesheet" href="css/style_mdp.css">
</head>

<body>
    <!-- #include file=include/menu.inc -->
    <div class="profile">
        <!--#include file="include/errorHandler.asp"-->
        <div class="resetTable">
            <form action="ChangerMdpAction.asp" method="post" id="chngPwd">
                <table id="resetTable" border="0">
                    <tr>
                        <td align="center" colspan="3">
                            <h6 id="msg">&#9888;La taille du mot de passe doit être supérieure à 8 caractères</h6>
                        </td>
                    </tr>
                    <tr>
                        <td>Saisir l'ancien mot de passe :</td>
                        <td colspan=2>
                            <input type="password" name="oldPwd" id="oldPwd" value="<%=Session("oldPas")%>" required />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="center">
                            <h6 id="msgOld"><%=Session("MsgOld")%></h6>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Saisir le nouveau mot de passe :</td>
                        <td>
                            <input type="password" onkeyup="checkPass()" name="newPwd" id="newPwd" required />
                        </td>
                        <td class="newPwd"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="center">
                            <h6 id="msgNew"></h6>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Confirmation du nouveau mot de passe :</td>
                        <td>
                            <input type="password" onkeyup="checkPass()" name="newPwd2" id="newPwd2" required />
                        </td>
                        <td class="newPwd2"></td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="edit">
            <input type="button" id="cancel" onclick="document.location = 'MonProfil.asp'" value="Annuler" />
            <input type="button" id="changer" form="chngPwd" disabled value="Changer" />
        </div>
    </div>
    <script>
        // validation du mot de passe
        function checkPass() {
            var input = event.target;
            var pass = input.value;
            var newPass = document.getElementById('newPwd');
            var newPass2 = document.getElementById('newPwd2');
            var span = document.querySelector('.' + input.id);
            var valid = (pass.length >= 8) ? true : false;
            if (valid) {
                input.style.border = '2px solid lightgreen';
                span.innerHTML = '&#10004;'
                span.style.color = 'lightgreen';
                input.checked = true;
            } else {
                input.style.border = '2px solid tomato';
                span.innerHTML = '&#10006;'
                span.style.color = 'tomato';
                input.checked = false;
            }

            var inputs = document.querySelectorAll('#newPwd, #newPwd2');
            if ((newPass.value != newPass2.value)) {
                document.getElementById('msgNew').innerHTML = 'Mots de passe ne sont pas identiques !';
                inputs[0].checked = inputs[1].checked = false;
            }
            else {
                document.getElementById('msgNew').innerHTML = '';
                inputs[0].checked = inputs[1].checked = true;
            }

            // si la validation est passee on active le button changer
            if (inputs[0].checked && inputs[1].checked) {
                document.getElementById('changer').disabled = false;
                document.getElementById('changer').style.opacity = '100%';
                document.getElementById('changer').onclick = function () {
                    document.forms[0].action = 'ChangerMdpAction.asp';
                    document.forms[0].submit();
                }
            }
            else
                document.getElementById('changer').disabled = true;
        }

        //style du page menu
        document.querySelector('.topnav a:first-child').className += 'active';
    </script>
</body>

</html>

<%
Session("msg") = ""
%>