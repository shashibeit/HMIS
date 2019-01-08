var Gender = null;


$(document).ready(function () {

    showPatientDetails();

    $('.timepicker').timepicker({
        showInputs: false
    });

    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {

        if (stepNumber === 0) {
            _getBastiDetails();
            return true;
        }
        if (stepNumber === 1) {

            if (_saveBastiPurvaKarmaDetails()) {
                _getUttarBastiDetails();
            }
            return true;
        }
        if (stepNumber === 2) {
            _saveUttarBastiDetails();
            return true;
        }
        //  if (stepNumber === 3) {
        //    if (_saveMedicineDetails()) {
        //        return true;
        //    }
        //    else {
        //        return false;
        //    }
        //}
    });



    $("#btnAddRows").click(function () {
        var Bastidays = 8;


        if ($("#txtBastiDays").val() != "") {
            Bastidays = $("#txtBastiDays").val();
        }

        var rowsinTable = 0;
        if (parseInt($('#BastiTable tbody tr').length) <= 0) {
            rowsinTable = 1;
        }
        else {
            rowsinTable = parseInt($('#BastiTable tbody tr').length) + 1;
        }


        var noofdays = 0;
        for (var i = 1; i <= Bastidays; i++) {

            var tableRow = "<tr class=' row_" + rowsinTable + "'>";
            tableRow += "<td class='srno' idx=" + rowsinTable + ">" + rowsinTable + ".</td>";
            tableRow += "<td>" + GenerateBastiDates(rowsinTable, "Bastidate") + "</td>";
            tableRow += "<td><div class='bootstrap-timepicker'>"
                + "<div class='input-group'>"
                + "<input id='txtDatta_" + rowsinTable + "' type='text' class='txtDatta form-control timepicker input-sm'>"
                + "</div>"
                + "</div></td>";
            tableRow += "<td><input id='txtPratyaGaman_" + rowsinTable + "' type='text' class='txtPratyaGaman input-sm form-control'/></td>";
            tableRow += "<td>" + GenerateOilorGheeDD(rowsinTable, 'ddlOilorGhee') + "</td>";
            tableRow += "<td>" + GenerateGheeOilDD(rowsinTable, 'ddlGheeOil') + "</td>";
            tableRow += "<td><input id='txtDosa_" + rowsinTable + "' type='text' onkeypress='javascript: return isNumber(event)' class='txtDosa input-sm form-control'/></td>";
            tableRow += "<td>" + GenerateMassageDD(rowsinTable, 'ddlMassageYesNo') + "</td>";
            tableRow += "<td>" + GenerateMassageOil(rowsinTable, 'ddlMassageOil') + "</td>";
            tableRow += "<td><input id='txtsymptoms_" + rowsinTable + "' type='text' class='txtsymptoms input-sm form-control'/></td>";
            tableRow += "</tr>";

            if (parseInt($('#BastiTable tbody tr').length) <= 0) {
                noofdays = 1;
            }
            else {
                noofdays = noofdays + 2;
            }
            var Bastidate = new Date();
            Bastidate.setDate(Bastidate.getDate() + noofdays);

            $("#BastiTable tbody").append(tableRow);

            $('#Bastidate_' + rowsinTable).datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
            }).datepicker('setDate', Bastidate);

            rowsinTable++;
        }
        $('.selectpicker').selectpicker();

        $('.timepicker').timepicker({
            showInputs: false
        });
    });

    $("#btnAddUttarBastiRows").click(function () {
        var Bastidays = 6;

        if ($("#txtUttarBastiDays").val() != "") {
            Bastidays = $("#txtUttarBastiDays").val();
        }
        var rowsinTable = 0;

        if (parseInt($('#UttarBastiTable tbody tr').length) <= 0) {
            rowsinTable = 1;
        }
        else {
            rowsinTable = parseInt($('#UttarBastiTable tbody tr').length) + 1;
        }


        var noofdays = 0;
        for (var i = 1; i <= Bastidays; i++) {

            if (parseInt($('#UttarBastiTable tbody tr').length) <= 0) {
                noofdays = 1;
            }
            else {
                noofdays = noofdays + 1;
            }

            if (Gender == "Female") {
                if (parseInt(rowsinTable) % 3 === 0) {
                    noofdays = noofdays + 3;
                }
            }

            var Bastidate = new Date();
            Bastidate.setDate(Bastidate.getDate() + noofdays);

            var tableRow = "<tr class=' row_" + rowsinTable + "'>";
            tableRow += "<td class='srno' idx=" + rowsinTable + ">" + rowsinTable + ".</td>";
            tableRow += "<td>" + GenerateBastiDates(rowsinTable, "UttarBastidate") + "</td>";
            tableRow += "<td><div class='bootstrap-timepicker'>"
                + "<div class='input-group'>"
                + "<input id='txtUttarBastiDatta_" + rowsinTable + "' type='text' class='txtUttarBastiDatta form-control timepicker input-sm'>"
                + "</div>"
                + "</div></td>";
            tableRow += "<td><input id='txtUttarBastiPratyaGaman_" + rowsinTable + "' type='text' class='txtUttarBastiPratyaGaman input-sm form-control'/></td>";
            tableRow += "<td>" + GenerateOilorGheeDD(rowsinTable, 'ddlUttarBastiOilorGhee') + "</td>";
            tableRow += "<td>" + GenerateGheeOilDD(rowsinTable, 'ddlUttarBastiGheeOil') + "</td>";
            tableRow += "<td><input id='txtUttarBastiDosa_" + rowsinTable + "' onkeypress='javascript: return isNumber(event)' type='text' class='txtUttarBastiDosa input-sm form-control'/></td>";
            tableRow += "<td>" + GenerateMassageDD(rowsinTable, 'ddlUttarBastiMassageYesNo') + "</td>";
            tableRow += "<td>" + GenerateMassageOil(rowsinTable, 'ddlUttarBastiMassageOil') + "</td>";

            tableRow += "<td><input id='txtUttarBastisymptoms_" + rowsinTable + "' type='text' class='txtUttarBastisymptoms input-sm form-control'/></td>";
            tableRow += "</tr>";

            $("#UttarBastiTable tbody").append(tableRow);

            $('#UttarBastidate_' + rowsinTable).datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
            }).datepicker('setDate', Bastidate);

            rowsinTable++;
        }
        $('.selectpicker').selectpicker();

        $('.timepicker').timepicker({
            showInputs: false
        });

        changeTableClass();
    });

    $("#btnNewCase").click(function () {
        window.location.href = ServerURI + "Case/Create";
        return false;
    });

});

