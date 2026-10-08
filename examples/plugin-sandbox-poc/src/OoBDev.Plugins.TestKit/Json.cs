using OoBDev.Plugins.Host;
using System.Text.Json;
using System.Text.Json.Nodes;

namespace OoBDev.Plugins.TestKit;

public static class Json
{
    public static JsonElement Of(object? value) => JsonSerializer.SerializeToElement(value);

    public static bool Equal(JsonElement? actual, object? expected)
        => actual is { } a && JsonNode.DeepEquals(JsonNode.Parse(a.GetRawText()), JsonSerializer.SerializeToNode(expected));
}
