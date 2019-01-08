var MedicinesTable = null;


$(document).ready(function () {

    showPatientDetails();

    $('.timepicker').timepicker({
        showInputs: false
    });

    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {

        if (stepNumber === 1) {
            _getRaktaMokshanaDetails();
            return true;
        }
        if (stepNumber === 2) {
              if (_saveRaktaMokshanaDetails()) {
               }
            return true;
        }
    });

    $("#btnAddRows").click(function () {
        var type = $("#txtRaktaMokshanaType").val()

        var RaktaMokshanadays = 3;
        if ($("#txtRaktaMokshanaDays").val() != "") {
            RaktaMokshanadays = $("#txtRaktaMokshanaDays").val();
        }


        var rowsinTable = 0;
        if (parseInt($('#RaktaMokshanaTable tbody tr').length) <= 0) {
            rowsinTable = 1;
        }
        else {
            rowsinTable = parseInt($('#RaktaMokshanaTable tbody tr').length) + 1;
        }

        var noofdays = 0;
        for (var i = 1; i <= RaktaMokshanadays; i++) {

            var tableRow = "<tr class=' row_" + rowsinTable + "'>";
            tableRow += "<td class='srno' idx=" + rowsinTable + ">" + rowsinTable + ".</td>";
            tableRow += "<td>" + GenerateDates(rowsinTable) + "</td>";
            tableRow += "<td><input value='" + type + "' id='txtRaktaMokshanaType_" + rowsinTable + "' type='text' class='form-control txtRaktaMokshanaType input-sm'/></td>";
            tableRow += "<td>" + GenerateSnehaPaanDD(rowsinTable) + "</td>";
            tableRow += "<td><input id='txtSnehaPaanDetails_" + rowsinTable + "' type='text' class='txtSnehaPaanDetails form-control input-sm'/></td>";
            tableRow += "<td><input id='txtQuantity_" + rowsinTable + "' type='text' class='txtQuantity form-control input-sm'/></td>";
            tableRow += "<td><input id='txtPlace_" + rowsinTable + "' type='text' class='txtPlace form-control input-sm'/></td>";
            tableRow += "<td><input id='txtsymptoms_" + rowsinTable + "' type='text' class='txtsymptoms form-control input-sm'/></td>";
            tableRow += "</tr>";

            if (parseInt($('#RaktaMokshanaTable tbody tr').length) <= 0) {
                noofdays = 1;
            }
            else {
                noofdays = noofdays + 2;
            }
            var RaktaMokshanadate = new Date();
            RaktaMokshanadate.setDate(RaktaMokshanadate.getDate() + noofdays);

            $("#RaktaMokshanaTable tbody").append(tableRow);

            $('#RaktaMokshanadate_' + rowsinTable).datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
            }).datepicker('setDate', RaktaMokshanadate);

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

Array.prototype.except = function (val) {
    return this.filter(function (x) { return x !== val; });
};

var TempData = [];

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


function _getRaktaMokshanaDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetRaktaMokshanaDetails",
        data: { "CaseID": CaseID },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                var rowsinTable = 1;
                var noofdays = 0;
                $("#RaktaMokshanaTable tbody").empty();
                $(data).each(function (idx, value) {
                    RowNo = value.SrNo;

                    var tableRow = "<tr class=' row_" + RowNo + "'>";
                    tableRow += "<td class='srno' idx=" + RowNo + ">" + RowNo + ".</td>";
                    tableRow += "<td>" + GenerateDates(RowNo) + "</td>";
                    tableRow += "<td><input value='" + RowNo + "' id='txtRaktaMokshanaType_" + RowNo + "' type='text' class='form-control txtRaktaMokshanaType input-sm'/></td>";
                    tableRow += "<td>" + GenerateSnehaPaanDD(RowNo) + "</td>";
                    tableRow += "<td><input id='txtSnehaPaanDetails_" + RowNo + "' type='text' class='txtSnehaPaanDetails form-control input-sm'/></td>";
                    tableRow += "<td><input id='txtQuantity_" + RowNo + "' type='text' class='txtQuantity form-control input-sm'/></td>";
                    tableRow += "<td><input id='txtPlace_" + RowNo + "' type='text' class='txtPlace form-control input-sm'/></td>";
                    tableRow += "<td><input id='txtsymptoms_" + RowNo + "' type='text' class='txtsymptoms form-control input-sm'/></td>";
                    tableRow += "</tr>";


                    $("#RaktaMokshanaTable tbody").append(tableRow);

                    $('#RaktaMokshanadate_' + RowNo).datepicker({
                        autoclose: true,
                        format: 'dd/mm/yyyy',
                    }).datepicker('setDate', value.Date);

                    $("#txtRaktaMokshanaType_" + RowNo).val(value.RaktaMokshanaType);
                    $("#txtSnehaPaanDetails_" + RowNo).val(value.SnehaPaanDetails);
                    $("#txtQuantity_" + RowNo).val(value.Quantity);
                    $("#txtPlace_" + RowNo).val(value.Place);
                    $("#txtsymptoms_" + RowNo).val(value.Symptoms);

                });

            }
            else {
                $("#RaktaMokshanaTable tbody").empty();
                $("#btnAddRows").trigger("click");
            }
        }
    });
}


function _saveRaktaMokshanaDetails() {

    var PostData = [];
    var RaktaMokshanaObject = {};
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseId = getUrlParameter("Case_ID");
    $("#RaktaMokshanaTable > tbody > tr").each(function (i, elem) {
        var Data = {}
        Data.SrNo = $(this).find('.srno').attr("idx");
        Data.RaktaMokshanaType = $(this).find('.txtRaktaMokshanaType').val();
        Data.ddlSnehaPaanYesNo = $(this).find('.ddlSnehaPaanYesNo').val();
        Data.SnehaPaanDetails = $(this).find('.txtSnehaPaanDetails').val();
        Data.Date = $(this).find('.RaktaMokshanadate').val();
        Data.Symptoms = $(this).find('.txtsymptoms').val();
        Data.Place = $(this).find('.txtPlace').val();
        Data.Quantity = $(this).find('.txtQuantity').val();
        PostData.push(Data);
    });

    if (PostData.length >= 1) {
        RaktaMokshanaObject.Data = PostData;
        RaktaMokshanaObject.FollowupRequired = "No";
        RaktaMokshanaObject.FollowupDate = $("#ddlFollowupDate").val();
        RaktaMokshanaObject.PatinetId = PatinetId;
        RaktaMokshanaObject.CaseId = CaseId;

        $.ajax({
            type: "POST",
            url: ServerURI + "Case/InsertRaktaMokshanaDetails",
            data: { "PostData": JSON.stringify(RaktaMokshanaObject) },
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

function GenerateDates(day) {

    var input = "<input id='RaktaMokshanadate_" + day + "' type='text' class='RaktaMokshanadate input-sm form-control datepicker' />";

    return input;
}

function GenerateSnehaPaanDD(idx) {
    var dd = '<select id="ddlSnehaPaanYesNo_' + idx + '" idx=' + idx + ' class="form-control ddlSnehaPaanYesNo">';
    dd += '<option>--</option>';
    dd += '<option>नाही</option>';
    dd += '<option>होय</option>';
    dd += '</select>';
    return dd;
}

