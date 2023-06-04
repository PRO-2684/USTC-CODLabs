- RV32-I 指令子集扩展 必做:
    - ✓ 必做部分(10) add、addi、auipc、lui、lw、sw、beq、blt、jal、jalr
    - 算数与逻辑指令(13) sll✓、slli✓、srl✓、srli✓、sra✓、srai✓、sub✓、xor✓、xori✓、or✓、ori✓、and✓、andi✓
    - 分支与条件指令(8) bne✓、bge✓、bltu✓、bgeu✓、 slt✓、slti✓、sltu✓、sltiu✓
    - 访存指令(6) lb✓、lh✓、lbu✓、lhu✓、sb✓、sh✓
- 异常处理
    - 实现异常状态保存 (ALU 加减法溢出)
    - 编写异常处理程序 (汇编，以 `ret` 结尾)
    - 实现用户程序与异常处理程序的切换 (保证处理器发现异常后可以切换到异常处理程序执行，且异常指令之前的指令均已执行完毕; 支持 `csrrs` 指令的功能，你也需要处理该指令可能的冒险)
- 异常处理的基本流程：
    1. 处理器检测到异常发生，通过硬件将异常信息保存在相应的 CSR 寄存器中；
    2. 冲刷流水线，设置 next_pc = 0x4000，进而执行异常处理程序（起始地址位于 0x4000，存储在专用的存储器中）；
    3. 在数码管上输出 0x8880F888，并轮询等待用户按下按钮确认（相关外设规则参考 Lab4 手册），按钮按下后程序继续执行；
    4. 需要使用 `csrrs` 等指令将 mepc+4 加载到 x1 寄存器，并用 ret（jalr, x0, 0(x1)）指令作为异常处理程序结束的标志。此时即可正确跳转到用户程序。
- 其它参考
    - [CSR 寄存器介绍](https://www.cnblogs.com/mikewolf2002/p/11314583.html)
    - CSR 寄存器：mepc 存储发生异常指令的 PC，地址 0x342。

- `lab6_inst_test`: 除访存外的指令测试
- `lab6_load_test`: 访存指令测试
- `inst_test`: 助教提供的检测程序
