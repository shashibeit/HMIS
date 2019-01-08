const monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];


var ServerURI = "http://localhost/HMIS_WEB/";

function isFloat(n) {
    return Number(n) === n && n % 1 !== 0;
}

function validateEmail(emailField) {
    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;

    if (reg.test(emailField.value) == false) {
        alert('Invalid Email Address');
        return false;
    }

    return true;

}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        return false;

    return true;
}   

function isDecimal(el,evt) {
    regexp = /^\d+(\.\d{1,2})?$/;

    console.log(el.value);

    //var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    //if (!regexp.test('10.5'))
    //    return false;


    return true;
  
}

function getAge(d1) {
   
    var d2 = new Date();   
    var diff = d2.getTime() - d1.getTime();
    //console.log(Math.floor(diff / (1000 * 60 * 60 * 24 * 365.25)));
    return Math.floor(diff / (1000 * 60 * 60 * 24 * 365.25));

    
}

function addMonths(date, count) {
    if (date && count) {
        var m, d = (date = new Date(+date)).getDate()

        date.setMonth(date.getMonth() + count, 1)
        m = date.getMonth()
        date.setDate(d)
        if (date.getMonth() !== m) date.setDate(0)
    }
    return date
}

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
};


function isFromBiggerThanTo(dtmfrom, dtmto) {
    return new Date(dtmfrom).getTime() >= new Date(dtmto).getTime();
}

function _getDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd;
    }
    if (mm < 10) {
        mm = '0' + mm;
    }
    return dd + '/' + mm + '/' + yyyy;
}

$(document).ready(function () {
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
});