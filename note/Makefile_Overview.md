### Makefile Overview

#### 编译和链接 `.o`, `.a`

> 无论是 C 还是 C++，首先需要把源文件编译成中间代码文件，在 Windows 下就是 `.obj` 文件，在 UNIX 下是 `.o` 文件，即 Object File，这个动作叫做编译（compile）。然后再把大量的 Object File 合成执行文件，这个动作叫作链接（link）。

> 在链接是需要明显地指出中间目标文件名，这对于编译很不方便。所以，我们要给中间目标文件打包，在 Windows 下这种包叫「库文件」（Library File），也就是 `.lib` 文件，在 UNIX 下是 Archive File，`.a` 文件。

