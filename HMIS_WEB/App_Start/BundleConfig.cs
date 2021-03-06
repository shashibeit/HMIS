﻿using System.Web.Optimization;
using WebHelpers.Mvc5;

namespace HMIS_WEB.App_Start
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/Bundles/css")
                .Include("~/Content/css/bootstrap.min.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/bootstrap-select.css")
                .Include("~/Content/css/bootstrap-datepicker3.min.css")
                .Include("~/Content/css/font-awesome.min.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/icheck/blue.min.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/js/plugins/select2/dist/css/select2.min.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/js/plugins/timepicker/bootstrap-timepicker.min.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/AdminLTE.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/smart_wizard.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/dataTables.bootstrap.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/smart_wizard_theme_arrows.css", new CssRewriteUrlTransformAbsolute())
                .Include("~/Content/css/skins/skin-blue.css")
                .Include("~/Content/css/main.css"));

            bundles.Add(new ScriptBundle("~/Bundles/js")
                .Include("~/Content/js/plugins/jquery/jquery-3.3.1.js")
                .Include("~/Content/js/plugins/bootstrap/bootstrap.js")
                .Include("~/Content/js/plugins/fastclick/fastclick.js")
                .Include("~/Content/js/plugins/slimscroll/jquery.slimscroll.js")
                .Include("~/Content/js/plugins/bootstrap-select/bootstrap-select.js")
                .Include("~/Content/js/plugins/moment/moment.js")
                .Include("~/Content/js/plugins/datepicker/bootstrap-datepicker.js")
                .Include("~/Content/js/plugins/icheck/icheck.js")
                .Include("~/Content/js/plugins/validator.js")
                .Include("~/Content/js/plugins/wizard/jquery.smartWizard.js")
                .Include("~/Content/js/plugins/inputmask/jquery.inputmask.bundle.js")
                .Include("~/Content/js/plugins/Datatables/jquery.dataTables.min.js")
                .Include("~/Content/js/plugins/Datatables/dataTables.bootstrap.min.js")
                .Include("~/Content/js/plugins/typehead/jquery.typeahead.js")
                .Include("~/Content/js/plugins/select2/dist/js/select2.full.min.js")
                .Include("~/Content/js/plugins/timepicker/bootstrap-timepicker.min.js")
                .Include("~/Content/js/adminlte.js")
                .Include("~/Content/js/init.js")
                .Include("~/Content/js/all.js"));

#if DEBUG
            BundleTable.EnableOptimizations = false;
#else
            BundleTable.EnableOptimizations = true;
#endif
        }
    }
}
