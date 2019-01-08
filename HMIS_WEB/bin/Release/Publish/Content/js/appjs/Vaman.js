var MedicinesTable = null;


$(document).ready(function () {

    showPatientDetails();

    $('.timepicker').timepicker({
        showInputs: false
    });

    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {

        if (stepNumber === 0) {
            _getVamanDetails();
            return true;
        }
        if (stepNumber === 1) {
            if (_saveVamanPurvaKarmaDetails()) {
            }
            return true;
        }
        if (stepNumber === 2) {
            _saveVamanPradhanKarmaDetails();
            return true;
        }
        //if (stepNumber === 3) {
        //    if (_saveMedicineDetails()) {
        //        return true;
        //    }
        //    else {
        //        return false;
        //    }
        //}
    });



    $("#btnAddRows").click(function () {
        var vamandays = 8;      


        if ($("#txtVamanDays").val() != "") {
            vamandays = $("#txtVamanDays").val();
        }

        var rowsinTable = 0;
        if (parseInt($('#VamanTable tbody tr').length) <= 0) {
            rowsinTable = 1;
        }
        else {
            rowsinTable = parseInt($('#VamanTable tbody tr').length) + 1;
        }


        var noofdays = 0;
        for (var i = 1; i <= vamandays; i++) {

            var tableRow = "<tr class=' row_" + rowsinTable + "'>";
            tableRow += "<td class='srno' idx=" + rowsinTable + ">" + rowsinTable + ".</td>";
            tableRow += "<td>" + GenerateVamanDates(rowsinTable) + "</td>";
            tableRow += "<td>" + GenerateOilorGheeDD(rowsinTable) + "</td>";
            tableRow += "<td>" + GenerateGheeOilDD(rowsinTable) + "</td>";
            tableRow += "<td><input id='txtDose_" + rowsinTable + "' type='text' onkeypress='javascript: return isNumber(event)' class='txtDosa input-sm form-control'/></td>";
            tableRow += "<td>" + GenerateMassageDD(rowsinTable) + "</td>";
            tableRow += "<td>" + GenerateMassageOil(rowsinTable) + "</td>";
            tableRow += "<td><input id='txtsymptoms_" + rowsinTable + "' type='text' class='txtsymptoms input-sm form-control'/></td>";
            tableRow += "</tr>";

            if (parseInt($('#VamanTable tbody tr').length) <= 0) {
                noofdays = 1;
            }
            else {
                noofdays = noofdays + 2;
            }
            var vamandate = new Date();
            vamandate.setDate(vamandate.getDate() + noofdays);

            $("#VamanTable tbody").append(tableRow);

            $('#vamandate_' + rowsinTable).datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
            }).datepicker('setDate', vamandate);

            rowsinTable++;
        }
        $('.selectpicker').selectpicker();

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
    if ($(this).val() == "तेल") {
        data = getOilDetails("VAMAN");
    } else if ($(this).val() == "तुप") {
        data = getGheeDetails();
    }
    else {
        $("#ddlGheeOil_" + id).empty().selectpicker('refresh');
    }
    $("#ddlGheeOil_" + id).empty().selectpicker('refresh');

    $(data).each(function (idx, val) {
        $("#ddlGheeOil_" + id).append('<option value="' + val + '">' + val + '</option>');
    });

    $("#ddlGheeOil_" + id).selectpicker('refresh');

});

$(document).on('change', '.ddlMassageYesNo', function () {
    var data = null;
    var id = $(this).attr("idx");
    if ($(this).val() == "होय") {
        data = getOilDetails("MASSAGE");
        $("#ddlMassageOil_" + id).empty().selectpicker('refresh');

        $(data).each(function (idx, val) {
            $("#ddlMassageOil_" + id).append('<option value="' + val + '">' + val + '</option>');
        });

        $("#ddlMassageOil_" + id).selectpicker('refresh');
    }
    else {
        $("#ddlMassageOil_" + id).empty().selectpicker('refresh');
    }



});


Array.prototype.except = function (val) {
    return this.filter(function (x) { return x !== val; });
};

var TempData = [];

function getGheeDetails() {
    var GheeDetail = {};
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetGheeDetails",
        data: { "type": "VAMAN" },
        dataType: "json",
        async: false,
        success: function (data) {

            GheeDetail = data;

        }
    });

    return GheeDetail;
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
        }
    });
}


