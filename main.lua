--
-- Created by IntelliJ IDEA.
-- User: larryhou
-- Date: 2019/12/10
-- Time: 2:36 PM
-- To change this template use File | Settings | File Templates.
--

-- require "string"
-- require "os"

local a = string.format("%x", -1)
print(os.date())

local x = a or "false" --> false
print(a, type(x))

print(math.sin(2.0))

local n = 1
print(n<=1)