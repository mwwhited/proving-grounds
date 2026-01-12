using System;
using System.Diagnostics;
using System.Linq;
using System.Xml;
using System.Xml.XPath;
using WhitedUS.Libs.Xml.Linq;

namespace WhitedUS.Libs.Xml.XPath
{
    public class XPathObjectNavigator : XPathNavigator
    {
        private static readonly string _typeNamespace = typeof(Type).ResolveNamespace();

        public XPathObjectNavigator(object value)
            : this(value.GetType().Name, value)
        {
        }
        public XPathObjectNavigator(string localName, object value)
        {
            _value = value;
            _localName = localName;
            _nameTable = new NameTable();
            _namespaceURI = value.ResolveNamespace();
            _nodeType = XPathNodeType.Element;
        }
        private XPathObjectNavigator() { }
        private XPathObjectNavigator(string localName,
                                     object value,
                                     XmlNameTable nameTable,
                                     XPathObjectNavigator parent,
                                     XPathNodeType nodeType)
        {
            Parent = parent;
            _value = value;
            _localName = localName;
            _nameTable = nameTable;
            _namespaceURI = value.ResolveNamespace();
            _nodeType = nodeType;
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _baseURI;
        public override string BaseURI { get { return _baseURI; } }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _namespaceURI;
        public override string NamespaceURI { get { return _namespaceURI; } }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _prefix;
        public override string Prefix { get { return _prefix; } }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _localName;
        public override string LocalName { get { return _localName; } }
        public override string Name { get { return _localName; } }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private XPathNodeType _nodeType;
        public override XPathNodeType NodeType { get { return _nodeType; } }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private XmlNameTable _nameTable;
        public override XmlNameTable NameTable { get { return _nameTable; } }

        protected XPathObjectNavigator Parent { get; private set; }
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private object _value;

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private object _elementsLock = new object();
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private XPathObjectNavigator[] _elements;
        internal XPathObjectNavigator[] Elements
        {
            get
            {
                if (_elements == null)
                {
                    lock (_elementsLock)
                        if (_elements == null)
                            if (_value == null || _value is Type)
                                _elements = new XPathObjectNavigator[0];
                            else
                            {
                                var type = _value.GetType();

                                var readableProperties = type.GetProperties()
                                                             .Where(prop => prop.CanRead);
                                var withoutIndexers = readableProperties
                                                             .Where(p => !p.GetIndexParameters()
                                                                           .Any());
                                var nameValues = withoutIndexers.Select(p =>
                                    new
                                    {
                                        name = p.Name,
                                        value = p.GetValue(_value, null),
                                    });
                                var properySet = nameValues.Where(p => p.value != null);

                                _elements = properySet.Select(p =>
                                    new XPathObjectNavigator(p.name,
                                                             p.value,
                                                             _nameTable,
                                                             this,
                                                             XPathNodeType.Element
                                                             )

                                    ).ToArray();
                            }
                }
                return _elements;
            }
        }

        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private object _attributesLock = new object();
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private XPathObjectNavigator[] _attributes;
        internal XPathObjectNavigator[] Attributes
        {
            get
            {
                if (_attributes == null)
                {
                    lock (_attributesLock)
                        if (_attributes == null)
                        {
                            if (_value == null || _value is Type)
                                _attributes = new XPathObjectNavigator[0];
                            else
                                _attributes = new[]{
                                new XPathObjectNavigator("type", 
                                                         _value.GetType(), 
                                                         _nameTable, 
                                                         this, 
                                                         XPathNodeType.Attribute)
                                {
                                     _prefix="t",
                                     _namespaceURI = _typeNamespace,
                                },
                            };
                        }
                }
                return _attributes;
            }
        }

        public override string Value
        {
            get { return _value != null ? _value.ToString() : null; }
        }
        public override bool IsEmptyElement
        {
            get { return _value == null; }
        }

        public override XPathNavigator Clone()
        {
            return new XPathObjectNavigator()
            {
                _attributes = Attributes.ToArray(),
                _elements = Elements.ToArray(),
                Parent = Parent,
                _value = _value,
                _baseURI = BaseURI,
                _namespaceURI = NamespaceURI,
                _prefix = Prefix,
                _localName = LocalName,
                _nodeType = NodeType,
            };
        }

        public override bool MoveToFirstNamespace(XPathNamespaceScope namespaceScope)
        {
            throw new NotImplementedException();
        }
        public override bool MoveToNextNamespace(XPathNamespaceScope namespaceScope)
        {
            throw new NotImplementedException();
        }

        public override bool IsSamePosition(XPathNavigator other)
        {
            throw new NotImplementedException();
        }

        public override bool MoveTo(XPathNavigator other)
        {
            throw new NotImplementedException();
        }

        public override bool MoveToFirstAttribute()
        {
            throw new NotImplementedException();
        }
        public override bool MoveToNextAttribute()
        {
            throw new NotImplementedException();
        }

        public override bool MoveToId(string id)
        {
            throw new NotImplementedException();
        }

        public override bool MoveToNext()
        {
            throw new NotImplementedException();
        }

        public override bool MoveToParent()
        {
            throw new NotImplementedException();
        }

        public override bool MoveToFirstChild()
        {
            throw new NotImplementedException();
        }

        public override bool MoveToPrevious()
        {
            throw new NotImplementedException();
        }
    }
}
