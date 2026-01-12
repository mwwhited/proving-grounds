using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace WhitedUS.Libs.Xml.Linq
{
    public static class ReflectionTools
    {
        /// <summary>
        /// Get the first matching attribute of type 
        /// <typeparamref name="TAttribute">TAttribute</typeparamref> on
        /// <paramref name="memberInfo">memberInfo</paramref>
        /// </summary>
        /// <typeparam name="TAttribute">Attribute Type to find</typeparam>
        /// <param name="memberInfo">member to find it on</param>
        /// <returns>instance of attribute</returns>
        public static TAttribute GetAttribute<TAttribute>(
               this MemberInfo memberInfo
           ) where TAttribute : Attribute
        {
            return memberInfo.GetAttribute<TAttribute>(false);
        }
        /// <summary>
        /// Get the first matching attribute of type 
        /// <typeparamref name="TAttribute">TAttribute</typeparamref> on
        /// <paramref name="memberInfo">memberInfo</paramref>
        /// </summary>
        /// <typeparam name="TAttribute">Attribute Type to find</typeparam>
        /// <param name="memberInfo">member to find it on</param>
        /// <param name="inherit">check inheritance</param>
        /// <returns>instance of attribute</returns>
        public static TAttribute GetAttribute<TAttribute>(
                this MemberInfo memberInfo,
                bool inherit
            ) where TAttribute : Attribute
        {
            return memberInfo
                       .GetAttributes<TAttribute>(inherit)
                       .FirstOrDefault();
        }
        /// <summary>
        /// Get the matching attributes of type 
        /// <typeparamref name="TAttribute">TAttribute</typeparamref> on
        /// <paramref name="memberInfo">memberInfo</paramref>
        /// </summary>
        /// <typeparam name="TAttribute">Attribute Type to find</typeparam>
        /// <param name="memberInfo">member to find it on</param>
        /// <returns>IEnumerable of attribute</returns>
        public static IEnumerable<TAttribute> GetAttributes<TAttribute>(
                this MemberInfo memberInfo
            ) where TAttribute : Attribute
        {
            return memberInfo.GetAttributes<TAttribute>(false);
        }
        /// <summary>
        /// Get the matching attributes of type 
        /// <typeparamref name="TAttribute">TAttribute</typeparamref> on
        /// <paramref name="memberInfo">memberInfo</paramref>
        /// </summary>
        /// <typeparam name="TAttribute">Attribute Type to find</typeparam>
        /// <param name="memberInfo">member to find it on</param>
        /// <param name="inherit">check inheritance</param>
        /// <returns>IEnumerable of attribute</returns>
        public static IEnumerable<TAttribute> GetAttributes<TAttribute>(
                this MemberInfo memberInfo,
                bool inherit
            ) where TAttribute : Attribute
        {
            return memberInfo
                    .GetCustomAttributes(typeof(TAttribute), inherit)
                    .OfType<TAttribute>();
        }
    }
}
