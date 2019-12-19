---
author: LARRY HOU
title: LUA教程
date: Dec 16, 2019
---

# 准备

`JetBrains Rider` + `EmmyLua`

# 语法

## 关键字
`and`, `break`, `do`, `else`, `elseif`, `end`, `false`, `for`, `function`, `goto`, `if`, `in`, `local`, `nil`, `not`, `or`, `repeat`, `return`, `then`, `true`, `until`, `while`

## 变量定义
- 区分大小写
- 无需声明直接使用
    - 未定义变量默认值为`nil`
    - 未加`local`关键字的变量为全局变量
- 变量无类型
- 变量值类型可以随时切换

## 逻辑运算

- `false`和`nil`以外的任何值在逻辑运算中都是`true`
```lua
print(4 and 5)         --> 5
print(nil and 13)      --> nil
print(false and 13)    --> false
print(0 or 5)          --> 0
print(false or "hi")   --> "hi"
print(nil or false)    --> false
```

- 关键字`or`、`and`、`not`替代`||`、`&&`、`!`
- 关键字`~=`替代`!=`

```lua
print(not nil)      --> true
print(not false)    --> true
print(not 0)        --> false
print(not not 1)    --> true
print(not not nil)  --> false
```

```lua
if x ~=0 then print(1/x) end
```

## 流程控制

> if..then...else...end

```lua
if op == "+" then
    r = a + b
elseif op == "-" then
    r = a - b
elseif op == "*" then
    r = a*b
elseif op == "/" then
    r = a/b
else
    print("invalid operation")
end
```

> while...do...end

```lua
local i = 1
while a[i] do
    print(a[i])
    i = i + 1
end
```

> for...do...end

```lua
for n = from, to, step do
    -- something
end
-- step = 1
for n = from, to do
    -- something
end
```

> repeat...until
```lua
local line
repeat
    line = io.read()
until line ~= ""
print(line)
```
## 注释

单行注释
```lua
-- 注释
```

多行注释

```lua
--[[
注释内容
第二行
第三行
--]]

```

# 数值

> 64位整数

> 64位双精度浮点数

> 支持科学计数法

> 支持16进制表达浮点数
- 0xF.8 = 0xF + 0x8/16 = 15.5
- 0x3p2 = 0x3 * 2^2 = 12
> 整除运算符`//`

10//3 = floor(10/3) = 3

> 幂运算符`^`

4^3 = 4\*4\*4 = 64
    
> 模运算符`%`

- 整数取模
- 浮点取模

```lua
print(math.pi % 0.1) --> 0.04159265358979
print(math.pi % 0.2) --> 0.14159265358979
```

> 位运算符

- 与`&`
- 或`|`
- 异或`~`
- 取反`~`

```lua
string.format("%x", 0xff & 0xabcd)    --> cd
string.format("%x", 0xff | 0xabcd)    --> abff
string.format("%x", 0xaaaa ~ -1)      --> ffffffffffff5555
string.format("%x", ~0)               --> ffffffffffffffff
```

# 字符串

自动垃圾回收

> 创建
```lua
name = "暗影猎人"
name = '暗影猎人'
name = '\u{6697}\u{5f71}\u{730e}\u{4eba}' --> unicode
name = '\xe6\x9a\x97\xe5\xbd\xb1\xe7\x8c\x8e\xe4\xba\xba' --> utf-8 bytes
```
> 长度
```lua
name='larryhou'
print(#name) --> 8
print(#'larryhou') --> 8
-- 宽字符
name='侯坤峰'
print(#name) --> 9
```
> 拼接

```lua
line = '今天'
line = line..'不上班'
print(line) --> 今天不上班
```

