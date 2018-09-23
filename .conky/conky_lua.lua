--this is a lua script for use in conky
require 'cairo'
require 'math'
require 'os'

function conky_main()
    -- init
    if conky_window == nil then
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

    curr_date = os.date ('*t')

    next_year = os.time {day = 1, month = 1, year = curr_date.year+1}
    next_5_year =  curr_date.year + (5 - (curr_date.year - 1992) % 5)
    next_5 = os.time {day = 2, month = 11, year = next_5_year} -- the next 5 year
    next_life_year = os.time {day = 2, month = 11, year = 1992+70} -- expected death at 60
    
    span_newyear = math.floor (os.difftime (next_year, os.time ()) / (24 * 60 * 60))
    span_next5 = math.floor (os.difftime ( next_5, os.time ()) / (24 * 60 * 60))
    span_life = math.floor (os.difftime ( next_life_year, os.time ()) / (24 * 60 * 60))

    range_next_year = math.min (1 - (span_newyear / 365), 1)
    range_next5 = math.min (1 - (span_next5 / (365 * 5)), 1)
    range_life = math.min (1 - (span_life / (365 * 60)), 1)

    x,y = 200, 300

    -- for lifetime
    my_cairo_draw_less_circle (
        cr, -- cairo object
        x,
        y,
        100, -- radius
        20, -- width
        range_life, -- value
        span_life.." days before DEAD"
    )

    -- for next 5 years
    my_cairo_draw_less_circle (
        cr, -- cairo object
        x,
        y,
        70, -- radius
        14, -- width
        range_next5, -- value
        span_next5.." days before " ..(next_5_year-1992).."'s"
    )
    
    -- for this year
    my_cairo_draw_less_circle (
        cr, -- cairo object
        x,
        y,
        40, -- radius
        8, -- width
        range_next_year, -- value
        span_newyear.." days before "..curr_date.year + 1
    )

    -- destroy
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
end

function my_cairo_draw_less_circle (
    cr, 
    center_x, 
    center_y, 
    radius, 
    line_width, 
    value,
    text
    )
    -- cr : cairo object
    -- center_x, center_y, radius, line_width : nuff said
    -- value : [0-1], the value of color in here
    -- text : The text want to display on
    -- w_color, wether we want color

    local start_angle = 0
    local end_angle = 2 * math.pi * 3/4

    -- first, draw border
    cairo_set_line_width (cr, 1)
    cairo_set_source_rgba (cr, 0.3,0.3,0.3,0.9) -- for border
    -- if radius set to 50, then 25 from center to top most, 25 to right most.
    cairo_arc_negative (cr, center_x, center_y, radius+line_width/2, end_angle , 0)
    cairo_arc (cr, center_x, center_y, radius-line_width/2, 0, end_angle)
    cairo_close_path (cr)

    -- for text placeholder
    y_bottom = center_y - radius + line_width/2
    cairo_move_to (cr, center_x, y_bottom)
    cairo_line_to (cr, center_x+line_width*2, y_bottom)
    cairo_stroke (cr)
    cairo_close_path (cr)

    color = {red = 0.4, green = 0.4, blue = 0.4, alpha = 1}
    my_cairo_text (cr, center_x + 10, y_bottom - 5, text, 3/2 * line_width , color) 

    -- the drawing process
    cairo_set_line_width (cr, line_width)
    steps = math.floor (value * 30) -- since 30 is the max step
    alpha = 0.9

    for i = 20,steps + 20 do 

        -- calculate color
        n = 4*i / 64
        -- n = 4 * 30 / 64

        r=math.min(math.max(math.min(n-1.5,-n+4.5),0),1);
        g=math.min(math.max(math.min(n-0.5,-n+3.5),0),1);
        b=math.min(math.max(math.min(n+0.5,-n+2.5),0),1);

        r = color['red']
        g = color['green']
        b = color['blue']

        -- calculate end angle
        end_angle = ((i-20)/30) * (2 * math.pi * 3/4)

        -- draw circle
        cairo_set_source_rgba (cr, r, g, b, alpha)
        cairo_arc (cr, center_x, center_y, radius, start_angle, end_angle)

        -- draw stroke
        cairo_stroke (cr)
        cairo_fill_preserve (cr)

        -- update start angle
        start_angle = end_angle
    end
end

function my_cairo_text (cr, x, y, text, size, color)
    font = "Nemoy"
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL
    font_size = size

    cairo_select_font_face (cr, font, font_slant, font_face)  -- font face
    cairo_set_font_size (cr, font_size) -- font size
    cairo_set_source_rgba (cr,color['red'],color['green'],color['blue'],color['alpha']) -- color
    cairo_move_to (cr,x,y) --  position
    cairo_show_text (cr,text) -- text
    cairo_stroke (cr)
end

