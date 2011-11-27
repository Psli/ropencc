ropencc
=======
ropencc is a project for conversion between Traditional and Simplified Chinese, wrapper in ruby.

Open Chinese Convert（OpenCC）「開放中文轉換」，是一個致力於中
文簡繁轉換的項目，提供高質量詞庫和函數庫(libopencc)。<a href='http://code.google.com/p/opencc/'>更多介紹</a>。

Install
-------
先安装 libopencc

Ubuntu

如果你正在使用Ubuntu 10.10 (Maverick) 以上的版本，opencc已經被加入到了官方源中，使用

    sudo apt-get install opencc

如果你更願意體驗最新的版本，請使用ppa：

    sudo add-apt-repository ppa:byvoid-kcp/ppa
    sudo apt-get update
    sudo apt-get install opencc


Mac OS X

使用 brew 安装

    brew install opencc

更多 libopencc 安装介绍请查看： <http://code.google.com/p/opencc/wiki/Install>

Usage
-----

简转繁

    Ropencc.conv('simp_to_trad',text)

繁转简

    Ropencc.conv('trad_to_simp',text)