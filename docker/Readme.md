# 概要

Docker Composerを利用してMarkERdを利用する環境を構築します。

# 準備

事前にDockerとDocker Composer等をいれておく必要があります。
[Docker Toolbox](https://www.docker.com/products/docker-toolbox) などを使って入れてください。

1. ターミナルを立ち上げてdocker-composer.ymlのあるディレクトリに移動

このファイルのあるディレクトリです。

docker-composer.yml、Dockerfileの二つがあればよく、他のファイルはなくても使えます。
(MarkERd本体は、githubからではなく、gemに公開されている最新版からとってきます。)


2. MarkERdの環境のビルド

ビルドは１コマンドですみます。ただ、いろいろなファイルをダウンロードしてくるので、すごく時間がかります。
時間がかかるのは初回だけで、一度実施してしまえば、次回からは時間がかかりません。

```
# docker-compose build
```

3. MarkERdの環境に入ってみる

下記でDocker上に構築されたxpubの環境に入ることができます。
```
# docker-compose run markerd bash
```

4. /rootディレクトリに移動する

MarkERdの環境の中で下記のようにして、移動します。これは、dockerを起動したホスト環境のdocker-composer.ymlと共有フォルダになっていて、MarkERdのdockerの環境からも、ホストマシンからも見ることができます。
```
# cd /root
# ls
Dockerfile  Readme.md  docker-compose.yml
```

5. サンプルファイルを用意する

MarkERdの環境内で、MarkERdの初期化を行います。

```
# markerd init
init...
```

```
# ls
Dockerfile  Readme.md docker-compose.yml sample.erd
```
ひな形のファイルができあがっています。


6. ビルドする。

MarkERdの環境の中でビルドしてみます。
```
# markerd build sample.erd sample.pdf
build...
```

すると、sample.pdfができあがっています。

dockerを起動したホスト環境で、sample.pdfを見てみましょう。

このファイルはsample.erdから生成されています。

sample.erdをかえて、

```
# markerd build sample.erd sample.pdf
```
することで、最新の状態にすることができます。

7. 終了

MarkERdの環境の中で

```
# exit
```
することで、終了できます。お疲れ様でした。

また使いたい場合はdocker-compose.ymlのあるディレクトリで下記のコマンドを実行します。

```
# docker-compose run markerd bash
```
