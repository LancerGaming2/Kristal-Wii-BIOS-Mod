local TextButton, super = Class("Button")

function TextButton:init(x, y, text)
	super:init(self, x, y, "button/blank_button")
	
	self.text = text
	self.font = Assets.getFont("main_mono")
end

function TextButton:draw()
	super:draw(self)
	
	love.graphics.setColor(0, 0, 0, 1)
	
	love.graphics.setFont(self.font)
	
	love.graphics.printf(self.text, 0, self.height/4, self.width, "center", 0, self.scale_x, self.scale_y)
	
	love.graphics.setColor(1, 1, 1, 1)
end

return TextButton