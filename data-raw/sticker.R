library(hexSticker)

sysfonts::font_add(
	family = "South Park",
	regular = "sticker/southpark.ttf"
)

hexSticker::sticker(
	"sticker/sweary-with-text.png",
	package = "",
	s_x = 1.1,
	s_y = 1,
	s_width = 0.9,
	p_color = "#000000",
	h_fill = "#FFFFFF",
	h_color = "#000000",
	filename = "sticker/sweary-sticker.png",
	p_family = "South Park"
)