> 长文本
```lua
desc=[[
    Lua是一种轻量语言，它的官方版本只包括一个精简的核心和最基本的库。这使得Lua体积小、启动速度快。它用ANSI C语言编写并以源代码形式开放，编译后仅仅一百餘K，可以很方便的嵌入别的程式裡。和许多“大而全”的语言不一样，网路通讯、图形界面等都没有預設提供。但是Lua可以很容易地被扩展：由宿主语言（通常是C或C++）提供这些功能，Lua可以使用它们，就像是本来就内置的功能一样。事实上，现在已经有很多成熟的扩展模块可供选用。
]]

-- \z换行
desc='Lua\xe6\x98\xaf\xe4\xb8\x80\xe7\xa7\x8d\xe8\xbd\xbb\xe9\x87\x8f\xe8\xaf\xad\xe8\xa8\x80\xef\xbc\x8c\xe5\xae\x83\z
\xe7\x9a\x84\xe5\xae\x98\xe6\x96\xb9\xe7\x89\x88\xe6\x9c\xac\xe5\x8f\xaa\xe5\x8c\x85\xe6\x8b\xac\xe4\xb8\x80\xe4\xb8\xaa\z
\xe7\xb2\xbe\xe7\xae\x80\xe7\x9a\x84\xe6\xa0\xb8\xe5\xbf\x83\xe5\x92\x8c\xe6\x9c\x80\xe5\x9f\xba\xe6\x9c\xac\xe7\x9a\x84\z
\xe5\xba\x93\xe3\x80\x82\xe8\xbf\x99\xe4\xbd\xbf\xe5\xbe\x97Lua\xe4\xbd\x93\xe7\xa7\xaf\xe5\xb0\x8f\xe3\x80\x81\z
\xe5\x90\xaf\xe5\x8a\xa8\xe9\x80\x9f\xe5\xba\xa6\xe5\xbf\xab\xe3\x80\x82\xe5\xae\x83\xe7\x94\xa8ANSI'
```

> 数值转换
- 字符串参与数学运算
- 数值使用`..`连接
```lua
print(10 .. 20) --> 1020
print("10" + 1) --> 11.0

-- tonumber
tonumber("  -3 ")        --> -3
tonumber(" 10e4 ")       --> 100000.0
tonumber("10e")          --> nil   (not a valid number)
tonumber("0x1.3p-4")     --> 0.07421875
-- 2~36进制解析
tonumber("100101", 2)       -- 2进制  > 37
tonumber("987", 8)          -- 8进制  > nil
tonumber("fff", 16)         -- 16进制 > 4095
tonumber("-ZZ", 36)         -- 36进制 > -1295
```

> 工具库`string`

```lua
string.rep("abc", 3)             --> abcabcabc
string.reverse("A Long Line!")   --> !eniL gnoL A
string.lower("A Long Line!")     --> a long line!
string.upper("A Long Line!")     --> A LONG LINE!
-- substring
s = "[in brackets]"
string.sub(s, 2, -2)      --> in brackets
s:sub(1, 1)       --> [
s:sub(-1, -1)     --> ]

-- char <=> byte
print(string.char(97))                    --> a
i = 99; print(string.char(i, i+1, i+2))   --> cde
print(string.byte("abc"))                 --> 97
print(string.byte("abc", 2))              --> 98
print(string.byte("abc", -1))             --> 99

-- string.format 类似C里面的printf
> string.format("x = %d  y = %d", 10, 20)   --> x = 10  y = 20
> string.format("x = %x", 200)              --> x = c8
> string.format("x = 0x%X", 200)            --> x = 0xC8
> string.format("x = %f", 200)              --> x = 200.000000
> tag, title = "h1", "a title"
> string.format("<%s>%s</%s>", tag, title, tag) --> <h1>a title</h1>

print(string.format("pi = %.4f", math.pi))      --> pi = 3.1416
d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d", d, m, y)) --> 05/11/1990

-- string.find
string.find("hello world", "wor")   --> 7   9
string.find("hello world", "war")   --> nil 

-- string.gsub
string.gsub("hello world", "l", ".")     --> he..o wor.d    3
string.gsub("hello world", "ll", "..")   --> he..o world    1
string.gsub("hello world", "a", ".")     --> hello world    0
```

> 工具库`utf8`

```lua
> utf8.len("résumé")              --> 6
> utf8.len("ação")                --> 4
> utf8.len("Månen")               --> 5
> utf8.len("ab\x93")              --> nil    3

> utf8.char(114, 233, 115, 117, 109, 233)    --> résumé
> utf8.codepoint("résumé", 6, 7)             --> 109    233

> s = "Nähdään"
> utf8.codepoint(s, utf8.offset(s, 5))    --> 228
> utf8.char(228)                          --> ä

> s = "ÃøÆËÐ"
> string.sub(s, utf8.offset(s, -2))    --> ËÐ

for i, c in utf8.codes("Ação") do
    print(i, c)
end
--> 1    65
--> 2    231
--> 4    227
--> 6    111
```

> 序列化

