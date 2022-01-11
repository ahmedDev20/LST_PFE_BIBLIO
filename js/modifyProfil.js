//récupérer les champs et les bouttons
let fields = document.querySelectorAll(
  "input[type='text'], input[type='date'], input[type='password']"
);
let modif = document.getElementById("modifier");
let annul = document.getElementById("annuler");
let valid = document.getElementById("valider");
let resetPsswd = document.getElementById("resetPd");
let fileImg = document.getElementById("file_img");
let lien = new URL(window.location.href);
let id = lien.searchParams.get("id");
let confPwd = document.getElementById("Tconf");
let confPwdInput = document.querySelector("#Tconf input");

console.log(fields);

modif.onclick = function modifier() {
  for (let fld of fields) {
    fld.style.background = "white";
    fld.style.border = "1px solid black";
    fld.style.paddingLeft = "3px";
    fld.readOnly = false;
  }

  confPwd.style.display = "table-row";
  resetPsswd.style.display = "none";
  modif.style.display = "none";
  valid.style.display = "inline-block";
  annul.style.display = "inline-block";

  confPwdInput.onkeyup = function () {
    if (confPwdInput.value !== "") {
      valid.style.opacity = "100%";
      valid.disabled = false;
    } else {
      valid.style.opacity = "30%";
      valid.disabled = true;
    }
  };

  valid.onclick = function () {
    document.getElementById("Profil").action = "ProfilAction.asp?id=" + id;
    document.getElementById("Profil").submit();
  };
  annul.onclick = function () {
    window.location.reload();
  };
};
