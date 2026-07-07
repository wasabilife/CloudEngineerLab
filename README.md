## Day 1 Completed

### AWS
- [x] AWS account created
- [x] Root MFA enabled
- [x] IAM Administrator user created
- [x] AWS Budgets (Zero-Spend Budget) configured

### Git
- [x] Git installed
- [x] GitHub connected
- [x] First push completed

## Day 2 & 3 Completed 🚀

### AWS (Networking & Compute)
- [x] **VPC (Virtual Private Cloud) の設計・構築**
  - サブネット、インターネットゲートウェイ（IGW）、ルートテーブルを適切に配置し、パブリック通信が可能なインフラの土台を確立。
- [x] **EC2インスタンス（Amazon Linux 2023）の起動**
  - キーペア（RSA形式/.pem）を発行し、ローカル環境（Windows/PowerShell）から安全なSSH接続を確立。
- [x] **Webサーバー（Apache）の導入とサービス化**
  - `httpd` パッケージのインストール、およびサーバー起動・自動起動（`systemctl enable`）を設定。
- [x] **ファイアウォール（セキュリティグループ）の制御**
  - HTTP通信（ポート80）を一般公開し、Webブラウザからの外部アクセスを可能に設定。

---

## ⚠️ ネットワーク構築におけるトラブルシューティング（検証と対策）

インフラ構築の過程で発生した通信遮断ログと、それに対する原因特定・解決のプロセスです。

### ケース1：SSH接続時の「Connection refused（接続拒否）」
- **事象**：
  ローカルPCのPowerShellからEC2へSSH接続を試みた際、`ssh: connect to host port 22: Connection refused` が発生。
- **原因特定**：
  `curl inet-ip.info` を実行したところ、自身のグローバルIPアドレス（ISP側で動的に割り当てられるIP）が変動していることを確認。EC2作成時に自動設定されたセキュリティグループの「マイIP（許可送信元）」の数値と不一致を起こしていた。また、EC2起動直後でOS内部のSSHサービス（sshd）が立ち上がる前のタイミングであった。
- **対策**：
  AWSコンソールからインバウンドルールを編集。変動した最新のグローバルIPアドレスを取得し、「マイIP」としてセキュリティグループに再適用して保存。
- **結果**：
  OS起動完了を待ちリトライした結果、ホストのフィンガープリント（ED25519）確認を経て、正常にLinuxサーバー内へのSSHログインに成功。

### ケース2：Webサーバー起動後の「ERR_CONNECTION_TIMED_OUT（応答なし）」
- **事象**：
  EC2内部でApache（httpd）を起動し、ステータスが正常であることを確認後、ブラウザからパブリックIP（`http://56.155.44.107`）へアクセスしたところ、接続タイムアウト（サイトに応答がない状態）となった。
- **原因特定**：
  EC2に紐づくセキュリティグループのインバウンドルールを検証したところ、「SSH（22）」および「HTTPS（443）」のみが許可されており、通常のWebアクセスである「HTTP（80）」の通信を受け付ける窓口（ポート）が閉じていることが判明。
- **対策**：
  インバウンドルールに以下のレコードを新規追加。
  - **タイプ**: `HTTP`
  - **ポート範囲**: `80`
  - **ソース**: `Anywhere-IPv4 (0.0.0.0/0)` （Webサイトとして広く一般公開するため、送信元を全員許可に設定）
- **結果**：
  ルール保存直後、ブラウザの再読み込みにて即座にターゲットサーバーへの疎通が確認され、画面に **「It works!」** のテストページが表示されたことを確認。Webサーバー化ミッションをコンプリート。