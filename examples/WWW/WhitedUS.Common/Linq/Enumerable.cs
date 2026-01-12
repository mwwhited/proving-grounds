using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.Common.Linq
{
    public static class Enumerable
    {
        public static IEnumerable<IEnumerable<T>> Pages<T>(
            this IEnumerable<T> input,
                 Func<T, bool> first,
                 Func<T, bool> last)
        {
            using (var enumerator = input.GetEnumerator())
                while (enumerator.MoveNext())
                    yield return enumerator.Page(first, last);
        }

        private static IEnumerable<T> Page<T>(
            this IEnumerator<T> input,
                 Func<T, bool> first,
                 Func<T, bool> last)
        {
            while (!first(input.Current))
                if (!input.MoveNext())
                    goto done;
            do
            {
                var item = input.Current;
                yield return item;

                if (last(item))
                    break;
            }
            while (input.MoveNext());
        done: ;
        }

        public static IEnumerable<T> SetAction<T>(
            this IEnumerable<T> left,
                 IEnumerable<T> right,
                 Func<T, T, T> merge)
        {
            return SetAction(left, right, merge, l => l);
        }

        public static IEnumerable<TResult> SetAction<T, TResult>(
            this IEnumerable<T> left,
                 IEnumerable<T> right,
                 Func<T, T, TResult> merge,
                 Func<T, TResult> single)
        {
            return SetAction(left, right, merge, single, single);
        }

        public static IEnumerable<TResult> SetAction<TLeft, TRight, TResult>(
            this IEnumerable<TLeft> left,
                 IEnumerable<TRight> right,
                 Func<TLeft, TRight, TResult> merge,
                 Func<TLeft, TResult> leftOnly,
                 Func<TRight, TResult> rightOnly)
        {
            using (var leftE = left.GetEnumerator())
            using (var rightE = right.GetEnumerator())
            {

                var leftToGo = leftE.MoveNext();
                if (!leftToGo)
                {
                    while (rightE.MoveNext())
                        yield return rightOnly(rightE.Current);
                    goto done;
                }
                var rigthToGo = rightE.MoveNext();
                if (!rigthToGo)
                {
                    do
                    {
                        yield return leftOnly(leftE.Current);
                    } while (leftE.MoveNext());
                    goto done;
                }

                var doLeft = false;
                var doRight = false;

                while (leftToGo || rigthToGo)
                {
                    if (doLeft)
                    {
                        doLeft = false;
                        leftE.Reset();
                        leftE.MoveNext();
                    }
                    if (doRight)
                    {
                        doRight = false;
                        rightE.Reset();
                        rightE.MoveNext();
                    }
                    yield return merge(leftE.Current, rightE.Current);
                    if (!leftE.MoveNext())
                    {
                        leftToGo = false;
                        doLeft = true;
                    }
                    if (!rightE.MoveNext())
                    {
                        rigthToGo = false;
                        doRight = true;
                    }
                }

            done: ;
            }
        }
    }
}
