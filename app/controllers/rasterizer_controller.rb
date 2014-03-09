class RasterizerController < ApplicationController
 skip_before_filter :verify_authenticity_token

  def create
    require 'mini_magick'

    size = params[:s].to_i
    size = 500 if size < 1

    if size > 1000
      render :json => {:error => 'Size too big! Max size 1000!'}
      return
    end
    puts "size: #{size}"

    multiplier = size.to_f / 1000.to_f

    top = MiniMagick::Image.open(params[:top])
    side = MiniMagick::Image.open(params[:side])
    front = MiniMagick::Image.open(params[:front])

    x_scale = multiplier * 520
    y_scale = multiplier * 662

    top.combine_options do |c|
      c.scale("#{x_scale}x#{602 * multiplier}!")
      c.background('none')
      c.shear('0x30')
      c.rotate('-60')
      c.gravity('center')
      c.scale('100%x85%!')
      c.crop("#{2000 * multiplier}x#{602 * multiplier}+0+0")
      c.repage("-1-#{298 * multiplier}")
    end

    side.combine_options do |c|
      c.scale("#{x_scale}x#{y_scale}!")
      c.background('none')
      c.shear('0x26')
    end

    front.combine_options do |c|
      c.brightness_contrast('-20x-18')
      c.scale("#{x_scale}x#{y_scale}!")
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
      c.scale("#{size}x#{size}")
    end

    send_data(side.to_blob)
  end
end
