var MedicinesTable = null;


$(document).ready(function () {
    $('#ddlFollowupDate').datepicker({
        autoclose: true,
        format: 'dd/mm/yyyy',
    }).datepicker('setDate', 'today');

    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {

        if (stepNumber === 0) {
            if (_showKadhaDetails()) {
            }
            return true;
        }
        if (stepNumber === 1) {
            if (_showMedicineDetails()) {
            }
            return true;
        }
        if (stepNumber === 2) {
            showPatientDetails();
            return true;
        }
        if (stepNumber === 3) {
            if (_saveMedicineDetails()) {
                return true;
            }
            else {
                return false;
            }
        }
    });


    $('.select2').select2({
        ajax: {
            url: ServerURI + "Case/GetMedicines",
            dataType: 'json',
            type: "GET",
            data: function (params) {
                var query = {
                    search: params.term
                }
                return query;
            },
            processResults: function (data, params) {

                params.page = params.page || 1;

                return {
                    results: $.map(data, function (item) {
                        return {
                            text: item.Name,
                            id: item.ID
                        }
                    }),
                    pagination: {
                        more: (params.page * 30) < data.total_count
                    }
                };
            },
            cache: true
        }
    });



    $("#btnAddMedicineToTable").click(function () {
        var row
        var _flag = false;

        if (validateInput($("#ddlMedicine"))) {
            _flag = true;
        } else {
            return false;
        }

        if (validateInput($("#ddlMedicineType"))) {
            _flag = true;
        } else {
            return false;
        }

        if (validateInput($("#ddlForKadha"))) {
            _flag = true;
            if ($("#ddlForKadha").val() == "होय") {
                if (validateInput($("#txtKadhaNo"))) {
                    _flag = true;
                }
                else {
                    return false;
                }
            } else {
                $("#txtKadhaNo").val("");
            }
        } else {
            return false;
        }

        if (_flag == true) {

            var SelectData = $("#ddlMedicine").select2('data');          
            var Name = SelectData[0].text;
            var Type = $("#ddlMedicineType").val();
            var ForKadha = $("#ddlForKadha").val();
            var KadhaNo = $("#txtKadhaNo").val() == "" ? "0" : $("#txtKadhaNo").val();

            var rowsinTable = 0;
            if (parseInt($('#MedicineTable tbody tr').length) <= 0) {
                rowsinTable = 1;
            }
            else {
                rowsinTable = parseInt($('#MedicineTable tbody tr').length) + 1;
            }
            var tableRow = "<tr class='row_" + rowsinTable + "'>";
            tableRow += "<td>" + rowsinTable + ".</td>";
            tableRow += "<td class='col_medicine col_medicine_" + rowsinTable + "' >" + Name + "</td>";
            tableRow += "<td class='col_type col_type_" + rowsinTable + "'>" + Type + "</td>";
            tableRow += "<td class='col_for_kadha col_for_kadha_" + rowsinTable + "'>" + ForKadha + "</td>";
            tableRow += "<td class='col_kadha_no col_kadha_no_" + rowsinTable + "'>" + KadhaNo + "</td>";
            tableRow += "<td><a href='javascript:void(0)' class='MedicineOperation' onClick='editMedicine(" + rowsinTable + ",1)'><i class='fa fa-pencil'></i></a>&nbsp;&nbsp;&nbsp; <a class='MedicineOperation'  href='javascript:void(0)' onClick='editMedicine(" + rowsinTable + ",2)'><i class='fa fa-trash'></i></a></td>";
            tableRow += "</tr>";

            $("#MedicineTable tbody").append(tableRow);
            $('.MedicineOperation').removeClass("disablelink");
            $("#ddlMedicine").val(null).trigger('change');
            $("#ddlMedicineType").val('चुर्ण');
            $("#ddlForKadha").val('नाही');
            $("#txtKadhaNo").val("");
        }
        return false;
    });


    $("#btnSaveMedicine").click(function () {

        var MedicineDataObject = {};

        var MedicineArray = []

        $("#MedicineTable > tbody > tr").each(function (i, elem) {

            var MedicineObj = {};

            MedicineObj.Medicine = $(this).find('.col_medicine').text();
            MedicineObj.MedicineID = $(this).find('.col_medicine').attr("MedicineID");
            MedicineObj.MedicineDuration = $(this).find('.col_medicine').attr("MedicineDuration");
            MedicineObj.TakeWith = $(this).find('.col_medicine').attr("TakeWith");
            MedicineObj.MedicineTime = $(this).find('.col_medicine').attr("MedicineTime");
            MedicineObj.type = $(this).find('.col_type').text();
            MedicineObj.qty = $(this).find('.col_qty').attr("Qty");
            MedicineObj.qtyunit = $(this).find('.col_qty').attr("QtyUnit");
            MedicineObj.frequency = $(this).find('.col_frequency').text();
            MedicineObj.FollowuRequired = $("#ddlFollowupRequired").val();
            MedicineObj.FollowuDate = $("#txtFollowupDate").val();

            MedicineArray.push(MedicineObj);

        });
        MedicineDataObject.MedicineDetails = MedicineArray;
        $.ajax({
            type: "POST",
            url: ServerURI + "Case/InsertMedicineDetails",
            data: { "PostData": JSON.stringify(MedicineDataObject) },
            dataType: "json",
            async: false,
            success: function (data) {
                if (data[0] == "true") {
                    $(".medicine-box-body").hide();
                    $(".success-box").show();

                }
                else {

                }
            }
        });

        return false;
    });

    $("#ddlFollowupRequired").change(function () {
        if ($(this).val() == "Yes") {
            $(".form-group-ddlFollowupDate").show();
        }
        else {
            $(".form-group-ddlFollowupDate").hide();
        }
    });


    $("#btnNewCase").click(function () {
        window.location.href = ServerURI + "Case/Create";
        return false;
    });

});

