function dropDown(id) {
    var d = document.getElementById(id);
    for (var i = 1; i<=10; i++) {
        if (document.getElementById('smenu'+i)) {
            document.getElementById('smenu'+i).style.display='none';
        }
    }
    if (d) {
        d.style.display='block';
   }
}

function collapse(id) {
    var d = document.getElementById(id);
    for (var i = 1; i<=10; i++) {
        if (document.getElementById('smenu'+i)) {
            document.getElementById('smenu'+i).style.display='none';
        }
    }
}
