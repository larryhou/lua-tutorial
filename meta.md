```lua

t = {}
print(t.x)

mt = {__index = {x = 100}}
setmetatable(t, mt)
print(t.x)

-- class
Object = {}
math.randomseed(os.clock() + os.time())
setmetatable(Object, {__index = {isa = 'Object', id = math.random()}})
print(Object.isa)

-- extends
Subclass = {}
setmetatable(Subclass, {__index = Object})
print(Subclass.isa)

-- index: table
UnityObject = {}
mt_UnityObject = { isa = 'UnityObject'}
setmetatable(mt_UnityObject,{__index = Object})
-- metatable chain
setmetatable(UnityObject, {__index = mt_UnityObject})
print(UnityObject.isa, UnityObject.id, UnityObject.xyz)

-- index: function
UnityObject = {}
mt_UnityObject = { isa = 'UnityObject'}
setmetatable(mt_UnityObject,{__index = function (_, k)
    v = Object[k]
    return v or string.format('%s:%s', k, nil)
end})
setmetatable(UnityObject, {__index = mt_UnityObject})
print(UnityObject.isa, UnityObject.id, UnityObject.xyz, UnityObject.rgb)


-- __newindex
t = {}
setmetatable(t, {__newindex = function (self, k, v)
    print(string.format('Insert %s=%s', k, v))
    rawset(self, k, v)
end})
print(t.x, t.rgb)
t.x = 10
t.rgb = {r = 1.0, g= 0.5, b = 0}
t.x = 100
print(t.x)
t.y = 1.0


-- oop
t = {
    isa = 'Person',
    run = function(self, speed)
        self.speed = speed
        print('run with speed', speed)
    end,
    jump = function(...)
        args = table.pack(...)
        self = args[1]
        height = args[2]
        self.height = height
        print('jump to height', height)
    end
}

t.run(t, 1.0)
t:run(2.0)

t.jump(t, 0.5)
t:jump(2.0)

Person = t

p = {bullets = 100}
setmetatable(p, {__index = Person})
p:jump(4.0)

function p:fire()
    print('fire', self.bullets)
    self.bullets = self.bullets - 1
end

function p:reload()
    self.bullets = 100
    print(string.format('reload bullets = %d', self.bullets))
end

Solider = p
s007 = {}
setmetatable(s007, {__index = Solider})
for i = 1, 5 do
    s007:fire()
end
s007:reload()
s007:run(100)

```

[<<<](README.md)