- 通过函数`string.pack`把值序列化为二进制
```lua
s = string.pack("iii", 3, -27, 450)
#s                             --> 12
string.unpack("iii", s)        --> 3   -27   450   13
```
- 通过函数`string.unpack`把二进制反解出值
```lua
s = "hello\0Lua\0world\0"
local i = 1
while i <= #s do
    local res
    res, i = string.unpack("z", s, i)
    print(res)
end
    --> hello
    --> Lua
    --> world
```

|编码选项|用途|
|-|-|
|z|编码`\0`结尾的字符串|
|s`#`|编码定长字符串，`#`表示字符串长度占用字节数，缺省值为`8`
|b|编码`int8`，大写`B`编码`Int8`
|h|编码`int16`，大写`H`编码`Int16`
|i|编码`int32`，大写`I`编码`Int32`
|i`#`|编码不大于`16`字节宽度的带符号整形`int#`，`#`表示整形占用字节数量,大写`I#`编码`Int#`
|l|编码`int64`，大写`I`编码`Int64`
|j|等同`l`
|f|编码32位单精度`float`
|d|编码64位双精度`double`
|>|大端编码
|<|小端编码

```lua
-- 7字节宽度整形编码
x = string.pack("i7", 1 << 54)
string.unpack("i7", x)             --> 18014398509481984   8
x = string.pack("i7", -(1 << 54))
string.unpack("i7", x)             --> -18014398509481984  8
x = string.pack("i7", 1 << 55)
stdin:1: bad argument #2 to 'pack' (integer overflow)

-- 12字节宽度整形编码
x = string.pack("i12", 2^61)
string.unpack("i12", x)      --> 2305843009213693952    13
x = "aaaaaaaaaaaa"           -- fake a large 12-byte number
string.unpack("i12", x)
stdin:1: 12-byte integer does not fit into Lua Integer

-- 单字节编码
s = "\xFF"
string.unpack("b", s)       --> -1    2
string.unpack("B", s)       --> 255   2

-- 编码定长字符串
s = string.pack("s1", "hello")
for i = 1, #s do 
    print((string.unpack("B", s, i))) 
end
    --> 5                           (length)
    --> 104                         ('h')

    --> 101                         ('e')
    --> 108                         ('l')
    --> 108                         ('l')
    --> 111                         ('o')

-- 大端编码
s = string.pack(">i4", 1000000)
for i = 1, #s do print((string.unpack("B", s, i))) end
    --> 0
    --> 15
    --> 66
    --> 64

-- 小端编码
s = string.pack("<i2 i2", 500, 24)
for i = 1, #s do print((string.unpack("B", s, i))) end
    --> 244
    --> 1
    --> 24
    --> 0

-- 文件反序列化
local f = assert(io.open(arg[1], "rb"))
local blocksize = 16
for bytes in f:lines(blocksize) do
for i = 1, #bytes do
    local b = string.unpack("B", bytes, i)
    io.write(string.format("%02X ", b))
end
io.write(string.rep("   ", blocksize - #bytes))
bytes = string.gsub(bytes, "%c", ".")
io.write(" ", bytes, "\n")
end
```
    
# 容器`table`
`table`是`lua`语言的最主要的数据结构，本质是一个关联容器，特征是可以通过下标`[]`访问数据，同时也是引用对象，也就是说如果需要垃圾回收`table`对象，则需要先清理所有的变量引用。

> 下标访问

```lua
a = {}           -- create a table and assign its reference
k = "x"
a[k] = 10        -- new entry, with key="x" and value=10
a[20] = "great"  -- new entry, with key=20 and value="great"
a["x"]                  --> 10
k = 20
a[k]                    --> "great"
a["x"] = a["x"] + 1     -- increments entry "x"
a["x"]                  --> 11
```
- 垃圾回收
```lua
a = {}
a["x"] = 10
b = a            -- 'b' refers to the same table as 'a'
b["x"]           --> 10
b["x"] = 20
a["x"]           --> 20
a = nil          -- only 'b' still refers to the table
b = nil          -- no references left to the table
```

- 访问未定义下标返回`nil`
```lua
a = {}     -- empty table
-- create 1000 new entries
for i = 1, 1000 do a[i] = i*2 end
a[9]               --> 18
a["x"] = 10
a["x"]             --> 10
a["y"]             --> nil
```

- 非数字下标属性可以通过点(`.`)运算符访问

```lua
a = {}                      -- empty table
a.x = 10                    -- same as a["x"] = 10
a.x       --> 10            -- same as a["x"]
a.y       --> nil           -- same as a["y"]
```

> 列表初始化

