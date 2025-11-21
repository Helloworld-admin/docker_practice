# Docker練習用プロジェクト

このプロジェクトはDockerの練習用に作成されたシンプルなWebアプリケーションです。

## 概要

http://localhost:8080 にアクセスすると、簡単なHTMLページが表示されます。

## 必要な環境

- Docker
- Docker Compose（オプション）

## 使い方

### 方法1: Docker Composeを使用（推奨）

#### ビルド

```bash
# Dockerイメージをビルド
docker-compose build

# キャッシュを使わずに再ビルド
docker-compose build --no-cache
```

#### 起動（アップ）

```bash
# コンテナをバックグラウンドで起動（ターミナルが開放されます）
docker-compose up -d

# 初回起動時はビルドも同時に行う場合
docker-compose up -d --build
```

#### 停止・削除（ダウン）

```bash
# コンテナを停止
docker-compose stop

# コンテナを停止して削除
docker-compose down

# コンテナを停止して削除（ボリュームも削除）
docker-compose down -v
```

#### その他の便利なコマンド

```bash
# コンテナの状態を確認
docker-compose ps

# ログを確認
docker-compose logs

# ログをリアルタイムで確認（Ctrl+Cで終了）
docker-compose logs -f

# コンテナを再起動
docker-compose restart

# コンテナ内のLinux環境に入る（シェルを起動）
docker-compose exec web sh
```

### 方法2: Dockerコマンドを直接使用

#### ビルド

```bash
# Dockerイメージをビルド
docker build -t docker-practice .

# キャッシュを使わずに再ビルド
docker build --no-cache -t docker-practice .
```

#### 起動（アップ）

```bash
# コンテナをバックグラウンドで起動
docker run -d -p 8080:80 --name docker-practice-web docker-practice
```

#### 停止・削除（ダウン）

```bash
# コンテナを停止
docker stop docker-practice-web

# コンテナを削除
docker rm docker-practice-web

# コンテナを停止して削除（まとめて実行）
docker stop docker-practice-web && docker rm docker-practice-web
```

#### その他の便利なコマンド

```bash
# コンテナの状態を確認
docker ps

# すべてのコンテナ（停止中も含む）を確認
docker ps -a

# コンテナ内のLinux環境に入る（シェルを起動）
docker exec -it docker-practice-web sh
```

## コンテナ内のLinux環境に入る方法

コンテナが起動している状態で、以下のコマンドでコンテナ内のLinux環境に入ることができます：

### Docker Composeを使用している場合

```bash
# Alpine Linuxなので sh を使用
docker-compose exec web sh

# コンテナ内でコマンドを実行（例：ファイル一覧を表示）
docker-compose exec web ls -la /usr/share/nginx/html/
```

### Dockerコマンドを直接使用している場合

```bash
# Alpine Linuxなので sh を使用
docker exec -it docker-practice-web sh

# コンテナ内でコマンドを実行（例：ファイル一覧を表示）
docker exec docker-practice-web ls -la /usr/share/nginx/html/
```

**注意**: このプロジェクトはAlpine Linuxベースのため、`sh`を使用します。`bash`は利用できません。

コンテナ内から出るには、`exit`と入力するか、`Ctrl+D`を押します。

## アクセス方法

### 同じPCからアクセス

ブラウザで以下のURLにアクセスしてください：
- http://localhost:8080
- http://127.0.0.1:8080

### 同じネットワーク上の他のPCからアクセス

同じネットワーク（同じWi-FiやLAN）に接続されている他のPCからもアクセスできます。

1. **ホストPCのIPアドレスを確認**

   Windowsの場合：
   ```bash
   ipconfig
   ```
   `IPv4 アドレス`の値を確認してください（例：192.168.1.100）

   Linux/Macの場合：
   ```bash
   ifconfig
   # または
   ip addr
   ```

2. **他のPCのブラウザからアクセス**

   ```
   http://<ホストPCのIPアドレス>:8080
   ```
   例：`http://192.168.1.100:8080`

**注意事項：**
- Windowsのファイアウォールがブロックしている場合があります
- ファイアウォールの警告が出た場合は、ポート8080を許可してください
- セキュリティ上、信頼できるネットワークでのみ使用してください

## ファイル構成

- `index.html` - 表示されるHTMLファイル
- `Dockerfile` - Dockerイメージの定義
- `docker-compose.yml` - Docker Composeの設定ファイル
- `.dockerignore` - Dockerビルド時に除外するファイル

## 技術スタック

- Nginx (Alpine Linuxベース)
- HTML5 / CSS3