Array.prototype.except = function (val) {
    return this.filter(function (x) { return x !== val; });
};

var TempData = [];


function editMedicine(idx, mode) {
    if (mode == 1) {
        $("#ddlMedicine").val($(".col_medicine_" + idx).text()).trigger('change');;
        $("#ddlMedicineType").val($(".col_type_" + idx).text());
        $("#ddlForKadha").val($(".col_for_kadha_" + idx).text());
        $("#txtKadhaNo").val($(".col_kadha_no_" + idx).text());
    }


    $(".row_" + idx).remove();
    var UneditedData = [];

    $("#MedicineTable > tbody > tr").each(function (i, elem) {
        i++;
        var TempData = {};
        TempData.rowIndex = i;
        TempData.medicine = $(this).find('.col_medicine').text();
        TempData.type = $(this).find('.col_type').text();
        TempData.ForKadha = $(this).find('.col_for_kadha').text();
        TempData.KadhaNo = $(this).find('.col_kadha_no').text();
        UneditedData.push(TempData);

    });

    $("#MedicineTable > tbody").empty();
    UneditedData.forEach(function (item) {
        var tableRow = "<tr class='row_" + item.rowIndex + "'>";
        tableRow += "<td>" + item.rowIndex + ".</td>";
        tableRow += "<td class='col_medicine col_medicine_" + item.rowIndex + "'>" + item.medicine + "</td>";
        tableRow += "<td class='col_type col_type_" + item.rowIndex + "'>" + item.type + "</td>";
        tableRow += "<td class='col_for_kadha col_for_kadha_" + item.rowIndex + "'>" + item.ForKadha + "</td>";
        tableRow += "<td class='col_kadha_no col_kadha_no_" + item.rowIndex + "'>" + item.KadhaNo + "</td>";
        tableRow += "<td><a href='javascript:void(0)' class='MedicineOperation' onClick='editMedicine(" + item.rowIndex + ",1)'><i class='fa fa-pencil'></i></a>&nbsp;&nbsp;&nbsp; <a class='MedicineOperation'  href='javascript:void(0)' onClick='editMedicine(" + item.rowIndex + ",2)'><i class='fa fa-trash'></i></a></td>";
        tableRow += "</tr>";
        $("#MedicineTable tbody").append(tableRow);
    });
    if (mode == 1) {
        $('.MedicineOperation').addClass("disablelink");
    }

}


