Merge "tensile-test-specimen.step"; // 读取stp文件
Mesh.CharacteristicLengthMax = 1.5; // 设置最大网格尺寸
Mesh.ElementOrder = 2;              // 使用二阶网格

// 定义物理组 physical groups ,区分约束条件和材质
//左边的名字 例如 "left"必须出现在fino输入中
// 右边的数字 例如 1  是出现在CAD文件中的实体编号 
Physical Surface ("left") =  {1};   // 左面, 固定端/面
Physical Surface ("right") =  {7};  // 右面, 负载端 
Physical Volume ("bulk") =  {1};    // 实体