using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    public class PathPartModel
    {
        public int Level { get; private set; }
        public string Name { get; private set; }

        public PathPartModel(string name, int level)
        {
            this.Level = level;
            this.Name = name;
        }
    }

    [SqlFunction(
        Name = "SplitPath",
        TableDefinition = "[Level] INT, [Name] NVARCHAR(200)",
        FillRowMethodName = "ParsePath"
        )]
    public static IEnumerable SplitPath(string path)
    {
        return path.Split('/', '\\')
                   .Select((v, i) => new PathPartModel(v, i));
    }

    public static void ParsePath(object obj, out SqlInt32 level, out SqlString name)
    {
        var part = obj as PathPartModel;
        level = part.Level;
        name = part.Name;
    }
}

