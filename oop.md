```lua

local OOP = {}
setmetatable(OOP, {__index = _G})
_ENV = OOP

-- class Object
Object = {}
function Object:new(o) 
    local instance = o or {}
    self.__index = self
    setmetatable(instance, self)
    return instance
end

-- class Shape: Object
Shape = Object:new{x = 0, y = 0}
function Shape:area() 
    return 0
end

function Shape:tostring() return self end

function Shape:translate(x, y) 
    self.x = self.x + (x or 0)
    self.y = self.y + (y or 0)
end

s = Shape:new()
s:translate(10, 10)
print(s, s:area(), s.x, s.y)

-- class Circle: Shape
Circle = Shape:new{radius=1}
function Circle:tostring()
    return string.format('{x=%s, y=%s, r=%s}', self.x, self.y, self. radius)
end

function Circle:area() 
    return math.pi * self.radius^2
end

do -- post registration
    Circle.__tostring = Circle.tostring
end

c = Circle:new{radius = 25}
c:translate(1.3, -1.2)
print(c, c:area(), c.x, c.y)

-- class Rectangle: Shape
Rectangle = Shape:new{width = 0, height = 0}
function Rectangle:tostring()
    return string.format('{x=%s, y = %s, w=%s, h=%s}', self.x, self.y, self.width, self.height)
end

function Rectangle:area()
    return width * height
end

function Rectangle:maxX() 
    return self.x + self.width
end

function Rectangle:maxY() 
    return self.y + self.height
end

function Rectangle:union(v) 
    local r = Rectangle:new()
    r.x = self.x < v.x and self.x or v.x
    r.y = self.y < v.y and self.y or v.y
    r.width  = (self:maxX() > v:maxX() and self:maxX() or v:maxX()) - r.x
    r.height = (self:maxY() > v:maxY() and self:maxY() or v:maxY()) - r.y
    return r
end

function Rectangle:intersection(v)
    local r = Rectangle:new()
    r.x = self.x > v.x and self.x or v.x
    r.y = self.y > v.y and self.y or v.y
    r.width  = (self:maxX() < v:maxX() and self:maxX() or v:maxX()) - r.x
    r.height = (self:maxY() < v:maxY() and self:maxY() or v:maxY()) - r.y
    return r
end

function Rectangle:equal(v)
    return self.x == v.x and self.y == v.y and self.width == v.width and self.height == v.height
end

function Rectangle:contains(v) 
    return self.x <= v.x and self.y <= v.y and self:maxX() >= v:maxX() and self:maxY() >= v:maxY()
end

function Rectangle:hittest(v)
    return self.x < v:maxX() and v.x < self:maxX() and self.y < v:maxY() and v.y < self:maxY()
end

do -- post registration
    Rectangle.__add = Rectangle.union
    Rectangle.__sub = Rectangle.intersection
    Rectangle.__eq = Rectangle.equal
    Rectangle.__le  = function(self, v)
        return Rectangle.contains(v, self)
    end
    Rectangle.__lt = function(self, v)
        return self ~= v and v >= self
    end
    Rectangle.__pow = Rectangle.hittest
    -- tostring
    Rectangle.__tostring = Rectangle.tostring
end

r1 = Rectangle:new{width=100, height=200}
r2 = Rectangle:new{x = 55, y = 15, width = 300, height = 300}
r1:translate(-10, -25)
u = r1 + r2
i = r1 - r2
print(r1:tostring(), r2:tostring())
print(u, i, r1 ^ r2, u ^ i, u > i, r1 >= r2)

print('module',OOP.Shape, OOP.Circle, OOP.Rectangle)
print('_ENV',_ENV.Shape, _ENV.Circle, _ENV.Rectangle)
print('_G',_G.Shape, _G.Circle, _G.Rectangle)
return OOP


```

[<<<](README.md)