- 值列表初始化
```lua
days = {"Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"}
print(days[4], #days)  --> Wednesday	7
print(days[0])  --> nil
print(days[1])  --> Sunday
print(days[7])  --> Saturday

days = {[1]="Sunday", [2]="Monday", [3]="Tuesday", [4]="Wednesday",[5]="Thursday", [6]="Friday", [7]="Saturday"}
```
通过值列表初始化创建的`table`对象拥有从`1`开始的连续下标索引

- 健值对列表初始化
```lua
a = {x = 10, y = 20}
a = {['x'] = 10, ['y'] = 20}
a = {}; a.x = 10; a.y = 10;
```

- 混合列表初始化
    - 无键名的值对象按顺序生成从`1`开始递增的下表索引
    - 长度运算符`#`只返回无键名的对象数量
```lua
polyline = {
    color="blue",
    thickness=2,
    npoints=4,
    {x=0,   y=0},    -- polyline[1]
    {x=-10, y=0},    -- polyline[2]
    {x=-10, y=1},    -- polyline[3]
    {x=0,   y=1}     -- polyline[4]
}
print(#polyline)  --> 4
```
- 允许初始化列表末尾多一个逗号`,`
```lua
a = {[1] = "red", [2] = "green", [3] = "blue",}
```

- 列表初始化结尾的`nil`被忽略
```lua
a = {10, 20, 30, nil, nil}
#a  -- 3 not 5
a = {10, 20, 30, nil, nil, 5}
#a  -- 6
```

> 长度运算符`#`

计算下标从`1`开始连续递增的对象数量
- 列表初始化里面的值对象必然生成连续下标
- 下标赋值可能产生不可预期的长度

```lua
c = {1,2,3,4,5}
#c  -- 5
c[3] = nil
#c  -- 5
c[5] = nil
#c  -- 2
```

```lua
c = {1,2,3,4,5}
#c  -- 5
c[3] = nil
#c  -- 5
c[6] = nil
#c  -- 5
c[5] = nil
#c  -- 4
```

> 遍历
- 遍历键值对不保证顺序
```lua
t = {10, print, x = 12, k = "hi"}
for k, v in pairs(t) do
    print(k, v)
end
    --> 1    10
    --> k    hi
    --> 2    function: 0x420610
    --> x    12
```
- 遍历列表通过迭代器`ipairs`保证遍历顺序
```lua
t = {10, print, 12, "hi"}
for k, v in ipairs(t) do
    print(k, v)
end
    --> 1    10
    --> 2    function: 0x420610
    --> 3    12
    --> 4    hi
```

或者

```lua
t = {10, print, 12, "hi"}
for n = 1, #t do
    print(n, t[n])
end
    --> 1    10
    --> 2    function: 0x420610
    --> 3    12
    --> 4    hi
```

# 函数

```lua
-- add the elements of sequence 'a'
function add (a)
    local sum = 0
    for i = 1, #a do
        sum = sum + a[i]
    end
    return sum
end
```

> 参数传递

```lua
function f (a, b) print(a, b) end
f()          --> nil    nil
f(3)         --> 3      nil
f(3, 4)      --> 3      4
f(3, 4, 5)   --> 3      4      (5 is discarded)
```

> 多返回值

```lua
s, e = string.find("hello Lua users", "Lua")
print(s, e)   --> 7      9
```

```lua
-- 定义多返回值函数
function maximum (a)
    local mi = 1          -- index of the maximum value
    local m = a[mi]       -- maximum value
    for i = 1, #a do
        if a[i] > m then
            mi = i; m = a[i]
        end
    end
    return m, mi          -- return the maximum and its index
end

print(maximum({8,10,23,12,5}))     --> 23   3
```

```lua
function foo0 () end                   -- returns no results
function foo1 () return "a" end        -- returns 1 result
function foo2 () return "a", "b" end   -- returns 2 results

-- 返回值赋值①
x, y = foo2()            -- x="a", y="b"
x = foo2()               -- x="a", "b" is discarded
x, y, z = 10, foo2()     -- x=10, y="a", z="b"

-- 返回值赋值②
x,y = foo0()      -- x=nil, y=nil
x,y = foo1()      -- x="a", y=nil
x,y,z = foo2()    -- x="a", y="b", z=nil

-- 返回值赋值③
x,y = foo2(), 20      -- x="a", y=20   ('b' discarded)
x,y = foo0(), 20, 30  -- x=nil, y=20   (30 is discarded)

-- 返回值打印
print(foo0())          -->            (no results)
print(foo1())          --> a
print(foo2())          --> a   b
print(foo2(), 1)       --> a   1
print(foo2() .. "x")   --> ax         (see next)

-- 列表初始化①
t = {foo0()}         -- t = {}  (an empty table)
t = {foo1()}         -- t = {"a"}
t = {foo2()}         -- t = {"a", "b"}

-- 列表初始化②
t = {foo0(), foo2(), 4}   -- t[1] = nil, t[2] = "a", t[3] = 4

-- 强制单结果返回
print((foo0()))        --> nil
print((foo1()))        --> a
print((foo2()))        --> a
```

