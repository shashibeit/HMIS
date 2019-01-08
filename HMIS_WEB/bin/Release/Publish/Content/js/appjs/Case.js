var complaintsTable = null;
var caseResponse = {};
$(document).ready(function () {

    // Step show event
    $("#smartwizard").on("showStep", function (e, anchorObject, stepNumber, stepDirection, stepPosition) {
        //alert("You are on step "+stepNumber+" now");
        if (stepPosition === 'first') {
            $("#prev-btn").addClass('disabled');
        } else if (stepPosition === 'final') {
            $("#next-btn").addClass('disabled');
        } else {
            $("#prev-btn").removeClass('disabled');
            $("#next-btn").removeClass('disabled');
        }
    });

    // Toolbar extra buttons
    var btnFinish = $('<button></button>').text('Finish')
        .addClass('btn btn-info')
        .on('click', function () { alert('Finish Clicked'); });
    var btnCancel = $('<button></button>').text('Cancel')
        .addClass('btn btn-danger')
        .on('click', function () { $('#smartwizard').smartWizard("reset"); });


    // Smart Wizard
    $('#smartwizard').smartWizard({
        selected: 0,
        theme: 'arrows',
        transitionEffect: 'fade',
        showStepURLhash: true,
        toolbarSettings: {
            toolbarPosition: 'bottom',
            toolbarButtonPosition: 'end',
            toolbarExtraButtons: [btnFinish, btnCancel]
        }
    });



    $("#reset-btn").on("click", function () {
        // Reset wizard
        $('#smartwizard').smartWizard("reset");
        return true;
    });

    $("#btnDiagnosis").click(function () {

        window.location.href = ServerURI + "Case/Diagnosis?Patient_ID=" + $("#txtPatientId").val() + "&Case_ID=" + caseResponse.caseID;
        return false;
    });


    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {
        //  console.log(stepNumber);
        if (stepNumber === 4) {
            if (createCase()) {
                console.log(caseResponse.success);
                if (caseResponse.success == true) {
                    $("#lblInfoCaseNo").text("Case No : " + caseResponse.caseID);
                    $(".error-message").hide();
                    $(".success-message").show();
                }
                else {
                    $(".error-message").show();
                    $(".success-message").hide();
                }
            }

            return true;
        }
        return true;
    });

    $("#inputComplaint").blur(function () {
        var elem = $(this);
        validateInput(elem);
    });

    $("#btnAddcol_complaintsToTable").click(function () {
        var _flag = false;
        var DurationYears = "";
        var DurationMonths = "";
        var DurationDays = "";
        var Duration = ""
        _flag = validateInput($("#inputComplaint"));
        if (_flag == true) {
            if ($("#inputDurationDays").val() == "" && $("#inputDurationMonths").val() == "" && $("#inputDurationYears").val() == "") {
                $(".form-group-inputDuration").removeClass("has-success").addClass("has-error");
                _flag = false;

            }
            else {
                $(".form-group-inputDuration").removeClass("has-error").addClass("has-success");
                _flag = true;
            }
        }
        if (_flag) {
            var inputComplaint = $("#inputComplaint").val();

            if ($("#inputDurationYears").val() != "" && $("#inputDurationYears").val() != "0") {
                DurationYears = $("#inputDurationYears").val();
                Duration = Duration + DurationYears + " Years ";
            }
            else {
                DurationYears = 0;
                Duration = "";
            }
            if ($("#inputDurationMonths").val() != "" && $("#inputDurationMonths").val() != "0") {
                DurationMonths = $("#inputDurationMonths").val();
                if (Duration != "") {
                    Duration = Duration + DurationMonths + " Months ";
                }
                else {
                    Duration = DurationMonths + " Months ";
                }
            }
            else if (Duration == "") {
                DurationMonths = 0;
                Duration = "";
            }
            else {
                DurationMonths = 0;
            }


            if ($("#inputDurationDays").val() != "" && $("#inputDurationDays").val() != "0") {
                DurationDays = $("#inputDurationDays").val();
                if (Duration != "") {
                    Duration = Duration + DurationDays + " and Days";
                }
                else {
                    Duration = DurationDays + " Days";
                }
            }
            else if (Duration == "") {
                DurationDays = 0;
                Duration = "";
            }
            else {
                DurationDays = 0;
            }
            var rowsinTable = 0;
            if (parseInt($('#complaintsTable tbody tr').length) <= 0) {
                rowsinTable = 1;
            }
            else {
                rowsinTable = parseInt($('#complaintsTable tbody tr').length) + 1;
            }


            var tableRow = "<tr class='row_" + rowsinTable + "'>";
            tableRow += "<td>" + rowsinTable + ".</td>";
            tableRow += "<td class='col_complaint col_col_complaint_" + rowsinTable + "'>" + inputComplaint + "</td>";
            tableRow += "<td DurationDays=" + DurationDays + " DurationMonths=" + DurationMonths + "  DurationYears=" + DurationYears + " class='col_duration col_duration_" + rowsinTable + "'>" + Duration + "</td>";
            tableRow += "<td><a href='javascript:void(0)' class='complaintOperation' onClick='editComplaint(" + rowsinTable + ",1)'><i class='fa fa-pencil'></i></a>&nbsp;&nbsp;&nbsp; <a class='complaintOperation'  href='javascript:void(0)' onClick='editComplaint(" + rowsinTable + ",2)'><i class='fa fa-trash'></i></a></td>";
            tableRow += "</tr>";
            $("#complaintsTable tbody").append(tableRow);
            $('.complaintOperation').removeClass("disablelink");
            $("#inputComplaint").val("");
            $("#inputDurationDays").val("");
            $("#inputDurationMonths").val("");
            $("#inputDurationYears").val("");

        }
        return false;
    });


    $("#btnSearch").click(function () {

        if ($("#txtPatientId").val() !== "") {

            $.ajax({
                type: "POST",
                url: ServerURI + "Case/GetPatientDetails",
                data: { "Patient_ID": $("#txtPatientId").val() },
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.PatientName == null) {
                        alert("No Details Found");
                        $("#txtPatientName").val("");
                        $("#txtAddress").val("");
                        $("#txtCity").val("");
                        $("#txtPin").val("");
                        $("#txtMobileNo").val("");
                        $("#txtBirthDate").val("");
                        $("#txtAge").val("");
                    } else {
                        $("#txtPatientName").val(data.PatientName);
                        $("#txtAddress").val(data.Address);
                        $("#txtCity").val(data.City);
                        $("#txtPin").val(data.Pin);
                        $("#txtMobileNo").val(data.MobileNo);
                        $("#txtBirthDate").val(data.BirthDate);
                        $("#txtAge").val(data.Age);
                    }
                }
            });
        }
        else {

        }
    });

    $('#txtSearchName').on('input', function (e) {
        var NameSearch = "";
        var ContactSearch = "";
        var CitySearch = "";

        if ($(this).val() != "") {
            NameSearch = $(this).val();
        }
        if ($("#txtSearchContactNo").val() != "") {
            ContactSearch = $("#txtSearchContactNo").val();
        }
        if ($("#txtSearchCity").val() != "") {
            CitySearch = $("#txtSearchCity").val();
        }

        _performSearch(NameSearch, CitySearch, ContactSearch);


    });


    $('#txtSearchContactNo').on('input', function (e) {
        var NameSearch = "";
        var ContactSearch = "";
        var CitySearch = "";

        if ($(this).val() != "") {
            ContactSearch = $(this).val();
        }
        if ($("#txtSearchCity").val() != "") {
            CitySearch = $("#txtSearchCity").val();
        }
        if ($("#txtSearchName").val() != "") {
            NameSearch = $("#txtSearchName").val();
        }
        _performSearch(NameSearch, CitySearch, ContactSearch);
    });


    $('#txtSearchCity').on('input', function (e) {
        var NameSearch = "";
        var ContactSearch = "";
        var CitySearch = "";
        if ($(this).val() != "") {
            CitySearch = $(this).val();
        }
        if ($("#txtSearchContactNo").val() != "") {
            ContactSearch = $("#txtSearchContactNo").val();
        }
        if ($("#txtSearchName").val() != "") {
            NameSearch = $("#txtSearchName").val();
        }
        _performSearch(NameSearch, CitySearch, ContactSearch);
    });

   


});

