
#!/bin/bash

# 定义配置参数
PANEL_PORT="8888"         # 1Panel 访问端口
PANEL_DATA_DIR="/opt/1panel"  # 持久化数据目录
DOCKER_COMPOSE_FILE="${PANEL_DATA_DIR}/docker-compose.yml"  # Compose 文件路径

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
	    echo "Docker 未安装，正在自动安装 Docker..."
			    curl -fsSL https://get.docker.com | bash -s docker
					    systemctl enable --now docker
							fi
							
							# 检查 Docker Compose 是否安装
							if ! command -v docker-compose &> /dev/null; then
								    echo "Docker Compose 未安装，正在自动安装 Docker Compose..."
										    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
												    chmod +x /usr/local/bin/docker-compose
														fi
														
														# 创建数据目录
														mkdir -p ${PANEL_DATA_DIR}
														
														# 生成 Docker Compose 文件
														cat > ${DOCKER_COMPOSE_FILE} << EOF
version: '3'
services:
  1panel:
    image: 1panel/1panel:latest
    container_name: 1panel
    restart: unless-stopped
    ports:
      - "${PANEL_PORT}:80"
    volumes:
      - ${PANEL_DATA_DIR}/data:/opt/1panel/data
      - ${PANEL_DATA_DIR}/volumes:/opt/1panel/volumes
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /etc/localtime:/etc/localtime:ro
    environment:
      - TZ=Asia/Shanghai  # 设置时区
EOF

# 启动 1Panel 服务
cd ${PANEL_DATA_DIR}
docker-compose up -d

# 输出访问信息
echo "======================================"
echo "1Panel 已成功部署！"
echo "访问地址: http://$(curl -s 4.ipw.cn):${PANEL_PORT}"
echo "初始用户名: admin"
echo "初始密码: $(docker logs 1panel 2>&1 | grep 'password:' | awk '{print $NF}')"
echo "======================================"
