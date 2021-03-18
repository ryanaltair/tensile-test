# fino 语言参考
> https://www.seamplex.com/fino/reference.html
> https://github.com/seamplex/fino/blob/master/src/parser.c
## fino 关键词
### FINO_STEP
告诉fino开始求解 没有参数
### FINO_SOLVER
设置求解器参数
```
FINO_SOLVER \
 [ PROGRESS ]
 [ PC { gamg | mumps | lu | hypre | sor | bjacobi | cholesky | ... } ]
 [ KSP { gmres | mumps | bcgs | bicg | richardson | chebyshev | ... } ]
 [ TS { bdf | arkimex | rosw | glle | beuler | ... } ]
 [ SNES_TYPE { newtonls | newtontr | nrichardson | ngmres | qn | ngs | ... } ]
 [ GRADIENT { gauss | nodes | none } ]
 [ GRADIENT_HIGHER { average | nodes } ]
 [ SMOOTH { always | never | material } ]
 [ ELEMENT_WEIGHT { volume_times_quality | volume | quality | flat } ]
```
#### PROGRESS 进度 
输出进度
`....` 表示 ensamble of the stiffness matrix (or matrices)  
`----` 表示 the solution of the system of equations 
`====` 表示 computation of gradients (stresses)
#### PC 预处理器
[ PC { gamg | mumps | lu | hypre | sor | bjacobi | cholesky | ... } ]
#### KSP Krylov method
[ KSP { gmres | mumps | bcgs | bicg | richardson | chebyshev | ... } ]
#### TS TS方法
[ TS { bdf | arkimex | rosw | glle | beuler | ... } ]
#### SNES_TYPES 非线性求解
[ SNES_TYPE { newtonls | newtontr | nrichardson | ngmres | qn | ngs | ... } ]


### FINO_REACTION 求解反作用力
```
FINO_REACTION PHYSICAL_GROUP <physical_group> RESULT { <variable> | <vector> }
```

### FINO_SOLVER 
TBD

### FINO_LINEARIZE
TBD

### FINO_PROBLEM
设置需要求解的问题类型
默认为 mechanical 弹性力学

## 网格相关关键词

### MATERIAL 材质
```
MATERIAL <name> [ MESH <name> ] [ PHYSICAL_GROUP <name_1> [ PHYSICAL_GROUP <name_2> [ ... ] ] ] [ <property_name_1> <expr_1> [ <property_name_2> <expr_2> [ ... ] ] ]
```

### MESH 网格
从文件（MSH、 VTK 或者 FRD）中读取网格数据
> https://www.seamplex.com/wasora/reference.html#mesh
```
MESH 
 [ NAME <name> ]
 { FILE <file_id> | FILE_PATH <file_path> } 
 [ DIMENSIONS <num_expr> ]
 [ SCALE <expr> ] [ OFFSET <expr_x> <expr_y> <expr_z> ]
 [ INTEGRATION { full | reduced } ] [ RE_READ ]
 [ READ_SCALAR <name_in_mesh> AS <function_name> ] [...]
 [ READ_FUNCTION <function_name> ] [...]
```

#### NAME 名字
非必需，除非有多个mesh
#### FILE_PATH 文件路径
从vtk msh 或者frd中读取网格
只有msh支持PDE（Partial Differential Equations） 问题
### MESH_POST 后处理
```
MESH_POST 
 [ MESH <mesh_identifier> ]
 { FILE <name> | FILE_PATH <file_path> } 
 [ NO_MESH ] 
 [ FORMAT { gmsh | vtk } ] 
 [ CELLS | ] NODES ] 
 [ NO_PHYSICAL_NAMES ] 
 [ VECTOR <function1_x> <function1_y> <function1_z> ] 
 [...] 
 [ <scalar_function_1> ]
 [ <scalar_function_2> ] 
 ...
```
### PHYSICAL_GROUP 物理组
```
PHYSICAL_GROUP <name> 
 [ MESH <name> ] 
 [ DIMENSION <expr> ]
 [ MATERIAL <name> ]
 [ BC <bc_1> <bc_2> ... ]
```

对于约束条件 需要使用BC关键词

## fino 变量

### sigma 相关
delta_sigma_max

> The uncertainty of the maximum Von Mises stress σ of the elastic
> problem. Not to be confused with the maximum uncertainty of the
> Von Mises stress.

sigma_max

The maximum von Mises stress σ of the elastic problem.

sigma_max_x

