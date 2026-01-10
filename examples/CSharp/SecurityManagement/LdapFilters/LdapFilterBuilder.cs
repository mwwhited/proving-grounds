using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapFilterBuilder
    {
        public string Build(ILdapFilter filter)
        {
            if (filter == null)
            {
                throw new ArgumentNullException("filter");
            }

            var result = Build(filter as LdapSimpleFilter)
                      ?? Build(filter as LdapFilterSetBase)
                      ?? Build(filter as LdapNotFilter)
                      ;
            if (result == null)
            {
                throw new NotSupportedException(string.Format("LdapFilterType: {0} is not supported", filter.GetType()));
            }

            return result;
        }


        private string Build(LdapNotFilter filter)
        {
            if (filter == null)
            {
                return null;
            }

            return string.Format("(!{0})", Build(filter.Wrapped));
        }

        private readonly Dictionary<LdapFilterTypes, string> _simpleMap = new Dictionary<LdapFilterTypes, string>()
        {
            { LdapFilterTypes.Equals, "="},
            { LdapFilterTypes.Approximate, "~="},
            { LdapFilterTypes.GreaterThanOrEqualTo, ">="},
            { LdapFilterTypes.LessThanOrEqualTo, "<="},
        };
        private string Build(LdapSimpleFilter filter)
        {
            if (filter == null)
            {
                return null;
            }

            if (string.IsNullOrWhiteSpace(filter.AttributeName))
            {
                throw new NullReferenceException("filter.AttributeName must be provided");
            }

            var notAllowed = "()*\0";
            if (notAllowed.Any(c => filter.AttributeName.Contains(c)))
            {
                throw new InvalidOperationException("Invalid character found in filter.AttributeName");
            }
            return string.Concat("(", filter.AttributeName, _simpleMap[filter.Operation], (string)filter.Value, ")");
        }

        private readonly Dictionary<LdapFilterSetOperations, string> _setMap = new Dictionary<LdapFilterSetOperations, string>()
        {
            { LdapFilterSetOperations.And, "&"},
            { LdapFilterSetOperations.Or, "|"},
        };
        internal string Build(LdapFilterSetBase filter)
        {
            if (filter == null)
            {
                return null;
            }

            return (filter.FilterSet ?? Enumerable.Empty<ILdapFilter>())
                    .Aggregate(new StringBuilder("(" + _setMap[filter.Operation]),
                               (b, v) => b.Append(Build(v)),
                               b => b.Append(")").ToString()
                               );
        }
    }
}
