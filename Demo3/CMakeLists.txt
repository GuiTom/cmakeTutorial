# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo3)

# 查找目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)


# 指定生成目标
add_executable(Demo ${DIR_SRCS})

# 添加 math 子目录,这个math目录下生成MathFunctions库
add_subdirectory(math)

# 添加链接库(将'MathFunctions'这个目标链接到'Demo'这个目标，因此要先add_excutable生成Demo目标)
target_link_libraries(Demo MathFunctions)
