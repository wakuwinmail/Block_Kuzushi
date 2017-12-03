require 'dxruby'
Window.width=1280
Window.height=640
BLOCK_WIDTH=16
BLOCK_HEIGHT=16
x = 0 #x座標の変数
y = 0 #y座標の変数
block = Image.load_tiles('block.png',4,1) #ブロック画像を読み込む

Window.loop do #メインループ
    
    for i in 0..Window.height/BLOCK_HEIGHT do
        for j in 0..Window.width/BLOCK_WIDTH do
        Window.draw(0+BLOCK_WIDTH*j,0+BLOCK_HEIGHT*i,block[rand(3)])
        end
    end

    break if Input.keyPush?(K_ESCAPE) #Escキーで終了
end