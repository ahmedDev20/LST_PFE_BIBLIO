<% If Session("id") <> Session.SessionId Then 
Session("err") = "Veuillez vous identifier" 
Response.redirect "./Login.asp"
End If %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
    />
    <link rel="icon" href="img/fsts_logo.png" />
    <title>Verification</title>
  </head>

  <body>
    <div>
      <img
        src="./img/patrick-tomasso-Oaqk7qqNh_c-unsplash.jpg"
        alt="bg"
        style="
          z-index: -1;
          width: 100%;
          height: 100%;
          position: absolute;
          top: 0;
          left: 0;
          filter: blur(2px);
        "
      />
    </div>
    <div
      class="container d-flex justify-content-center align-items-center"
      style="height: 100vh;"
    >
      <div class="card bg-light mb-3" style="max-width: 22rem;">
        <form method="POST" onsubmit="validerCode(event)">
          <div class="card-header text-center">
            <img
              class="card-img-top"
              src="./img/fsts_logo.png"
              alt="FST SETTAT"
              style="width: 100px;"
            />
          </div>
          <div class="card-body text-center">
            <h5 class="card-title">
              Verification d'inscription
              <p>
                (Vous avez
                <span id="chances" class="badge badge-warning">3</span> chances)
              </p>
            </h5>
            <p class="card-text">
              Veuillez saisir le code envoyé par e-mail à l'adresse <b><% =Session("data4") %></b>
            </p>
            <input type="text" class="form-control" name="code" id="code" />
            <small id="passwordHelpBlock" class="form-text text-muted">
              Le code doit être égale à 6 caractères.
            </small>
            <br />
            <a
              href="Inscription.asp?expired=true"
              id="annuler"
              class="btn btn-secondary mt-2 mr-3"
            >
              Annuler
            </a>
            <button id="valider" class="btn btn-success mt-2" disabled>
              Valider
            </button>
          </div>
        </form>
      </div>
    </div>

    <script type="text/javascript">
      let code = document.getElementById("code");
      let span = document.getElementById("chances");
      let annuler = document.getElementById("annuler");

      // stocker le nombre des chances dans le stock du navigateur
      let chances = JSON.parse(sessionStorage.getItem("chances"));
      if (!chances) sessionStorage.setItem("chances", JSON.stringify("3"));
      span.innerText = JSON.parse(sessionStorage.getItem("chances"));

      code.addEventListener("keyup", ({ target: input }) => {
        valider.disabled = input.value.length !== 6;
      });

      function validerCode(event) {
        const { target: form } = event;
        event.preventDefault();
        chances = JSON.parse(sessionStorage.getItem("chances"));
        // Recuperer le nombre de chances dapres le stockage du navigateur
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
          if (this.readyState == 4 && this.status == 200) {
            correctHash = '<% =Session("HASH") %>';
            if (this.responseText === correctHash) {
              form.action = "verifCodeAction.asp";
              form.submit();
            } else {
              chances = chances - 1;
              if (chances <= 0 || chances > 3) {
                document.location = "Inscription.asp?expired=true";
              }
              sessionStorage.setItem("chances", JSON.stringify(chances));
              chances = JSON.parse(sessionStorage.getItem("chances"));
              span.innerText = chances;
              code.value = "";
            }
          }
        };
        xmlhttp.open("POST", "verifCodeAction.asp?AJAX=true", true);
        xmlhttp.setRequestHeader(
          "Content-type",
          "application/x-www-form-urlencoded"
        );
        xmlhttp.send("verif=" + code.value);
      }
    </script>
  </body>
</html>
