using Markdig.Parsers;
using Markdig.Syntax;
using System;

namespace markdownplantuml
{
    public class PlantUmlBlock : FencedCodeBlock
    {
        public PlantUmlBlock(BlockParser parser) : base(parser)
        {
        }

        public string GetScript()
        {
            if (Lines.Count > 0)
            {
                return string.Join(Environment.NewLine, Lines);
            }
            else
                return "";
        }
    }
}
