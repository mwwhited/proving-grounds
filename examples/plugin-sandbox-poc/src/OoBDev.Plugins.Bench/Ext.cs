internal static class Ext { public static byte[] GetBytes(this Random r, int n) { var b = new byte[n]; r.NextBytes(b); return b; } }
