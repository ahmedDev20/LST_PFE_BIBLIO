function VerifDate(str) {
	var TD = str.split('-');
	var j, m, a;
	var TM = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if ((TD.length != 3) || ((TD[2].length != 1) && (TD[2].length != 2)) || ((TD[1].length != 1) && (TD[1].length != 2)) || (TD[0].length != 4) || (!VerifNum(TD[0])) || (!VerifNum(TD[1])) || (!VerifNum(TD[2]))) {
		return false;
	}
	j = parseInt(TD[2], 10);
	m = parseInt(TD[1], 10);
	a = parseInt(TD[0], 10);
	if (a % 4 == 0)
		TM[2] = 29;
	if ((m < 1) || (m > 12)) {
		alert("Date invalide!");
		return false;
	}
	if ((j < 1) || (j > TM[m])) {
		alert("Date invalide!");
		return false;
	}
	return true;
}

function VerifNum(str) {
	var lg = str.length,
		i, car;

	if (lg == 0)
		return false;

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 48) || (car > 57)) {
			alert('NPI Invalide');
			return false;
		}
	}
	return true;
}

function VerifCin(str) {
	var lg = str.length,
		i, car;

	if (lg == 0)
		return false;

	str = str.toLowerCase();

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 48) || ((car > 57) && (car < 97)) || (car > 122)) {
			return false;
		}
	}

	return true;
}

function VerifTel(str) {
	var lg = str.length,
		i, car;

	if (lg == 0)
		return false;

	if ((str.indexOf('+') != -1) && ((str.indexOf('+') != 0) || (str.indexOf('+') != str.lastIndexOf('+'))))
		return false;

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if (((car != 32) && (car != 43) && (car < 48)) || (car > 57)) {
			alert("Telephone invalide!");
			return false;
		}
	}

	return true;
}

function VerifName(str) {
	var lg = str.length,
		i, car;

	if (lg == 0)
		return false;

	str = str.toLowerCase();

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if (((car != 32) && (car != 39) && (car != 45) && (car < 97)) || ((car > 122) && (car < 224)) || (car > 251)) {
			alert("Nom/Prenom invalide!");
			return false;
		}
	}

	return true;
}


function AllTrim(str) {
	while (str.indexOf('  ') != -1)
		str = str.replace(/  /g, ' ');

	if (str.indexOf(' ') == 0) {
		str = str.substr(1);
	}
	if (str.lastIndexOf(' ') == str.length - 1) {
		str = str.substr(0, str.length - 1);
	}
	return str;
}

function VerifAlpha(str) {
	var lg = str.length,
		i, car;

	if (lg == 0) {
		return false;
	}

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 65) || ((car > 90) && (car < 97)) || (car > 122)) {
			return false;
		}
	}
	return true;
}


function VerifAlphaNum(str) {
	var lg = str.length,
		i, car;

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 48) || ((car > 57) && (car < 65)) || ((car > 90) && (car < 97)) || (car > 122)) {
			alert("NPI invalide!");
			return false;
		}
	}
	return true;
}

function VerifAlias(str) {
	var lg = str.length,
		i, car;

	if (lg < 1)
		return false;

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 45) || ((car > 46) && (car < 48)) || ((car > 57) && (car < 65)) || ((car > 90) && (car < 95)) || ((car > 95) && (car < 97)) || (car > 122)) {
			alert("Alias invalide!");
			return false;
		}
	}

	car = str.charAt(0);
	if ((car == '.') || (car == '-') || (car == '_'))
		return false;
	car = str.charAt(lg - 1);
	if ((car == '.') || (car == '-') || (car == '_'))
		return false;

	return true;

}


function VerifDomaine(str) {
	var lg = str.length,
		i, car;

	if (lg < 2)
		return false;

	for (i = 0; i < lg; i++) {
		car = str.charCodeAt(i);

		if ((car < 45) || ((car > 45) && (car < 48)) || ((car > 57) && (car < 65)) || ((car > 90) && (car < 97)) || (car > 122)) {
			return false;
		}
	}

	car = str.charAt(0);
	if (car == '-')
		return false;
	car = str.charAt(lg - 1);
	if (car == '-')
		return false;

	return true;

}

function VerifExtension(str) {
	var lg = str.length;

	if ((lg < 2) || !VerifAlpha(str)) {
		return false;
	}
	return true;
}

function VerifSousExtension(str) {
	var lg = str.length;

	if ((lg < 2) || !VerifAlpha(str))
		return false;
	return true;
}

function VerifEmail(email) {
	var tab = email.split('@');
	var lg = tab.length;

	if (lg != 2) {
		return false;
	}
	if (!VerifAlias(tab[0])) {
		return false;
	}
	tab = tab[1];
	tab = tab.split('.');
	lg = tab.length;
	if ((lg != 2) && (lg != 3)) {
		alert("Email invalide!");
		return false;
	}
	if (!VerifDomaine(tab[0])) {
		alert("Email invalide!");
		return false;
	}
	if (lg == 2) {
		if (!VerifExtension(tab[1])) {
			alert("Email invalide!");
			return false;
		}

	} else {
		if (!VerifSousExtension(tab[1]) || !VerifExtension(tab[2])) {
			alert("Email invalide!");
			return false;
		}
	}
	return true;
}

function EmailChar() {
	var char = window.event.keyCode;

	if (((char == 45) || (char == 46) || (char == 64) || (char == 95) || ((char >= 48) && (char <= 57)) || ((char >= 65) && (char <= 90)) || ((char >= 97) && (char <= 122))) != true)
		window.event.returnValue = false;
}


function NumChar() {
	var char = window.event.keyCode;

	if (((char < 48) && (char != 32) && (char != 43)) || (char > 57))
		window.event.returnValue = false;
}

function FormatText(msg) {
	var ch = msg,
		car, cc, s = '',
		pos, taille = ch.length;

	for (pos = 0; pos < taille; pos++) {
		car = ch.charAt(pos);
		cc = ch.charCodeAt(pos);
		if (cc == 10)
			s = s + '<br>';
		else if (car == '<')
			s = s + '&lt;';
		else
			s = s + car;
	}

	return s;
}

function validateCardNumber(number) {
	number = number.replace(/\s/g, '');
	var regex = new RegExp("^[0-9]{13,16}$");
	if (!regex.test(number)) {
		alert("Numéro de carte : syntaxe invalide!");
		return false;
	}
	if (luhnCheck(number))
		return true;
	else {
		alert("Numéro de carte invalide!");
		return false;
	}
}

function isExpireDate(str) {
	re = /^(0[1-9]|1[0-2])\/?([0-9]{2})$/;
	var regex = new RegExp(re);
	if (!regex.test(str)) {
		alert("Verifiez le format de date d'expiration!!");
		return false;
	}
	return true;
}

function isCvv(str) {
	var regex = new RegExp("^[0-9]{3}$");
	if (!regex.test(str)) {
		alert("CVV invalide!");
		return false;
	}
	return true;
}

function luhnCheck(val) {
	var sum = 0;
	for (var i = 0; i < val.length; i++) {
		var intVal = parseInt(val.substr(i, 1));
		if (i % 2 == 0) {
			intVal *= 2;
			if (intVal > 9) {
				intVal = 1 + (intVal % 10);
			}
		}
		sum += intVal;
	}
	return (sum % 10) == 0;
}