using Markdig;
using System.IO;

namespace markdownplantuml
{
    class Program
    {
        static void Main(string[] args)
        {
            var filePath = "Design.md";
            var markdownText = File.ReadAllText(filePath);

            var pipeline = new MarkdownPipelineBuilder()
                .UseAdvancedExtensions()
                .UsePlantuml()
                .Build()
                ;

            var md = Markdown.Parse(markdownText, pipeline);

            var markdown = Markdown.Normalize(markdownText, new Markdig.Renderers.Normalize.NormalizeOptions
            {
                EmptyLineAfterCodeBlock = true,
                EmptyLineAfterHeading = true,
                EmptyLineAfterThematicBreak = true,
                ExpandAutoLinks = true,
                ListItemCharacter = '-',
                SpaceAfterQuoteBlock = true,
            }, pipeline);
            File.WriteAllText(filePath + ".md", markdown);

            var plainText = Markdown.ToPlainText(markdownText, pipeline);
            File.WriteAllText(filePath + ".txt", plainText);

            //visitor commonmark + plantuml to github mark + plantuml images
            var html = Markdown.ToHtml(markdownText, pipeline);
            File.WriteAllText(filePath + ".html", html);
        }
    }
}