$(function () {
    $('.datepicker').datepicker({
        autoclose: true,
        format: 'dd/mm/yyyy',
    }).datepicker('setDate', _getDate());
});

$(document).on('change', '.ddlOilorGhee', function () {
    var data = null;

    var id = $(this).attr("idx");
    var elm = "#ddlGheeOil_" + id;
    if ($(this).val() == "तेल") {
        data = getOilDetails("BASTI");
    } else if ($(this).val() == "तुप") {
        data = getGheeDetails();
    }
    else if ($(this).val() == "चूर्ण") {
        data = getChurnaDetails();
    }
    else {
        $(elm).empty().selectpicker('refresh');
    }
    $(elm).empty().selectpicker('refresh');

    $(data).each(function (idx, val) {
        $(elm).append('<option value="' + val + '">' + val + '</option>');
    });

    $(elm).selectpicker('refresh');
});

$(document).on('change', '.ddlUttarBastiOilorGhee', function () {
    var data = null;
    var id = $(this).attr("idx");
    var elm = "#ddlUttarBastiGheeOil_" + id;
    if ($(this).val() == "तेल") {
        data = getOilDetails("BASTI");
    } else if ($(this).val() == "तुप") {
        data = getGheeDetails();
    }
    else if ($(this).val() == "चूर्ण") {
        data = getChurnaDetails();
    }
    else {
        $(elm).empty().selectpicker('refresh');
    }
    $(elm).empty().selectpicker('refresh');

    $(data).each(function (idx, val) {
        $(elm).append('<option value="' + val + '">' + val + '</option>');
    });

    $(elm).selectpicker('refresh');
});

