using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Samples.Libs
{
    public class TestLicenseProvider : LicenseProvider
    {
        public override License GetLicense(LicenseContext context, Type type, object instance, bool allowExceptions)
        {
            var lic = TestLicense.Create(context, type, instance, allowExceptions);
            return lic;
        }
    }
}