The x coordinate of the maximum von Mises stress σ of the elastic
problem.

sigma_max_y

The x coordinate of the maximum von Mises stress σ of the elastic
problem.

sigma_max_z

The x coordinate of the maximum von Mises stress σ of the elastic
problem.sigma_max

The maximum von Mises stress σ of the elastic problem.

sigma_max_x

The x coordinate of the maximum von Mises stress σ of the elastic
problem.

sigma_max_y

The x coordinate of the maximum von Mises stress σ of the elastic
problem.

sigma_max_z

The x coordinate of the maximum von Mises stress σ of the elastic
problem.

### displacement 位移相关

displ_max

> The module of the maximum displacement of the elastic problem.

displ_max_x

> The x coordinate of the maximum displacement of the elastic problem.

displ_max_y

> The y coordinate of the maximum displacement of the elastic problem.

displ_max_z

> The z coordinate of the maximum displacement of the elastic problem.

u_at_displ_max

> The x component u of the maximum displacement of the elastic problem.

u_at_sigma_max

> The x component u of the displacement where the maximum von Mises
> stress σ of the elastic problem is located.

v_at_displ_max

> The y component v of the maximum displacement of the elastic problem.

v_at_sigma_max

> The y component v of the displacement where the maximum von Mises
> stress σ of the elastic problem is located.

w_at_displ_max

> The z component w of the maximum displacement of the elastic problem.
 
w_at_sigma_max

> The z component w of the displacement where the maximum von Mises
> stress σ of the elastic problem is located.

### 其他

fino_abstol

Absolute tolerance of the linear solver, as passed to PETSc’s
[KSPSetTolerances](http: Default 1e-50.

fino_divtol

Divergence tolerance, as passed to PETSc’s [KSPSetTolerances](http:
Default 1e+4.

fino_gamg_threshold

Relative threshold to use for dropping edges in aggregation graph for
the [Geometric Algebraic Multigrid Preconditioner](http: as passed to
PETSc’s [PCGAMGSetThreshold](http: A value of 0.0 means keep all nonzero
entries in the graph; negative means keep even zero entries in the
graph. Default 0.01.

fino_iterations

This variable contains the actual number of iterations used by the
solver. It is set after FINO_STEP.

fino_max_iterations

Number of maximum iterations before diverging, as passed to PETSc’s
[KSPSetTolerances](http: Default 10000.

fino_penalty_weight

The weight w used when setting multi-freedom boundary conditions. Higher
values mean better precision in the constrain but distort the matrix
condition number. Default is 1e8.

fino_reltol

Relative tolerance of the linear solver, as passed to PETSc’s
[KSPSetTolerances](http: Default 1e-6.

fino_residual_norm

This variable contains the residual obtained by the solver. It is set
after FINO_STEP.

lambda

Requested eigenvalue. It is equal to 1.0 until FINO_STEP is executed.

memory

Maximum resident set size (global memory used), in bytes.

memory_available

Total available memory, in bytes.

memory_petsc

Maximum resident set size (memory used by PETSc), in bytes.

nodes_rough

The number of nodes of the mesh in ROUGH mode.

petsc_flops

Number of floating point operations performed by PETSc/SLEPc.



strain_energy

The strain energy stored in the solid, computed as 1/2 ⋅ u⃗^(T)Ku⃗ where
u⃗ is the displacements vector and K is the stiffness matrix.

time_cpu_build

CPU time insumed to build the problem matrices, in seconds.

time_cpu_solve

CPU time insumed to solve the problem, in seconds.

time_cpu_stress

CPU time insumed to compute the stresses from the displacements, in
seconds.

time_petsc_build

CPU time insumed by PETSc to build the problem matrices, in seconds.

time_petsc_solve

CPU time insumed by PETSc to solve the eigen-problem, in seconds.

time_petsc_stress

CPU time insumed by PETSc to compute the stresses, in seconds.

time_wall_build

Wall time insumed to build the problem matrices, in seconds.

time_wall_solve

Wall time insumed to solve the problem, in seconds.

time_wall_stress

Wall time insumed to compute the stresses, in seconds.

time_wall_total

Wall time insumed to initialize, build and solve, in seconds. CPU time
insumed to initialize, build and solve, in seconds. CPU time insumed by
PETSc to initialize, build and solve, in seconds.

T_max

The maximum temperature T_(max) of the thermal problem.

T_min

The minimum temperature T_(min) of the thermal problem.


