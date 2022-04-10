# Dapp-FastSolt
教你如何使用ArinaChain區塊鏈，打造Unity3D老虎機Dapp

對Dapp遊戲開發有興趣的朋友們，
今天這片文章會讓你很輕鬆的獲得開發Dapp全端的基礎能力，
只要一步一步攻略，
無須伺服器主機，
３０分鐘就可以發行自己的Dapp。


0.使用軟體及語言
>>下載FastSlot老虎機SDK

>>Metamask Wallet

Chrome應用程式商店下載地址:
https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?utm_source=chrome-ntp-icon


到ArinaChain區塊鏈瀏覽器下方
https://arinascan.com/
按下"Add Arina Network"
添加ArinaChain網路到Metamask


安裝後創建新地址,並到Discord
https://discord.com/invite/4eMpVWtWbu
詢問取得ARA方法

>>Solidity IDE Remix線上編譯器

網址:https://remix.ethereum.org/


>>Unity 3D遊戲編輯引擎(免費)

A1.網址:https://unity3d.com/cn/get-unity/download

A2.下載Unity Hub並且安裝(圖02)

A3.安裝Unity Hub後點擊圖示進入

A4.進入Unity Hub後選擇<安裝> --> <新增> --> <選擇Unity 2020.3.17f1版>下載(圖03)

A5.(圖04)下載後點選Unity Hub的<專案>--> <舊專案> --> <選擇下載的FastSlot資料夾> --> <點選選擇料夾> --> <開啟FastSlot專案> 

A6.進入FastSlot專案(圖05)

A7.安裝Microsoft Visual Studio Community 2017(或最新版)來編譯C#程式代碼，可到此下載：https://visualstudio.microsoft.com/zh-hant/downloads/



1.介紹ArinaChain

ArinaChain是台灣團隊Bitape，基於POA開源項目升級開發的高性能遊戲鏈，採用POA共識機制，，出塊速度每2秒一個區塊，對於極度追求性能的遊戲Dapp開發者而言，ArinaChain是符合目前市面鏈遊的最佳環境之一。
(圖06)


2.介紹老虎機原理

文章開頭看到的影片裡，可以看到玩家按下轉老虎機後，每一輪的轉牌就會開始動，最後停下來依照連線獲獎。而我們使用Unity3D來開發老虎機其實原理很簡單，轉盤會動的效果是利用幾張動態模糊的圖片產生的錯覺，加上音效後就會讓玩家誤以為機器在轉動，但其實原本只是靜態圖片的輪播。(圖07)


3.開獎架構介紹

每次玩家投注後會取得一個隨機數，隨機數範圍為0-100，這裡我們使用Tangerine網路的可驗證隨機數Rand()，當智能合約取得這個隨機後，再依照隨機數的值來配獎，賠率表如下：

隨機數為 0:    獲得 投注金額 X  50倍
隨機數為 1:    獲得 投注金額 X  20倍
隨機數為 2:    獲得 投注金額 X  10倍
隨機數為 3:    獲得 投注金額 X   8倍
隨機數為 4:    獲得 投注金額 X   5倍
隨機數為 5:    獲得 投注金額 X   3倍
隨機數為 6-10: 獲得 投注金額 X   2倍
隨機數為11-20: 獲得 投注金額 X   1倍
其他隨機數21-100沒有中獎



4.合約部屬

這個篇教學不涉及Solidity的教學，所以可以直接按照下面步驟Step by Step完成Fastslot合約部屬:

B1.來到https://remix.ethereum.org/ ，並打開安裝好的Metamask Wallet(圖08)。

B2.新增檔案命名Fastslot.sol(圖09)。

B3.把附檔裡Fastslot.sol的代碼貼上，並在Compile後複製ABI，然後把ABI存檔(圖10)。

B4.點選Deploy部屬合約並確認發送交易，交易完成後複製合約地址到https://arinascan.com/貼上查詢(圖11)。

B5.只要看到如下圖畫面就表示合約部屬完成(圖12)。


6.合約導入Unity3D

Unity3D是使用C#語言來開發遊戲的（也可以使用Javascript），而要讓Unity3D可以調用查詢智能合約必須使用Nethereum SDK（出處在：https://nethereum.com），Nethereum的功能可以直接產生私鑰或導入私鑰到專案裡，編譯後玩家無須使用第三方錢包來簽屬Dapp，在使用得宜之下，玩家可以跨越區塊鏈的高門檻，讓完全不懂區塊鏈及加密貨幣的圈外玩家暢玩Dapp遊戲，並享受區塊鏈帶來的革命及便利。


C1.用Unity3D打開FastSlot專案，在Assets/Scripts資料夾裡會發現一個Slot.cs檔(圖13)。

C2.雙擊點選Slot.cs後會用Visual Studio打開檔案，並看到被收起的大綱項目，點選智能合約大綱旁的＋號展開代碼。

C3.把剛剛部屬好的合約地址貼在地65行的ContractAddressTSlot後面(圖14)。

C4.合約地址裡面至少要放100個ARA，或在部屬合約時把代碼修改(圖15)。

C5.點選Maximize On Play後，再點選中間上面的箭頭Play>，便可進入遊戲(圖16)。

C6.可以直接把Metamask Wallet裡面的私鑰導入，或是點選Create產生新的私鑰，創造新的私鑰後會複製在剪貼簿，可以另外貼到記事本裡存下來方便下次使用，而創造出來新的私鑰及地址，需要再去取得ARA幣。

C7.進入遊戲後可以點選地址處複製地址到剪貼簿，下方有不同投注倍數的按鈕可以點選投注(圖18)。


7.其他注意事項

D1.如果ARA測試不好取得足夠數量，可以將合約地址換成我已經部屬好的地址0x11F59CDb028E3644bf9834a60aa8fE22C4238418。

D2.您在本篇教學產生的私鑰請只拿來開發測試遊戲使用，不要用在任何主網（ETH/BSC）的資產儲存轉移。

D3.本篇教學裡的Unity3D輸出編譯以Android為主，若要輸出成Windows版應用程式，需要把解析度做調整，要輸出IOS版請善用Google大神查詢。

D4.若要轉出APK需要安裝JDK和Android SDK。


8.教學內容版權聲明

智能合約撰寫：劉岳峰（Arina團隊）

Unity3D專案製作：葉辰（Arina團隊）

Slot C#撰寫：葉辰（Arina團隊）

視覺ＵＩ製作：Arina團隊美術小姐姐

