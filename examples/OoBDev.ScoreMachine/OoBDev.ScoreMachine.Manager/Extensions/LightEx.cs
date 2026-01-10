using OoBDev.ScoreMachine.Common;

namespace OoBDev.ScoreMachine.Manager.Extensions
{
    public static class LightEx
    {
        public static string MapColor(this Lights light, string touchColor)
        {
            switch (light)
            {
                default:
                case Lights.None:
                    return "transparent";

                case Lights.Touch:
                    return touchColor;

                case Lights.White:
                case Lights.Yellow:
                    return light.ToString().ToLower();
            }
        }
    }
}
