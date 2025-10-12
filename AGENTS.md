# リポジトリガイドライン

このリポジトリは、`yuxsr-dev` の各サービスが利用する Protocol Buffers 定義と生成済みのクライアント／サーバースタブを管理します。変更は常に再現性を保ち、コード生成を決定的にし、API やツールの調整時には利用側への影響を意識してください。

## プロジェクト構成とモジュール

- `proto/yuxsr_dev_pb/`: `.proto` 契約の作成とレビュー場所。`buf.yaml` と `buf.gen.yaml` が lint 設定と生成ターゲットを制御します。
- `gencode/go/yuxsr_dev_pb/`: 生成済み Go パッケージ。`gencode.sh` が `go.mod` を管理するため、手動編集は避け、再現可能な成果物のみをコミットしてください。
- `gencode/ts/yuxsr_dev_pb/`: 生成済み TypeScript クライアント。`index.ts` で Connect/ES バンドルを再エクスポートし、下流パッケージへ公開します。
- `gencode.sh`: Buf での生成、Go モジュールの整備、`npx tsc` による TypeScript コンパイルを一括実行します。リポジトリ直下で実行してください。

## ビルド／テスト／開発コマンド

- `npm install`: Buf プラグインと TypeScript コンパイルに必要な Node 依存を導入します。
- `npm run generate` または `make gencode`: `gencode.sh` を通じて Buf 生成 → Go `mod tidy` → `npx tsc` を連続実行します。
- `make lint`: `buf lint` で proto ツリーを検証します。PR 前に実行してください。
- `make format`: `buf format -w` により proto の書式を正規化します。
- `npx tsc --noEmit`: `index.ts` やカスタムヘルパーの編集時に行う型チェックの簡易コマンドです。

## コーディングスタイルと命名規約

- Proto は Buf の `STANDARD` lint プロファイルに従います。`snake_case` のフィールド名、`yuxsr_dev_pb.v1` のようなパッケージ名、`buf.gen.yaml` で管理する `go_package` と ES ターゲットを明示します。
- 生成された Go コードは `gofmt` 準拠です。手動での修正は避け、独自のヘルパーが必要な場合は `gencode/` 外に配置してください。
- TypeScript は `tsconfig.json` の設定（CommonJS・スペース 2 つのインデントなど）に従います。公開面を増やす場合は `index.ts` から再エクスポートしてください。

## テスト指針

- 専用の単体テストスイートは未整備ですが、コード生成とコンパイルの成功がリグレッション検知の基盤です。
- Proto を更新した際は `make lint` と `npm run generate` を必ず実行し、Buf lint の合格と Go／TypeScript 出力のビルド成功を確認してください。
- TypeScript のヘルパーを追加する場合は、`gencode/ts/__tests__/`（必要なら作成）にテストを配置し、`npm test` で実行できる状態にしてください。

## コミットとプルリクエスト

- Git ログで採用されている形式に合わせ、先頭に絵文字（例: `:sparkles:`, `:art:`, `:arrow_up:`）を置き、続けて簡潔な命令形サマリー（例: `:sparkles: add notification proto`）を 72 文字以内で記述します。
- 生成物はコミットに含めるか、再生成を見送る理由を明記してください。
- プルリクエストでは API 変更内容、影響を受けるサービス、必要に応じた Buf の breaking-change 出力を記載し、関連 Issue をリンクしてください。UI に影響する場合のみスクリーンショットを添付します。

## コミュニケーションルール

- レビューコメント、Issue、PR 説明、ドキュメント更新のすべてで日本語を用いてください。翻訳が難しい専門用語は英単語を併記しても構いません。
