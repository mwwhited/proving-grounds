using Microsoft.VisualStudio.TestTools.UnitTesting;
using OobDev.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common.Tests
{
    [TestClass]
    public class DateTimeExTests
    {
        [TestMethod()]
        public void UnixTimeStampToLocalDateTimeTest()
        {
            var local = 0L.UnixTimeStampToLocalDateTime();
            var utc = local.ToUniversalTime();
            Assert.AreEqual(utc, new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc));

            local = 385118400L.UnixTimeStampToLocalDateTime();
            utc = local.ToUniversalTime();
            Assert.AreEqual(utc, new DateTime(1982, 3, 16, 9, 20, 0, DateTimeKind.Utc));
        }

        [TestMethod()]
        public void LocalDateTimeToUnixTimeStampTest()
        {
            var utc = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var unix = utc.LocalDateTimeToUnixTimeStamp();
            Assert.AreEqual(unix, 0L);

            utc = new DateTime(1982, 3, 16, 9, 20, 0, DateTimeKind.Utc);
            unix = utc.LocalDateTimeToUnixTimeStamp();
            Assert.AreEqual(unix, 385118400L);
        }
    }
}
