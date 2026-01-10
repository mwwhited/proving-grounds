using System;
using System.Diagnostics;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    [DebuggerDisplay("S{Score} L{Lights} C{Cards} P{Priority}")]
    public struct Fencer
    {
        public Fencer(byte score, Cards cards, Lights lights , bool priority)
        {
            this.Score = score;
            this.Cards = cards;
            this.Lights = lights;
            this.Priority = priority;
        }

        public byte Score { get; }
        public Cards Cards { get; }
        public Lights Lights { get; }
        public bool Priority { get; }

        public override string ToString()
        {
            return $"S>{Score:000} L>{Lights} C>{Cards} P>{Priority}";
        }

        public override bool Equals(object obj)
        {
            if (!(obj is Fencer)) return false;

            var i = (Fencer)obj;
            return this.Score == i.Score
                    && this.Cards == i.Cards
                    && this.Lights == i.Lights
                    && this.Priority == i.Priority;
        }

        public override int GetHashCode()
        {
            return Tuple.Create(this.Score, this.Cards, this.Lights, this.Priority).GetHashCode();
        }
    }
}