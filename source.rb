require 'dxruby'
require 'date'

class MyObject < Sprite
    @@flag
    attr_accessor :flag
    def initialize(x,y,image,flag)
        self.x=x
        self.y=y
        self.image=image
        self.flag=flag
    end
end

Window.width=1280
Window.height=640
BLOCK_WIDTH=16
BLOCK_HEIGHT=16
blockgraph = Image.load_tiles('block.png',4,1) #ブロック画像を読み込む
ballgraph=Image.new(16,16).circleFill(8,8,5,[255,255,255])
bargraph=Image.new(64,16,[255,60,255])

ballspeed=5
ballvecx=1
ballvecy=1
ball=MyObject.new(Window.width/3,Window.height/2,ballgraph,true)
bar=MyObject.new(Window.width/2,Window.height-16,bargraph,true)
block=[]

for i in 0..Window.height/2/BLOCK_HEIGHT do
    for j in 0..Window.width/BLOCK_WIDTH do
        block.push(MyObject.new(0+BLOCK_WIDTH*j,0+BLOCK_HEIGHT*i,blockgraph[rand(3)],true))
    end
end

Window.loop do #メインループ
    bar.x=Input.mouse_pos_x

    if ball.flag then
        ball.x+=ballspeed*ballvecx
        ball.y+=ballspeed*ballvecy
        ballvecx*=-1 if ball.x<0 ||ball.x>Window.width
        ballvecy*=-1 if ball.y<0
        ball.flag=false if ball.y>Window.height
    end

    ballvecy*=-1 if ball===bar
    block.each do |i|
        if i.flag
            if ball===i then
                i.flag=false
                ballvecy*=-1
            end
        end
    end

    block.each do |i|
        i.draw if i.flag
    end
    bar.draw
    ball.draw
    break if ball.flag==false
    break if Input.keyPush?(K_ESCAPE) #Escキーで終了
end