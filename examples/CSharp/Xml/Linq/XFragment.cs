using System.Collections;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;

namespace Originations.DataProviders.Xml.Linq
{
    // https://github.com/OutOfBandDevelopment/Samples/blob/master/HandyClasses/XFragment.cs
    public class XFragment : IList<XNode>
    {
        private readonly IList<XNode> _nodes = new List<XNode>();

        public XFragment()
        {
        }

        public XFragment(IEnumerable<XNode> nodes)
        {
            foreach (var node in nodes ?? Enumerable.Empty<XNode>().Where(n => n != null))
                this._nodes.Add(node);
        }

        public XFragment(XNode node, params XNode[] nodes)
            : this(new[] { node }.Concat(nodes ?? Enumerable.Empty<XNode>()))
        {
        }

        public XFragment(string xml)
            : this(XFragment.Parser(xml).ToArray())
        {
        }
        public XFragment(XmlReader xmlReader)
            : this(XFragment.Parser(xmlReader).ToArray())
        {
        }

        private static IEnumerable<XNode> Parser(string xml)
        {
            if (string.IsNullOrWhiteSpace(xml))
                yield break;


            var settings = new XmlReaderSettings
            {
                ConformanceLevel = ConformanceLevel.Fragment,
                IgnoreWhitespace = true,
                XmlResolver = null,
                DtdProcessing = DtdProcessing.Ignore,
            };


            using (var stringReader = new StringReader(xml))
            using (var xmlReader = XmlReader.Create(stringReader, settings))
            {
                foreach (var node in XFragment.Parser(xmlReader))
                    yield return node;
            }
        }

        private static IEnumerable<XNode> Parser(XmlReader xmlReader)
        {
            if (xmlReader == null)
                yield break;


            xmlReader.MoveToContent();
            while (xmlReader.ReadState != ReadState.EndOfFile)
            {
                yield return XNode.ReadFrom(xmlReader);
            }
        }

        public override string ToString()
        {
            return this;
        }

        public XmlReader CreateReader()
        {
            return XmlReader.Create(new StringReader(this), new XmlReaderSettings
            {
                ConformanceLevel = ConformanceLevel.Fragment,
                XmlResolver = null,
                DtdProcessing = DtdProcessing.Ignore,
            });
        }

        public static XFragment Parse(string xml)
        {
            return new XFragment(xml);
        }
        public static XFragment Parse(XmlReader xmlReader)
        {
            return new XFragment(xmlReader);
        }

        #region IEnumerable  

        public IEnumerator<XNode> GetEnumerator()
        {
            return (this._nodes ?? Enumerable.Empty<XNode>()).Where(n => n != null).GetEnumerator();
        }

        #endregion

        #region IList 

        public int Count { get { return this._nodes.Count; } }
        public bool IsReadOnly { get { return this._nodes.IsReadOnly; } }
        public XNode this[int index]
        {
            get { return this._nodes[index]; }
            set { this._nodes[index] = value; }
        }

        public int IndexOf(XNode item)
        {
            Contract.Requires(item != null);
            return this._nodes.IndexOf(item);
        }

        public void Insert(int index, XNode item)
        {
            Contract.Requires(item != null);
            this._nodes.Insert(index, item);
        }

        public void RemoveAt(int index)
        {
            this._nodes.RemoveAt(index);
        }

        public void Add(XNode item)
        {
            Contract.Requires(item != null);
            this._nodes.Add(item);
        }

        public void Clear()
        {
            this._nodes.Clear();
        }

        public bool Contains(XNode item)
        {
            Contract.Requires(item != null);
            return this._nodes.Contains(item);
        }

        public void CopyTo(XNode[] array, int arrayIndex)
        {
            Contract.Requires(array != null);
            this._nodes.CopyTo(array, arrayIndex);
        }

        public bool Remove(XNode item)
        {
            Contract.Requires(item != null);
            return this._nodes.Remove(item);
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return this.GetEnumerator();
        }

        #endregion

        #region Conversions  

        public static implicit operator XFragment(string xml)
        {
            return new XFragment(xml);
        }

        public static implicit operator string(XFragment fragment)
        {
            if (fragment == null)
                return null;

            var settings = new XmlWriterSettings
            {
                OmitXmlDeclaration = true,
                ConformanceLevel = ConformanceLevel.Fragment,
            };
            var sb = new StringBuilder();
            using (var xmlwriter = XmlWriter.Create(sb, settings))
            {
                foreach (var node in fragment)
                {
                    xmlwriter.WriteNode(node.CreateReader(), false);
                }
            }

            return sb.ToString();
        }

        public static implicit operator XFragment(XNode[] nodes)
        {
            return new XFragment(nodes);
        }

        public static implicit operator XFragment(XNode node)
        {
            return new XFragment(node);
        }

        #endregion
    }
}
