
$(document).ready(function () {

    $.ajax({
        type: "POST",
        url: ServerURI + "Home/GetFollowupDetails",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.length > 0) {
                $("#FollowupTable tbody").empty();
                var pageUrl = "";
                $(data).each(function (idx, value) {

                    var rowsinTable = 0;
                    if (parseInt($('#FollowupTable tbody tr').length) <= 0) {
                        rowsinTable = 1;
                    }
                    else {
                        rowsinTable = parseInt($('#FollowupTable tbody tr').length) + 1;
                    }

                    var CASE_ID = value.CASE_ID;
                    var PATIENT_ID = value.PATIENT_ID;
                    var FOLLOWUP_FOR = value.FOLLOWUP_FOR;
                    var FOLLOWUP_ID = value.FOLLOWUP_ID;    
                
                    var badge = "bg-red";
                    var tbl_class = "active"
                    if (value.FOLLOWUP_FOR == "MEDICINE") {
                        badge = "bg-red";
                        tbl_class = "danger";
                    }
                    else if (value.FOLLOWUP_FOR == "PANCHAKARMA") {
                        tbl_class = "success";
                        badge = "bg-green";
                    }
                    else if (value.FOLLOWUP_FOR == "MASSAGE") {
                        tbl_class = "info";
                        badge = "bg-light-blue";
                    }


                    var tableRow = "<tr class='" + tbl_class + "'>";
                    tableRow += "<td>" + rowsinTable + " </td>";
                    tableRow += "<td>" + value.PATIENT_ID + "</td>";
                    tableRow += "<td>" + value.PATIENT_NAME + "</td>";
                    tableRow += "<td>" + value.MOBILE_NO + "</td>";
                    tableRow += "<td><span class='badge " + badge + "'>" + value.FOLLOWUP_FOR + "</span></td>";
                    tableRow += "<td><a target='blank' href='/HMIS_WEB/FollowUp/Index?Patient_ID=" + PATIENT_ID + "&CASE_ID=" + CASE_ID + "&FOLLOWUP_FOR=" + FOLLOWUP_FOR + "&FOLLOWUP_ID=" + FOLLOWUP_ID+"'><span class='badge " + badge + "'>&nbsp;<i class='fa fa-chevron-right'></i>&nbsp;</span></td>";
                    tableRow += "</tr>";


                    $("#FollowupTable tbody").append(tableRow);

                });
            }
            else {
                var tableRow = "<tr>";
                tableRow += "<td colspan='6'><center>No followup details for today</center></td>";
                 tableRow += "</tr>";


                $("#FollowupTable tbody").append(tableRow);

            }
        }
    });


});

