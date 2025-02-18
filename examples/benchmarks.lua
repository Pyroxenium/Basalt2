local basalt = require("src")
local main = basalt.getMainFrame()

local btn = main:addButton()
    :setText("Test")
    :setX(40)
    :setY(5)
    :onMouseClick(function()
        main:logContainerBenchmarks("render")
    end)

local prog = main:addProgram()
    :execute("../rom/programs/shell.lua")

local frame main:addFrame():setX(30):addButton()

main:benchmarkContainer("render")
basalt.run()