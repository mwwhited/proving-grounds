using System;
using System.Reflection;
using Iced.Intel;

foreach (var ctor in typeof(MemoryOperand).GetConstructors())
{
    Console.WriteLine(ctor);
    foreach (var p in ctor.GetParameters()) Console.WriteLine("  " + p.ParameterType + " " + p.Name);
}

// try building: word ptr [ES:SI+2]
var mo = new MemoryOperand(Register.SI, Register.None, 1, 2, 2, false, Register.ES);
Console.WriteLine(mo);

var instr = Instruction.CreateBranch(Code.Call_rel16_16, 0x8255);
Console.WriteLine(instr);

// Check Instruction.Create signature for reg,mem forms
foreach (var m in typeof(Instruction).GetMethods(BindingFlags.Public|BindingFlags.Static))
{
    if (m.Name=="Create" && m.GetParameters().Length==3)
    {
        var ps = m.GetParameters();
        if (ps[1].ParameterType==typeof(Register) && ps[2].ParameterType==typeof(MemoryOperand))
            Console.WriteLine(m);
    }
}