function _showKadhaDetails() {
    var Data = [];
    var arrKadha = [];
    $("#MedicineTable > tbody > tr").each(function (i, elem) {

        i++;
        var TempData = {};
        TempData.rowIndex = i;
        TempData.medicine = $(this).find('.col_medicine').text();
        TempData.type = $(this).find('.col_type').text();
        TempData.ForKadha = $(this).find('.col_for_kadha').text();
        TempData.KadhaNo = $(this).find('.col_kadha_no').text();
        arrKadha.push($(this).find('.col_kadha_no').text());
        Data.push(TempData);
    });
    var uniqueKadhaNo = arrKadha.filter(function (itm, i, arrKadha) {
        return i == arrKadha.indexOf(itm);
    });


    var rowsinTable = 0;
    if (parseInt($('#KadhaTable tbody tr').length) <= 0) {
        rowsinTable = 1;
    }
    else {
        rowsinTable = parseInt($('#KadhaTable tbody tr').length) + 1;
    }
    TempData = [];

    $("#KadhaTable tbody").empty();
    $(uniqueKadhaNo).each(function (i, kadha) {

        var MedicineRow = "";
        if (kadha != "0") {
            $(Data).each(function (idx, val) {
                if (val.KadhaNo == kadha) {
                    MedicineRow = val.medicine + ', ' + MedicineRow;
                }
            });
            var tableRow = "<tr>";
            tableRow += "<td class='kadha_no'>" + kadha + "</td>";
            tableRow += "<td class='kadha_medicine'>" + MedicineRow.slice(0, -2) + "</td>";
            tableRow += "<td><input  type='text' class='form-control kadha_quantity' /></td>";
            tableRow += "</tr>";

            $("#KadhaTable tbody").append(tableRow);
        }
    });

    $(Data).each(function (idx, val) {
        if (val.ForKadha == "नाही") {
            var d = {}
            d.medicine = val.medicine;
            d.type = val.type;
            d.ForKadha = val.ForKadha;
            d.KadhaNo = val.KadhaNo;
            TempData.push(d);
        }
    });
    return true;
}

