# 株式会社ゆめみ iOS エンジニアコードチェック課題

## アプリ仕様

仕様の機能に加え、Bookmarkの機能を搭載しました。

動作イメージ
![yumemi-codecheck-app](https://user-images.githubusercontent.com/93827556/181872362-875678e1-e17c-4d06-a5b7-011eb3f17816.gif)

## アピールポイント
仕様書にある昨日は全て実装した上で、ブックマーク機能を搭載した。
TabViewで検索タブとブックマークタブで切り替えられるようにしていますが、Viewを無駄に増やさないために、ブックマークタブからRepoDetailViewに遷移できるようにした

検索結果がない場合は、No Imageと出力することで、ユーザーが混乱しないようにした

コメントを多くしたり、ファイルを分割したりすることで、可読性を意識した。

## 開発時の悩みなど

### 開発時の悩み
* APIを叩く際、日本語をリンクにそのまま貼り付けるとエラーになることを知らず、解決に時間がかかった。
* 

### さらに実装したかったこと
* RepoViewにあるAddToBookmarkボタンを押したときに、ブックマークリストにすでにあるデータなのかを判断して、ボタンのデザインを変更する(今の状態では、ただボタンが押されたときにデザインを変える仕様になっている)
* ブックマークをデータベースに保存できるようにする
* APIから取り出すデータの項目が多いので、APIを叩く時点で必要な項目(full_name, languageなど)だけを抽出し、動作を早くさせる

## 質問したいこと
* extensionではなく、別クラスとしてViewController内のTableViewなどのDelegateの操作をする方法はないか。
* 他クラスから別クラスの変数の値を変更する方法はないか。今回はグローバル変数を使ってbookmarkリストを扱ったが、本来はBookmarkViewControllerの中に入れておきたかった。
* 強制アンラップを使う意味は？初心者の自分から見たら、エラーの根源のように見え、使うのを躊躇してしまう。
* メインのTableViewDelegateとブックマークのTableViewDelegateのような、同じようなコードを省略化できる方法はないか。
* 「Issues-ソースコードの可読性の向上-命名規則, ネスト, インデント, スペースや改行」について、配布コードのどこが具体的に間違っていたのか見つけられなかったため、正解のコードを見たい
