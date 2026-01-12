#define LocalDebug_

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;

namespace WhitedUS.Common.Converters
{
    /// <summary>
    /// This class can convert or parse between most Object Types
    /// </summary>
    public partial class GenericParser
    {
        private volatile static Dictionary<Type, Delegate>
                    _cachedGenericHandlers = new Dictionary<Type, Delegate>();
        private delegate bool TryParseHandler<T>(string input, out T result);
        private static TryParseHandler<T> GetTryParseHandler<T>()
        {
            if (_cachedGenericHandlers.ContainsKey(typeof(T)))
                return _cachedGenericHandlers[typeof(T)] as TryParseHandler<T>;

            var args = new[] { typeof(string), typeof(T).MakeByRefType() };

            MethodInfo mi = typeof(T).GetMethod("TryParse", args);
            if (mi == null)
                return null;

            DynamicMethod dm = new DynamicMethod(
                string.Format("_{0}_TryParse", typeof(T).Name),
                typeof(bool),
                args,
                typeof(T)
            );

            dm.DefineParameter(1, ParameterAttributes.In, "input");
            dm.DefineParameter(2, ParameterAttributes.Out, "result");

            ILGenerator il = dm.GetILGenerator();
            il.Emit(OpCodes.Ldarg_0);
            il.Emit(OpCodes.Ldarg_1);
            il.EmitCall(OpCodes.Call, mi, null);
            il.Emit(OpCodes.Ret);

            var handler = dm.CreateDelegate<TryParseHandler<T>>();

            _cachedGenericHandlers.Add(typeof(T), handler);

            return handler;
        }

        /// <summary>
        /// Generic TryParse
        /// </summary>
        /// <typeparam name="T">Type to Parse</typeparam>
        /// <param name="input">String to Parse</param>
        /// <param name="result">Return Instance</param>
        /// <returns>True if successful</returns>
        public static bool TryParse<T>(string input, out T result)
        {
            TryParseHandler<T> handler = GetTryParseHandler<T>();
            if (handler != null)
                return handler(input, out result);
            else
            {
                result = default(T);
                return false;
            }
        }

        private volatile static Dictionary<Type, Delegate>
                        _cachedHandlers = new Dictionary<Type, Delegate>();
        private delegate bool TryParseHandler(string input, out object result);
        private static TryParseHandler GetTryParseHandler(Type T)
        {
            lock (_cachedHandlers)
            {
                if (_cachedHandlers.ContainsKey(T))
                    return _cachedHandlers[T] as TryParseHandler;

                var mi = T.GetMethod("TryParse", new[] { 
                    typeof(string),
                    T.MakeByRefType() 
                });
                if (mi == null)
                    return null;

#if LocalDebug
            AssemblyName an = new AssemblyName("ExifDataTest");
            AssemblyBuilder ab = AppDomain.CurrentDomain.DefineDynamicAssembly(an, AssemblyBuilderAccess.RunAndSave);
            ModuleBuilder mb = ab.DefineDynamicModule("ExifDataTest", "ExifDataTest.dll", true);
            TypeBuilder tb = mb.DefineType("ExifDataTest.MyType", TypeAttributes.Public);
            MethodBuilder dm = tb.DefineMethod(
                string.Format("_{0}_TryParse", T.Name),
                MethodAttributes.Static | MethodAttributes.Public,
                typeof(bool),
                new Type[] { typeof(string), typeof(object).MakeByRefType() }
                );
#else
                DynamicMethod dm = new DynamicMethod(
                    string.Format("_{0}_TryParse", T.Name),
                    typeof(bool),
                    new Type[] { typeof(string), typeof(object).MakeByRefType() },
                    typeof(GenericParser)
                );
#endif

                var pm1 = dm.DefineParameter(1, ParameterAttributes.None, "input");
                var pm2 = dm.DefineParameter(2, ParameterAttributes.Out, "result");

                var il = dm.GetILGenerator();
                var lb0 = il.DeclareLocal(T);
                var lb1 = il.DeclareLocal(typeof(bool));
                var lb2 = il.DeclareLocal(typeof(bool));

                il.Emit(OpCodes.Nop);
                il.Emit(OpCodes.Ldarg_0);
                il.Emit(OpCodes.Ldloca_S, lb0);
                il.EmitCall(OpCodes.Call, mi, null);
                il.Emit(OpCodes.Ldc_I4_0);
                il.Emit(OpCodes.Ceq);
                il.Emit(OpCodes.Stloc_2);
                il.Emit(OpCodes.Ldloc_2);
                il.Emit(OpCodes.Brtrue_S, (byte)13);
                il.Emit(OpCodes.Nop);
                il.Emit(OpCodes.Ldarg_1);
                il.Emit(OpCodes.Ldloc_0);

                //if (T.IsValueType)
                il.Emit(OpCodes.Box, T);
                //else
                //    il.Emit(OpCodes.Castclass, T);

                il.Emit(OpCodes.Stind_Ref);
                il.Emit(OpCodes.Ldc_I4_1);
                il.Emit(OpCodes.Stloc_1);
                il.Emit(OpCodes.Br_S, (byte)8);

                il.Emit(OpCodes.Nop);
                il.Emit(OpCodes.Ldarg_1);
                il.Emit(OpCodes.Ldnull);
                il.Emit(OpCodes.Stind_Ref);
                il.Emit(OpCodes.Ldc_I4_0);
                il.Emit(OpCodes.Stloc_1);
                il.Emit(OpCodes.Br_S, (byte)0);
                il.Emit(OpCodes.Ldloc_1);
                il.Emit(OpCodes.Ret);

#if LocalDebug
            Type myType = tb.CreateType();
            ab.Save("ExifDataTest.dll");
            //return myType.GetMethod(string.Format("_{0}_TryParse", T.Name));
            return null;
#else
                var handler = dm.CreateDelegate<TryParseHandler>();
                if (handler != null)
                    _cachedHandlers.Add(T, handler);
                return handler;
#endif
            }
        }

        /// <summary>
        /// Generic TryParse
        /// </summary>
        /// <param name="T">Type to Parse</param>
        /// <param name="input">String to Parse</param>
        /// <param name="result">Return Instance</param>
        /// <returns>True if successful</returns>
        public static bool TryParse(Type T, string input, out object result)
        {
            TryParseHandler handler = GetTryParseHandler(T);

            if (handler != null && handler(input, out result))
                return true;

            result = CreateInstance(T);
            return false;
        }
    }
}
