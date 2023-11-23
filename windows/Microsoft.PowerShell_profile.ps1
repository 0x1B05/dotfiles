#------------------------------- Import Modules BEGIN -------------------------------
# 引入 posh-git
Import-Module posh-git

# 引入 ps-read-line
Import-Module PSReadLine

# 设置 PowerShell 主题
oh-my-posh init pwsh --config C:\Users\38649\AppData\Local\Programs\oh-my-posh\themes\paradox.omp.json | Invoke-Expression
#------------------------------- Import Modules END   -------------------------------





#-------------------------------   Set Encoding BEGIN    -------------------------------
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
#-------------------------------    Set Encoding END     -------------------------------





#-------------------------------  Set Hot-keys BEGIN  -------------------------------
# 关闭提示音
Set-PSReadlineOption -BellStyle None
# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 回到行首/行尾
Set-PSReadlineKeyHandler -Key "Ctrl+a" -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key "Ctrl+e" -Function EndOfLine

# 前进/后退一个单词
Set-PSReadlineKeyHandler -Key 'Alt+f' -Function ShellForwardWord
Set-PSReadlineKeyHandler -Key 'Alt+b' -Function ShellBackwardWord

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 启用预测性 IntelliSense
Set-PSReadLineOption -PredictionSource History
#-------------------------------  Set Hot-keys END    -------------------------------





#-------------------------------    Functions BEGIN   -------------------------------
# Python 直接执行
$env:PATHEXT += ";.py"

# 更新系统组件
function Update-Packages {
	# update pip
	# Write-Host "Step 1: 更新 pip" -ForegroundColor Magenta -BackgroundColor Cyan
	# $a = pip list --outdated
	# $num_package = $a.Length - 2
	# for ($i = 0; $i -lt $num_package; $i++) {
	# 	$tmp = ($a[2 + $i].Split(" "))[0]
	# 	pip install -U $tmp
	# }

	# update conda
	Write-Host "Step 1: 更新 Anaconda base 虚拟环境" -ForegroundColor Magenta -BackgroundColor Cyan
	conda activate base
	conda upgrade python

	# update TeX Live
	# $CurrentYear = Get-Date -Format yyyy
	# Write-Host "Step 2: 更新 TeX Live" $CurrentYear -ForegroundColor Magenta -BackgroundColor Cyan
	# tlmgr update --self
	# tlmgr update --all

	# update Apps using winget
	Write-Host "Step 3: 通过 winget 更新 Windows 应用程序" -ForegroundColor Magenta -BackgroundColor Cyan
	winget upgrade
	# winget upgrade --all
	
}
#-------------------------------    Functions END     -------------------------------





#-------------------------------   Set Alias BEGIN    -------------------------------
# 1. 编译函数 make
function MakeThings {
	nmake.exe $args -nologo
}
Set-Alias -Name make -Value MakeThings

# 2. 更新系统 os-update
Set-Alias -Name os-update -Value Update-Packages

# 3. 查看目录 ls & ll
function ListDirectory {
	(Get-ChildItem).Name
	Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem

# 4. 打开当前工作目录
function OpenCurrentFolder {
	param
	(
		# 输入要打开的路径
		# 用法示例：open C:\
		# 默认路径：当前工作文件夹
		$Path = '.'
	)
	Invoke-Item $Path
}
Set-Alias -Name open -Value OpenCurrentFolder

# 5. 更改工作目录
function Change-Directory {
	param (
		# 输入要切换到的路径
		# 用法示例：cd C:/
		# 默认路径：D 盘的桌面
		$Path = 'C:\Users\38649\Desktop\'
	)
	Set-Location $Path
}
Set-Alias -Name cd -Value Change-Directory -Option AllScope
#-------------------------------    Set Alias END     -------------------------------





#-------------------------------   Set Network BEGIN    -------------------------------
# 1. 获取所有 Network Interface
function Get-AllNic {
	Get-NetAdapter | Sort-Object -Property MacAddress
}
Set-Alias -Name getnic -Value Get-AllNic

# 2. 获取 IPv4 关键路由
function Get-IPv4Routes {
	Get-NetRoute -AddressFamily IPv4 | Where-Object -FilterScript {$_.NextHop -ne '0.0.0.0'}
}
Set-Alias -Name getip -Value Get-IPv4Routes

# 3. 获取 IPv6 关键路由
function Get-IPv6Routes {
	Get-NetRoute -AddressFamily IPv6 | Where-Object -FilterScript {$_.NextHop -ne '::'}
}
Set-Alias -Name getip6 -Value Get-IPv6Routes
#-------------------------------    Set Network END     -------------------------------
