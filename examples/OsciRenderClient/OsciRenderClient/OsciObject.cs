
namespace OsciRenderClient;

public class OsciObject
{
    public double[] CameraSpaceMatrix { get; set; } = Identity4x4();
    public List<OsciStroke> Strokes { get; set; } = new();

    public static double[] Identity4x4() => new double[]
    {
        1,0,0,0,
        0,1,0,0,
        0,0,1,0,
        0,0,0,1
    };
}