function _performSearch(SearchName, SearchCity, SearchContact) {

    var d = {};
    d.SearchName = SearchName;
    d.SearchCity = SearchCity;
    d.SearchContact = SearchContact;
    var SearchDataObject = {};
    SearchDataObject.SearchData = d;


    $.ajax({
        type: "POST",
        url: ServerURI + "Case/GetPatients",
        data: { "PostData": JSON.stringify(SearchDataObject) },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0 && data != null) {
                $("#PatientsTable tbody").empty();
                var rowsinTable = 0;
                if (parseInt($('#PatientsTable tbody tr').length) <= 0) {
                    rowsinTable = 1;
                }
                else {
                    rowsinTable = parseInt($('#PatientsTable tbody tr').length) + 1;
                }

                $(data).each(function (idx, value) {


                    var tableRow = "<tr onclick='selectPatient(" + value.PatientId + ")' class=' row_" + rowsinTable + "'>";
                    tableRow += "<td class='srno' idx=" + rowsinTable + ">" + value.PatientId + ".</td>";
                    tableRow += "<td PATIENT_ID='" + value.PatientId + "'>" + value.PatientName + "</td>";
                    tableRow += "<td>" + value.MobileNo + "</td>";
                    tableRow += "<td>" + value.City + "</td>";
                    tableRow += "<td>" + value.Pin + "</td>";
                    tableRow += "</tr>";
                    $("#PatientsTable tbody").append(tableRow);
                    rowsinTable++;
                });
            }
            else {
                $("#PatientsTable tbody").empty();
                var tableRow = "<tr>";
                tableRow += "<td colspan='5'><center>No patients found...</center></td>";
                tableRow += "</tr>";


                $("#PatientsTable tbody").append(tableRow);

            }
        }
    });
}

