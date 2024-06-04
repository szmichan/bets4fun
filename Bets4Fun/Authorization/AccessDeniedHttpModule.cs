using System;
using System.Web;
using System.Web.Configuration;

namespace Bets4Fun.Authorization
{
    public class AccessDeniedHttpModule : IHttpModule
    {
        static bool _enabled;
        static string _redirectPage;
        static string _loginPage;
        static bool _remoteOnly;
        const int AccessDeniedStatusCode = 401;

        static AccessDeniedHttpModule()
        {
            var section = (CustomErrorsSection)WebConfigurationManager.GetWebApplicationSection(@"system.web/customErrors");
            if (section == null || section.Mode == CustomErrorsMode.Off)
            {
                _enabled = false;
            }
            else
            {
                _remoteOnly = section.Mode == CustomErrorsMode.RemoteOnly;
                var definedError = section.Errors.Get(AccessDeniedStatusCode.ToString());
                _redirectPage = definedError != null ? definedError.Redirect : section.DefaultRedirect;
                _enabled = true;
            }
            var authSection = (AuthenticationSection)WebConfigurationManager.GetWebApplicationSection(@"system.web/authentication");
            if (authSection != null && authSection.Mode == AuthenticationMode.Forms)
            {
                _loginPage = authSection.Forms.LoginUrl;
            }
        }

        void RedirectWhenAccessDenied(object sender, EventArgs e)
        {
            var application = (HttpApplication)sender;
            /*
            if (remoteOnly && application.Request.IsLocal) return;
            if (application.Response.StatusCode != AccessDeniedStatusCode || !application.Request.IsAuthenticated) return;

            application.Response.ClearContent();
            application.Server.Execute(redirectPage);
             */

            if (!_remoteOnly || !application.Request.IsLocal)
            {
                /*
                if ((application.Response.StatusCode == AccessDeniedStatusCode) && (application.Request.IsAuthenticated))
                {
                    application.Response.ClearContent();
                    application.Server.Execute(redirectPage);
                }
                 */
                var b = application.Request.IsAuthenticated;
                var retUrl = application.Request.QueryString["ReturnUrl"];
                var str = application.Request.FilePath;
                var b1 = str.EndsWith(_loginPage);


                if (application.Request.IsAuthenticated && !string.IsNullOrEmpty(application.Request.QueryString["ReturnUrl"]) && application.Request.FilePath.EndsWith(_loginPage))
                {

                    application.Response.Redirect(_redirectPage + "?ReturnUrl=" + application.Request.QueryString["ReturnUrl"]);
                    //application.Server.Execute(redirectPage);
                }
            }
        }

        #region IHttpModule Members

        public void Init(HttpApplication context)
        {
            if (_enabled)
            {
                context.EndRequest += RedirectWhenAccessDenied;
            }
        }

        public void Dispose()
        {
           // throw new NotImplementedException();
        }

        #endregion
    }
}
