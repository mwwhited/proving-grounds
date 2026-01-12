using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Data;
using System.IO;
using System.Windows.Media.Imaging;
using System.Globalization;

namespace PhotoAlbumViewer
{
    public class BinaryImageConverter : IValueConverter
    {
        object IValueConverter.Convert(object value, 
                                       Type targetType, 
                                       object parameter, 
                                       CultureInfo culture)
        {
            if (value != null && value is byte[])
            {
                byte[] bytes = value as byte[];
                MemoryStream stream = new MemoryStream(bytes);
                BitmapImage image = new BitmapImage();
                image.BeginInit();
                image.StreamSource = stream;
                image.EndInit();
                return image;
            } return null;
        }

        object IValueConverter.ConvertBack(object value, 
                                           Type targetType, 
                                           object parameter, 
                                           CultureInfo culture)
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
