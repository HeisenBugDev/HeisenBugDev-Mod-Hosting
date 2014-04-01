module RasterizerHelper
  def main_post
    size = params[:s].to_i
    size = 250 if size < 1
    images = { :top => nil, :side => nil, :front => nil }

    verified_parameters = verify_parameters(params, size, images)

    unless verified_parameters == nil
      verified_parameters.call
      return
    end

    multiplier = size.to_f / 1000.to_f
    x_scale = multiplier * 520
    y_scale = multiplier * 662

    convert_top(images[:top])
    convert_side(images[:side])
    convert_front(images[:front])

    combine_all(images)

    send_data(images[:side].to_blob)
  end

  private

  def combine_all(images)
    images[:side].combine_options 'convert' do |c|
      c.push(images[:front].path)
      c.append.+
      c.push(images[:top].path)
      c.background('none')
      c.layers('merge')
      c.repage.+
      c.scale("#{size}x#{size}")
    end
  end

  def convert_front(front)
    front.combine_options do |c|
      c.brightness_contrast('-20x-18')
      c.scale("#{x_scale}x#{y_scale}!")
      c.background('none')
      c.shear('0x-26')
    end
  end

  def convert_side(side)
    side.combine_options do |c|
        c.scale("#{x_scale}x#{y_scale}!")
        c.background('none')
        c.shear('0x26')
      end
  end

  def convert_top(top)
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
  end

  def verify_parameters(params, size, images)
    missing_params = []

    [:top, :side, :front].each do |param|
      missing_params << param if params[param].nil?
    end

    unless missing_params.empty?
      return proc do
        render :json => {:error => "parameters are missing or broken!"},
             :status => :bad_request
      end
    end

    if size > 1000
      return proc do
        render :json => {:error => 'Size too big! Max size 1000!'},
             :status => :bad_request
      end
    end

    begin
      images[:top] = MiniMagick::Image.open(params[:top])
      images[:side] = MiniMagick::Image.open(params[:side])
      images[:front] = MiniMagick::Image.open(params[:front])
    rescue Errno::ENOENT
      return proc do
        render :json => {:error => 'One or more files does not exist.'},
             :status => :failed_dependency
      end
    end

    return
  end
end
