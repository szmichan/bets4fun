using System.Diagnostics;

namespace Bets4Fun
{
    public static class AssemblyHelper
    {
        public static string AssemblyVersion
        {
            get
            {
                var assembly = System.Reflection.Assembly.GetExecutingAssembly();
                var fvi = FileVersionInfo.GetVersionInfo(assembly.Location);
                return fvi.FileVersion;
            }
        }
    }
}