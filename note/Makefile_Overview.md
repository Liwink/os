### Makefile Overview

#### 编译和链接 `.o`, `.a`

> 无论是 C 还是 C++，首先需要把源文件编译成中间代码文件，在 Windows 下就是 `.obj` 文件，在 UNIX 下是 `.o` 文件，即 Object File，这个动作叫做编译（compile）。然后再把大量的 Object File 合成执行文件，这个动作叫作链接（link）。

> 在链接是需要明显地指出中间目标文件名，这对于编译很不方便。所以，我们要给中间目标文件打包，在 Windows 下这种包叫「库文件」（Library File），也就是 `.lib` 文件，在 UNIX 下是 Archive File，`.a` 文件。



#### makefile 的基础规则如下：

```makefile
target : prerequisites
	command
```

`target` 依赖于 `prerequisites` ，而其生成规则定义在 `command` 中。

**make** 会比较 `target` 和 `prerequisites`，如果 `prerequisites` 日期更晚，或者 `target` 不存在，则会执行后面的 `command`.



#### 一个示例

```makefile
edit : main.o kbd.o command.o display.o
	cc -o edit main.o kbd.o command.o display.o
 
main.o : main.o defs.h
	cc -c main.c
kbd.o : kbd.c defs.h command.h
    cc -c kbd.c
command.o : command.c defs.h command.h
    cc -c command.c
display.o : display.c defs.h buffer.h
    cc -c display.c

clean :
    rm edit main.o kbd.o command.o display.o \
        insert.o search.o files.o utils.o
```

可以看到层级似的依赖关系。

如果我们修改 `command.c` 并运行 make，make 从新编译 `command.o`，而 `edit` 也会从新链接。

`clean` 是一种动作名或 label，后面没有依赖。如果需要执行后面的指令，需要在 make 后明确指出 label 名。



> make会比较 targets 文件和 prerequisites 文件的修改日期，如果 prerequisites 文件的日期要比 targets 文件的日期要新，或 者target不存在的话，那么，make就会执行后续定义的命令。