function _showMedicineDetails() {
    $("#MedicineInfoTable tbody").empty();


    $("#KadhaTable > tbody > tr").each(function (i, elem) {

        var d = {};

        d.medicine = "काढा क्रं " + $(this).find('.kadha_no').text();
        d.type = "काढा";
        d.ForKadha = "होय";
        d.KadhaNo = $(this).find('.kadha_no').text();
        d.Kadha_Medicine = $(this).find('.kadha_medicine').text();
        d.Kadha_Quantity = $(this).find('.kadha_quantity').val();
        TempData.push(d);

    });

    $(TempData).each(function (idx, val) {

        var rowsinTable = 0;
        if (parseInt($('#MedicineInfoTable tbody tr').length) <= 0) {
            rowsinTable = 1;
        }
        else {
            rowsinTable = parseInt($('#MedicineInfoTable tbody tr').length) + 1;
        }

        var quantity = val.Kadha_Quantity;
        if (typeof quantity === "undefined") {
            quantity = "";
        }
        var tableRow = "<tr>";
        tableRow += "<td>" + rowsinTable + ".</td>";
        tableRow += "<td class='cmb_Name' MedicineType=" + val.type + ">" + val.medicine + "</td>";
        tableRow += "<td class='cmb_Duration'><input type='text' class='form-control cmb_txt_Duration' /></td>";
        tableRow += "<td class='cmb_Frequency'>" + GenerateFrequencyDD() + "</td>";
        tableRow += "<td class='cmb_When'>" + GenerateWhenToDD() + "</td>";
        tableRow += "<td class='cmb_With'>" + GenerateWithToDD() + "</td>";
        tableRow += "<td class='cmb_Quantity'><input type='text' class='form-control cmb_txt_Quantity' value='" + quantity + "' /></td>";
        tableRow += "</tr>";
        $("#MedicineInfoTable tbody").append(tableRow);
    });


    $('.ddlWhentoTake').selectpicker('render');

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


function _saveMedicineDetails() {
    var from = $("#ddlFollowupDate").val().split("/")
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();
    var returnval = false;
    if ($("#ddlFollowupRequired").val() == "Yes") {
        if (new Date(from[2], from[1] - 1, from[0]) <= new Date(yyyy, mm - 1, dd)) {
            $("#lblerr").text("Please select next followup date");
            $(".followupDateError").show();
            returnval = false;
        }
        else {
            returnval = true;
        }
    }
    else {
        returnval = true;        
    }

    if (returnval == false) {
        return returnval;
    }
    else {
        $(".followupDateError").hide();
        var PostData = [];
        var MedicineObject = {};
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        $("#MedicineInfoTable > tbody > tr").each(function (i, elem) {
            var Data = {}
            Data.Name = $(this).find('.cmb_Name').text();
            Data.Type = $(this).find('.cmb_Name').attr("MedicineType");
            Data.Duration = $(this).find('.cmb_txt_Duration').val();
            Data.Frequency = $(this).find('.ddlFrequency').val();
            Data.WhenToTake = $(this).find('.ddlWhentoTake').selectpicker('val').join(", ");
            Data.WithToTake = $(this).find('.ddlWithTake').val();
            Data.Quantity = $(this).find('.cmb_txt_Quantity').val();

            PostData.push(Data);
        });
        if (PostData.length >= 1) {
            MedicineObject.Data = PostData;
            MedicineObject.FollowupRequired = $("#ddlFollowupRequired").val();
            MedicineObject.FollowupDate = $("#ddlFollowupDate").val();
            MedicineObject.PatinetId = PatinetId;
            MedicineObject.CaseId = CaseId;
            $.ajax({
                type: "POST",
                url: ServerURI + "Case/InsertMedicineDetails",
                data: { "PostData": JSON.stringify(MedicineObject) },
                dataType: "json",
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




}


function GenerateFrequencyDD() {
    var dd = '<select class="form-control ddlFrequency">';
    dd += '<option>1</option>';
    dd += '<option>1-1</option>';
    dd += '<option>1-1-1</option>';
    dd += '</select>';
    return dd;
}

function GenerateWhenToDD() {
    var dd = '<select class="form-control  ddlWhentoTake selectpicker" multiple>';
    dd += '<option>उपाशी पोटी</option>';
    dd += '<option>जेवनापूर्वी-सकाळी</option>';
    dd += '<option>जेवनानंतर-सकाळी</option>';
    dd += '<option>जेवनापूर्वी-दुपारी</option>';
    dd += '<option>जेवनानंतर-दुपारी</option>';
    dd += '<option>जेवनापूर्वी-रात्री</option>';
    dd += '<option>जेवनानंतर-रात्री</option>';
    dd += '<option>रात्री झोपताना</option>';
    dd += '</select>';
    return dd;
}


function GenerateWithToDD() {
    var dd = '<select class="form-control ddlWithTake">';
    dd += '<option>साधे पाणी</option>';
    dd += '<option>गरम पाणी</option>';
    dd += '<option>दुध</option>';
    dd += '<option>तुप</option>';
    dd += '<option>मध</option>';
    dd += '</select>';
    return dd;
}


function validateInput(elem) {
    if (elem.val() == "") {
        $(".form-group-" + elem.attr('id')).removeClass("has-success").addClass("has-error");
        return false;
    } else {
        $(".form-group-" + elem.attr('id')).removeClass("has-error").addClass("has-success");
        return true;
    }
}
function calculateAge(elem) {
    var age = getAge(elem.value);
    $("#inputAge").val(age);
}




