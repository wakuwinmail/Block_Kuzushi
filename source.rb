require 'dxruby'
require 'date'



Window.width=1280
Window.height=640
BLOCK_WIDTH=16
BLOCK_HEIGHT=16
ballx = 0 #x座標の変数
bally = 0 #y座標の変数
blockgraph = Image.load_tiles('block.png',4,1) #ブロック画像を読み込む
ballgraph=Image.new(10,10).circleFill(5,5,5,[255,255,255])
block=[]
blocks=[]
for i in 0..Window.height/2/BLOCK_HEIGHT do
    for j in 0..Window.width/BLOCK_WIDTH do
        block.push(0+BLOCK_WIDTH*j,0+BLOCK_HEIGHT*i,blockgraph[rand(3)])
    end
end
i=0
while i<block.length do
    blocks.push(Sprite.new(block[i],block[i+1],block[i+2]))
    i+=3
end

Window.loop do #メインループ
    i=0
    while i<block.length do
        Window.draw(block[i],block[i+1],block[i+2])#3つ目の引数がうまく読み込めない
        i+=3
    end
    ballx=ballx+Input.x
    bally=bally+Input.y
Window.draw(ballx,bally,ballgraph)
    break if Input.keyPush?(K_ESCAPE) #Escキーで終了
end