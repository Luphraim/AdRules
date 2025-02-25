import os
import sys


def deduplicate_file(file):
    if not os.path.isfile(file):
        print(f"文件 {file} 不存在！")
        return

    if os.path.splitext(file)[1] != ".txt":
        print(f"文件 {file} 不是一个文本文件！")
        return

    print(f"开始去重 {file}")

    # 使用 with 语句自动管理文件关闭
    with open(file, "r", encoding="utf8") as input_file:
        lines = input_file.readlines()

    if not lines:
        print(f"文件 {file} 是空的，不需要去重！")
        return

    # 去重并排序
    result = sorted(set(lines))

    # 创建临时文件进行输出
    temp_file = f"test_{file}"
    with open(temp_file, "w", encoding="utf8") as output_file:
        output_file.writelines(result)

    # 替换原文件
    os.remove(file)
    os.rename(temp_file, file)

    print(f"{file} 去重完成")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("请提供一个文件路径作为参数")
    else:
        deduplicate_file(sys.argv[1])