> 变长参数函数

```lua
-- 多参数函数定义
function add (...)
    local s = 0
    for _, v in ipairs{...} do
        s = s + v
    end
    return s
end

print(add(3, 4, 10, 25, 12))    --> 54
```

```lua
-- 参数透传
function fwrite (fmt, ...)
    io.write(string.format(fmt, ...))
end
fwrite('[%s] %d pi=%.6f seed=%f\n', os.date(), 1, math.pi, math.random())  --> [Wed Dec 18 10:02:46 2019] 1 pi=3.141593 seed=0.798440
```

```lua
-- 参数赋值
function foo (...)
    a, b, c = ...
    print(a, b, c)
end
foo(1)              --> 1	nil	nil
foo(1, "A")         --> 1	A	nil
foo(1, "A", 1.5)    --> 1	A	1.5
```

```lua
-- 遍历参数①
function nonils (...)
    local arg = table.pack(...)
    for i = 1, arg.n do
        if arg[i] == nil then return false end
    end
    return true
end

print(nonils(2,3,nil))    --> false
print(nonils(2,3))        --> true
print(nonils())           --> true
print(nonils(nil))        --> false

-- 遍历参数②
function add (...)
    local s = 0
    for i = 1, select("#", ...) do
        s = s + select(i, ...)
    end
    return s
end
```

> 批量传参数

```lua
print(table.unpack{10,20,30})    --> 10   20   30
a,b = table.unpack{10,20,30}     -- a=10, b=20, 30 is discarded

-- 函数原型
print(string.find("hello", "ll"))  --> 3	4
-- 批量传参
f = string.find
a = {"hello", "ll"}
print(f(table.unpack(a)))  --> 3	4

-- 参数选择
print(table.unpack({"Sun", "Mon", "Tue", "Wed"}, 2, 3))  --> Mon    Tue
```

> 递归

不保存递归堆栈，无递归深度限制

```lua
local fact -- 前置声明
fact = function (n)
    if n == 0 then return 1
    else return n*fact(n-1)
    end
end
```

> 函数对象

```lua
function foo (x)  return 2*x  end
-- 等价声明
foo = function (x)  return 2*x  end
```
函数既然是对象，那就会被其他对象引用，默认存储在名为`_G`的`table`对象里面

```lua
foo(2) -- 4
_G.foo(2) -- 4
```

```lua
lib = {}
lib.foo = function (x, y) return x + y end
lib.goo = function (x, y) return x - y end

-- 语法糖等价定义
function lib.foo(x, y) return x + y end
function lib.goo(x, y) return x - y end

print(lib.foo(2, 3), lib.goo(2, 3))    --> 5    -1
```

> 闭包
```lua
names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function (n1, n2)
    return grades[n1] > grades[n2]        -- compare the grades
end)

-- 封装
function sortbygrade (names, grades)
    table.sort(names, function (n1, n2)
        return grades[n1] > grades[n2]      -- compare the grades
    end)
end
```

```lua
function newCounter ()
    local count = 0
    return function ()      -- anonymous function
        count = count + 1
        return count
    end
end

c1 = newCounter()
print(c1())  --> 1
print(c1())  --> 2
```

# 元表

[meta.lua](meta.md)

# 面向对象编程

[oop.lua](oop.md)

# 垃圾回收

> 弱引用
```lua
local results = {}
setmetatable(results, {__mode = "v"})  -- make values weak
function createRGB (r, g, b)
    local key = string.format("%d-%d-%d", r, g, b)
    local color = results[key]
    if color == nil then
        color = {red = r, green = g, blue = b}
        results[key] = color
    end
    return color
end
```

> 析构函数

```lua
o = {x = "hi"}
mt = {}
setmetatable(o, mt)
mt.__gc = function (o) print(o.x) end
o = nil
collectgarbage()   --> (prints nothing)
```