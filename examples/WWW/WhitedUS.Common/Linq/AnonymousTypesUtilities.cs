using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

namespace WhitedUS.Common.Linq
{
    /// <summary>
    /// Anonymous Types Utilities
    /// </summary>
    public static class AnonymousTypesUtilities
    {
        /// <summary>
        /// Test is current object is Anonymous Type
        /// </summary>
        /// <param name="input">object to test</param>
        /// <returns>true if input is anoymous type</returns>
        public static bool IsAnonymous(this object input)
        {
            if (input == null)
                return false;

            //•It will override Equals, GetHashCode and ToString
            //•Each property will have a type parameter with a name including 
            //      the property name, and will be of that type parameter, e.g. 
            //      the Name property becomes a property of type <>_Name
            //•Each property will be public and read-only
            //•For each property there will be a corresponding readonly private
            //      field
            //•There will be no other properties or fields
            //•There will be a constructor taking one parameter corresponding 
            //      to each type parameter, in the same order as the type 
            //      parameters
            //•The name of the type will start with "<>" and contain 
            //      "AnonymousType"
            var inputType = input.GetType();
            if (
                inputType.Namespace == null &&
                inputType.IsClass &&
                inputType.BaseType == typeof(object) &&
                inputType.IsSealed &&
                !inputType.IsNested &&
                inputType.IsNotPublic &&
                inputType.GetCustomAttributes(
                                    typeof(CompilerGeneratedAttribute), 
                                    false
                                ).Length > 0
                )
            {
                var constrs = inputType.GetConstructors();
                if (constrs.Length == 1)
                {
                    var props = inputType.GetProperties();
                    if (props.Length == constrs[0].GetParameters().Length)
                        return true;
                }
            }
            return false;
        }
    }
}
