

namespace OsciRenderClient;

public class OsciFrame
{
    public double FocalLength { get; set; } // e.g. -0.05 * lens_mm
    public List<OsciObject> Objects { get; set; } = new();
}
