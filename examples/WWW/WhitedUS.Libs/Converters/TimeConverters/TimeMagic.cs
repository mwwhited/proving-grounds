using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Libs.Converters.TimeConverters
{
    /// <summary>
    /// Time Controller (idea from some dude on the internet)
    /// </summary>
    public static class TimeMagic
    {
        /// <summary>
        /// Convert int into a TimeSpam in minutes
        /// </summary>
        /// <param name="_Minutes">Length of Time in Minutes</param>
        /// <returns>TimeSpan in minutes</returns>
        public static TimeSpan Minutes(this int _Minutes)
        {
            return new TimeSpan(0, _Minutes, 0);
        }

        /// <summary>
        /// Convert int into a TimeSpam in minutes
        /// </summary>
        /// <param name="_Seconds">Length of Time in Seconds</param>
        /// <returns>TimeSpan in Seconds</returns>     
        public static TimeSpan Seconds(this int _Seconds)
        {
            return new TimeSpan(0, 0, _Seconds);
        }

        /// <summary>
        /// Convert int into a TimeSpam in minutes
        /// </summary>
        /// <param name="_Hours">Length of Time in Hours</param>
        /// <returns>TimeSpan in Hours</returns>
        public static TimeSpan Hours(this int _Hours)
        {
            return new TimeSpan(_Hours, 0, 0);
        }

        /// <summary>
        /// Convert int into a TimeSpam in minutes
        /// </summary>
        /// <param name="_Days">Length of Time in Days</param>
        /// <returns>TimeSpan in Days</returns>
        public static TimeSpan Days(this int _Days)
        {
            return new TimeSpan(_Days, 0, 0, 0);
        }

        /// <summary>
        /// Convert int into a TimeSpam in minutes
        /// </summary>
        /// <param name="_Milliseconds">Length of Time in Milliseconds</param>
        /// <returns>TimeSpan in Milliseconds</returns>
        public static TimeSpan Milliseconds(this int _Milliseconds)
        {
            return new TimeSpan(0, 0, 0, 0, _Milliseconds);
        }

        /// <summary>
        /// Get Time before now
        /// </summary>
        /// <param name="_TimeSpan">Amount of time to go back</param>
        /// <returns>back in time based on timespan</returns>
        public static DateTime Ago(this TimeSpan _TimeSpan)
        {
            return _TimeSpan.Before(DateTime.Now);
        }

        /// <summary>
        /// Get Time from Now
        /// </summary>
        /// <param name="_TimeSpan">Ammount of time to add</param>
        /// <returns>forward in time from now</returns>
        public static DateTime FromNow(this TimeSpan _TimeSpan)
        {
            return _TimeSpan.From(DateTime.Now);
        }

        /// <summary>
        /// Get Time before Input Time based on TimeSpan
        /// </summary>
        /// <param name="_TimeSpan">Difference in Time</param>
        /// <param name="_DateTime">Selected Time</param>
        /// <returns>Differential Time</returns>
        public static DateTime Before(this TimeSpan _TimeSpan, 
                                      DateTime _DateTime)
        {
            return _DateTime.Subtract(_TimeSpan);
        }

        /// <summary>
        /// Get Time from Input Time based on TimeSpan
        /// </summary>
        /// <param name="_TimeSpan">Difference in Time</param>
        /// <param name="_DateTime">Selected Time</param>
        /// <returns>Differential Time</returns>
        public static DateTime From(this TimeSpan _TimeSpan, 
                                    DateTime _DateTime)
        {
            return _DateTime.Add(_TimeSpan);
        }

        /// <summary>
        /// Selected time is less then Now
        /// </summary>
        /// <param name="_DateTime">Selected Time</param>
        /// <returns>Boolean true if before now</returns>
        public static bool IsHistory(this DateTime _DateTime)
        {
            return _DateTime < DateTime.Now;
        }

        /// <summary>
        /// Selected time is greater then now
        /// </summary>
        /// <param name="_DateTime">Selected Time</param>
        /// <returns>Boolean true is time is after now</returns>
        public static bool IsFuture(this DateTime _DateTime)
        {
            return _DateTime > DateTime.Now;
        }
    }
}
