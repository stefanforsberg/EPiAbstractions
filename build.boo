solution_file = "EPiAbstractions.sln"
configuration = "release"
test_assemblies = "src/Phantom.Tests/bin/${configuration}/Phantom.Tests.dll"

target default, (init, compile, deploy, package):
  pass

target init:
  rmdir("build")
  
desc "Compiles the solution"
target compile:
  msbuild(file: solution_file, configuration: configuration)
  
desc "Copies the binaries to the 'build' directory"
target deploy:
  print "Copying to build dir"

  with FileList():
    .Include("EPiAbstractions/bin/${configuration}")
    .Include("EPiAbstractions.Fakes/bin/${configuration}")
    .Include("EPiAbstractions.Opinionated/bin/${configuration}")
    .Include("EPiAbstractions.FixtureSupport/bin/${configuration}")
    .Include("*.{dll,exe}")
    .ForEach def(file):
      file.CopyToDirectory("build/${configuration}")

desc "Creates zip package"
target package:
  zip("build/${configuration}", 'build/EPiAbstractions.zip')

