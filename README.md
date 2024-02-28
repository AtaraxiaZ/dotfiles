# My dotfiles

## Use GNU Stow to manage my dotfiles

Do not actually run the command, but show what will do:
```shell
stow -adopt -nv git
```

Move file and create symlink
```shell
stow -adopt -v git
```
create file tree
```shell
stow -S git
```

remove created file tree
```shell
stow -D git
```

remove and recreate file tree
```shell
stow -R git
```
This is equal to `stow -D git && stow -S git`


## Package list
### Arch Linux

```shell
# 获取当前系统中主动安装的包
pacman -Qqet > pkglist
# 从列表文件安装软件包
pacman -S --needed - < pkglist
# 如果其中包含AUR等外部包，需要过滤后再执行
pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist))
# 移除没有列在文件中的包
pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort pkglist))
```

### Ubuntu
```
sudo apt-get install $(cat pkglist)
xrgs sudo apt-get install < pkglist
for i in $(cat pkglist); do sudo apt-get install $i; done
```

