# nginxの公式イメージを使用
FROM nginx:alpine

# カスタムHTMLファイルをnginxのデフォルトディレクトリにコピー
COPY index.html /usr/share/nginx/html/

# ポート8080を公開（デフォルトの80ポートを8080にマッピングするため）
EXPOSE 80

# nginxを起動（デフォルトで実行されるため、明示的に指定）
CMD ["nginx", "-g", "daemon off;"]