$(document).on('change', '.ddlMassageYesNo', function () {
    var data = null;
    var id = $(this).attr("idx");
    var elm = "#ddlMassageOil_" + id;
    if ($(this).val() == "होय") {
        data = getOilDetails("MASSAGE");
        $(elm).empty().selectpicker('refresh');

        $(data).each(function (idx, val) {
            $(elm).append('<option value="' + val + '">' + val + '</option>');
        });

        $(elm).selectpicker('refresh');
    }
    else {
        $(elm).empty().selectpicker('refresh');
    }
});

$(document).on('change', '.ddlUttarBastiMassageYesNo', function () {
    var data = null;
    var id = $(this).attr("idx");
    var elm = "#ddlUttarBastiMassageOil_" + id;
    if ($(this).val() == "होय") {
        data = getOilDetails("MASSAGE");
        $(elm).empty().selectpicker('refresh');

        $(data).each(function (idx, val) {
            $(elm).append('<option value="' + val + '">' + val + '</option>');
        });

        $(elm).selectpicker('refresh');
    }
    else {
        $(elm).empty().selectpicker('refresh');
    }
});


Array.prototype.except = function (val) {
    return this.filter(function (x) { return x !== val; });
};

var TempData = [];

function changeTableClass() {
    var tblClass = "";
    var n = 3;
    $('#UttarBastiTable > tbody > tr').each(function (i) {
        if (i === 0) {
            tblClass = "";
        }
        else {
            if (i % n === 0) tblClass = "change";
        }
        tblClass == "change" ? $(this).addClass("success") : $(this).addClass("danger");

    });

}

function getGheeDetails() {
    var GheeDetail = {};
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetGheeDetails",
        data: { "type": "BASTI" },
        dataType: "json",
        async: false,
        success: function (data) {

            GheeDetail = data;

        }
    });

    return GheeDetail;
}

function getChurnaDetails() {
    var ChurnaDetail = {};
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetMedicineByType",
        data: { "Type": "CHURNA", "MedicineFor": "PANCHAKARMA", "MedicineTypeFor": "BASTI" },
        dataType: "json",
        async: false,
        success: function (data) {

            ChurnaDetail = data;

        }
    });

    return ChurnaDetail;
}

function getOilDetails(type) {
    var OilDetail = {};
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetOilDetails",
        data: { "type": type },
        dataType: "json",
        async: false,
        success: function (data) {
            OilDetail = data;
        }
    });

    return OilDetail;
}

function showPatientDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");

    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetPatientDetails",
        data: { "Patient_ID": PatinetId },
        dataType: "json",
        async: false,
        success: function (data) {
            $("#txtPatientId").val(PatinetId);
            $("#txtCaseID").val(CaseID);
            $("#txtPatientName").val(data.PatientName);
            $("#txtAddress").val(data.Address);
            $("#txtCity").val(data.City);
            $("#txtPin").val(data.Pin);
            $("#txtMobileNo").val(data.MobileNo);
            Gender = data.Gender;
            if (data.Gender == "Male") {

                $(".form-group-txtMenstrualDate").hide();
            }
            else {
                $(".form-group-txtMenstrualDate").show();
            }

        }
    });
}

