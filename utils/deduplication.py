import os

# 去重开始
print("规则去重中...")
# 得到文件夹下的所有文件名称
files = os.listdir()
result = []
# 遍历文件夹
for file in files:
    # 判断是否是文件夹，不是文件夹才打开
    if not os.path.isdir(file):
        if os.path.splitext(file)[1] == '.txt':
            # print('开始去重'+(file))
            f = open(file, encoding="utf8")
            # 打开文件
            result = list(set(f.readlines()))
            result.sort()
            fo = open('test' + (file), "w", encoding="utf8")
            fo.writelines(result)
            f.close()
            fo.close()
            os.remove(file)
            os.rename('test' + (file), (file))
            # print((file) + '去重完成')

print("去重完毕")
