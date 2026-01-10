using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Collections.ObjectModel;

namespace RedBlack
{
    public class Node : IEnumerable<Node>
    {
        public static ReadOnlyCollection<Node> AllNodes
        {
            get
            {
                List<Node> allNodes = new List<Node>();
                foreach (Node childNode in _root)
                    allNodes.Add(childNode);
                return allNodes.AsReadOnly();
            }
        }

        //public Node this[int id]
        //{
        //    get
        //    {
        //        return this.findValue(id);
        //    }
        //}

        ~Node()
        {
            if (this.Parent != null || this.ChildL != null || this.ChildG != null)
                RemoveNode(this);
        }

        private static Node _root;
        private static int _autoNumber;

        private readonly int _id = _autoNumber++;
        private Node _parent;
        private Node _childL;
        private Node _childG;
        private int _count;
        private int _value;

        private Node(Node parent, int value)
        {
            _parent = parent;
            _value = value;
            _count = 1;
        }

        private Node(int value)
        {
            _value = value;
            _count = 1;
        }

        public static Node Root { get { return _root; } }

        public int ID { get { return _id; } }

        public Node Parent { get { return _parent; } }

        public Node ChildL { get { return _childL; } }

        public Node ChildG { get { return _childG; } }

        public int Count { get { return _count; } }

        public int Value { get { return _value; } }

        public int Weight
        {
            get
            {
                int returnVal = 1;
                if (ChildL != null)
                    returnVal += ChildL.Weight;
                if (ChildG != null)
                    returnVal += ChildG.Weight;
                return returnVal;
            }
        }

        public int MaxValue
        {
            get
            {
                if (ChildL != null && ChildG == null)
                    return Math.Max(ChildL.MaxValue, Value);
                else if (ChildL == null && ChildG != null)
                    return Math.Max(ChildG.MaxValue, Value);
                else if (ChildL != null && ChildG != null)
                    return Math.Max(ChildL.MaxValue, Math.Max(ChildG.MaxValue, Value));
                else
                    return Value;
            }
        }

        public int MinValue
        {
            get
            {
                if (ChildL != null && ChildG == null)
                    return Math.Min(ChildL.MinValue, Value);
                else if (ChildL == null && ChildG != null)
                    return Math.Min(ChildG.MinValue, Value);
                else if (ChildL != null && ChildG != null)
                    return Math.Min(ChildL.MinValue, Math.Min(ChildG.MinValue, Value));
                else
                    return Value;
            }
        }

        public static void AddValue(int value)
        {
            if (Root == null)
                _root = new Node(value);
            else
                _root.addValue(value);
        }

        public static Node FindValue(int value)
        {
            if (Root == null)
                return null;
            return Root.findValue(value);
        }

        public static void RemoveNode(Node node)
        {
            //you cant remove what doest exit so just return
            if (node == null)
                return;

            if (Root == node)
            {
                if (node.ChildL != null && node.ChildG == null)
                    _root = node.ChildL;
                else if (node.ChildL == null && node.ChildG != null)
                    _root = node.ChildG;
                else if (node.ChildL != null && node.ChildG != null)
                {
                    if (node.ChildL.Weight > node.ChildG.Weight)
                    {
                        _root = node.ChildL;
                        _root.addChild(node.ChildG);
                    }
                    else
                    {
                        _root = node.ChildG;
                        _root.addChild(node.ChildL);
                    }
                }
            }
            else if (node.Parent != null)
            {
                if (node.Parent.ChildG == node)
                    node.Parent._childG = null;
                else if (node.Parent.ChildL == node)
                    node.Parent._childL = null;

                node.Parent.addChild(node.ChildL);
                node.Parent.addChild(node.ChildG);
            }

            node._parent = null;
            node._childG = null;
            node._childL = null;
            node = null;
        }

        public static void RebalanceTree()
        {
            int medianValue = (_root.MaxValue - _root.MinValue) / 2;

            if (medianValue <= 0 || _root.Value == medianValue)
                return;

            Node oldRoot = _root;
            _root = _root.findClosestValue(medianValue);

            if (_root.Parent != null)
            {
                if (_root == _root.Parent.ChildG)
                    _root.Parent._childG = null;
                else if (_root == _root.Parent.ChildL)
                    _root.Parent._childL = null;
                _root._parent = null;
            }
            _root.addChild(oldRoot);

            _root.rebalanceTree();
        }

        public static void ResetTree()
        {
            _root = null;
        }

        private void rebalanceTree()
        {
            Node childL = this.ChildL;
            Node childG = this.ChildG;
            this._childL = null;
            this._childG = null;
            if (childL != null)
            {
                childL.rebalanceTree();
                Root.addChild(childL);
            }
            if (childG != null)
            {
                childG.rebalanceTree();
                Root.addChild(childG);
            }
        }

        private void addChild(Node node)
        {
            if (node == null)
                return;

            if (this.Value < node.Value)
            {
                if (this.ChildL == null)
                {
                    node._parent = this;
                    this._childL = node;
                }
                else
                    this.ChildL.addChild(node);
            }
            else
            {
                if (this.ChildG == null)
                {
                    node._parent = this;
                    this._childG = node;
                }
                else
                    this.ChildG.addChild(node);
            }
        }

        private void addValue(int value)
        {
            if (value == Value)
                _count++;
            else if (value > Value)
            {
                if (ChildG == null)
                    _childG = new Node(this, value);
                else
                    ChildG.addValue(value);
            }
            else
            {
                if (ChildL == null)
                    _childL = new Node(this, value);
                else
                    ChildL.addValue(value);
            }
        }

        private Node findValue(int value)
        {
            if (value == Value)
                return this;
            else if (value > Value)
            {
                if (ChildG == null)
                    return null;
                else
                    return ChildG.findValue(value);
            }
            else
            {
                if (ChildL == null)
                    return null;
                else
                    return ChildL.findValue(value);
            }
        }

        private Node findClosestValue(int value)
        {
            if (value == Value)
                return this;
            else if (value > Value)
            {
                if (ChildG == null)
                    return ChildL ?? this;
                else
                    return ChildG.findClosestValue(value);
            }
            else
            {
                if (ChildL == null)
                    return ChildG ?? this;
                else
                    return ChildL.findClosestValue(value);
            }
        }

        public override string ToString()
        {
            if (Count > 1)
                return string.Format("{0} ({1}) Cnt:{2} ", Value, ID, Count);
            else
                return string.Format("{0} ({1})", Value, ID);
        }

        public override int GetHashCode()
        {
            return Weight.GetHashCode();
        }

        #region IEnumerable<Node> Members

        public IEnumerator<Node> GetEnumerator()
        {
            if (ChildG != null)
            {
                IEnumerator<Node> childG = ChildG.GetEnumerator();
                while (childG.MoveNext())
                {
                    yield return childG.Current;
                }
            }
            yield return this;
            if (ChildL != null)
            {
                IEnumerator<Node> childL = ChildL.GetEnumerator();
                while (childL.MoveNext())
                {
                    yield return childL.Current;
                }
            }
        }

        #endregion

        #region IEnumerable Members

        IEnumerator IEnumerable.GetEnumerator()
        {
            yield return this.GetEnumerator();
        }

        #endregion

    }
}
