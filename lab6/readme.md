- RV32-I 指令子集扩展 必做:
    - ✓ 必做部分(10) add、addi、auipc、lui、lw、sw、beq、blt、jal、jalr
    - 算数与逻辑指令(13) sll✓、slli✓、srl✓、srli✓、sra✓、srai✓、sub✓、xor✓、xori✓、or✓、ori✓、and✓、andi✓
    - 分支与条件指令(8) bne✓、bge✓、bltu✓、bgeu✓、 slt✓、slti✓、sltu✓、sltiu✓
    - 访存指令(6) lb✓、lh✓、lbu✓、lhu✓、sb✓、sh✓
- 分支预测 选做 3
    - 2bits 感知机局部历史分支预测
        1. 实现基于 2bits 感知机的局部历史分支预测及其纠正，并成功接入流水线
        2. 如果设计中没有体现“局部历史记录”，而只使用 2bits 感知机进行预测，则酌情扣分
        3. 需要自主设计 BHT 与 PHT 表的规模
        4. 需要能定量分析你的分支预测器对程序运行改进的效果"
    - 2bits 感知机全局历史分支预测
        1. 在局部分支预测的基础上添加全局历史预测（GHR+PHT）
        2. 分析竞争处理策略，正确处理全局预测与局部预测的竞争，并接入流水线
        3. 需要能定量分析你的分支预测器对程序运行改进的效果"
- `lab6_inst_test`: 除访存外的指令测试
- `lab6_load_test`: 访存指令测试
- `inst_test`: 助教提供的检测程序
