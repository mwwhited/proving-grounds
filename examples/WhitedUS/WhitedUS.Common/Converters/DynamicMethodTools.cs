using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection.Emit;

namespace WhitedUS.Common.Converters
{
    /// <summary>
    /// Delegate utility methods
    /// </summary>
    public static class DynamicMethodTools
    {
        /// <summary>
        /// generic wrapper for CreateDelegate on DynamicMethods
        /// </summary>
        /// <typeparam name="TDelegate">Delegate Type</typeparam>
        /// <param name="method">Dynamic Method</param>
        /// <returns>Instance of Delegate</returns>
        public static TDelegate CreateDelegate<TDelegate>(this DynamicMethod method)
            where TDelegate : class
        {
            return method.CreateDelegate(typeof(TDelegate)) as TDelegate;
        }
    }
}
