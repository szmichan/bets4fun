using System.Web.UI;

namespace Bets4Fun.Common
{
    public static class DataBinderExtensions
    {
        public static T Eval<T>(object container, string expression)
        {
            var value = DataBinder.Eval(container, expression);
            var valueStr = value.ToString();
            return (T)(string.IsNullOrWhiteSpace(valueStr) ? null : value);
        }
    }
}