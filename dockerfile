# 使用官方 Python 基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制所有项目文件
COPY . .

# 【关键】创建一个非 root 用户并切换（HF 安全要求）
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# 【关键】暴露 7860 端口（HF 健康检查必须）
EXPOSE 7860

# 启动脚本
CMD ["python", "start.py"]
