require 'dxruby'
require 'date'

class MyObject < Sprite
=begin
    @@flag
    attr_accessor :flag
    def initialize(x,y,image,flag)
        self.x=x
        self.y=y
        self.image=image
        self.flag=flag
    end
=end
end

class Ball < MyObject
@@speed=0
@@vecx=0
@@vecy=0
attr_accessor :speed
attr_accessor :vecx
attr_accessor :vecy

def start(mousex,flag)
    self.x=mousex
    if flag then
        @@speed=5.0
        @@vecx=0.5
        @@vecy=-1
        return true
    end
    return false
end

def update(width,height)
    self.x+=@@speed*@@vecx
    self.y+=@@speed*@@vecy
    @@vecx*=-1 if self.x<0 ||self.x>width
    @@vecy*=-1 if self.y<0
    self.vanish if self.y>height
end

def reflect
    @@vecy*=-1
    @@speed+=0.005
end
end

Window.width=1280
Window.height=640
BLOCK_WIDTH=16
BLOCK_HEIGHT=16
blockgraph = Image.load_tiles('block.png',4,1) #ブロック画像を読み込む
ballgraph=Image.new(16,16).circleFill(8,8,8,[255,255,255])
bargraph=Image.new(64,16,[255,60,255])

ball=Ball.new(0,Window.height-32,ballgraph)
bar=MyObject.new(Window.width/2,Window.height-16,bargraph)
block=[]

for i in 0..Window.height/2/BLOCK_HEIGHT do
    for j in 0..Window.width/BLOCK_WIDTH do
        block.push(MyObject.new(0+BLOCK_WIDTH*j,0+BLOCK_HEIGHT*i,blockgraph[rand(3)]))
    end
end

ball.collision=[8,8,8]
startflag=false
Window.loop do #メインループ
    bar.x=Input.mouse_pos_x
    startflag=ball.start(bar.x,Input.mouse_down?(M_LBUTTON)) if !startflag

    ball.update(Window.width,Window.height)

    ball.reflect if ball===bar
    block.each do |i|
        if ball===i then
                i.vanish
                ball.reflect
        end
    end



    Sprite.clean(block)
    block.each do |i|
        i.draw
    end
    bar.draw
    ball.draw
    break if ball.vanished? == true
    break if Input.keyPush?(K_ESCAPE) #Escキーで終了
end