function _getBastiDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetBastiDetails",
        data: { "CaseID": CaseID },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                var rowsinTable = 1;
                var noofdays = 0;
                $("#BastiTable tbody").empty();
                $(data).each(function (idx, value) {
                    RowNo = value.SrNo;

                    var tableRow = "<tr class=' row_" + RowNo + "'>";
                    tableRow += "<td class='srno' idx=" + RowNo + ">" + RowNo + ".</td>";
                    tableRow += "<td>" + GenerateBastiDates(RowNo, "Bastidate") + "</td>";
                    tableRow += "<td><div class='bootstrap-timepicker'><div class='input-group'><input id='txtDatta_" + RowNo + "' type='text' class='txtDatta form-control timepicker input-sm'></div></div></td>";
                    tableRow += "<td><input id='txtPratyaGaman_" + RowNo + "' type='text' class='txtPratyaGaman input-sm form-control'/></td>";
                    tableRow += "<td>" + GenerateOilorGheeDD(RowNo, 'ddlOilorGhee') + "</td>";
                    tableRow += "<td>" + GenerateGheeOilDD(RowNo, 'ddlGheeOil') + "</td>";
                    tableRow += "<td><input id='txtDosa_" + RowNo + "' onkeypress='javascript: return isNumber(event)' type='text' class='txtDosa input-sm form-control'/></td>";
                    tableRow += "<td>" + GenerateMassageDD(RowNo, 'ddlMassageYesNo') + "</td>";
                    tableRow += "<td>" + GenerateMassageOil(RowNo, 'ddlMassageOil') + "</td>";
                    tableRow += "<td><input id='txtsymptoms_" + RowNo + "' type='text' class='txtsymptoms input-sm form-control'/></td>";
                    tableRow += "</tr>";


                    $("#BastiTable tbody").append(tableRow);

                    $('#Bastidate_' + RowNo).datepicker({
                        autoclose: true,
                        format: 'dd/mm/yyyy',
                    }).datepicker('setDate', value.Date);



                    $("#ddlOilorGhee_" + RowNo).val(value.Oil_Ghee).trigger('change');
                    $("#ddlGheeOil_" + RowNo).selectpicker();

                    $("#txtDatta_" + RowNo).val(value.Datta);
                    $("#txtPratyaGaman_" + RowNo).val(value.Datta)

                    $("#ddlGheeOil_" + RowNo).selectpicker('val', value.Oil_Ghee_Name);
                    $("#txtDosa_" + RowNo).val(value.Dosa);
                    $("#ddlMassageYesNo_" + RowNo).val(value.Massage).trigger('change');;
                    $("#ddlMassageOil_" + RowNo).selectpicker();
                    if (value.Massage_Oil != "") {
                        $("#ddlMassageOil_" + RowNo).selectpicker('val', value.Massage_Oil);
                    }
                    $("#txtsymptoms_" + RowNo).val(value.Symptoms);


                });

                $('.txtDatta').timepicker({
                    showInputs: false
                });
            }
            else {
                $("#BastiTable tbody").empty();
                $("#btnAddRows").trigger("click");
            }
        }
    });
}

function _getUttarBastiDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetUttarBastiDetails",
        data: { "CaseID": CaseID },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                var rowsinTable = 1;
                var noofdays = 0;
                $("#UttarBastiTable tbody").empty();
                $(data).each(function (idx, value) {
                    RowNo = value.SrNo;

                    var tableRow = "<tr class=' row_" + RowNo + "'>";
                    tableRow += "<td class='srno' idx=" + RowNo + ">" + RowNo + ".</td>";
                    tableRow += "<td>" + GenerateBastiDates(RowNo, "UttarBastidate") + "</td>";
                    tableRow += "<td><div class='bootstrap-timepicker'><div class='input-group'><input id='txtUttarBastiDatta_" + RowNo + "' type='text' class='txtUttarBastiDatta form-control timepicker input-sm'></div></div></td>";
                    tableRow += "<td><input id='txtUttarBastiPratyaGaman_" + RowNo + "' type='text' class='txtUttarBastiPratyaGaman input-sm form-control'/></td>";
                    tableRow += "<td>" + GenerateOilorGheeDD(RowNo, 'ddlUttarBastiOilorGhee') + "</td>";
                    tableRow += "<td>" + GenerateGheeOilDD(RowNo, 'ddlUttarBastiGheeOil') + "</td>";
                    tableRow += "<td><input id='txtUttarBastiDosa_" + RowNo + "' onkeypress='javascript: return isNumber(event)' type='text' class='txtUttarBastiDosa input-sm form-control'/></td>";
                    tableRow += "<td>" + GenerateMassageDD(RowNo, 'ddlUttarBastiMassageYesNo') + "</td>";
                    tableRow += "<td>" + GenerateMassageOil(RowNo, 'ddlUttarBastiMassageOil') + "</td>";
                    tableRow += "<td><input id='txtUttarBastisymptoms_" + RowNo + "' type='text' class='txtUttarBastisymptoms input-sm form-control'/></td>";
                    tableRow += "</tr>";


                    $("#UttarBastiTable tbody").append(tableRow);

                    $('#UttarBastidate_' + RowNo).datepicker({
                        autoclose: true,
                        format: 'dd/mm/yyyy',
                    }).datepicker('setDate', value.Date);



                    $("#ddlUttarBastiOilorGhee_" + RowNo).val(value.Oil_Ghee).trigger('change');
                    $("#ddlUttarBastiGheeOil_" + RowNo).selectpicker();

                    $("#txtUttarBastiDatta_" + RowNo).val(value.Datta);
                    $("#txtUttarBastiPratyaGaman_" + RowNo).val(value.Datta)

                    $("#ddlUttarBastiGheeOil_" + RowNo).selectpicker('val', value.Oil_Ghee_Name);
                    $("#txtUttarBastiDosa_" + RowNo).val(value.Dosa);
                    $("#ddlUttarBastiMassageYesNo_" + RowNo).val(value.Massage).trigger('change');;
                    $("#ddlUttarBastiMassageOil_" + RowNo).selectpicker();
                    if (value.Massage_Oil != "") {
                        $("#ddlUttarBastiMassageOil_" + RowNo).selectpicker('val', value.Massage_Oil);
                    }
                    $("#txtUttarBastisymptoms_" + RowNo).val(value.Symptoms);


                });
                $('.selectpicker').selectpicker();
                changeTableClass();
                $('.txtUttarBastiDatta').timepicker({
                    showInputs: false
                });
            }
            else {
                $("#UttarBastiTable tbody").empty();
                $("#btnAddUttarBastiRows").trigger("click");
            }
        }
    });
}

