using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection.Emit;
using System.Reflection;

namespace WhitedUS.Libs.Converters
{
    public partial class GenericParser
    {
        /// <summary>
        /// Generic Cast
        /// </summary>
        /// <typeparam name="T">Type to Cast To</typeparam>
        /// <param name="input">Object to cast</param>
        /// <returns>Type of "T" based on "input"</returns>
        public static T CastTo<T>(object input)
        {
            if (input == null)
                return default(T);
            return (T)input;
        }

        private delegate object CastToHandler(object input);
        /// <summary>
        /// Generic Cast
        /// </summary>
        /// <param name="outputType">Type to Cast To</param>
        /// <param name="input">Object to cast</param>
        /// <returns>Type of "outputType" based on "input"</returns>
        public static object CastTo(Type outputType, object input)
        {
            if (outputType == null)
                throw new ArgumentNullException("outputType must be provided");

            var castMethod = outputType.GetMethod("op_Implicit",
                                                  new [] { input.GetType() });
            if (castMethod == null)
                castMethod = outputType.GetMethod("op_Explicit", 
                                                  new [] { input.GetType() });

            Type ownerType = outputType;

            if (outputType.IsArray)
                ownerType = outputType.GetElementType();

            DynamicMethod dm = new DynamicMethod(
                string.Format("_CastTo_{0}", outputType.Name),
                MethodAttributes.Static | MethodAttributes.Public,
                CallingConventions.Standard,
                typeof(object),
                new Type[] { typeof(object) },
                ownerType,
                true
                );

            ILGenerator il = dm.GetILGenerator();
            il.DeclareLocal(typeof(object));
            il.Emit(OpCodes.Ldarg_0);
            //if (!outputType.IsArray)
            //{
                if (castMethod == null && outputType.IsValueType)
                    il.Emit(OpCodes.Unbox_Any, input.GetType());
                
                if(castMethod != null)
                    il.EmitCall(OpCodes.Call, castMethod, null);

                if (outputType.IsValueType)
                    il.Emit(OpCodes.Box, outputType);
                else
                    il.Emit(OpCodes.Castclass, outputType);

                il.Emit(OpCodes.Ret);
            //}
            //else
            //{
            //    il.Emit(OpCodes.Castclass, outputType);
            //    il.Emit(OpCodes.Ret);
            //}

            var handler = dm.CreateDelegate<CastToHandler>();
            if (handler != null)
                return handler(input);

            throw new InvalidOperationException(
                string.Format("\"_CastTo_{0}\" could not be created",
                              outputType.Name));
        }
    }
}