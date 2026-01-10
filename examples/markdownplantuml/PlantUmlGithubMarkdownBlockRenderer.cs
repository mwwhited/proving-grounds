using Markdig;
using Markdig.Renderers.Normalize;

namespace markdownplantuml
{
    public class PlantUmlGithubMarkdownBlockRenderer : NormalizeObjectRenderer<PlantUmlBlock>
    {
        private readonly PlantUmlRenderer _renderer;
        public PlantUmlGithubMarkdownBlockRenderer(MarkdownPipeline pipeline) => _renderer = new PlantUmlRenderer(pipeline);
        protected override void Write(NormalizeRenderer renderer, PlantUmlBlock obj) => _renderer.Write(renderer, obj.GetScript());
    }
}
