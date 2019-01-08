$(document).ready(function () {


    showPatientDetails();


    $("#btnProceedtoFollowup").click(function () {
        var PatinetId = getUrlParameter("Patient_ID");
        var CaseID = getUrlParameter("CASE_ID");
        var FOLLOWUP_ID = getUrlParameter("FOLLOWUP_ID");
        window.location.href = ServerURI + "Case/Medicine?Patient_ID=" + PatinetId + "&Case_ID=" + CaseID+"&FollowupID="+FOLLOWUP_ID;
        return false;
    });

});



function showPatientDetails() {
    var PatinetId = getUrlParameter("Patient_ID");
    var CaseID = getUrlParameter("CASE_ID");

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


    $.ajax({
        type: "POST",
        url: ServerURI + "FollowUp/GetFollowupDetilsByCase",
        data: { "CaseID": CaseID },
        dataType: "json",
        async: false,
        success: function (data) {
            // console.log(data);
            var rowsinTable = 1;
            $(data).each(function (idx, val) {
                var FollowupDate = val.FOLLOWUP_DATE
                var FollowupStatus = val.FOLLOWUP_STATUS
                var FollowupDoneDate = val.FOLLOWUP_DONE_DATE
                var cls = "";

                if (FollowupStatus == "COMPLETE")
                    cls = "success";
                else if (FollowupStatus == "PENDING")
                    cls = "warning";
                else if (FollowupStatus == "OVERDUE")
                    cls = "danger";
                else 
                    cls = "warning";

                var tableRow = "<tr class='" + cls + "'>";
                tableRow += "<td class='srno' idx=" + rowsinTable + ">" + rowsinTable + ".</td>";
                tableRow += "<td>" + FollowupDate + "</td>";
                tableRow += "<td>" + FollowupStatus + "</td>";
                tableRow += "<td>" + FollowupDoneDate + "</td>";
                tableRow += "</tr>";
                rowsinTable++;
               // console.log(tableRow);
                $("#FollowupTable tbody").append(tableRow);
            });
           
        }
    });
}
