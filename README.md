# ros1_docker

## For orne_or
このブランチは https://github.com/open-rdc/orne_or の使用を前提としています。

## インストール

Precondition:Installed Docker

ワークスペースを作る
```bash
mkdir -p orne_or_docker/catkin_ws/src && cd orne_or_docker
```

本リポジトリをcloneする
```bash
git clone -b orne_or https://github.com/MibuchiYuta/ros1_docker.git && cd ros1_docker
```

ビルドする
```bash
./build.sh && cd ..
```

orne_orをcloneする
```bash
git clone git@github.com:open-rdc/orne_or.git catkin_ws/src/orne_or
```

orne_orの環境構築をする
```bash
cd ros1_docker
```
```bash
./run.sh
```
```bash
cd catkin_ws/src
```
```bash
wstool init
```
```bash
wstool merge orne_or/orne_or_pkgs.install
```
```bash
wstool up
```
```bash
rosdep update
```
```bash
rosdep install --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y
```
```bash
cd ~/catkin_ws
```
```bash
catkin build
```
```bash
source ~/.bashrc
```

## 使い方

コンテナの起動とログイン
```bash
./run.sh
```

別windowからコンテナへのログイン
```bash
./login.sh
```
