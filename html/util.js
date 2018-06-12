/* vim: set shiftwidth=4 tabstop=2 expandtab: */

String.prototype.hashCode = function() {
    var hash = 0, i, chr;
    if (this.length === 0) return hash;
    for (i = 0; i < this.length; i++) {
        chr   = this.charCodeAt(i);
        hash  = ((hash << 5) - hash) + chr;
        hash |= 0; // Convert to 32bit integer
    }
    return hash;
};

function hasString(txt_hashes, str) {
    var hash = str.hashCode();
    for (var i = 0; i < txt_hashes.length; i++) {
        if (parseInt(txt_hashes[i]) === hash)
            return true;
    }

    return false;
}

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function loadNumberArray(name) {
    var a = [];
    var c = getCookie(name);
    if (c !== "")
        a = c.split(',');

    return a;
}

function saveNumberArray(array, name) {
    setCookie(name, array.join(','), 365);
}

function pushOrShiftArray(array, newValue) {
    for (var i = 1; i < array.length; i++)
        array[i - 1] = array[i];

    if (array.length >= 10)
        array[array.length - 1] = newValue;
    else
        array.push(newValue);

    return array;
}

function averageNumberArray(array) {
    var sum = 0.0;
    for (var i = 0; i < array.length; i++) {
        var one = parseFloat(array[i]);
        if (one === NaN)
            one = 0.0;
        sum += one;
        //console.log("array[" + i + "] = " + array[i]);
    }
    sum /= array.length;
    return sum;
}

function loadExercises(responseAction) {
    var client = new XMLHttpRequest();
    client.open('GET', "0_Exercises.txt");
    client.onreadystatechange = function() {
        if (client.readyState != client.DONE)
            return;
        if (client.status == 200) {
            responseAction(client.responseText.split('\n'));
        } else {
            document.getElementById('errordiv').innerHTML = client.responseText;
        }
    }
    client.send();
}
