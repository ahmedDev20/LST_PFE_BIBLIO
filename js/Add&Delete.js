//Declaration
var ajoutInputs = document.querySelectorAll("input, select");
var ajout = document.getElementById("ajouter");
var formTable = document.querySelector("#DataClientForm table");
var idClient = document.getElementById('IdClient');

//Gestion de navigation 
var lien = new URL(window.location.href);
var table = lien.searchParams.get("table");
var retourEmp = lien.searchParams.get("retourEmp");
var multiAbonn = lien.searchParams.get("multiAbonn");
var origin = lien.searchParams.get('page');
var prev = window.location.href.split('/').pop();

//inserer les donnees lorsque on tape sur la touche 'Entrer'
window.onkeypress = () => {
    if (event.keyCode === 13) {
        add();
    }
}


//si je clique valider l'operation
function operate() {
    window.CBchecked = document.querySelectorAll('tbody input[type=checkbox]:checked');
    //si aucune ligne n'est sélectionner
    if (window.CBchecked.length == 0) {
        alert("Veuillez Choisir au moins une ligne !");
    }
    else {
        let operation = document.getElementById('operations').value;
        if (operation == 'delete') {
            document.querySelector('#cbForm').action = 'TablesActions.asp?opera=delete&previous=' + prev;
            document.querySelector('#cbForm').submit();
        }
        else if (operation == 'enableAb')
            update(1);
        else if (operation == 'disableAb')
            update(0);
        else if (operation == 'EmpruntAb')
            empruntAb();
        else if (operation == 'RetourEx')
            retourEx();
        else if (operation == 'assocAbonn')
            assocAbonn();
    }
}

//si je clique ajouter
function add() {
    let champsVide = 0;
    for (let i = 0; i < ajoutInputs.length; i++) {
        if (ajoutInputs[i].value == '') {
            alert("Veuillez Remplir tous les champs !");
            ajoutInputs[i].focus();
            return;
        }
    }
    if (table == 'TLIVRES') {
        document.querySelector('#imgForm').action = 'UploadLivre.asp?previous=AjoutForm.asp?table=TLIVRES';
        document.querySelector('#imgForm').submit();
    }
    else {
        document.querySelector('#form').action = 'TablesActions.asp?opera=insert&table=' + table + '&retourEmp=' + retourEmp + '&multiAbonn=' + multiAbonn + '&previous=AjoutForm.asp?page=' + origin;
        document.querySelector('#form').submit();
    }
}

// modifier etat abonnement
function update(etat) {
    document.querySelector('#cbForm').action = 'TablesActions.asp?opera=update&etat=' + etat + '&previous=' + prev;
    document.querySelector('#cbForm').submit();
}
// modifier une offre
function updateOffre() {
    document.querySelector('#cbForm').action = 'TablesActions.asp?opera=update&table=TOFFRES&previous=OffresList.asp';
    document.querySelector('#cbForm').submit();
}

//Emprunter un exemplaire dans la origin des abonnements
function empruntAb() {
    let e = document.querySelector("tbody input[type=checkbox]:checked").value;
    if (window.CBchecked.length == 1) {
        document.querySelector('#cbForm').action = 'AjoutForm.asp?page=AbonnementsList.asp&table=TEMPRUNTS&value=' + e;
        document.querySelector('#cbForm').submit();
    }
    else
        alert("Vous devez choisir un et un seul client pour emprunter!")
}

//Retourner un exemplaire 
function retourEx() {
    if (window.CBchecked.length == 1) {
        document.querySelector('#cbForm').action = 'TablesActions.asp?opera=insert&previous=EmpruntsList.asp&table=TEMPRUNTS&retourEmp=true&emprOnly=true';
        document.querySelector('#cbForm').submit();
    }
    else
        alert("Veuillez choisir un abonnement au maximum !")
}

//Ajouter plusieurs abonnements
function assocAbonn() {
    var str = "";
    let e;
    for (e of window.CBchecked) {
        str += e.value + ' | ';
    }
    str = str.slice(0, -2);
    document.querySelector('#cbForm').action = 'AjoutForm.asp?origin=ClientsList.asp&table=TABONNEMENTS&multiAbonn=' + str;
    document.querySelector('#cbForm').submit();
}