function selectPatient(Patient_ID) {
    $("#txtPatientId").val(Patient_ID);
    $("#btnSearch").trigger("click");
    $("#modal-AdvanceSearch").modal("hide");
    $("#PatientsTable tbody").empty();
    $("#txtSearchName").val("");
    $("#txtSearchContactNo").val("");
    $("#txtSearchCity").val("");
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

function editComplaint(idx, mode) {
    if (mode == 1) {
        $("#inputComplaint").val($(".col_col_complaint_" + idx).text());
        var DuratonObj = $(".col_duration_" + idx);
        var Duration = $(DuratonObj).text();
        if ($(DuratonObj).attr("DurationDays") != "") {
            $("#inputDurationDays").val($(DuratonObj).attr("DurationDays"));
        }
        if ($(DuratonObj).attr("DurationMonths") != "") {
            $("#inputDurationMonths").val($(DuratonObj).attr("DurationMonths"));
        }
        if ($(DuratonObj).attr("DurationYears") != "") {
            $("#inputDurationYears").val($(DuratonObj).attr("DurationYears"));
        }


    }


    $(".row_" + idx).remove();
    var UneditedData = [];

    $("#complaintsTable > tbody > tr").each(function (i, elem) {
        i++;
        var TempData = {};
        TempData.rowIndex = i;
        TempData.inputComplaint = $(this).find('.col_complaint').text();
        TempData.Duration = $(this).find('.col_duration').text();
        TempData.DurationDays = $(this).find('.col_duration').attr("DurationDays");
        TempData.DurationMonths = $(this).find('.col_duration').attr("DurationMonths");
        TempData.DurationYears = $(this).find('.col_duration').attr("DurationYears");
        UneditedData.push(TempData);
    });

    $("#complaintsTable > tbody").empty();
    UneditedData.forEach(function (item) {
        var tableRow = "<tr class='row_" + item.rowIndex + "'>";
        tableRow += "<td>" + item.rowIndex + ".</td>";
        tableRow += "<td class='col_complaint col_col_complaint_" + item.rowIndex + "'>" + item.inputComplaint + "</td>";
        tableRow += "<td DurationDays=" + item.DurationDays + " DurationMonths=" + item.DurationMonths + "  DurationYears=" + item.DurationYears + " class='col_duration col_duration_" + item.rowIndex + "'>" + item.Duration + "</td>";
        tableRow += "<td><a href='javascript:void(0)' data-toggle='tooltip' title='Edit Complaint' class='complaintOperation' onClick='editComplaint(" + item.rowIndex + ",1)'><i class='fa fa-pencil'></i></a>&nbsp;&nbsp;&nbsp; <a class='complaintOperation' data-toggle='tooltip' title='Delete Complaint' href='javascript:void(0)' onClick='editComplaint(" + item.rowIndex + ",2)'><i class='fa fa-trash'></i></a></td>";
        tableRow += "</tr>";
        $("#complaintsTable tbody").append(tableRow);
    });
    if (mode == 1) {
        $('.complaintOperation').addClass("disablelink");
    }

}




function createCase() {
    var CaseDataObject = {};

    var PatientObject = {}
    PatientObject.Patient_ID = $("#txtPatientId").val();

    CaseDataObject.PatientDetails = PatientObject;

    var NadiDetailsObject = {};

    NadiDetailsObject.Nadi = $("#inputNadi").val();
    NadiDetailsObject.Mala = $("#inputMala").val();
    NadiDetailsObject.Mutra = $("#inputMutra").val();
    NadiDetailsObject.Avastha = $("#ddlAvastha").val();
    NadiDetailsObject.Prakruti = $("#inputPrakruti").val();

    CaseDataObject.NadiDetails = NadiDetailsObject;


    //Complaints Data
    var ComplaintArray = []

    $("#complaintsTable > tbody > tr").each(function (i, elem) {

        var ComplaintObj = {};

        var DuratonObj = $(".col_duration");
        ComplaintObj.Complaint = $(this).find('.col_complaint').text();

        if ($(DuratonObj).attr("DurationDays") != "") {
            ComplaintObj.DurationDays = typeof $(DuratonObj).attr("DurationDays") == "undefined" ? "" : ComplaintObj.DurationDays = $(DuratonObj).attr("DurationDays");
        }
        if ($(DuratonObj).attr("DurationMonths") != "") {
            ComplaintObj.DurationMonths = typeof $(DuratonObj).attr("DurationMonths") == "undefined" ? "" : ComplaintObj.DurationMonths = $(DuratonObj).attr("DurationMonths");
        }
        if ($(DuratonObj).attr("DurationYears") != "") {
            ComplaintObj.DurationYears = typeof $(DuratonObj).attr("DurationYears") == "undefined" ? "" : ComplaintObj.DurationYears = $(DuratonObj).attr("DurationYears");
        }
        ComplaintArray.push(ComplaintObj);


    });
    CaseDataObject.ComplaintDetails = ComplaintArray;


    // Medical History
    var ComplaintObj = {};

    ComplaintObj.PastMedicalHistory = $("#inputPastMedicalHistory").val();
    ComplaintObj.PastDrugsHistory = $("#inputPastDrugsHistory").val();
    ComplaintObj.FamilyHistory = $("#inputFamilyHistory").val();

    CaseDataObject.MedicalHistory = ComplaintObj;


    // Daily Routine
    var DailyRoutineObject = {};

    DailyRoutineObject.WakeupTime = $("#inputWakeupTime").val();
    DailyRoutineObject.WaterBeforeTea = $("#ddlWaterBeforeTea").val();
    DailyRoutineObject.WaterQuantity = $("#ddlWaterQuantity").val();
    DailyRoutineObject.MorningDrink = $("#ddlMorningDring").val();
    DailyRoutineObject.Divasvaap = $("#ddlDivasvaap").val();
    DailyRoutineObject.NatureofWork = $("#ddlNatureofWork").val();
    DailyRoutineObject.WorkingHours = $("#inputWorkingHours").val();
    DailyRoutineObject.Breakfast = $("#inputBreakfast").val();
    CaseDataObject.DailyRoutine = DailyRoutineObject;



    var DietObject = {};

    DietObject.Aahar = $("#ddlAahar").val();
    DietObject.Bhaji = $("#ddlBhaji").val();
    DietObject.Koshimbir = $("#ddlKoshimbir").val();
    DietObject.Ambat = $("#ddlAmbat").val();
    DietObject.Dal = $("#ddlDal").val();
    DietObject.Chatani = $("#ddlChatani").val();
    DietObject.Vidahi = $("#ddlVidahi").val();
    DietObject.FastFood = $("#ddlFastFood").val();
    DietObject.NonVeg = $("#ddlNonVeg").val();
    DietObject.ColdDrink = $("#ddlColdDrink").val();
    DietObject.Puyrishitha = $("#ddlPuyrishitha").val();
    DietObject.FastingFood = $("#ddlFastingFood").val();
    DietObject.OilyFood = $("#ddlOilyFood").val();
    DietObject.AaharNiyam = $("#ddlAaharNiyam").val();
    DietObject.Opposite = $("#ddlOpposite").val();
    DietObject.Bakery = $("#ddlBakery").val();
    DietObject.Water = $("#ddlWater").val();
    DietObject.Fruits = $("#ddlFruits").val();
    DietObject.Other = $("#ddlOther").val();
    DietObject.VegDharan = $("#ddlVegDharan").val();
    DietObject.Habbit = $("#ddlHabbit").val();
    DietObject.KoshtaExam = $("#ddlKoshtaExam").val();
    DietObject.Sleep = $("#ddlSleep").val();
    DietObject.OjaExam = $("#ddlOjaExam").val();


    CaseDataObject.DietData = DietObject;

    $.ajax({
        type: "POST",
        url: ServerURI + "Case/CreateCase",
        data: { "PostData": JSON.stringify(CaseDataObject) },
        dataType: "json",
        async: false,
        success: function (data) {
            if (data[0] == "true") {

                caseResponse.success = true;
                caseResponse.caseID = data[2];
                caseResponse.message = data[1];
            }
            else {
                caseResponse.success = false;
                caseResponse.message = data[1];
            }
        }
    });



    return true;
}
