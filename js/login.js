
window.addEventListener('keyup', function (event) {
    // Number 13 is the "Enter" key on the keyboard
    if (event.keyCode === 13) {
        // Trigger the button element with a click
        document.getElementById("BTConnexion").click();
    }
});
function Verif() {
    var login = document.getElementById('TLogin');
    var passwd = document.getElementById('TPasswd');
    if (login.value.length == 0) {
        alert('Veuillez saisir le login');
        login.focus();
        return;
    }
    if (passwd.value.length == 0) {
        alert('Veuillez saisir le mot de passe');
        passwd.focus();
        return;
    }
    document.getElementById('FormLogin').submit();
}