function _saveBastiPurvaKarmaDetails() {

    var PostData = [];
    var BastiObject = {};
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseId = getUrlParameter("Case_ID");
    $("#BastiTable > tbody > tr").each(function (i, elem) {
        var Data = {}
        Data.SrNo = $(this).find('.srno').attr("idx");
        Data.Date = $(this).find('.Bastidate').val();
        if ($(this).find('.ddlOilorGhee').val() != "--") {
            Data.Oil_Ghee = $(this).find('.ddlOilorGhee').val();
        }
        else {
            Data.Oil_Ghee = "";
        }

        if ($(this).find('.ddlGheeOil').selectpicker('val') != null) {
            Data.Oil_Ghee_Name = $(this).find('.ddlGheeOil').selectpicker('val');
        }
        else {
            Data.Oil_Ghee_Name = "--";
        }
        Data.Dosa = $(this).find('.txtDosa').val();

        if ($(this).find('.ddlMassageYesNo').val() != "--") {
            Data.Massage = $(this).find('.ddlMassageYesNo').val();
        }
        else {
            Data.Massage = "";
        }

        if ($(this).find('.ddlMassageOil').selectpicker('val') != null) {
            Data.Massage_Oil = $(this).find('.ddlMassageOil').selectpicker('val');
        }
        else {
            Data.Massage_Oil = "";
        }

        Data.Datta = $(this).find('.txtDatta').val();
        Data.PratyaGaman = $(this).find('.txtPratyaGaman').val();
        Data.Symptoms = $(this).find('.txtsymptoms').val();

        PostData.push(Data);
    });

    if (PostData.length >= 1) {
        BastiObject.Data = PostData;
        BastiObject.FollowupRequired = "No";
        BastiObject.FollowupDate = $("#ddlFollowupDate").val();
        BastiObject.PatinetId = PatinetId;
        BastiObject.CaseId = CaseId;

        $.ajax({
            type: "POST",
            url: ServerURI + "Case/InsertBastiPurvaKarmaDetails",
            data: { "PostData": JSON.stringify(BastiObject) },
            dataType: "json",
            async: false,
            success: function (data) {

                if (data[0] == "true") {
                    $("#lblInfoCaseNo").text("Case No : " + data[2]);
                    $(".error-message").hide();
                    $(".success-message").show();
                }
                else {
                    $(".error-message").show();
                    $(".success-message").hide();
                }
            }
        });
    }
    return true;
}