function _getVamanDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetVamanDetails",
        data: { "CaseID": CaseID },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                var rowsinTable = 1;
                var noofdays = 0;
                $("#VamanTable tbody").empty();
                $(data).each(function (idx, value) {
                    RowNo = value.SrNo;

                    var tableRow = "<tr class=' row_" + RowNo + "'>";
                    tableRow += "<td class='srno' idx=" + RowNo + ">" + RowNo + ".</td>";
                    tableRow += "<td>" + GenerateVamanDates(RowNo) + "</td>";
                    tableRow += "<td>" + GenerateOilorGheeDD(RowNo) + "</td>";
                    tableRow += "<td>" + GenerateGheeOilDD(RowNo) + "</td>";
                    tableRow += "<td><input id='txtDose_" + RowNo + "' onkeypress='javascript: return isNumber(event)' type='text' class='txtDosa input-sm form-control'/></td>";
                    tableRow += "<td>" + GenerateMassageDD(RowNo) + "</td>";
                    tableRow += "<td>" + GenerateMassageOil(RowNo) + "</td>";
                    tableRow += "<td><input id='txtsymptoms_" + RowNo + "' type='text' class='txtsymptoms input-sm form-control'/></td>";
                    tableRow += "</tr>";


                    $("#VamanTable tbody").append(tableRow);

                    $('#vamandate_' + RowNo).datepicker({
                        autoclose: true,
                        format: 'dd/mm/yyyy',
                    }).datepicker('setDate', value.Date);


                    $("#ddlOilorGhee_" + RowNo).val(value.Oil_Ghee).trigger('change');
                    $("#ddlGheeOil_" + RowNo).selectpicker();

                    $("#ddlGheeOil_" + RowNo).selectpicker('val', value.Oil_Ghee_Name);
                    $("#txtDose_" + RowNo).val(value.Dose);
                    $("#ddlMassageYesNo_" + RowNo).val(value.Massage).trigger('change');;
                    $("#ddlMassageOil_" + RowNo).selectpicker();
                    if (value.Massage_Oil != "") {
                        $("#ddlMassageOil_" + RowNo).selectpicker('val', value.Massage_Oil);
                    }
                    $("#txtsymptoms_" + RowNo).val(value.Symptoms);


                });
            }
            else {
                $("#VamanTable tbody").empty();
                $("#btnAddRows").trigger("click");
            }
        }
    });
}


function _saveVamanPurvaKarmaDetails() {

    var PostData = [];
    var VamanObject = {};
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseId = getUrlParameter("Case_ID");
    $("#VamanTable > tbody > tr").each(function (i, elem) {
        var Data = {}
        Data.SrNo = $(this).find('.srno').attr("idx");
        Data.Date = $(this).find('.vamandate').val();
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
        Data.Dose = $(this).find('.txtDosa').val();

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
        Data.Symptoms = $(this).find('.txtsymptoms').val();

        PostData.push(Data);
    });

    if (PostData.length >= 1) {
        VamanObject.Data = PostData;
        VamanObject.FollowupRequired = "No";
        VamanObject.FollowupDate = $("#ddlFollowupDate").val();
        VamanObject.PatinetId = PatinetId;
        VamanObject.CaseId = CaseId;

        $.ajax({
            type: "POST",
            url: ServerURI + "Case/InsertVamanPurvaKarmaDetails",
            data: { "PostData": JSON.stringify(VamanObject) },
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

function _saveVamanPradhanKarmaDetails() {
    var PostData = {};
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseId = getUrlParameter("Case_ID");

    PostData.PradhanKarmaDate = $("#txtPradhanKarmaDate").val();
    PostData.UatkleshaAhar = $("#txtUatkleshaAhar").val();
    PostData.VamanDravya = $("#txtVamanDravya").val();
    PostData.SnehanSvedanTime = $("#txtSnehanSvedanTime").val();

    PostData.DudhapanTime = $("#txtDudhapanTime").val();
    PostData.DudhpanQty = $("#txtDudhpanQty").val();

    PostData.Chatan = $("#txtChatan").val();
    PostData.ChatanTime = $("#txtChatanTime").val();
    PostData.ChatanQty = $("#txtChatanQty").val();

    PostData.Akanthapan = $("#txtAkanthapan").val();
    PostData.AkanthapanStart = $("#txtAkanthapanStart").val();

    PostData.SaivadhJalTime = $("#txtSaivadhJalTime").val();
    PostData.SaivadhJal = $("#txtSaivadhJal").val();

    PostData.Dhumpan = $("#txtDhumpan").val();
   

    PostData.PatinetId = PatinetId;
    PostData.CaseId = CaseId;

    var VamanObject = {};
    VamanObject.VamanData = PostData;
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/InsertVamanPradhanKarmaDetails",
        data: { "PostData": JSON.stringify(VamanObject) },
        dataType: "json",
        success: function (data) {

            if (data[0] == "true") {
                return true;
            }
            else {
                return false;
            }
        }
    });

}


function GenerateVamanDates(day) {

    var input = "<input id='vamandate_" + day + "' type='text' class='vamandate form-control input-sm datepicker' />";
    return input;
}


function GenerateOilorGheeDD(idx) {
    var dd = '<select id="ddlOilorGhee_' + idx + '" idx=' + idx + ' class="form-control input-sm ddlOilorGhee">';
    dd += '<option>--</option>';
    dd += '<option>तेल</option>';
    dd += '<option>तुप</option>';
    dd += '</select>';
    return dd;
}

function GenerateMassageDD(idx) {
    var dd = '<select id="ddlMassageYesNo_' + idx + '" idx=' + idx + ' class="form-control input-sm ddlMassageYesNo">';
    dd += '<option>--</option>';
    dd += '<option>नाही</option>';
    dd += '<option>होय</option>';
    dd += '</select>';
    return dd;
}

function GenerateGheeOilDD(id) {
    var dd = '<select  style="width: 100%;" id="ddlGheeOil_' + id + '" class="form-control input-sm  ddlGheeOil selectpicker" data-live-search="true">';
    dd += '</select>';
    return dd;
}


function GenerateMassageOil(id) {
    var dd = '<select  style="width: 100%;" id="ddlMassageOil_' + id + '" class="form-control input-sm ddlMassageOil selectpicker" data-live-search="true">';
    dd += '</select>';
    return dd;
}