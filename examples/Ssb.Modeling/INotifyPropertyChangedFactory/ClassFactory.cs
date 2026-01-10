using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace INotifyPropertyChangedFactory
{
    public static class ClassFactory
    {
        // http://www.codeproject.com/Articles/13337/Introduction-to-Creating-Dynamic-Types-with-Reflec 

        private static AssemblyBuilder asmBuilder = null;
        private static ModuleBuilder modBuilder = null;

        private static Dictionary<Type, Type> _cached = new Dictionary<Type, Type>();

        public static void SaveAssembly()
        {
            // Note: AssemblyBuilder.Save() was removed in .NET Core/.NET 5+
            // To save assemblies in .NET 9.0, use System.Reflection.Emit NuGet package
            // and PersistedAssemblyBuilder instead of AssemblyBuilder
            throw new NotSupportedException("Assembly saving is not supported in this .NET version. Use PersistedAssemblyBuilder for this functionality.");
        }

        public static T Create<T>(Type[] parameterTypes = null, object[] parameters = null)
        {
            if (!_cached.ContainsKey(typeof(T)))
            {
                var moduleBuilder = ClassFactory.GetModuleBuilder();
                var typeBuilder = ClassFactory.CreateType<T>(moduleBuilder);
                var conBuilder = ClassFactory.CreateConstructor<T>(typeBuilder, parameterTypes ?? Type.EmptyTypes);
                ClassFactory.AddINotifyPropertyChanged<T>(typeBuilder);

                var newType = typeBuilder.CreateType();
                _cached.Add(typeof(T), newType);
            }

            var ctor = _cached[typeof(T)].GetConstructor(parameterTypes ?? Type.EmptyTypes)
                                         .Invoke(parameters);

            var result = (T)ctor;
            return result;
        }
        private static ModuleBuilder GetModuleBuilder()
        {
            if (asmBuilder == null)
            {
                var assemblyName = new AssemblyName("DynamicAssembly");
                asmBuilder = AssemblyBuilder.DefineDynamicAssembly(assemblyName, AssemblyBuilderAccess.Run);
                modBuilder = asmBuilder.DefineDynamicModule(asmBuilder.GetName().Name);
            }
            return modBuilder;
        }
        private static TypeBuilder CreateType<T>(ModuleBuilder modBuilder)
        {
            var interfaces = typeof(T).GetInterfaces();
            if (!interfaces.Contains(typeof(INotifyPropertyChanged)))
            {
                interfaces = interfaces.Concat(new[] { typeof(INotifyPropertyChanged) }).ToArray();
            }

            var typebuilder = modBuilder.DefineType(typeof(T).Name + "_NotifyProperty",
                 TypeAttributes.Public |
                 TypeAttributes.Class |
                 TypeAttributes.AutoClass |
                 TypeAttributes.AnsiClass |
                 TypeAttributes.BeforeFieldInit |
                 TypeAttributes.AutoLayout,
                 typeof(T),
                 interfaces);
            return typebuilder;
        }
        private static ConstructorBuilder CreateConstructor<T>(TypeBuilder typeBuilder, Type[] parameterTypes)
        {
            var baseCon = typeof(T).GetConstructor(parameterTypes);
            var conBuilder = typeBuilder.DefineConstructor(MethodAttributes.Public | MethodAttributes.SpecialName | MethodAttributes.RTSpecialName,
                                             CallingConventions.Standard,
                                             parameterTypes
                                             );
            var baseParameters = baseCon.GetParameters();
            var baseParametersCount = baseParameters.Count();
            for (byte i = 0; i < baseParametersCount; i++)
            {
                var baseParameter = baseParameters[i];
                conBuilder.DefineParameter(i + 1, baseParameter.Attributes, baseParameter.Name);
            }

            var il = conBuilder.GetILGenerator();
            il.Emit(OpCodes.Ldarg_0);
            var ptc = parameterTypes.Count();
            for (byte i = 1; i <= ptc; i++)
                il.Emit(OpCodes.Ldarg_S, i);
            il.Emit(OpCodes.Call, baseCon);
            il.Emit(OpCodes.Ret);
            return conBuilder;
        }

        private static void AddINotifyPropertyChanged<T>(TypeBuilder typeBuilder)
        {
            MethodInfo onPropertyChanged;
            if (!typeof(T).IsInstanceOfType(typeof(INotifyPropertyChanged)))
            {
                var evnt = new
                {
                    Name = "PropertyChanged",
                    Attributes = EventAttributes.None,
                    EventHandlerType = typeof(PropertyChangedEventHandler),

                    AddAttributes = (MethodAttributes)2534,
                    RemoveAttributes = (MethodAttributes)2534,
                    OnMethodAttributes = (MethodAttributes)453,
                };
                //Add Event
                var eventFieldBuilder = typeBuilder.DefineField(evnt.Name, evnt.EventHandlerType, FieldAttributes.Private);
                var eventBuilder = typeBuilder.DefineEvent(evnt.Name, evnt.Attributes, evnt.EventHandlerType);
                //Add
                {
                    var eventAddOnMethodBuilder = typeBuilder.DefineMethod("add_" + evnt.Name, evnt.AddAttributes);
                    eventAddOnMethodBuilder.SetParameters(evnt.EventHandlerType);
                    eventAddOnMethodBuilder.SetReturnType(typeof(void));
                    eventAddOnMethodBuilder.SetImplementationFlags(MethodImplAttributes.IL);

                    var il = eventAddOnMethodBuilder.GetILGenerator();

                    var local0 = il.DeclareLocal(evnt.EventHandlerType);
                    var local1 = il.DeclareLocal(evnt.EventHandlerType);
                    var local2 = il.DeclareLocal(evnt.EventHandlerType);

                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldfld, eventFieldBuilder);
                    il.Emit(OpCodes.Stloc_0);
                    var loopTarget = il.DefineLabel();
                    il.MarkLabel(loopTarget);
                    il.Emit(OpCodes.Ldloc_0);
                    il.Emit(OpCodes.Stloc_1);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Ldarg_1);
                    il.Emit(OpCodes.Call, typeof(Delegate).GetMethod("Combine", new[] { typeof(Delegate), typeof(Delegate) }));
                    il.Emit(OpCodes.Castclass, evnt.EventHandlerType);
                    il.Emit(OpCodes.Stloc_2);
                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldflda, eventFieldBuilder);
                    il.Emit(OpCodes.Ldloc_2);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Call, typeof(Interlocked).GetMethods().Single(mi => mi.Name == "CompareExchange" && mi.IsGenericMethod).MakeGenericMethod(evnt.EventHandlerType));
                    il.Emit(OpCodes.Stloc_0);
                    il.Emit(OpCodes.Ldloc_0);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Bne_Un_S, loopTarget);
                    il.Emit(OpCodes.Ret);

                    eventBuilder.SetAddOnMethod(eventAddOnMethodBuilder);
                }
                //Remove
                {
                    var eventRemoveOnMethodBuilder = typeBuilder.DefineMethod("remove_" + evnt.Name, evnt.RemoveAttributes);
                    eventRemoveOnMethodBuilder.SetParameters(evnt.EventHandlerType);
                    eventRemoveOnMethodBuilder.SetReturnType(typeof(void));
                    eventRemoveOnMethodBuilder.SetImplementationFlags(MethodImplAttributes.IL);

                    var il = eventRemoveOnMethodBuilder.GetILGenerator();

                    var local0 = il.DeclareLocal(evnt.EventHandlerType);
                    var local1 = il.DeclareLocal(evnt.EventHandlerType);
                    var local2 = il.DeclareLocal(evnt.EventHandlerType);

                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldfld, eventFieldBuilder);
                    il.Emit(OpCodes.Stloc_0);
                    var loopTarget = il.DefineLabel();
                    il.MarkLabel(loopTarget);
                    il.Emit(OpCodes.Ldloc_0);
                    il.Emit(OpCodes.Stloc_1);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Ldarg_1);
                    il.Emit(OpCodes.Call, typeof(Delegate).GetMethod("Remove", new[] { typeof(Delegate), typeof(Delegate) }));
                    il.Emit(OpCodes.Castclass, evnt.EventHandlerType);
                    il.Emit(OpCodes.Stloc_2);
                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldflda, eventFieldBuilder);
                    il.Emit(OpCodes.Ldloc_2);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Call, typeof(Interlocked).GetMethods().Single(mi => mi.Name == "CompareExchange" && mi.IsGenericMethod).MakeGenericMethod(evnt.EventHandlerType));
                    il.Emit(OpCodes.Stloc_0);
                    il.Emit(OpCodes.Ldloc_0);
                    il.Emit(OpCodes.Ldloc_1);
                    il.Emit(OpCodes.Bne_Un_S, loopTarget);
                    il.Emit(OpCodes.Ret);

                    eventBuilder.SetRemoveOnMethod(eventRemoveOnMethodBuilder);
                }

                //Add OnPropertyChanged
                {
                    var onPropertyChangedBuilder = typeBuilder.DefineMethod("On" + evnt.Name, evnt.OnMethodAttributes, typeof(void), new[] { typeof(string) });
                    var il = onPropertyChangedBuilder.GetILGenerator();
                    var exitEarily = il.DefineLabel();

                    il.DeclareLocal(typeof(bool));
                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldfld, eventFieldBuilder);
                    il.Emit(OpCodes.Brfalse_S, exitEarily);
                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldfld, eventFieldBuilder);
                    il.Emit(OpCodes.Ldarg_0);
                    il.Emit(OpCodes.Ldarg_1);
                    il.Emit(OpCodes.Newobj, typeof(PropertyChangedEventArgs).GetConstructor(new[] { typeof(string) }));
                    il.Emit(OpCodes.Callvirt, evnt.EventHandlerType.GetMethod("Invoke", new[] { typeof(object), typeof(PropertyChangedEventArgs) }));
                    il.MarkLabel(exitEarily);
                    il.Emit(OpCodes.Ret);

                    onPropertyChanged = onPropertyChangedBuilder;
                }
            }
            else
            {
                onPropertyChanged = typeof(T).GetMethod("OnPropertyChanged", BindingFlags.Instance | BindingFlags.NonPublic);
                if (onPropertyChanged == null)
                    throw new NotSupportedException(string.Format("NonPublic \"OnPropertyChanged\" method not found on \"{0}\"", typeof(T)));
            }

            //Notifiable Properties
            {
                var properties = from p in typeof(T).GetProperties(BindingFlags.Instance | BindingFlags.Public)
                                 let attr = p.GetCustomAttributes<NotifiableAttribute>()
                                 where attr.Any()
                                 select new
                                 {
                                     Property = p,
                                     Attributes = attr,
                                 };

                foreach (var item in properties)
                {
                    var prop = item.Property;
                    //var propBuilder = typeBuilder.DefineProperty(prop.Name, prop.Attributes, prop.PropertyType, Type.EmptyTypes);

                    // Set
                    {
                        var targetedPropertyNames = (from attr in item.Attributes
                                                     from name in attr.PropertyNames ?? Enumerable.Empty<string>()
                                                     select name).Concat(new[] { prop.Name })
                                                                 .Distinct()
                                                                 .ToArray();


                        var existingSetter = prop.GetSetMethod();
                        var setter = typeBuilder.DefineMethod(existingSetter.Name, existingSetter.Attributes);
                        setter.SetParameters(existingSetter.GetParameters().Select(pi => pi.ParameterType).ToArray());
                        setter.SetReturnType(existingSetter.ReturnType);
                        setter.SetImplementationFlags(MethodImplAttributes.IL);

                        var il = setter.GetILGenerator();
                        il.Emit(OpCodes.Ldarg_0);
                        il.Emit(OpCodes.Ldarg_1);
                        il.Emit(OpCodes.Call, existingSetter);

                        foreach (var propname in targetedPropertyNames)
                        {
                            il.Emit(OpCodes.Ldarg_0);
                            il.Emit(OpCodes.Ldstr, propname);
                            il.Emit(OpCodes.Callvirt, onPropertyChanged);
                        }

                        il.Emit(OpCodes.Ret);

                        //propBuilder.SetSetMethod(setter);

                        typeBuilder.DefineMethodOverride(setter, existingSetter);
                    }

                    ////Get
                    //{
                    //    var existingGetter = prop.GetGetMethod();
                    //    var getter = typeBuilder.DefineMethod(existingGetter.Name, existingGetter.Attributes);
                    //    getter.SetParameters(existingGetter.GetParameters().Select(pi => pi.ParameterType).ToArray());
                    //    getter.SetReturnType(existingGetter.ReturnType);
                    //    getter.SetImplementationFlags(MethodImplAttributes.IL);
                    //    var il = getter.GetILGenerator();
                    //    il.Emit(OpCodes.Ldarg_0);
                    //    il.Emit(OpCodes.Call, existingGetter);
                    //    il.Emit(OpCodes.Ret);
                    //    propBuilder.SetGetMethod(getter);
                    //}
                }
            }
        }
    }
}
