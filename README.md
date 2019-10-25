# Dapp-FastSolt
教你如何使用柑橘區塊鏈
打造Unity3D老虎機Dapp

對Dapp遊戲開發有興趣的朋友們，今天這片文章會讓你很輕鬆的獲得開發Dapp全端的基礎能力，只要一步一步攻略，無須伺服器主機，３０分鐘就可以發行自己的Dapp。

0.使用軟體及語言
>>下載FastSlot老虎機SDK

>>Tangerine Wallet(類似MetaMask)
Chrome應用程式商店下載地址:
https://chrome.google.com/webstore/detail/tangerine-wallet/pmfboceaaldgniakejfcfkidccbiimae
安裝後創建新地址,並到
https://testnet.tangerine.garden查詢自己的地址
可點選代幣水龍頭取得TAN測試代幣(圖01)
每天3次,每次1TAN(主網每次0.01TAN)


>>Solidity IDE Remix線上編譯器
網址:https://remix.dxn.ninja


>>Unity 3D遊戲編輯引擎(免費)
A1.網址:https://unity3d.com/cn/get-unity/download
A2.下載Unity Hub並且安裝(圖02)
A3.安裝Unity Hub後點擊圖示進入
A4.進入Unity Hub後選擇<安裝> --> <新增> --> <選擇Unity 2019.2.9f1版>下載(圖03)
A5.(圖04)下載後點選Unity Hub的<專案>--> <舊專案> --> <選擇下載的FastSlot資料夾> --> <點選選擇料夾> --> <開啟FastSlot專案> 
A6.進入FastSlot專案(圖05)
A7.安裝Microsoft Visual Studio Community 2017(或最新版)來編譯C#程式代碼，可到此下載：https://visualstudio.microsoft.com/zh-hant/downloads/



1.介紹柑橘網路
Tangerine Network是台灣團隊Byzantine-Lab，基於Dexon開源項目升級開發的高性能公鏈，採用POS共識機制，由台灣數十個技術團隊所組成的社區共同治理，並將節點分散到Tangerine社區夥伴來運營，出塊速度趨近於每秒一個區塊，對於極度追求性能的遊戲Dapp開發者而言，Tangerine Network柑橘網路是目前市面上最佳公鏈環境，沒有之一（個人使用評比觀點）。
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


4.可驗證隨機數Rand()
這是一個從底層架構產生的函數，因為是使用包含從底層節點產生的值所組成，這個函數就無法被預測，可以避免常見的預言攻擊，並大大降低該發者取得公正隨機數的成本。
函數的公式如下：
rand = Keccak( Randomness . Caller . Nonce . RandCallIndex )

介紹連結：
https://tangerine-network.github.io/wiki/#/On-Chain-Random-Oracle



5.合約部屬
這個篇教學不涉及Solidity的教學，所以可以直接按照下面步驟Step by Step完成Fastslot合約部屬:
B1.來到https://remix.dxn.ninja，並打開安裝好的Tangerine Wallet(圖08)。
B2.新增檔案命名Fastslot.sol(圖09)。
B3.把附檔裡Fastslot.sol的代碼貼上，並在Compile後複製ABI，然後把ABI存檔(圖10)。
B4.點選Deploy部屬合約並確認發送交易，交易完成後複製合約地址到https://testnet.tangerine.garden/貼上查詢(圖11)。
B5.只要看到如下圖畫面就表示合約部屬完成(圖12)。


6.合約導入Unity3D
Unity3D是使用C#語言來開發遊戲的（也可以使用Javascript），而要讓Unity3D可以調用查詢智能合約必須使用Nethereum SDK（出處在：https://nethereum.com），Nethereum的功能可以直接產生私鑰或導入私鑰到專案裡，編譯後玩家無須使用第三方錢包來簽屬Dapp，在使用得宜之下，玩家可以跨越區塊鏈的高門檻，讓完全不懂區塊鏈及加密貨幣的圈外玩家暢玩Dapp遊戲，並享受區塊鏈帶來的革命及便利。

C1.用Unity3D打開FastSlot專案，在Assets/Scripts資料夾裡會發現一個Slot.cs檔(圖13)。
C2.雙擊點選Slot.cs後會用Visual Studio打開檔案，並看到被收起的大綱項目，點選智能合約大綱旁的＋號展開代碼。
C3.把剛剛部屬好的合約地址貼在地65行的ContractAddressTSlot後面(圖14)。
C4.合約地址裡面至少要放100個TAN，或在部屬合約時把代碼修改(圖15)。
C5.點選Maximize On Play後，再點選中間上面的箭頭Play>，便可進入遊戲(圖16)。
C6.可以直接把Tangerine Wallet裡面的私鑰導入，或是點選Create產生新的私鑰，創造新的私鑰後會複製在剪貼簿，可以另外貼到記事本裡存下來方便下次使用，而創造出來新的私鑰及地址，需要再去代幣水龍頭取得TAN測試幣(圖17)。
C7.進入遊戲後可以點選地址處複製地址到剪貼簿，下方有不同投注倍數的按鈕可以點選投注(圖18)。


7.其他注意事項
D1.如果TAN測試不好取得足夠數量，可以將合約地址換成我已經部屬好的地址0x50ab1918a2047263ea7FFBBD3AD50F2d2DCe6F6a。
D2.您在本篇教學產生的私鑰請只拿來開發測試遊戲使用，不要用在任何主網（ETH/TAN）的資產儲存轉移。
D3.本篇教學裡的Unity3D輸出編譯以Android為主，若要輸出成Windows版應用程式，需要把解析度做調整，要輸出IOS版請善用Google大神查詢。
D4.若要轉出APK需要安裝JDK和Android SDK。


8.教學內容版權聲明

智能合約撰寫：劉岳峰（Arina團隊）

Unity3D專案製作：虎哥（Arina團隊）

Slot C#撰寫：虎哥（Arina團隊）

視覺ＵＩ製作：Arina團隊


9.Arin團隊其他Dapp介紹

Arina地產大亨：https://www.arinatycoon.com

Arina Hunters(封測中):https://www.arinahunters.com

Arina官網：https://www.arinamillion.com

詢問Line ID: tiggerzeeen
