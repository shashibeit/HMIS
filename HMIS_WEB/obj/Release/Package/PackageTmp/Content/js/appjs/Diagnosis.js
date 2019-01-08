
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

    //$("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {
    //    //  console.log(stepNumber);
    //    //if (stepNumber === 3) {
    //    //    return createCase();
    //    //}
    //    return true;
    //});


    $("#smartwizard").on("leaveStep", function (e, anchorObject, stepNumber, stepDirection) {

        if (stepNumber === 0) {
            if (_showDiagnosisDetails()) {
            }
            return true;
        }
    });


    $("#btnMedicine").click(function () {
        $(".panchakarma-types").hide();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/Medicine?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;

        return false;
    });

    $("#btnMassage").click(function () {
        $(".panchakarma-types").hide();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
       // window.location.href = ServerURI + "Case/Medicine?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;

        return false;
    });

    $("#btnPanchakarma").click(function () {
        $(".panchakarma-types").show();
    //    window.location.href = ServerURI + "Case/Medicine?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;

        return false;
    });

    $("#btnVaman").click(function () {
        $(".panchakarma-types").show();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/Vaman?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;
        return false;
    });

    $("#btnVirechana").click(function () {
        $(".panchakarma-types").show();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/Virechana?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;
        return false;
    });

    $("#btnBasti").click(function () {
        $(".panchakarma-types").show();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/Basti?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;
        return false;
    });

    $("#btnNasya").click(function () {
        $(".panchakarma-types").show();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/Nasya?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;
        return false;
    });

    $("#btnRaktaMokshana").click(function () {
        $(".panchakarma-types").show();
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseId = getUrlParameter("Case_ID");
        window.location.href = ServerURI + "Case/RaktaMokshana?Patient_ID=" + PatinetId + "&Case_ID=" + CaseId;
        return false;
    });

});


function _showDiagnosisDetails() {

    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("Case_ID");

    var DiagnosisData = {};
    DiagnosisData.PatinetId = PatinetId;
    DiagnosisData.CaseID = CaseID;
    DiagnosisData.Rugnabal = $('#ddlRugnaBal').selectpicker('val').join(", ");
    DiagnosisData.VyadhiBal = $('#ddlVyadhiBal').selectpicker('val').join(", ");
    DiagnosisData.Vaat = $('#ddlVaat').selectpicker('val').join(", ");
    DiagnosisData.Pitta = $('#ddlPitta').selectpicker('val').join(", ");
    DiagnosisData.Cough = $('#ddlCough').selectpicker('val').join(", ");
    DiagnosisData.Dosha = $('#ddlDosha').selectpicker('val').join(", ");
    DiagnosisData.Strotas = $('#ddlStrotas').selectpicker('val').join(", ");
    DiagnosisData.Avastha = $('#ddlAvastha').selectpicker('val');
    DiagnosisData.JathraAgni = $('#ddlJathraAgni').selectpicker('val').join(", ");
    DiagnosisData.DwhtaAgni = $('#ddlDwhtaAgni').selectpicker('val').join(", ");
    DiagnosisData.MahaBhutaAgni = $('#ddlMahaBhutaAgni').selectpicker('val').join(", ");
    DiagnosisData.VyahiNidan = $('#inputVyahiNidan').val();
    var DiagnosisObject = {};
    DiagnosisObject.DiagnosisData = DiagnosisData;
    $.ajax({
        type: "POST",
        url: ServerURI + "Case/InsertDiagnosisDetails",
        data: { "PostData": JSON.stringify(DiagnosisObject) },
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


