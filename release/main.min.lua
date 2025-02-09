local da=require("elementManager")
local _b=require("libraries/expect")local ab=require("errorManager")local bb={}bb.traceback=true
bb._events={}bb._schedule={}bb._plugins={}bb.LOGGER=require("log")local cb=nil
local db=false
function bb.create(bc,cc)if(cc==nil)then cc=da.generateId()end
local dc=da.getElement(bc).new(cc,bb)local _d,ad=pcall(require,"main")if not _d then ab(false,ad)end
return dc end
function bb.createFrame()local bc=bb.create("BaseFrame")cb=bc;return bc end;function bb.getElementManager()return da end;function bb.getMainFrame()if(cb==nil)then
cb=bb.createFrame()end;return cb end;function bb.setActiveFrame(bc)
cb=bc;return false end;function bb.scheduleUpdate(bc)
table.insert(bb._schedule,bc)return#bb._schedule end;function bb.removeSchedule(bc)bb._schedule[bc]=
nil end
local function _c(bc,...)
if(bc=="terminate")then bb.stop()end
if bc:find("mouse")then if cb then cb:handleEvent(bc,...)end end
if bc:find("key")then if cb then cb:handleEvent(bc,...)end end;if bb._events[bc]then
for cc,dc in ipairs(bb._events[bc])do dc(...)end end end;local function ac()if(cb)then cb:render()end end;function bb.update()
for bc,cc in
pairs(bb._schedule)do if type(cc)=="function"then cc()end end end;function bb.stop()term.clear()
term.setCursorPos(1,1)db=false end
function bb.run(bc)db=bc
if(bc==nil)then db=true end
local function cc()ac()while db do _c(os.pullEventRaw())end end
while db do local dc,_d=pcall(cc)if not(dc)then ab.header="Basalt Runtime Error"
ab.error(_d)end end end;bb.autoUpdate=bb.run;return bb