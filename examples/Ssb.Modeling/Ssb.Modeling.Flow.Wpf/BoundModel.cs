using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;

namespace Ssb.Modeling.Flow.Wpf
{
    public class BoundModel
    {
        public enum Types
        {
            Endpoint,
            Message,
            Sender,
            Receiver

        }

        public Types Type { get; set; }

        public MessageModel Message { get; set; }

        public Rect Rect { get; set; }

        public string Service { get; set; }
    }
}
