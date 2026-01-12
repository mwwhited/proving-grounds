using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Web.Controls
{
    [Serializable]
    public class ImageData
    {
        private readonly TimeSpan _expiry = TimeSpan.FromMinutes(5);

        public ImageData()
        {
            _timeStamp = DateTime.UtcNow;
        }

        public ImageData(TimeSpan expiry)
        {
            _timeStamp = DateTime.UtcNow;
            _expiry = expiry;
        }

        private byte[] _buffer;
        public byte[] Buffer
        {
            get
            {
                _timeStamp.Add(_expiry);
                return _buffer;
            }
            set { _buffer = value; }
        }

        public string MimeType { get; set; }

        public string Key { get; set; }

        private DateTime _timeStamp;
        public DateTime TimeStamp { get { return _timeStamp; } }

        public bool IsExpired
        {
            get { return _timeStamp.Add(_expiry) < DateTime.UtcNow; }
        }
    }
}
