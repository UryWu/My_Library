
#### git设置、查看、取消代理 翻墙 科学上网

于 2020-06-16 19:21:08 发布

设置代理：

```shell
//http || https
git config --global http.proxy 192.168.169.105:10809
git config --global https.proxy 192.168.169.105:10809
```

//sock5代理

```shell
git config --global http.proxy socks5 192.168.169.105:10808
git config --global http.proxy socks5 192.168.169.105:10808

git config --global http.proxy 'socks5://192.168.87.105:10808'
git config --global https.proxy 'socks5://192.168.87.105:10808'
```

查看代理：

```shell
git config --global --get http.proxy
git config --global --get https.proxy
```

批量查看配置：
```shell
git config --global --list
或者：
cat ~/.gitconfig
```

```output
user.name=urywu
user.email=urywu@qq.com
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
http.postbuffer=1557286400
http.proxy=192.168.87.105:10809
http.proxy=socks5
http.proxy=socks5
http.proxy=socks5
http.proxy=socks5
```
取消代理：

```shell
git config --global --unset http.proxy
git config --global --unset https.proxy
```
测试：
```
curl www.google.com

git clone https://github.com/Significant-Gravitas/AutoGPT.git
```
