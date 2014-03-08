class RasterizerController < ApplicationController
 skip_before_filter :verify_authenticity_token

  def create
    require 'mini_magick'

    top = MiniMagick::Image.open(params[:top])
    side = MiniMagick::Image.open(params[:side])
    front = MiniMagick::Image.open(params[:front])

    top.combine_options do |c|
      c.scale('520x602!')
      c.background('none')
      c.shear('0x30')
      c.rotate('-60')
      c.gravity('center')
      c.scale('100%x85%!')
      c.crop('2000x602+0+0')
      c.repage('+0-298')
    end

    side.combine_options do |c|
      c.scale('520x662!')
      c.background('none')
      c.shear('0x26')
    end

    front.combine_options do |c|
      c.brightness_contrast('-20x-18')
      c.scale('520x662!')
      c.background('none')
      c.shear('0x-26')
    end

    side.combine_options 'convert' do |c|
      c.push(front.path)
      c.append.+
      c.push(top.path)
      c.background('none')
      c.layers('merge')
      c.repage.+
    end

    send_data(side.to_blob)
  end
end
