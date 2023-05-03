# windows 下配置我的neovim的全教程

## 安装Windows-termianls
https://learn.microsoft.com/zh-cn/windows/terminal/install

## 安装字体
到这里 https://www.nerdfonts.com/font-downloads 找到你喜欢的字体。
- 我使用的是[FiraCode](https://link.zhihu.com/?target=https%3A//github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode/Regular/complete/)
- 然后在终端的外观中配置你的字体成`nerdfonts`

## 安装scoop
- 这一步非常重要，因为有了scoop后之后安装什么都非常方便
- [scoop官网](https://scoop.sh/#/)，里面有安装全过程
- 安装好后添加main和extras包
```bash
scoop bucket add main
scoop bucket add extras
```

## (可选,如果已经有node环境就不需要再弄了)
- 安装`nvm`,node版本管理器
```bash
scoop install nvm
```
- 使用`nvm`安装node
	- -   `nvm install (你需要安装的node版本号)` 可以去官网查看 [以往版本列表](https://link.segmentfault.com/?enc=thFbNhhjyYI412Q%2BqwinwQ%3D%3D.pS4DMYK7HwhPLLZWCofN4nDb%2BUuGkx4ao8jovXqxFH2Un4pwF2z7jrGDvG5h8PQr)
	-   注意！！！上一步会直接同时安装相对应版本npm
	-   `nvm use (你需要安装的node版本号)` 一般还会弹出系统权限使用框，一定要点通过
- 安装`pnpm`
```bash
npm install -g pnpm
```

## (可选,配置rust环境)
- [配置rust环境](https://harsimranmaan.medium.com/install-and-setup-rust-development-environment-on-wsl2-dccb4bf63700)
- 安装`wasm-pack`
```bash
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
```

## 安装git

```bash
scoop install git
```

## 安装neovim

```bash
scoop bucket add extras #前面加过就不用在加了
scoop install vcredist2022
scoop install neovim
```

## 安装chezmoi

```bash
scoop install chezmoi
```

## 使用chezmoi来clone我的配置

```bash
chezmoi init git@github.com:$GITHUB_USERNAME/dotfiles.git
#或者
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
```

## 配置LazyVim需要的一些东西

- [官网](https://www.lazyvim.org/)
- 全部都可以用`scoop`来进行下载
- 然后直接打开你也有可能会报错
	- 所以你要继续安装一点东西
```bash
scoop install gcc
scoop install make
```

- 接下来可能就不会报错了,但是`vscode-js-debug`**可能会报错**
	- 你可以手动进入`vscode-js-debug`文件夹目录，然后手动执行下面的命令
	- 路径在`C:\Users\Administrator\AppData\Local\nvim-data\lazy\vscode-js-debug`
```bash
npm install --legacy-peer-deps
npx gulp vsDebugServerBundle
mv dist out
```

## 最后只要你有代理,就可以很顺利的使用nvim已经各种插件了
