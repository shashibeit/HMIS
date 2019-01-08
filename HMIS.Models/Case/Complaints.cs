using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HMIS.Models.Case
{

    public class ComplaintsDetaills
    {
        public string PastMedicalHistory;
        public string PastDrugsHistory;
        public string FamilyHistory;
        public List<Complaints> ComplaintList;

    }


    public class Complaints
    {
        public string Complaint;
        public string DurationDays;
        public string DurationMonths;
        public string DurationYears;

    }

    public class DailyRoutine
    {
        public string WakeupTime;
        public string WaterBeforeTea;
        public string WaterQuantity;
        public string MorningDrink;
        public string Divasvaap;
        public string NatureofWork;
        public string WorkingHours;
        public string Breakfast;
    }

    public class DailyDiet {

        public string Aahar ;
        public string Bhaji ;
        public string Koshimbir;
        public string Ambat ;
        public string Dal;
        public string Chatani;
        public string Vidahi;
        public string FastFood ;
        public string NonVeg ;
        public string ColdDrink ;
        public string Puyrishitha ;
        public string FastingFood;
        public string OilyFood;
        public string AaharNiyam ;
        public string Opposite;
        public string Bakery ;
        public string Water ;
        public string Fruits;
        public string Other;
        public string VegDharan;
        public string Habbit;
        public string KoshtaExam ;
        public string Sleep ;
        public string OjaExam;

    }
}