function _saveUttarBastiDetails() {
    var PostData = [];
    var BastiObject = {};
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseId = getUrlParameter("Case_ID");
    $("#UttarBastiTable > tbody > tr").each(function (i, elem) {
        var Data = {}
        Data.SrNo = $(this).find('.srno').attr("idx");
        Data.Date = $(this).find('.UttarBastidate').val();
        if ($(this).find('.ddlUttarBastiOilorGhee').val() != "--") {
            Data.Oil_Ghee = $(this).find('.ddlUttarBastiOilorGhee').val();
        }
        else {
            Data.Oil_Ghee = "";
        }

        if ($(this).find('.ddlUttarBastiGheeOil').selectpicker('val') != null) {
            Data.Oil_Ghee_Name = $(this).find('.ddlUttarBastiGheeOil').selectpicker('val');
        }
        else {
            Data.Oil_Ghee_Name = "--";
        }
        Data.Dosa = $(this).find('.txtUttarBastiDosa').val();

        if ($(this).find('.ddlUttarBastiMassageYesNo').val() != "--") {
            Data.Massage = $(this).find('.ddlUttarBastiMassageYesNo').val();
        }
        else {
            Data.Massage = "";
        }

        if ($(this).find('.ddlUttarBastiMassageOil').selectpicker('val') != null) {
            Data.Massage_Oil = $(this).find('.ddlUttarBastiMassageOil').selectpicker('val');
        }
        else {
            Data.Massage_Oil = "";
        }

        Data.Datta = $(this).find('.txtUttarBastiDatta').val();
        Data.PratyaGaman = $(this).find('.txtUttarBastiPratyaGaman').val();
        Data.Symptoms = $(this).find('.txtUttarBastisymptoms').val();

        PostData.push(Data);
    });

    if (PostData.length >= 1) {
        BastiObject.Data = PostData;
        BastiObject.FollowupRequired = "No";
        BastiObject.FollowupDate = $("#ddlFollowupDate").val();
        BastiObject.PatinetId = PatinetId;
        BastiObject.CaseId = CaseId;

        $.ajax({
            type: "POST",
            url: ServerURI + "Case/InsertUttarBastiDetails",
            data: { "PostData": JSON.stringify(BastiObject) },
            dataType: "json",
            async: false,
            success: function (data) {

                if (data[0] == "true") {
                    $("#lblInfoCaseNo").text("Case No : " + data[2]);
                    $(".error-message").hide();
                    $(".success-message").show();
                }
                else {
                    $(".error-message").show();
                    $(".success-message").hide();
                }
            }
        });
    }
}

function GenerateBastiDates(day, className) {

    var input = "<input id='" + className + "_" + day + "' type='text' class='" + className + " form-control input-sm datepicker' />";
    return input;
}

function GenerateOilorGheeDD(idx, className) {
    var dd = '<select id="' + className + '_' + idx + '" idx=' + idx + ' class="form-control oilgheeddl input-sm ' + className + '">';
    dd += '<option>--</option>';
    dd += '<option>तेल</option>';
    dd += '<option>तुप</option>';
    dd += '<option>चूर्ण</option>';
    dd += '<option>इतर</option>';
    dd += '</select>';
    return dd;
}

function GenerateMassageDD(idx, className) {
    var dd = '<select id="' + className + '_' + idx + '" idx=' + idx + ' class="form-control massageddl input-sm ' + className + '">';
    dd += '<option>--</option>';
    dd += '<option>नाही</option>';
    dd += '<option>होय</option>';
    dd += '</select>';
    return dd;
}

function GenerateGheeOilDD(id, className) {
    var dd = '<select  style="width: 100%;" id="' + className + '_' + id + '" class="form-control input-sm  ' + className + ' selectpicker" data-live-search="true">';
    dd += '</select>';
    return dd;
}

function GenerateMassageOil(id, className) {
    var dd = '<select  style="width: 100%;" id="' + className + '_' + id + '" class="form-control input-sm ' + className + ' selectpicker" data-live-search="true">';
    dd += '</select>';
    return dd;
}