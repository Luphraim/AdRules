# -*- coding:utf-8 -*-
import os
import sys

result = []
file = sys.argv[1]
if os.path.splitext(file)[1] == ".txt":
    print("开始去重" + (file))
    input = open(file, encoding="utf8")
    # 打开文件
    result = list(set(input.readlines()))
    result.sort()
    output = open("test" + (file), "w", encoding="utf8")
    output.writelines(result)
    input.close()
    output.close()
    os.remove(file)
    os.rename("test" + (file), (file))
    print((file) + "去重完成")
# else:
#     print("规则去重中...")
#     files = os.listdir()  # 得到文件夹下的所有文件名称
#     for file in files:  # 遍历文件夹
#         if not os.path.isdir(file):  # 判断是否是文件夹，不是文件夹才打开
#             if os.path.splitext(file)[1] == ".txt":
#                 f = open(file, encoding="utf8")
#                 # 打开文件
#                 result = list(set(f.readlines()))
#                 result.sort()
#                 fo = open("test" + (file), "w", encoding="utf8")
#                 fo.writelines(result)
#                 f.close()
#                 fo.close()
#                 os.remove(file)
#                 os.rename("test" + (file), (file))

#     # 处理完毕
#     print("去重完毕")
