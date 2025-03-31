`in-game_server.lua`は`saves/world_name/computercraft/computer/N`下にシンボリックリンクを張る等して使うと良い。
その際、シンボリックリンクを含むワールドについて警告されるので[ここ](https://help.minecraft.net/hc/en-us/articles/16165590199181)を参考に`allowed_symlinks.txt`を作成すること。  
また、[ここ](https://tweaked.cc/guide/local_ips.html)を参考にCC:TweakedをローカルIPと通信できるように設定すること。
これは下のような項目を`[http]`セクション中の`[[http.rules]]`のうち一番先頭に配置することでも達成できる
```
[[http.rules]]
	host = "127.0.0.1"
	action = "allow"
```
ひとまずローカルではクライアントとNGINXサーバーの通信はポート8081で行うことにする  
[http://localhost:8081/storage](http://localhost:8081/storage)

NGINXサーバー起動:`nginx -p $(pwd) -c conf/nginx.conf`
