#define LocalDebug_

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;

namespace WhitedUS.Libs.Converters
{
    public partial class GenericParser
    {
        private delegate object CreateInstaneHandler();
        /// <summary>
        /// This of this as a non generic response to default(T)
        /// </summary>
        /// <param name="T">Type to get default instance for</param>
        /// <returns>Default Instance of Type "T"</returns>
        public static object CreateInstance(Type T)
        {
            if (T == null)
                throw new ArgumentNullException("You must provide a type");

            if (!T.IsValueType)
                return null;

            var dm = new DynamicMethod(
                string.Format("_{0}_CreateInstance", T.Name),
                typeof(object),
                Type.EmptyTypes,
                T
                );
            var il = dm.GetILGenerator();
            il.DeclareLocal(typeof(object));
            var lb2 = il.DeclareLocal(T);

            il.Emit(OpCodes.Ldloca_S, lb2);
            il.Emit(OpCodes.Initobj, T);
            il.Emit(OpCodes.Ldloc_1);
            il.Emit(OpCodes.Box, T);
            il.Emit(OpCodes.Ret);

            var handler = dm.CreateDelegate<CreateInstaneHandler>();
            if (handler == null)
                return null;
            else
                return handler();
        }

        private delegate T CreateInstaneHandler<T>();
        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static T CreateInstance<T>()
        {
            return default(T);
        }
    }
}
