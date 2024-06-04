using System;

namespace Bets4Fun.Common
{
    public class ZpException : Exception
    {
        public ZpException()
            : base()
        {
        }

        public ZpException(string message)
            : base(message)
        {
        }
    }
}
