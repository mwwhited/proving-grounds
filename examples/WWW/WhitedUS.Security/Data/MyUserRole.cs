using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Security.Data
{
    public partial class MyUserRole
    {
        public MyRole Role { get; set; }
        public MyUser User { get; set; }
    }
}
