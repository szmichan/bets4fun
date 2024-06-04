using System;

namespace Bets4Fun.Common
{
    public class DateConverter
    {
        //public static int hourOffset = 0;

        public static DateTime ConvertToCest(DateTime dateTime)
        {
            //if (!int.TryParse(ConfigurationManager.AppSettings["MinutesOffset"], out hourOffset))
            //{
            //    hourOffset = 0;
            //}
            return TimeZoneInfo.ConvertTime(dateTime, TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time"));
        }

        public static DateTimeOffset ConvertToCest(DateTimeOffset dateTimeOffset)
        {
            return TimeZoneInfo.ConvertTime(dateTimeOffset, TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time"));
        }

        public static DateTimeOffset ConvertToUtcFromTimeZone(DateTime dateTime, TimeZoneInfo timeZone)
        {
            dateTime = DateTime.SpecifyKind(dateTime, DateTimeKind.Unspecified);
            return TimeZoneInfo.ConvertTimeToUtc(dateTime, timeZone);
        }

        public static DateTimeOffset ConvertToUtcFromCest(DateTime dateTime)
            => ConvertToUtcFromTimeZone(dateTime, TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time"));
    }
}
