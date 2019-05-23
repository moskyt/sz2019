module ApplicationHelper

  def favicon_path
    root_path.split("?").first + 'favicon.ico'
  end

  def link_js(text, options = {})
    link_to text, "javascript:void(0)", options
  end

  def test_time_widget(time_end, done_url = nil)
    sss = time_end.to_datetime - Time.now.localtime.to_datetime
    # sss /= 24*3600

    d = sss.floor
    h = ((sss          ).frac * 24).floor
    m = ((sss * 24     ).frac * 60).floor
    s = ((sss * 24 * 60).frac * 60).floor

    content_tag :span, class: "time-widget", data: {done_url: done_url, d: d, h: h, m: m, s: s, n: 0} do
      format_time_left(sss)
    end
  end

  def format_time_left(sss)
    d = sss.floor
    h = ((sss          ).frac * 24).floor
    m = ((sss * 24     ).frac * 60).floor
    s = ((sss * 24 * 60).frac * 60).floor
    "" + (d > 0 ? "#{d}d " : "") + "%02d:%02d:%02d" % [h,m,s]
  end

  def tooltip(text, ttext)
    content_tag(:span, text, :"data-show" => 'tooltip', :"data-title" => ttext)
  end

  def bool_icon(value, options = {})
    true_icon = icon('check', options.merge({style: 'color: green;', tooltip: (options[:true_tooltip] || options[:tooltip])}))
    false_icon = icon('times', options.merge({style: 'color: red;', tooltip: (options[:false_tooltip] || options[:tooltip])}))
    value ? true_icon : false_icon
  end

  def icon(klass, options = {})
    group = nil
    if options.is_a?(Hash)
      group = options[:group]
    end
    group ||= "fas"
    attrs = {:class => "#{group} fa-#{klass}"}
    if options.is_a?(String)
      attrs[:"data-show"] = "tooltip"
      attrs[:"data-title"] = options
    else
      if tooltip = options.delete(:tooltip)
        attrs[:"data-show"] = "tooltip"
        attrs[:"data-title"] = tooltip
      end
      if popover = options.delete(:popover)
        attrs[:"data-show"] = "popover"
        attrs[:"data-placement"] = 'left'
        attrs[:"data-content"] = popover
      end
      attrs.merge!(options)
    end
    content_tag(:i, "", attrs)
  end

end
