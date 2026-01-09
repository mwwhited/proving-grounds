# BuildFirstOnce

## Summary

Using the `Directory.Build.props` you can add a `ProjectReference` to all of the projects within
your solution. Adding to that `<PrivateAssets>all</PrivateAssets>` you can make this a development 
only depency so it won't show as a required reference.  

Then within `BuildMeFirst` project you can define your MSBuild tasks you want to run first as well
as add a `ProjectReference` with a `Remove` to not cause circular references.  

The tasks defined in the `BuildMeFirst` will run before any build on child projects in your solution
even if those projects are compiled individually.  They will also only run once if you build the 
solution as while. 

## Example output for the solution

```log
Rebuild started at 2:04 PM...
1>------ Rebuild All started: Project: BuildMeFirst, Configuration: Debug Any CPU ------
Restored C:\Repos\github\BuildFirstOnce\src\AnotherProject\AnotherProject.csproj (in 6 ms).
Restored C:\Repos\github\BuildFirstOnce\src\YetAnotherProject\YetAnotherProject.csproj (in 11 ms).
Restored C:\Repos\github\BuildFirstOnce\src\Notes\Notes.csproj (in 12 ms).
Restored C:\Repos\github\BuildFirstOnce\src\BuildMeFirst\BuildMeFirst.csproj (in 14 ms).
1>BuildMeFirst -> C:\Repos\github\BuildFirstOnce\src\BuildMeFirst\bin\Debug\net8.0\BuildMeFirst.dll
1>I run first and only once BuildMeFirst.csproj
1>I also only run once BuildMeFirst.csproj
2>------ Rebuild All started: Project: YetAnotherProject, Configuration: Debug Any CPU ------
3>------ Rebuild All started: Project: AnotherProject, Configuration: Debug Any CPU ------
4>------ Rebuild All started: Project: Notes, Configuration: Debug Any CPU ------
2>YetAnotherProject -> C:\Repos\github\BuildFirstOnce\src\YetAnotherProject\bin\Debug\net8.0\YetAnotherProject.dll
2>Run before everything else YetAnotherProject.csproj
2>Run after everything else YetAnotherProject.csproj
4>Notes -> C:\Repos\github\BuildFirstOnce\src\Notes\bin\Debug\net8.0\Notes.dll
4>Run before everything else Notes.csproj
4>Run after everything else Notes.csproj
3>AnotherProject -> C:\Repos\github\BuildFirstOnce\src\AnotherProject\bin\Debug\net8.0\AnotherProject.dll
3>Run before everything else AnotherProject.csproj
3>Run after everything else AnotherProject.csproj
========== Rebuild All: 4 succeeded, 0 failed, 0 skipped ==========
========== Rebuild completed at 2:04 PM and took 00.775 seconds ==========
```

## Example output for targeted project

```log
Rebuild started at 2:05 PM...
1>------ Rebuild All started: Project: BuildMeFirst, Configuration: Debug Any CPU ------
Restored C:\Repos\github\BuildFirstOnce\src\AnotherProject\AnotherProject.csproj (in 6 ms).
Restored C:\Repos\github\BuildFirstOnce\src\YetAnotherProject\YetAnotherProject.csproj (in 7 ms).
Restored C:\Repos\github\BuildFirstOnce\src\Notes\Notes.csproj (in 8 ms).
Restored C:\Repos\github\BuildFirstOnce\src\BuildMeFirst\BuildMeFirst.csproj (in 10 ms).
1>BuildMeFirst -> C:\Repos\github\BuildFirstOnce\src\BuildMeFirst\bin\Debug\net8.0\BuildMeFirst.dll
1>I run first and only once BuildMeFirst.csproj
1>I also only run once BuildMeFirst.csproj
2>------ Rebuild All started: Project: AnotherProject, Configuration: Debug Any CPU ------
2>AnotherProject -> C:\Repos\github\BuildFirstOnce\src\AnotherProject\bin\Debug\net8.0\AnotherProject.dll
2>Run before everything else AnotherProject.csproj
2>Run after everything else AnotherProject.csproj
========== Rebuild All: 2 succeeded, 0 failed, 0 skipped ==========
========== Rebuild completed at 2:05 PM and took 00.663 seconds ==========
```
