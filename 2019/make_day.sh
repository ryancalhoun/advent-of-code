#!/bin/bash

dir=$(printf %02d $1)

if [[ ! -d $dir ]]; then
  mkdir $dir
fi

cd $dir

if [[ ! -f README.md ]]; then
cat > README.md <<END
# Day $1: ${@:2}

[Full info here](https://adventofcode.com/2019/day/$1)

END
fi

if [[ ! -f build.xml ]]; then
cat > build.xml <<END
<project name="Day $1" default="all">

  <target name="all" depends="sample1,sample2,part1,part2"/>

  <target name="sample1">
    <antcall target="run">
      <param name="part" value="1"/>
      <param name="file" value="sample.txt"/>
    </antcall>
  </target>
  <target name="sample2">
    <antcall target="run">
      <param name="part" value="2"/>
      <param name="file" value="sample.txt"/>
    </antcall>
  </target>
  <target name="part1">
    <antcall target="run">
      <param name="part" value="1"/>
      <param name="file" value="full.txt"/>
    </antcall>
  </target>
  <target name="part2">
    <antcall target="run">
      <param name="part" value="2"/>
      <param name="file" value="full.txt"/>
    </antcall>
  </target>

  <target name="build">
    <javac srcdir="." includeantruntime="false"/>
  </target>
  <target name="clean">
    <delete>
      <fileset dir="." includes="**/*.class"/>
    </delete>
  </target>

  <target name="run" depends="build">
    <fail message="missing input file \${file}">
      <condition>
        <not>
          <available file="\${file}"/>
        </not>
      </condition>
    </fail>
    <java classname="App" fork="true" input="\${file}" failonerror="true">
      <env key="PART" value="\${part}"/>
      <classpath>
        <pathelement location="."/>
      </classpath>
    </java>
  </target>

</project>
END
fi

if [[ ! -f App.java ]]; then
cat > App.java <<END
import java.io.BufferedReader;

public class App {
  public static void main(String [] args) {

    int part = Integer.parseInt(System.getenv("PART"));
    BufferedReader in = new BufferedReader(new java.io.InputStreamReader(System.in));

  }
}
END
fi
