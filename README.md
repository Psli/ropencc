
ropencc
=======
ropencc is a project for conversion between Traditional and Simplified Chinese, wrapper in ruby.

繁简转换的程序，看似简单，但一研究起来，却真的不简单。其中一个难点是繁简汉字之间往往不能一一对应

例如：瞭解 -> 了解 瞭望 -> 瞭望；“標準”繁換簡是“标准”，但“标准”簡換繁卻是“標准”

还有若干语言习惯的问题，例如同一个地名的称呼就不一样，就不一一列举了

而 Open Chinese Convert（OpenCC）「开发中文转换」，是一个致力于中
文简繁转换的项目，由清华大学的 [BYVoid](http://www.byvoid.com/blog/about/) 提供高质量词库和函数库(libopencc)。<a href='http://code.google.com/p/opencc/'>更多介紹</a>。

Install
-------
1. 先安装 libopencc

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

2. 安装 ropencc
   
        gem install ropencc

Usage
-----

简转繁

    Ropencc.conv('simp_to_trad', str)

繁转简

    Ropencc.conv('trad_to_simp', str)


附：libopencc 作者简介
--------------------
BYVoid，清華大學計算機系二零一零級本科生，清華大學學生網絡管理委員會副會長，現於微軟亞洲研究院系統組實習。

出生於1991年末，年十九歲，河南安陽人。熱愛計算機科學、語言學、漢語音韻學。能說有入聲的老派安陽話，會用簡繁體流暢地閱讀書寫，能夠辨析漢字簡繁正異用法。認爲「正體字」不等於「臺灣正體字」，支持傳統正體字回歸主流，主張廢除簡體字， 希望陸、港、澳、臺、日、韓、越早日實現漢字統一。