local minified = true
local minified_elementDirectory = {}
local minified_pluginDirectory = {}
local project = {}
local loadedProject = {}
local baseRequire = require
require = function(path) if(project[path..".lua"])then if(loadedProject[path]==nil)then loadedProject[path] = project[path..".lua"]() end return loadedProject[path] end return baseRequire(path) end
minified_elementDirectory["BaseFrame"] = {}
minified_elementDirectory["Timer"] = {}
minified_elementDirectory["Program"] = {}
minified_elementDirectory["Image"] = {}
minified_elementDirectory["BarChart"] = {}
minified_elementDirectory["ComboBox"] = {}
minified_elementDirectory["TabControl"] = {}
minified_elementDirectory["TextBox"] = {}
minified_elementDirectory["Button"] = {}
minified_elementDirectory["Label"] = {}
minified_elementDirectory["SideNav"] = {}
minified_elementDirectory["Input"] = {}
minified_elementDirectory["BigFont"] = {}
minified_elementDirectory["Switch"] = {}
minified_elementDirectory["Frame"] = {}
minified_elementDirectory["Container"] = {}
minified_elementDirectory["Tree"] = {}
minified_elementDirectory["DropDown"] = {}
minified_elementDirectory["Display"] = {}
minified_elementDirectory["LineChart"] = {}
minified_elementDirectory["Graph"] = {}
minified_elementDirectory["FlexBox"] = {}
minified_elementDirectory["Table"] = {}
minified_elementDirectory["Menu"] = {}
minified_elementDirectory["Slider"] = {}
minified_elementDirectory["ScrollBar"] = {}
minified_elementDirectory["VisualElement"] = {}
minified_elementDirectory["ProgressBar"] = {}
minified_elementDirectory["CheckBox"] = {}
minified_elementDirectory["BaseElement"] = {}
minified_elementDirectory["List"] = {}
minified_pluginDirectory["canvas"] = {}
minified_pluginDirectory["theme"] = {}
minified_pluginDirectory["reactive"] = {}
minified_pluginDirectory["state"] = {}
minified_pluginDirectory["xml"] = {}
minified_pluginDirectory["debug"] = {}
minified_pluginDirectory["animation"] = {}
minified_pluginDirectory["benchmark"] = {}
project["errorManager.lua"] = function(...) local d=require("log")
local _a={tracebackEnabled=true,header="Basalt Error"}local function aa(ba,ca)term.setTextColor(ca)print(ba)
term.setTextColor(colors.white)end
function _a.error(ba)
if _a.errorHandled then error()end;term.setBackgroundColor(colors.black)
term.clear()term.setCursorPos(1,1)
aa(_a.header..":",colors.red)print()local ca=2;local da;while true do local db=debug.getinfo(ca,"Sl")
if not db then break end;da=db;ca=ca+1 end;local _b=da or
debug.getinfo(2,"Sl")local ab=_b.source:sub(2)
local bb=_b.currentline;local cb=ba
if(_a.tracebackEnabled)then local db=debug.traceback()
if db then
for _c in db:gmatch("[^\r\n]+")do
local ac,bc=_c:match("([^:]+):(%d+):")
if ac and bc then term.setTextColor(colors.lightGray)
term.write(ac)term.setTextColor(colors.gray)term.write(":")
term.setTextColor(colors.lightBlue)term.write(bc)term.setTextColor(colors.gray)_c=_c:gsub(
ac..":"..bc,"")end;aa(_c,colors.gray)end;print()end end
if ab and bb then term.setTextColor(colors.red)
term.write("Error in ")term.setTextColor(colors.white)term.write(ab)
term.setTextColor(colors.red)term.write(":")
term.setTextColor(colors.lightBlue)term.write(bb)term.setTextColor(colors.red)
term.write(": ")
if cb then cb=string.gsub(cb,"stack traceback:.*","")
if cb~=""then
aa(cb,colors.red)else aa("Error message not available",colors.gray)end else aa("Error message not available",colors.gray)end;local db=fs.open(ab,"r")
if db then local _c=""local ac=1
repeat _c=db.readLine()if
ac==tonumber(bb)then aa("\149Line "..bb,colors.cyan)
aa(_c,colors.lightGray)break end;ac=ac+1 until not _c;db.close()end end;term.setBackgroundColor(colors.black)
d.error(ba)_a.errorHandled=true;error()end;return _a end
project["render.lua"] = function(...) local _a=require("libraries/colorHex")local aa=require("log")
local ba={}ba.__index=ba;local ca=string.sub
function ba.new(da)local _b=setmetatable({},ba)
_b.terminal=da;_b.width,_b.height=da.getSize()
_b.buffer={text={},fg={},bg={},dirtyRects={}}
for y=1,_b.height do _b.buffer.text[y]=string.rep(" ",_b.width)
_b.buffer.fg[y]=string.rep("0",_b.width)_b.buffer.bg[y]=string.rep("f",_b.width)end;return _b end;function ba:addDirtyRect(da,_b,ab,bb)
table.insert(self.buffer.dirtyRects,{x=da,y=_b,width=ab,height=bb})return self end
function ba:blit(da,_b,ab,bb,cb)if
_b<1 or _b>self.height then return self end;if(#ab~=#bb or
#ab~=#cb)then
error("Text, fg, and bg must be the same length")end
self.buffer.text[_b]=ca(self.buffer.text[_b]:sub(1,
da-1)..ab..
self.buffer.text[_b]:sub(da+#ab),1,self.width)
self.buffer.fg[_b]=ca(
self.buffer.fg[_b]:sub(1,da-1)..bb..self.buffer.fg[_b]:sub(da+#bb),1,self.width)
self.buffer.bg[_b]=ca(
self.buffer.bg[_b]:sub(1,da-1)..cb..self.buffer.bg[_b]:sub(da+#cb),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:multiBlit(da,_b,ab,bb,cb,db,_c)if _b<1 or _b>self.height then return self end;if(
#cb~=#db or#cb~=#_c)then
error("Text, fg, and bg must be the same length")end;cb=cb:rep(ab)
db=db:rep(ab)_c=_c:rep(ab)
for dy=0,bb-1 do local ac=_b+dy
if ac>=1 and ac<=self.height then
self.buffer.text[ac]=ca(self.buffer.text[ac]:sub(1,
da-1)..cb..
self.buffer.text[ac]:sub(da+#cb),1,self.width)
self.buffer.fg[ac]=ca(
self.buffer.fg[ac]:sub(1,da-1)..db..self.buffer.fg[ac]:sub(da+#db),1,self.width)
self.buffer.bg[ac]=ca(
self.buffer.bg[ac]:sub(1,da-1).._c..self.buffer.bg[ac]:sub(da+#_c),1,self.width)end end;self:addDirtyRect(da,_b,ab,bb)return self end
function ba:textFg(da,_b,ab,bb)if _b<1 or _b>self.height then return self end
bb=_a[bb]or"0"bb=bb:rep(#ab)
self.buffer.text[_b]=ca(self.buffer.text[_b]:sub(1,
da-1)..ab..
self.buffer.text[_b]:sub(da+#ab),1,self.width)
self.buffer.fg[_b]=ca(
self.buffer.fg[_b]:sub(1,da-1)..bb..self.buffer.fg[_b]:sub(da+#bb),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:textBg(da,_b,ab,bb)if _b<1 or _b>self.height then return self end
bb=_a[bb]or"f"
self.buffer.text[_b]=ca(
self.buffer.text[_b]:sub(1,da-1)..
ab..self.buffer.text[_b]:sub(da+#ab),1,self.width)
self.buffer.bg[_b]=ca(
self.buffer.bg[_b]:sub(1,da-1)..
bb:rep(#ab)..self.buffer.bg[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:text(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.text[_b]=ca(self.buffer.text[_b]:sub(1,
da-1)..ab..
self.buffer.text[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:fg(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.fg[_b]=ca(self.buffer.fg[_b]:sub(1,
da-1)..ab..
self.buffer.fg[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:bg(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.bg[_b]=ca(self.buffer.bg[_b]:sub(1,
da-1)..ab..
self.buffer.bg[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:text(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.text[_b]=ca(self.buffer.text[_b]:sub(1,
da-1)..ab..
self.buffer.text[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:fg(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.fg[_b]=ca(self.buffer.fg[_b]:sub(1,
da-1)..ab..
self.buffer.fg[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:bg(da,_b,ab)if _b<1 or _b>self.height then return self end
self.buffer.bg[_b]=ca(self.buffer.bg[_b]:sub(1,
da-1)..ab..
self.buffer.bg[_b]:sub(da+#ab),1,self.width)self:addDirtyRect(da,_b,#ab,1)return self end
function ba:clear(da)local _b=_a[da]or"f"
for y=1,self.height do
self.buffer.text[y]=string.rep(" ",self.width)self.buffer.fg[y]=string.rep("0",self.width)
self.buffer.bg[y]=string.rep(_b,self.width)self:addDirtyRect(1,y,self.width,1)end;return self end
function ba:render()local da={}
for _b,ab in ipairs(self.buffer.dirtyRects)do local bb=false;for cb,db in ipairs(da)do
if
self:rectOverlaps(ab,db)then self:mergeRects(db,ab)bb=true;break end end;if not bb then
table.insert(da,ab)end end
for _b,ab in ipairs(da)do
for y=ab.y,ab.y+ab.height-1 do
if y>=1 and y<=self.height then
self.terminal.setCursorPos(ab.x,y)
self.terminal.blit(self.buffer.text[y]:sub(ab.x,ab.x+ab.width-1),self.buffer.fg[y]:sub(ab.x,
ab.x+ab.width-1),self.buffer.bg[y]:sub(ab.x,
ab.x+ab.width-1))end end end;self.buffer.dirtyRects={}
if self.blink then
self.terminal.setTextColor(self.cursorColor or
colors.white)
self.terminal.setCursorPos(self.xCursor,self.yCursor)self.terminal.setCursorBlink(true)else
self.terminal.setCursorBlink(false)end;return self end
function ba:rectOverlaps(da,_b)return
not(
da.x+da.width<=_b.x or _b.x+_b.width<=da.x or da.y+da.height<=_b.y or
_b.y+_b.height<=da.y)end
function ba:mergeRects(da,_b)local ab=math.min(da.x,_b.x)
local bb=math.min(da.y,_b.y)
local cb=math.max(da.x+da.width,_b.x+_b.width)
local db=math.max(da.y+da.height,_b.y+_b.height)da.x=ab;da.y=bb;da.width=cb-ab;da.height=db-bb;return self end
function ba:setCursor(da,_b,ab,bb)
if bb~=nil then self.terminal.setTextColor(bb)end;self.terminal.setCursorPos(da,_b)
self.terminal.setCursorBlink(ab)self.xCursor=da;self.yCursor=_b;self.blink=ab;self.cursorColor=bb
return self end
function ba:clearArea(da,_b,ab,bb,cb)local db=_a[cb]or"f"
for dy=0,bb-1 do local _c=_b+dy;if
_c>=1 and _c<=self.height then local ac=string.rep(" ",ab)local bc=string.rep(db,ab)
self:blit(da,_c,ac,"0",db)end end;return self end;function ba:getSize()return self.width,self.height end
function ba:setSize(da,_b)
self.width=da;self.height=_b
for y=1,self.height do
self.buffer.text[y]=string.rep(" ",self.width)self.buffer.fg[y]=string.rep("0",self.width)
self.buffer.bg[y]=string.rep("f",self.width)end;return self end;return ba end
project["init.lua"] = function(...) local da={...}local _b=fs.getDir(da[2])local ab=package.path
local bb="path;/path/?.lua;/path/?/init.lua;"local cb=bb:gsub("path",_b)package.path=cb.."rom/?;"..ab
local function db(bc)package.path=
cb.."rom/?"local cc=require("errorManager")
package.path=ab;cc.header="Basalt Loading Error"cc.error(bc)end;local _c,ac=pcall(require,"main")package.loaded.log=nil
package.path=ab;if not _c then db(ac)else return ac end end
project["elements/BaseFrame.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("Container")local da=require("errorManager")local _b=require("render")
local ab=setmetatable({},ca)ab.__index=ab
local function bb(cb)
local db,_c=pcall(function()return peripheral.getType(cb)end)if db then return true end;return false end
ab.defineProperty(ab,"term",{default=nil,type="table",setter=function(cb,db)cb._peripheralName=nil;if
cb.basalt.getActiveFrame(cb._values.term)==cb then
cb.basalt.setActiveFrame(cb,false)end;if
db==nil or db.setCursorPos==nil then return db end;if(bb(db))then
cb._peripheralName=peripheral.getName(db)end;cb._values.term=db
if
cb.basalt.getActiveFrame(db)==nil then cb.basalt.setActiveFrame(cb)end;cb._render=_b.new(db)cb._renderUpdate=true;local _c,ac=db.getSize()
cb.set("width",_c)cb.set("height",ac)return db end})function ab.new()local cb=setmetatable({},ab):__init()
cb.class=ab;return cb end;function ab:init(cb,db)
ca.init(self,cb,db)self.set("term",term.current())
self.set("type","BaseFrame")return self end
function ab:multiBlit(cb,db,_c,ac,bc,cc,dc)if
(cb<1)then _c=_c+cb-1;cb=1 end;if(db<1)then ac=ac+db-1;db=1 end
self._render:multiBlit(cb,db,_c,ac,bc,cc,dc)end;function ab:textFg(cb,db,_c,ac)if cb<1 then _c=string.sub(_c,1 -cb)cb=1 end
self._render:textFg(cb,db,_c,ac)end;function ab:textBg(cb,db,_c,ac)if cb<1 then _c=string.sub(_c,1 -
cb)cb=1 end
self._render:textBg(cb,db,_c,ac)end;function ab:drawText(cb,db,_c)if cb<1 then _c=string.sub(_c,
1 -cb)cb=1 end
self._render:text(cb,db,_c)end
function ab:drawFg(cb,db,_c)if cb<1 then
_c=string.sub(_c,1 -cb)cb=1 end;self._render:fg(cb,db,_c)end;function ab:drawBg(cb,db,_c)if cb<1 then _c=string.sub(_c,1 -cb)cb=1 end
self._render:bg(cb,db,_c)end
function ab:blit(cb,db,_c,ac,bc)
if cb<1 then
_c=string.sub(_c,1 -cb)ac=string.sub(ac,1 -cb)bc=string.sub(bc,1 -cb)cb=1 end;self._render:blit(cb,db,_c,ac,bc)end;function ab:setCursor(cb,db,_c,ac)local bc=self.get("term")
self._render:setCursor(cb,db,_c,ac)end
function ab:monitor_touch(cb,db,_c)
local ac=self.get("term")if ac==nil then return end
if(bb(ac))then if self._peripheralName==cb then
self:mouse_click(1,db,_c)
self.basalt.schedule(function()sleep(0.1)self:mouse_up(1,db,_c)end)end end end;function ab:mouse_click(cb,db,_c)ca.mouse_click(self,cb,db,_c)
self.basalt.setFocus(self)end
function ab:mouse_up(cb,db,_c)
ca.mouse_up(self,cb,db,_c)ca.mouse_release(self,cb,db,_c)end
function ab:term_resize()local cb,db=self.get("term").getSize()
if(cb==
self.get("width")and db==self.get("height"))then return end;self.set("width",cb)self.set("height",db)
self._render:setSize(cb,db)self._renderUpdate=true end
function ab:key(cb)self:fireEvent("key",cb)ca.key(self,cb)end
function ab:key_up(cb)self:fireEvent("key_up",cb)ca.key_up(self,cb)end
function ab:char(cb)self:fireEvent("char",cb)ca.char(self,cb)end
function ab:dispatchEvent(cb,...)local db=self.get("term")if db==nil then return end;if(bb(db))then if
cb=="mouse_click"then return end end
ca.dispatchEvent(self,cb,...)end;function ab:render()
if(self._renderUpdate)then if self._render~=nil then ca.render(self)
self._render:render()self._renderUpdate=false end end end
return ab end
project["elements/Timer.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("BaseElement")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"interval",{default=1,type="number"})
aa.defineProperty(aa,"action",{default=function()end,type="function"})
aa.defineProperty(aa,"running",{default=false,type="boolean"})
aa.defineProperty(aa,"amount",{default=-1,type="number"})aa.defineEvent(aa,"timer")function aa.new()
local ba=setmetatable({},aa):__init()ba.class=aa;return ba end;function aa:init(ba,ca)
_a.init(self,ba,ca)self.set("type","Timer")end
function aa:start()if
not self.running then self.running=true;local ba=self.get("interval")
self.timerId=os.startTimer(ba)end;return self end
function aa:stop()if self.running then self.running=false
os.cancelTimer(self.timerId)end;return self end
function aa:dispatchEvent(ba,...)_a.dispatchEvent(self,ba,...)
if ba=="timer"then
local ca=select(1,...)
if ca==self.timerId then self.action()local da=self.get("amount")if da>0 then self.set("amount",
da-1)end;if da~=0 then
self.timerId=os.startTimer(self.get("interval"))end end end end;return aa end
project["elements/Program.lua"] = function(...) local ca=require("elementManager")
local da=ca.getElement("VisualElement")local _b=require("errorManager")local ab=setmetatable({},da)
ab.__index=ab
ab.defineProperty(ab,"program",{default=nil,type="table"})
ab.defineProperty(ab,"path",{default="",type="string"})
ab.defineProperty(ab,"running",{default=false,type="boolean"})
ab.defineProperty(ab,"errorCallback",{default=nil,type="function"})
ab.defineProperty(ab,"doneCallback",{default=nil,type="function"})ab.defineEvent(ab,"*")local bb={}bb.__index=bb
local cb=dofile("rom/modules/main/cc/require.lua").make
function bb.new(_c,ac,bc)local cc=setmetatable({},bb)cc.env=ac or{}cc.args={}cc.addEnvironment=
bc==nil and true or bc;cc.program=_c;return cc end;function bb:setArgs(...)self.args={...}end
local function db(_c)
local ac={shell=shell,multishell=multishell}ac.require,ac.package=cb(ac,_c)return ac end
function bb:run(_c,ac,bc)
self.window=window.create(self.program:getBaseFrame():getTerm(),1,1,ac,bc,false)
local cc=shell.resolveProgram(_c)or fs.exists(_c)and _c or nil
if(cc~=nil)then
if(fs.exists(cc))then local dc=fs.open(cc,"r")local _d=dc.readAll()
dc.close()
local ad=setmetatable(db(fs.getDir(_c)),{__index=_ENV})ad.term=self.window;ad.term.current=term.current
ad.term.redirect=term.redirect;ad.term.native=function()return self.window end
if
(self.addEnvironment)then for __a,a_a in pairs(self.env)do ad[__a]=a_a end else ad=self.env end
self.coroutine=coroutine.create(function()local __a=load(_d,"@/".._c,nil,ad)if __a then
local a_a=__a(table.unpack(self.args))return a_a end end)local bd=term.current()term.redirect(self.window)
local cd,dd=coroutine.resume(self.coroutine)term.redirect(bd)
if not cd then
local __a=self.program.get("doneCallback")if __a then __a(self.program,cd,dd)end
local a_a=self.program.get("errorCallback")
if a_a then local b_a=debug.traceback(self.coroutine,dd)
local c_a=a_a(self.program,dd,b_a:gsub(dd,""))if(c_a==false)then self.filter=nil;return cd,dd end end;_b.header="Basalt Program Error ".._c;_b.error(dd)end
if coroutine.status(self.coroutine)=="dead"then
self.program.set("running",false)self.program.set("program",nil)
local __a=self.program.get("doneCallback")if __a then __a(self.program,cd,dd)end end else _b.header="Basalt Program Error ".._c
_b.error("File not found")end else _b.header="Basalt Program Error"
_b.error("Program ".._c.." not found")end end;function bb:resize(_c,ac)self.window.reposition(1,1,_c,ac)
self:resume("term_resize",_c,ac)end
function bb:resume(_c,...)local ac={...}if
(_c:find("mouse_"))then
ac[2],ac[3]=self.program:getRelativePosition(ac[2],ac[3])end;if self.coroutine==nil or
coroutine.status(self.coroutine)=="dead"then
self.program.set("running",false)return end
if
(self.filter~=nil)then if(_c~=self.filter)then return end;self.filter=nil end;local bc=term.current()term.redirect(self.window)
local cc,dc=coroutine.resume(self.coroutine,_c,table.unpack(ac))term.redirect(bc)
if cc then self.filter=dc
if
coroutine.status(self.coroutine)=="dead"then
self.program.set("running",false)self.program.set("program",nil)
local _d=self.program.get("doneCallback")if _d then _d(self.program,cc,dc)end end else local _d=self.program.get("doneCallback")if _d then
_d(self.program,cc,dc)end
local ad=self.program.get("errorCallback")
if ad then local bd=debug.traceback(self.coroutine,dc)
bd=bd==nil and""or bd;dc=dc or"Unknown error"
local cd=ad(self.program,dc,bd:gsub(dc,""))if(cd==false)then self.filter=nil;return cc,dc end end;_b.header="Basalt Program Error"_b.error(dc)end;return cc,dc end
function bb:stop()if self.coroutine==nil or
coroutine.status(self.coroutine)=="dead"then
self.program.set("running",false)return end
coroutine.close(self.coroutine)self.coroutine=nil end;function ab.new()local _c=setmetatable({},ab):__init()
_c.class=ab;_c.set("z",5)_c.set("width",30)_c.set("height",12)
return _c end
function ab:init(_c,ac)
da.init(self,_c,ac)self.set("type","Program")
self:observe("width",function(bc,cc)
local dc=bc.get("program")
if dc then dc:resize(cc,bc.get("height"))end end)
self:observe("height",function(bc,cc)local dc=bc.get("program")if dc then
dc:resize(bc.get("width"),cc)end end)return self end
function ab:execute(_c,ac,bc,...)self.set("path",_c)self.set("running",true)
local cc=bb.new(self,ac,bc)self.set("program",cc)cc:setArgs(...)
cc:run(_c,self.get("width"),self.get("height"),...)self:updateRender()return self end;function ab:stop()local _c=self.get("program")if _c then _c:stop()
self.set("running",false)self.set("program",nil)end
return self end;function ab:sendEvent(_c,...)
self:dispatchEvent(_c,...)return self end;function ab:onError(_c)
self.set("errorCallback",_c)return self end;function ab:onDone(_c)
self.set("doneCallback",_c)return self end
function ab:dispatchEvent(_c,...)
local ac=self.get("program")local bc=da.dispatchEvent(self,_c,...)
if ac then ac:resume(_c,...)
if
(self.get("focused"))then local cc=ac.window.getCursorBlink()
local dc,_d=ac.window.getCursorPos()
self:setCursor(dc,_d,cc,ac.window.getTextColor())end;self:updateRender()end;return bc end
function ab:focus()
if(da.focus(self))then local _c=self.get("program")if _c then
local ac=_c.window.getCursorBlink()local bc,cc=_c.window.getCursorPos()
self:setCursor(bc,cc,ac,_c.window.getTextColor())end end end
function ab:render()da.render(self)local _c=self.get("program")
if _c then
local ac,bc=_c.window.getSize()for y=1,bc do local cc,dc,_d=_c.window.getLine(y)if cc then
self:blit(1,y,cc,dc,_d)end end end end;return ab end
project["elements/Image.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=require("libraries/colorHex")
local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"bimg",{default={{}},type="table",canTriggerRender=true})
_b.defineProperty(_b,"currentFrame",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"autoResize",{default=false,type="boolean"})
_b.defineProperty(_b,"offsetX",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"offsetY",{default=0,type="number",canTriggerRender=true})
_b.combineProperties(_b,"offset","offsetX","offsetY")
function _b.new()local cb=setmetatable({},_b):__init()
cb.class=_b;cb.set("width",12)cb.set("height",6)
cb.set("background",colors.black)cb.set("z",5)return cb end;function _b:init(cb,db)ca.init(self,cb,db)self.set("type","Image")
return self end
function _b:resizeImage(cb,db)
local _c=self.get("bimg")
for ac,bc in ipairs(_c)do local cc={}
for y=1,db do local dc=string.rep(" ",cb)
local _d=string.rep("f",cb)local ad=string.rep("0",cb)
if bc[y]and bc[y][1]then local bd=bc[y][1]
local cd=bc[y][2]local dd=bc[y][3]
dc=(bd..string.rep(" ",cb)):sub(1,cb)
_d=(cd..string.rep("f",cb)):sub(1,cb)
ad=(dd..string.rep("0",cb)):sub(1,cb)end;cc[y]={dc,_d,ad}end;_c[ac]=cc end;self:updateRender()return self end
function _b:getImageSize()local cb=self.get("bimg")if not cb[1]or not cb[1][1]then
return 0,0 end;return#cb[1][1][1],#cb[1]end
function _b:getPixelData(cb,db)
local _c=self.get("bimg")[self.get("currentFrame")]if not _c or not _c[db]then return end;local ac=_c[db][1]
local bc=_c[db][2]local cc=_c[db][3]
if not ac or not bc or not cc then return end;local dc=tonumber(bc:sub(cb,cb),16)
local _d=tonumber(cc:sub(cb,cb),16)local ad=ac:sub(cb,cb)return dc,_d,ad end
local function ab(cb,db)
local _c=cb.get("bimg")[cb.get("currentFrame")]if not _c then _c={}
cb.get("bimg")[cb.get("currentFrame")]=_c end
if not _c[db]then _c[db]={"","",""}end;return _c end
local function bb(cb,db,_c)if not cb.get("autoResize")then return end
local ac=cb.get("bimg")local bc=db;local cc=_c
for dc,_d in ipairs(ac)do for ad,bd in pairs(_d)do bc=math.max(bc,#bd[1])
cc=math.max(cc,ad)end end
for dc,_d in ipairs(ac)do
for y=1,cc do if not _d[y]then _d[y]={"","",""}end;local ad=_d[y]while#ad[1]<
bc do ad[1]=ad[1].." "end;while#ad[2]<bc do
ad[2]=ad[2].."f"end;while#ad[3]<bc do ad[3]=ad[3].."0"end end end end
function _b:setText(cb,db,_c)if
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end
if
not self.get("autoResize")then local cc,dc=self:getImageSize()if db>dc then return self end end;local ac=ab(self,db)if self.get("autoResize")then
bb(self,cb+#_c-1,db)else local cc=#ac[db][1]if cb>cc then return self end
_c=_c:sub(1,cc-cb+1)end
local bc=ac[db][1]
ac[db][1]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:getText(cb,db,_c)if not cb or not db then return""end
local ac=self.get("bimg")[self.get("currentFrame")]if not ac or not ac[db]then return""end;local bc=ac[db][1]if not bc then
return""end
if _c then return bc:sub(cb,cb+_c-1)else return bc:sub(cb,cb)end end
function _b:setFg(cb,db,_c)if
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end
if
not self.get("autoResize")then local cc,dc=self:getImageSize()if db>dc then return self end end;local ac=ab(self,db)if self.get("autoResize")then
bb(self,cb+#_c-1,db)else local cc=#ac[db][2]if cb>cc then return self end
_c=_c:sub(1,cc-cb+1)end
local bc=ac[db][2]
ac[db][2]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:getFg(cb,db,_c)if not cb or not db then return""end
local ac=self.get("bimg")[self.get("currentFrame")]if not ac or not ac[db]then return""end;local bc=ac[db][2]if not bc then
return""end
if _c then return bc:sub(cb,cb+_c-1)else return bc:sub(cb)end end
function _b:setBg(cb,db,_c)if
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end
if
not self.get("autoResize")then local cc,dc=self:getImageSize()if db>dc then return self end end;local ac=ab(self,db)if self.get("autoResize")then
bb(self,cb+#_c-1,db)else local cc=#ac[db][3]if cb>cc then return self end
_c=_c:sub(1,cc-cb+1)end
local bc=ac[db][3]
ac[db][3]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:getBg(cb,db,_c)if not cb or not db then return""end
local ac=self.get("bimg")[self.get("currentFrame")]if not ac or not ac[db]then return""end;local bc=ac[db][3]if not bc then
return""end
if _c then return bc:sub(cb,cb+_c-1)else return bc:sub(cb)end end
function _b:setPixel(cb,db,_c,ac,bc)if _c then self:setText(cb,db,_c)end;if ac then
self:setFg(cb,db,ac)end;if bc then self:setBg(cb,db,bc)end;return self end
function _b:nextFrame()
if not self.get("bimg").animation then return self end;local cb=self.get("bimg")local db=self.get("currentFrame")
local _c=db+1;if _c>#cb then _c=1 end;self.set("currentFrame",_c)return self end
function _b:addFrame()local cb=self.get("bimg")
local db=cb.width or#cb[1][1][1]local _c=cb.height or#cb[1]local ac={}local bc=string.rep(" ",db)
local cc=string.rep("f",db)local dc=string.rep("0",db)for y=1,_c do ac[y]={bc,cc,dc}end
table.insert(cb,ac)return self end;function _b:updateFrame(cb,db)local _c=self.get("bimg")_c[cb]=db
self:updateRender()return self end;function _b:getFrame(cb)
local db=self.get("bimg")
return db[cb or self.get("currentFrame")]end
function _b:getMetadata()local cb={}
local db=self.get("bimg")
for _c,ac in pairs(db)do if(type(ac)=="string")then cb[_c]=ac end end;return cb end
function _b:setMetadata(cb,db)if(type(cb)=="table")then
for ac,bc in pairs(cb)do self:setMetadata(ac,bc)end;return self end
local _c=self.get("bimg")if(type(db)=="string")then _c[cb]=db end;return self end
function _b:render()ca.render(self)
local cb=self.get("bimg")[self.get("currentFrame")]if not cb then return end;local db=self.get("offsetX")
local _c=self.get("offsetY")local ac=self.get("width")local bc=self.get("height")
for y=1,bc do local cc=y+_c
local dc=cb[cc]
if dc then local _d=dc[1]local ad=dc[2]local bd=dc[3]
if _d and ad and bd then
local cd=ac-math.max(0,db)
if cd>0 then if db<0 then local dd=math.abs(db)+1;_d=_d:sub(dd)ad=ad:sub(dd)
bd=bd:sub(dd)end;_d=_d:sub(1,cd)
ad=ad:sub(1,cd)bd=bd:sub(1,cd)
self:blit(math.max(1,1 +db),y,_d,ad,bd)end end end end end;return _b end
project["elements/BarChart.lua"] = function(...) local aa=require("elementManager")
local ba=aa.getElement("VisualElement")local ca=aa.getElement("Graph")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b;function _b.new()
local ab=setmetatable({},_b):__init()ab.class=_b;return ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","BarChart")return self end
function _b:render()ba.render(self)local ab=self.get("width")
local bb=self.get("height")local cb=self.get("minValue")local db=self.get("maxValue")
local _c=self.get("series")local ac=0;local bc={}
for ad,bd in pairs(_c)do if(bd.visible)then if#bd.data>0 then ac=ac+1
table.insert(bc,bd)end end end;local cc=ac;local dc=1
local _d=math.min(bc[1]and bc[1].pointCount or 0,math.floor((ab+dc)/ (
cc+dc)))
for groupIndex=1,_d do local ad=( (groupIndex-1)* (cc+dc))+1
for bd,cd in ipairs(bc)do
local dd=cd.data[groupIndex]
if dd then local __a=ad+ (bd-1)local a_a=(dd-cb)/ (db-cb)
local b_a=math.floor(bb- (a_a* (bb-1)))b_a=math.max(1,math.min(b_a,bb))for barY=b_a,bb do
self:blit(__a,barY,cd.symbol,da[cd.fgColor],da[cd.bgColor])end end end end end;return _b end
project["elements/ComboBox.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/DropDown")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"editable",{default=true,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"text",{default="",type="string",canTriggerRender=true})
ca.defineProperty(ca,"cursorPos",{default=1,type="number"})
ca.defineProperty(ca,"viewOffset",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"placeholder",{default="...",type="string"})
ca.defineProperty(ca,"placeholderColor",{default=colors.gray,type="color"})
ca.defineProperty(ca,"focusedBackground",{default=colors.blue,type="color"})
ca.defineProperty(ca,"focusedForeground",{default=colors.white,type="color"})
ca.defineProperty(ca,"autoComplete",{default=false,type="boolean"})
ca.defineProperty(ca,"manuallyOpened",{default=false,type="boolean"})function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",16)da.set("height",1)da.set("z",8)
return da end
function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","ComboBox")
self.set("cursorPos",1)self.set("viewOffset",0)return self end
function ca:setText(da)if da==nil then da=""end
self.set("text",tostring(da))
self.set("cursorPos",#self.get("text")+1)self:updateViewport()return self end;function ca:getText()return self.get("text")end;function ca:setEditable(da)
self.set("editable",da)return self end
function ca:getFilteredItems()
local da=self.get("items")or{}local _b=self.get("text"):lower()if not
self.get("autoComplete")or#_b==0 then return da end
local ab={}
for bb,cb in ipairs(da)do local db=""
if type(cb)=="string"then db=cb:lower()elseif type(cb)=="table"and
cb.text then db=cb.text:lower()end;if db:find(_b,1,true)then table.insert(ab,cb)end end;return ab end
function ca:updateFilteredDropdown()
if not self.get("autoComplete")then return end;local da=self:getFilteredItems()local _b=#da>0 and
#self.get("text")>0
if _b then self.set("isOpen",true)
self.set("manuallyOpened",false)local ab=self.get("dropdownHeight")or 5
local bb=math.min(ab,#da)self.set("height",1 +bb)else self.set("isOpen",false)
self.set("manuallyOpened",false)self.set("height",1)end;self:updateRender()end
function ca:updateViewport()local da=self.get("text")
local _b=self.get("cursorPos")local ab=self.get("width")local bb=self.get("dropSymbol")
local cb=ab-#bb;if cb<1 then cb=1 end;local db=self.get("viewOffset")if _b-db>cb then db=_b-cb elseif
_b-1 <db then db=math.max(0,_b-1)end
self.set("viewOffset",db)end
function ca:char(da)if not self.get("editable")then return end;if not
self.get("focused")then return end;local _b=self.get("text")
local ab=self.get("cursorPos")local bb=_b:sub(1,ab-1)..da.._b:sub(ab)
self.set("text",bb)self.set("cursorPos",ab+1)self:updateViewport()
if
self.get("autoComplete")then self:updateFilteredDropdown()else self:updateRender()end end
function ca:key(da,_b)if not self.get("editable")then return end;if not
self.get("focused")then return end;local ab=self.get("text")
local bb=self.get("cursorPos")
if da==keys.left then
self.set("cursorPos",math.max(1,bb-1))self:updateViewport()elseif da==keys.right then
self.set("cursorPos",math.min(#ab+1,bb+1))self:updateViewport()elseif da==keys.backspace then
if bb>1 then local cb=ab:sub(1,bb-2)..
ab:sub(bb)self.set("text",cb)
self.set("cursorPos",bb-1)self:updateViewport()if self.get("autoComplete")then
self:updateFilteredDropdown()else self:updateRender()end end elseif da==keys.delete then
if bb<=#ab then
local cb=ab:sub(1,bb-1)..ab:sub(bb+1)self.set("text",cb)self:updateViewport()
if
self.get("autoComplete")then self:updateFilteredDropdown()else self:updateRender()end end elseif da==keys.home then self.set("cursorPos",1)
self:updateViewport()elseif da==keys["end"]then self.set("cursorPos",#ab+1)
self:updateViewport()elseif da==keys.enter then
self.set("isOpen",not self.get("isOpen"))self:updateRender()end end
function ca:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
local db=self.get("width")local _c=self.get("dropSymbol")
if cb==1 then
if
bb>=db-#_c+1 and bb<=db then local ac=self.get("isOpen")self.set("isOpen",not ac)
if
self.get("isOpen")then local bc=self.get("items")or{}
local cc=self.get("dropdownHeight")or 5;local dc=math.min(cc,#bc)self.set("height",1 +dc)
self.set("manuallyOpened",true)else self.set("height",1)
self.set("manuallyOpened",false)end;self:updateRender()return true end
if bb<=db-#_c and self.get("editable")then
local ac=self.get("text")local bc=self.get("viewOffset")local cc=#ac+1
local dc=math.min(cc,bc+bb)self.set("cursorPos",dc)self:updateRender()return true end;return true elseif
self.get("isOpen")and cb>1 and self.get("selectable")then local ac=(cb-1)+self.get("offset")
local bc=self.get("items")
if ac<=#bc then local cc=bc[ac]
if type(cc)=="string"then cc={text=cc}bc[ac]=cc end
if not self.get("multiSelection")then for dc,_d in ipairs(bc)do if type(_d)=="table"then
_d.selected=false end end end;cc.selected=true;if cc.text then self:setText(cc.text)end
self.set("isOpen",false)self.set("height",1)self:updateRender()return true end end;return false end
function ca:render()_a.render(self)local da=self.get("text")
local _b=self.get("width")local ab=self.get("dropSymbol")local bb=self.get("focused")
local cb=self.get("isOpen")local db=self.get("viewOffset")
local _c=self.get("placeholder")
local ac=bb and self.get("focusedBackground")or self.get("background")
local bc=bb and self.get("focusedForeground")or self.get("foreground")local cc=da;local dc=_b-#ab;if#da==0 and not bb and#_c>0 then cc=_c
bc=self.get("placeholderColor")end
if#cc>0 then cc=cc:sub(db+1,db+dc)end;cc=cc..string.rep(" ",dc-#cc)local _d=cc..
(cb and"\31"or"\17")
self:blit(1,1,_d,string.rep(ba[bc],_b),string.rep(ba[ac],_b))
if bb and self.get("editable")then local ad=self.get("cursorPos")
local bd=ad-db;if bd>=1 and bd<=dc then
self:setCursor(bd,1,true,self.get("foreground"))end end
if cb then local ad
if
self.get("autoComplete")and not self.get("manuallyOpened")then ad=self:getFilteredItems()else ad=self.get("items")end
local bd=math.min(self.get("dropdownHeight"),#ad)
if bd>0 then local cd=self.get("offset")
for i=1,bd do local dd=i+cd
if ad[dd]then local __a=ad[dd]
local a_a=__a.text or""local b_a=__a.selected or false
local c_a=
b_a and self.get("selectedBackground")or self.get("background")
local d_a=b_a and self.get("selectedForeground")or self.get("foreground")if#a_a>_b then a_a=a_a:sub(1,_b)end;a_a=a_a..
string.rep(" ",_b-#a_a)
self:blit(1,i+1,a_a,string.rep(ba[d_a],_b),string.rep(ba[c_a],_b))end end end end end;function ca:focus()aa.focus(self)end
function ca:blur()aa.blur(self)
self.set("isOpen",false)self.set("height",1)self:updateRender()end;return ca end
project["elements/TabControl.lua"] = function(...) local ba=require("elementManager")
local ca=require("elements/VisualElement")local da=ba.getElement("Container")
local _b=require("libraries/colorHex")local ab=require("log")local bb=setmetatable({},da)bb.__index=bb
bb.defineProperty(bb,"activeTab",{default=
nil,type="number",allowNil=true,canTriggerRender=true,setter=function(cb,db)return db end})
bb.defineProperty(bb,"tabHeight",{default=1,type="number",canTriggerRender=true})
bb.defineProperty(bb,"tabs",{default={},type="table"})
bb.defineProperty(bb,"headerBackground",{default=colors.gray,type="color",canTriggerRender=true})
bb.defineProperty(bb,"activeTabBackground",{default=colors.white,type="color",canTriggerRender=true})
bb.defineProperty(bb,"activeTabTextColor",{default=colors.black,type="color",canTriggerRender=true})
bb.defineProperty(bb,"scrollableTab",{default=false,type="boolean",canTriggerRender=true})
bb.defineProperty(bb,"tabScrollOffset",{default=0,type="number",canTriggerRender=true})bb.defineEvent(bb,"mouse_click")
bb.defineEvent(bb,"mouse_up")bb.defineEvent(bb,"mouse_scroll")function bb.new()
local cb=setmetatable({},bb):__init()cb.class=bb;cb.set("width",20)cb.set("height",10)
cb.set("z",10)return cb end
function bb:init(cb,db)
da.init(self,cb,db)self.set("type","TabControl")end
function bb:newTab(cb)local db=self.get("tabs")or{}local _c=#db+1
table.insert(db,{id=_c,title=tostring(
cb or("Tab ".._c))})self.set("tabs",db)if not self.get("activeTab")then
self.set("activeTab",_c)end;self:updateTabVisibility()
local ac=self;local bc={}
setmetatable(bc,{__index=function(cc,dc)
if
type(dc)=="string"and dc:sub(1,3)=="add"and type(ac[dc])=="function"then
return
function(ad,...)
local bd=ac[dc](ac,...)
if bd then bd._tabId=_c;ac.set("childrenSorted",false)
ac.set("childrenEventsSorted",false)ac:updateRender()end;return bd end end;local _d=ac[dc]if type(_d)=="function"then
return function(ad,...)return _d(ac,...)end end;return _d end})return bc end;bb.addTab=bb.newTab;function bb:setTab(cb,db)cb._tabId=db
self:updateTabVisibility()return self end
function bb:addElement(cb,db)
local _c=da.addElement(self,cb)local ac=db or self.get("activeTab")if ac then _c._tabId=ac
self:updateTabVisibility()end;return _c end
function bb:addChild(cb)da.addChild(self,cb)if not cb._tabId then
local db=self.get("tabs")or{}
if#db>0 then cb._tabId=1;self:updateTabVisibility()end end;return self end;function bb:updateTabVisibility()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)end
function bb:setActiveTab(cb)
local db=self.get("activeTab")if db==cb then return self end;self.set("activeTab",cb)
self:updateTabVisibility()self:dispatchEvent("tabChanged",cb,db)return self end
function bb:isChildVisible(cb)
if not da.isChildVisible(self,cb)then return false end
if cb._tabId then return cb._tabId==self.get("activeTab")end;return true end
function bb:getContentYOffset()local cb=self:_getHeaderMetrics()return cb.headerHeight end
function bb:_getHeaderMetrics()local cb=self.get("tabs")or{}
local db=self.get("width")or 1;local _c=self.get("tabHeight")or 1
local ac=self.get("scrollableTab")local bc={}
if ac then local cc=self.get("tabScrollOffset")or 0
local dc=1;local _d=0
for ad,bd in ipairs(cb)do local cd=#bd.title+2;if cd>db then cd=db end;local dd=dc-cc
local __a=0;local a_a=0;if dd<1 then __a=1 -dd end
if dd+cd-1 >db then a_a=(dd+cd-1)-db end
if dd+cd>1 and dd<=db then local b_a=math.max(1,dd)local c_a=cd-__a-a_a
table.insert(bc,{id=bd.id,title=bd.title,line=1,x1=b_a,x2=
b_a+c_a-1,width=cd,displayWidth=c_a,actualX=dc,startClip=__a,endClip=a_a})end;dc=dc+cd end;_d=dc-1;return
{headerHeight=1,lines=1,positions=bc,totalWidth=_d,scrollOffset=cc,maxScroll=math.max(0,_d-db)}else local cc=1;local dc=1
for bd,cd in ipairs(cb)do local dd=#
cd.title+2;if dd>db then dd=db end
if dc+dd-1 >db then cc=cc+1;dc=1 end
table.insert(bc,{id=cd.id,title=cd.title,line=cc,x1=dc,x2=dc+dd-1,width=dd})dc=dc+dd end;local _d=cc;local ad=math.max(_c,_d)
return{headerHeight=ad,lines=_d,positions=bc}end end
function bb:mouse_click(cb,db,_c)
if not ca.mouse_click(self,cb,db,_c)then return false end;local ac,bc=ca.getRelativePosition(self,db,_c)
local cc=self:_getHeaderMetrics()
if bc<=cc.headerHeight then if#cc.positions==0 then return true end
for dc,_d in
ipairs(cc.positions)do
if _d.line==bc and ac>=_d.x1 and ac<=_d.x2 then
self:setActiveTab(_d.id)self.set("focusedChild",nil)return true end end;return true end;return da.mouse_click(self,cb,db,_c)end
function bb:getRelativePosition(cb,db)
local _c=self:_getHeaderMetrics().headerHeight
if cb==nil or db==nil then return ca.getRelativePosition(self)else
local ac,bc=ca.getRelativePosition(self,cb,db)return ac,bc-_c end end
function bb:multiBlit(cb,db,_c,ac,bc,cc,dc)local _d=self:_getHeaderMetrics().headerHeight;return da.multiBlit(self,cb,(
db or 1)+_d,_c,ac,bc,cc,dc)end
function bb:textFg(cb,db,_c,ac)local bc=self:_getHeaderMetrics().headerHeight;return da.textFg(self,cb,(
db or 1)+bc,_c,ac)end
function bb:textBg(cb,db,_c,ac)local bc=self:_getHeaderMetrics().headerHeight;return da.textBg(self,cb,(
db or 1)+bc,_c,ac)end
function bb:drawText(cb,db,_c)local ac=self:_getHeaderMetrics().headerHeight;return da.drawText(self,cb,(
db or 1)+ac,_c)end
function bb:drawFg(cb,db,_c)local ac=self:_getHeaderMetrics().headerHeight;return da.drawFg(self,cb,(
db or 1)+ac,_c)end
function bb:drawBg(cb,db,_c)local ac=self:_getHeaderMetrics().headerHeight;return da.drawBg(self,cb,(
db or 1)+ac,_c)end
function bb:blit(cb,db,_c,ac,bc)local cc=self:_getHeaderMetrics().headerHeight;return da.blit(self,cb,(
db or 1)+cc,_c,ac,bc)end
function bb:mouse_up(cb,db,_c)
if not ca.mouse_up(self,cb,db,_c)then return false end;local ac,bc=ca.getRelativePosition(self,db,_c)
local cc=self:_getHeaderMetrics().headerHeight;if bc<=cc then return true end;return da.mouse_up(self,cb,db,_c)end
function bb:mouse_release(cb,db,_c)ca.mouse_release(self,cb,db,_c)
local ac,bc=ca.getRelativePosition(self,db,_c)local cc=self:_getHeaderMetrics().headerHeight
if bc<=cc then return end;return da.mouse_release(self,cb,db,_c)end
function bb:mouse_move(cb,db,_c)
if ca.mouse_move(self,cb,db,_c)then
local ac,bc=ca.getRelativePosition(self,db,_c)local cc=self:_getHeaderMetrics().headerHeight;if bc<=cc then
return true end
local dc={self:getRelativePosition(db,_c)}
local _d,ad=self:callChildrenEvent(true,"mouse_move",table.unpack(dc))if _d then return true end end;return false end
function bb:mouse_drag(cb,db,_c)
if ca.mouse_drag(self,cb,db,_c)then
local ac,bc=ca.getRelativePosition(self,db,_c)local cc=self:_getHeaderMetrics().headerHeight;if bc<=cc then
return true end;return da.mouse_drag(self,cb,db,_c)end;return false end
function bb:scrollTabs(cb)
if not self.get("scrollableTab")then return self end;local db=self:_getHeaderMetrics()
local _c=self.get("tabScrollOffset")or 0;local ac=db.maxScroll or 0;local bc=_c+ (cb*5)
bc=math.max(0,math.min(ac,bc))self.set("tabScrollOffset",bc)return self end
function bb:mouse_scroll(cb,db,_c)
if ca.mouse_scroll(self,cb,db,_c)then
local ac=self:_getHeaderMetrics().headerHeight;if self.get("scrollableTab")and _c==self.get("y")then
self:scrollTabs(cb)return true end;return
da.mouse_scroll(self,cb,db,_c)end;return false end
function bb:setCursor(cb,db,_c,ac)local bc=self:_getHeaderMetrics().headerHeight
if
self.parent then local cc,dc=self:calculatePosition()local _d=cb+cc-1
local ad=db+dc-1 +bc
if

(_d<1)or(_d>self.parent.get("width"))or(ad<1)or(ad>self.parent.get("height"))then return self.parent:setCursor(_d,ad,false)end;return self.parent:setCursor(_d,ad,_c,ac)end;return self end
function bb:render()ca.render(self)local cb=self.get("width")
local db=self:_getHeaderMetrics()local _c=db.headerHeight or 1
ca.multiBlit(self,1,1,cb,_c," ",_b[self.get("foreground")],_b[self.get("headerBackground")])local ac=self.get("activeTab")
for bc,cc in ipairs(db.positions)do
local dc=(cc.id==ac)and
self.get("activeTabBackground")or self.get("headerBackground")local _d=(cc.id==ac)and self.get("activeTabTextColor")or
self.get("foreground")
ca.multiBlit(self,cc.x1,cc.line,
cc.displayWidth or(cc.x2 -cc.x1 +1),1," ",_b[self.get("foreground")],_b[dc])local ad=cc.title;local bd=1 + (cc.startClip or 0)
local cd=#cc.title- (cc.startClip or
0)- (cc.endClip or 0)if cd>0 then ad=cc.title:sub(bd,bd+cd-1)local dd=cc.x1;if
(cc.startClip or 0)==0 then dd=dd+1 end
ca.textFg(self,dd,cc.line,ad,_d)end end
if not self.get("childrenSorted")then self:sortChildren()end
if not self.get("childrenEventsSorted")then for bc in pairs(self._values.childrenEvents or
{})do
self:sortChildrenEvents(bc)end end
for bc,cc in ipairs(self.get("visibleChildren")or{})do if cc==self then
error("CIRCULAR REFERENCE DETECTED!")return end;cc:render()cc:postRender()end end
function bb:sortChildrenEvents(cb)
local db=self._values.childrenEvents and self._values.childrenEvents[cb]
if db then local _c={}for ac,bc in ipairs(db)do
if self:isChildVisible(bc)then table.insert(_c,bc)end end
for i=2,#_c do local ac=_c[i]
local bc=ac.get("z")local cc=i-1
while cc>0 do local dc=_c[cc].get("z")if dc>bc then _c[cc+1]=_c[cc]
cc=cc-1 else break end end;_c[cc+1]=ac end
self._values.visibleChildrenEvents=self._values.visibleChildrenEvents or{}self._values.visibleChildrenEvents[cb]=_c end;self.set("childrenEventsSorted",true)return self end;return bb end
project["elements/TextBox.lua"] = function(...) local b_a=require("elements/VisualElement")
local c_a=require("libraries/colorHex")local d_a=setmetatable({},b_a)d_a.__index=d_a
d_a.defineProperty(d_a,"lines",{default={""},type="table",canTriggerRender=true})
d_a.defineProperty(d_a,"cursorX",{default=1,type="number"})
d_a.defineProperty(d_a,"cursorY",{default=1,type="number"})
d_a.defineProperty(d_a,"scrollX",{default=0,type="number",canTriggerRender=true})
d_a.defineProperty(d_a,"scrollY",{default=0,type="number",canTriggerRender=true})
d_a.defineProperty(d_a,"editable",{default=true,type="boolean"})
d_a.defineProperty(d_a,"syntaxPatterns",{default={},type="table"})
d_a.defineProperty(d_a,"cursorColor",{default=nil,type="color"})
d_a.defineProperty(d_a,"autoPairEnabled",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoPairCharacters",{default={["("]=")",["["]="]",["{"]="}",['"']='"',['\'']='\'',['`']='`'},type="table"})
d_a.defineProperty(d_a,"autoPairSkipClosing",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoPairOverType",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoPairNewlineIndent",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteEnabled",{default=false,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteItems",{default={},type="table"})
d_a.defineProperty(d_a,"autoCompleteProvider",{default=nil,type="function",allowNil=true})
d_a.defineProperty(d_a,"autoCompleteMinChars",{default=1,type="number"})
d_a.defineProperty(d_a,"autoCompleteMaxItems",{default=6,type="number"})
d_a.defineProperty(d_a,"autoCompleteCaseInsensitive",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteTokenPattern",{default="[%w_]+",type="string"})
d_a.defineProperty(d_a,"autoCompleteOffsetX",{default=0,type="number"})
d_a.defineProperty(d_a,"autoCompleteOffsetY",{default=1,type="number"})
d_a.defineProperty(d_a,"autoCompleteZOffset",{default=1,type="number"})
d_a.defineProperty(d_a,"autoCompleteMaxWidth",{default=0,type="number"})
d_a.defineProperty(d_a,"autoCompleteShowBorder",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteBorderColor",{default=colors.black,type="color"})
d_a.defineProperty(d_a,"autoCompleteBackground",{default=colors.lightGray,type="color"})
d_a.defineProperty(d_a,"autoCompleteForeground",{default=colors.black,type="color"})
d_a.defineProperty(d_a,"autoCompleteSelectedBackground",{default=colors.gray,type="color"})
d_a.defineProperty(d_a,"autoCompleteSelectedForeground",{default=colors.white,type="color"})
d_a.defineProperty(d_a,"autoCompleteAcceptOnEnter",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteAcceptOnClick",{default=true,type="boolean"})
d_a.defineProperty(d_a,"autoCompleteCloseOnEscape",{default=true,type="boolean"})d_a.defineEvent(d_a,"mouse_click")
d_a.defineEvent(d_a,"key")d_a.defineEvent(d_a,"char")
d_a.defineEvent(d_a,"mouse_scroll")d_a.defineEvent(d_a,"paste")
d_a.defineEvent(d_a,"auto_complete_open")d_a.defineEvent(d_a,"auto_complete_close")
d_a.defineEvent(d_a,"auto_complete_accept")local _aa;local aaa;local function baa(c_b)local d_b=c_b._autoCompleteFrame
return
d_b and not d_b._destroyed and d_b.get and d_b.get("visible")end
local function caa(c_b)return
c_b.get("autoCompleteShowBorder")and 1 or 0 end
local function daa(c_b)local d_b=c_b._autoCompleteFrame;local _ab=c_b._autoCompleteList;if
not d_b or d_b._destroyed then return end
d_b:setBackground(c_b.get("autoCompleteBackground"))
d_b:setForeground(c_b.get("autoCompleteForeground"))
if _ab and not _ab._destroyed then
_ab:setBackground(c_b.get("autoCompleteBackground"))
_ab:setForeground(c_b.get("autoCompleteForeground"))
_ab:setSelectedBackground(c_b.get("autoCompleteSelectedBackground"))
_ab:setSelectedForeground(c_b.get("autoCompleteSelectedForeground"))_ab:updateRender()end;aaa(c_b)_aa(c_b)d_b:updateRender()end
local function _ba(c_b,d_b,_ab)local aab=c_b._autoCompleteList
if not aab or aab._destroyed then return end;local bab=aab.get("items")local cab=#bab;if cab==0 then return end
if d_b<1 then d_b=1 end;if d_b>cab then d_b=cab end;c_b._autoCompleteIndex=d_b
for abb,bbb in ipairs(bab)do if
type(bbb)=="table"then bbb.selected=(abb==d_b)end end;local dab=aab.get("height")or 0
local _bb=aab.get("offset")or 0;if not _ab and dab>0 then
if d_b>_bb+dab then
aab:setOffset(math.max(0,d_b-dab))elseif d_b<=_bb then aab:setOffset(math.max(0,d_b-1))end end
aab:updateRender()end
local function aba(c_b,d_b)if baa(c_b)then
c_b._autoCompleteFrame:setVisible(false)
if not d_b then c_b:fireEvent("auto_complete_close")end end
c_b._autoCompleteIndex=nil;c_b._autoCompleteSuggestions=nil;c_b._autoCompleteToken=nil
c_b._autoCompleteTokenStart=nil;c_b._autoCompletePopupWidth=nil end
local function bba(c_b,d_b)local _ab=c_b._autoCompleteSuggestions or{}
local aab=c_b._autoCompleteIndex or 1;local bab=d_b or _ab[aab]if not bab then return end
local cab=bab.insert or bab.text or""if cab==""then return end;local dab=c_b.get("lines")
local _bb=c_b.get("cursorY")local abb=c_b.get("cursorX")local bbb=dab[_bb]or""
local cbb=c_b._autoCompleteTokenStart or abb;if cbb<1 then cbb=1 end;local dbb=bbb:sub(1,cbb-1)local _cb=bbb:sub(abb)dab[_bb]=
dbb..cab.._cb;c_b.set("cursorX",cbb+#cab)
c_b:updateViewport()c_b:updateRender()aba(c_b,true)
c_b:fireEvent("auto_complete_accept",cab,bab.source or bab)end
local function cba(c_b)
if not c_b.get("autoCompleteEnabled")then return nil end;local d_b=c_b._autoCompleteFrame;if d_b and not d_b._destroyed then
return c_b._autoCompleteList end;local _ab=c_b:getBaseFrame()if not _ab or not
_ab.addFrame then return nil end
d_b=_ab:addFrame({width=c_b.get("width"),height=1,x=1,y=1,visible=false,background=c_b.get("autoCompleteBackground"),foreground=c_b.get("autoCompleteForeground"),ignoreOffset=true,z=
c_b.get("z")+c_b.get("autoCompleteZOffset")})d_b:setIgnoreOffset(true)d_b:setVisible(false)
local aab=caa(c_b)
local bab=d_b:addList({x=aab+1,y=aab+1,width=math.max(1,d_b.get("width")-aab*2),height=math.max(1,
d_b.get("height")-aab*2),selectable=true,multiSelection=false,background=c_b.get("autoCompleteBackground"),foreground=c_b.get("autoCompleteForeground")})
bab:setSelectedBackground(c_b.get("autoCompleteSelectedBackground"))
bab:setSelectedForeground(c_b.get("autoCompleteSelectedForeground"))bab:setOffset(0)
bab:onSelect(function(cab,dab,_bb)if not baa(c_b)then return end
_ba(c_b,dab)
if c_b.get("autoCompleteAcceptOnClick")then bba(c_b,_bb)end end)c_b._autoCompleteFrame=d_b;c_b._autoCompleteList=bab;daa(c_b)return bab end
aaa=function(c_b,d_b,_ab)local aab=c_b._autoCompleteFrame;local bab=c_b._autoCompleteList
if
not aab or aab._destroyed or not bab or bab._destroyed then return end;local cab=caa(c_b)
local dab=
tonumber(d_b)or rawget(c_b,"_autoCompletePopupWidth")or bab.get("width")or aab.get("width")
local _bb=tonumber(_ab)or(bab.get and bab.get("height"))or(# (
rawget(c_b,"_autoCompleteSuggestions")or{}))dab=math.max(1,dab or 1)_bb=math.max(1,_bb or 1)local abb=
aab.get and aab.get("width")or dab;local bbb=
aab.get and aab.get("height")or _bb;local cbb=math.max(1,
abb-cab*2)
local dbb=math.max(1,bbb-cab*2)if dab>cbb then dab=cbb end;if _bb>dbb then _bb=dbb end
bab:setPosition(cab+1,cab+1)bab:setWidth(math.max(1,dab))
bab:setHeight(math.max(1,_bb))end
_aa=function(c_b)local d_b=c_b._autoCompleteFrame
if not d_b or d_b._destroyed then return end;local _ab=d_b.get and d_b.get("canvas")
if not _ab then return end;_ab:setType("post")
if d_b._autoCompleteBorderCommand then
_ab:removeCommand(d_b._autoCompleteBorderCommand)d_b._autoCompleteBorderCommand=nil end;if not c_b.get("autoCompleteShowBorder")then
d_b:updateRender()return end;local aab=c_b.get("autoCompleteBorderColor")or
colors.black
local bab=_ab:addCommand(function(cab)local dab=
cab.get("width")or 0;local _bb=cab.get("height")or 0;if dab<1 or
_bb<1 then return end
local abb=cab.get("background")or colors.black;local bbb=c_a[abb]or c_a[colors.black]local cbb=c_a[aab]or
c_a[colors.black]
cab:textFg(1,1,("\131"):rep(dab),aab)cab:multiBlit(1,_bb,dab,1,"\143",bbb,cbb)
cab:multiBlit(1,1,1,_bb,"\149",cbb,bbb)cab:multiBlit(dab,1,1,_bb,"\149",bbb,cbb)
cab:blit(1,1,"\151",cbb,bbb)cab:blit(dab,1,"\148",bbb,cbb)
cab:blit(1,_bb,"\138",bbb,cbb)cab:blit(dab,_bb,"\133",bbb,cbb)end)d_b._autoCompleteBorderCommand=bab;d_b:updateRender()end
local function dba(c_b)local d_b=c_b.get("lines")local _ab=c_b.get("cursorY")
local aab=c_b.get("cursorX")local bab=d_b[_ab]or""
local cab=bab:sub(1,math.max(aab-1,0))
local dab=c_b.get("autoCompleteTokenPattern")or"[%w_]+"local _bb=""if dab~=""then
_bb=cab:match("("..dab..")$")or""end;local abb=aab-#_bb;if abb<1 then abb=1 end;return _bb,abb end
local function _ca(c_b)
if type(c_b)=="string"then return{text=c_b,insert=c_b,source=c_b}elseif
type(c_b)=="table"then local d_b=
c_b.text or c_b.label or c_b.value or c_b.insert or c_b[1]if not d_b then return
nil end
local _ab={text=d_b,insert=c_b.insert or c_b.value or d_b,source=c_b}if c_b.foreground then _ab.foreground=c_b.foreground end;if
c_b.background then _ab.background=c_b.background end;if c_b.selectedForeground then
_ab.selectedForeground=c_b.selectedForeground end;if c_b.selectedBackground then
_ab.selectedBackground=c_b.selectedBackground end
if c_b.icon then _ab.icon=c_b.icon end;if c_b.info then _ab.info=c_b.info end;return _ab end end
local function aca(c_b,d_b)if type(c_b)~="table"then return end;local _ab=#c_b
if _ab>0 then for index=1,_ab do
d_b(c_b[index])end else for aab,bab in pairs(c_b)do d_b(bab)end end end
local function bca(c_b,d_b)local _ab=c_b.get("autoCompleteProvider")local aab={}
if _ab then
local abb,bbb=pcall(_ab,c_b,d_b)if abb and type(bbb)=="table"then aab=bbb end else aab=
c_b.get("autoCompleteItems")or{}end;local bab={}local cab=c_b.get("autoCompleteCaseInsensitive")local dab=cab and
d_b:lower()or d_b
aca(aab,function(abb)local bbb=_ca(abb)
if bbb and bbb.text then
local cbb=
cab and bbb.text:lower()or bbb.text;if dab==""or cbb:find(dab,1,true)==1 then
table.insert(bab,bbb)end end end)local _bb=c_b.get("autoCompleteMaxItems")if#bab>_bb then while#bab>_bb do
table.remove(bab)end end;return bab end
local function cca(c_b,d_b)local _ab=0
for _bb,abb in ipairs(d_b)do local bbb=abb;if type(abb)=="table"then
bbb=
abb.text or abb.label or abb.value or abb.insert or abb[1]end;if bbb~=nil then
local cbb=#tostring(bbb)if cbb>_ab then _ab=cbb end end end;local aab=c_b.get("autoCompleteMaxWidth")
local bab=c_b.get("width")if aab and aab>0 then bab=math.min(bab,aab)end
local cab=caa(c_b)local dab=c_b:getBaseFrame()
if dab and dab.get then
local _bb=dab.get("width")if _bb and _bb>0 then local abb=_bb-cab*2;if abb<1 then abb=1 end
bab=math.min(bab,abb)end end;_ab=math.min(_ab,bab)return math.max(1,_ab)end
local function dca(c_b,d_b,_ab)local aab=c_b._autoCompleteFrame;local bab=c_b._autoCompleteList;if
not aab or aab._destroyed then return end;local cab=caa(c_b)
local dab=math.max(1,_ab or c_b.get("width"))local _bb=math.max(1,d_b or 1)local abb=c_b:getBaseFrame()if not abb then
return end;local bbb=abb.get and abb.get("width")local cbb=abb.get and
abb.get("height")
if bbb and bbb>0 then local bac=bbb-cab*2;if bac<1 then
bac=1 end;if dab>bac then dab=bac end end;if cbb and cbb>0 then local bac=cbb-cab*2;if bac<1 then bac=1 end
if _bb>bac then _bb=bac end end;local dbb=dab+cab*2
local _cb=_bb+cab*2;local acb,bcb=c_b:calculatePosition()
local ccb=c_b.get("scrollX")or 0;local dcb=c_b.get("scrollY")or 0;local _db=(c_b._autoCompleteTokenStart or
c_b.get("cursorX"))local adb=_db-ccb
adb=math.max(1,math.min(c_b.get("width"),adb))local bdb=c_b.get("cursorY")-dcb
bdb=math.max(1,math.min(c_b.get("height"),bdb))local cdb=c_b.get("autoCompleteOffsetX")
local ddb=c_b.get("autoCompleteOffsetY")local __c=acb+adb-1 +cdb;local a_c=__c-cab
if cab>0 then a_c=a_c+1 end;local b_c=bcb+bdb+ddb;local c_c=bcb+bdb-ddb-1;local d_c=b_c-cab;local _ac=
c_c-_bb+1 -cab;local aac=d_c
if bbb and bbb>0 then if dbb>bbb then dbb=bbb
dab=math.max(1,dbb-cab*2)end;if a_c+dbb-1 >bbb then
a_c=math.max(1,bbb-dbb+1)end;if a_c<1 then a_c=1 end else if a_c<1 then a_c=1 end end
if cbb and cbb>0 then
if aac+_cb-1 >cbb then aac=_ac;if cab>0 then aac=aac-cab end;if
aac<1 then aac=math.max(1,cbb-_cb+1)end end;if aac<1 then aac=1 end else if aac<1 then aac=1 end;if aac==_ac and cab>0 then
aac=math.max(1,aac-cab)end end;aab:setPosition(a_c,aac)aab:setWidth(dbb)
aab:setHeight(_cb)
aab:setZ(c_b.get("z")+c_b.get("autoCompleteZOffset"))aaa(c_b,dab,_bb)if bab and not bab._destroyed then
bab:updateRender()end;aab:updateRender()end
local function _da(c_b)
if not c_b.get("autoCompleteEnabled")then aba(c_b,true)return end
if not c_b.get("focused")then aba(c_b,true)return end;local d_b,_ab=dba(c_b)c_b._autoCompleteToken=d_b
c_b._autoCompleteTokenStart=_ab
if#d_b<c_b.get("autoCompleteMinChars")then aba(c_b)return end;local aab=bca(c_b,d_b)if#aab==0 then aba(c_b)return end
local bab=cba(c_b)if not bab then return end;bab:setOffset(0)bab:setItems(aab)
c_b._autoCompleteSuggestions=aab;_ba(c_b,1,true)local cab=cca(c_b,aab)c_b._autoCompletePopupWidth=cab;dca(c_b,
#aab,cab)daa(c_b)
c_b._autoCompleteFrame:setVisible(true)c_b._autoCompleteList:updateRender()
c_b._autoCompleteFrame:updateRender()c_b:fireEvent("auto_complete_open",d_b,aab)end
local function ada(c_b,d_b)if not baa(c_b)then return false end
if d_b==keys.tab or(d_b==keys.enter and
c_b.get("autoCompleteAcceptOnEnter"))then
bba(c_b)return true elseif d_b==keys.up then
_ba(c_b,(c_b._autoCompleteIndex or 1)-1)return true elseif d_b==keys.down then
_ba(c_b,(c_b._autoCompleteIndex or 1)+1)return true elseif d_b==keys.pageUp then
local _ab=(c_b._autoCompleteList and
c_b._autoCompleteList.get("height"))or 1
_ba(c_b,(c_b._autoCompleteIndex or 1)-_ab)return true elseif d_b==keys.pageDown then
local _ab=(c_b._autoCompleteList and
c_b._autoCompleteList.get("height"))or 1
_ba(c_b,(c_b._autoCompleteIndex or 1)+_ab)return true elseif
d_b==keys.escape and c_b.get("autoCompleteCloseOnEscape")then aba(c_b)return true end;return false end
local function bda(c_b,d_b)if not baa(c_b)then return false end;local _ab=c_b._autoCompleteList;if not _ab or
_ab._destroyed then return false end
local aab=_ab.get("items")local bab=_ab.get("height")or 1
local cab=_ab.get("offset")or 0;local dab=#aab;if dab==0 then return false end
local _bb=math.max(0,dab-bab)local abb=math.max(0,math.min(_bb,cab+d_b))if
abb~=cab then _ab:setOffset(abb)end;local bbb=(c_b._autoCompleteIndex or 1)+
d_b;if bbb>=1 and bbb<=dab then
_ba(c_b,bbb)else _ab:updateRender()end;return true end
function d_a.new()local c_b=setmetatable({},d_a):__init()
c_b.class=d_a;c_b.set("width",20)c_b.set("height",10)return c_b end
function d_a:init(c_b,d_b)b_a.init(self,c_b,d_b)
self.set("type","TextBox")
local function _ab()if
self.get("autoCompleteEnabled")and self.get("focused")then _da(self)end end;local function aab()daa(self)end
local function bab()
if baa(self)then
local cab=rawget(self,"_autoCompleteSuggestions")or{}
dca(self,math.max(#cab,1),rawget(self,"_autoCompletePopupWidth")or
self.get("width"))end end
self:observe("autoCompleteEnabled",function(cab,dab)if not dab then aba(self,true)elseif self.get("focused")then
_da(self)end end)
self:observe("focused",function(cab,dab)if dab then _ab()else aba(self,true)end end)self:observe("foreground",aab)
self:observe("background",aab)self:observe("autoCompleteBackground",aab)
self:observe("autoCompleteForeground",aab)
self:observe("autoCompleteSelectedBackground",aab)
self:observe("autoCompleteSelectedForeground",aab)self:observe("autoCompleteBorderColor",aab)
self:observe("autoCompleteZOffset",function()
if

self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
self._autoCompleteFrame:setZ(self.get("z")+self.get("autoCompleteZOffset"))end end)
self:observe("z",function()
if
self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
self._autoCompleteFrame:setZ(self.get("z")+self.get("autoCompleteZOffset"))end end)
self:observe("autoCompleteShowBorder",function()aab()bab()end)
for cab,dab in
ipairs({"autoCompleteItems","autoCompleteProvider","autoCompleteMinChars","autoCompleteMaxItems","autoCompleteCaseInsensitive","autoCompleteTokenPattern","autoCompleteOffsetX","autoCompleteOffsetY"})do self:observe(dab,_ab)end;self:observe("x",bab)self:observe("y",bab)self:observe("width",function()
bab()_ab()end)
self:observe("height",bab)self:observe("cursorX",bab)
self:observe("cursorY",bab)self:observe("scrollX",bab)
self:observe("scrollY",bab)self:observe("autoCompleteOffsetX",bab)
self:observe("autoCompleteOffsetY",bab)
self:observe("autoCompleteMaxWidth",function()
if baa(self)then
local cab=rawget(self,"_autoCompleteSuggestions")or{}if#cab>0 then local dab=cca(self,cab)self._autoCompletePopupWidth=dab
dca(self,math.max(#cab,1),dab)end end end)return self end;function d_a:addSyntaxPattern(c_b,d_b)
table.insert(self.get("syntaxPatterns"),{pattern=c_b,color=d_b})return self end
function d_a:removeSyntaxPattern(c_b)local d_b=
self.get("syntaxPatterns")or{}
if type(c_b)~="number"then return self end
if c_b>=1 and c_b<=#d_b then table.remove(d_b,c_b)
self.set("syntaxPatterns",d_b)self:updateRender()end;return self end;function d_a:clearSyntaxPatterns()self.set("syntaxPatterns",{})
self:updateRender()return self end
local function cda(c_b,d_b)
local _ab=c_b.get("lines")local aab=c_b.get("cursorX")local bab=c_b.get("cursorY")
local cab=_ab[bab]
_ab[bab]=cab:sub(1,aab-1)..d_b..cab:sub(aab)c_b.set("cursorX",aab+1)c_b:updateViewport()
c_b:updateRender()end
local function dda(c_b,d_b)for i=1,#d_b do cda(c_b,d_b:sub(i,i))end end
local function __b(c_b)local d_b=c_b.get("lines")local _ab=c_b.get("cursorX")
local aab=c_b.get("cursorY")local bab=d_b[aab]local cab=bab:sub(_ab)
d_b[aab]=bab:sub(1,_ab-1)table.insert(d_b,aab+1,cab)c_b.set("cursorX",1)c_b.set("cursorY",
aab+1)c_b:updateViewport()
c_b:updateRender()end
local function a_b(c_b)local d_b=c_b.get("lines")local _ab=c_b.get("cursorX")
local aab=c_b.get("cursorY")local bab=d_b[aab]
if _ab>1 then
d_b[aab]=bab:sub(1,_ab-2)..bab:sub(_ab)c_b.set("cursorX",_ab-1)elseif aab>1 then local cab=d_b[aab-1]c_b.set("cursorX",
#cab+1)c_b.set("cursorY",aab-1)d_b[aab-1]=
cab..bab;table.remove(d_b,aab)end;c_b:updateViewport()c_b:updateRender()end
function d_a:updateViewport()local c_b=self.get("cursorX")
local d_b=self.get("cursorY")local _ab=self.get("scrollX")local aab=self.get("scrollY")
local bab=self.get("width")local cab=self.get("height")
if c_b-_ab>bab then
self.set("scrollX",c_b-bab)elseif c_b-_ab<1 then self.set("scrollX",c_b-1)end
if d_b-aab>cab then self.set("scrollY",d_b-cab)elseif d_b-aab<1 then self.set("scrollY",
d_b-1)end;return self end
function d_a:char(c_b)if
not self.get("editable")or not self.get("focused")then return false end
local d_b=self.get("autoPairEnabled")
if d_b and#c_b==1 then
local _ab=self.get("autoPairCharacters")or{}local aab=self.get("lines")local bab=self.get("cursorX")
local cab=self.get("cursorY")local dab=aab[cab]or""local _bb=dab:sub(bab,bab)local abb=_ab[c_b]
if abb then
cda(self,c_b)
if self.get("autoPairSkipClosing")then
if _bb~=abb then cda(self,abb)self.set("cursorX",
self.get("cursorX")-1)end else cda(self,abb)
self.set("cursorX",self.get("cursorX")-1)end;_da(self)return true end
if self.get("autoPairOverType")then
for bbb,cbb in pairs(_ab)do if c_b==cbb and _bb==cbb then
self.set("cursorX",bab+1)_da(self)return true end end end end;cda(self,c_b)_da(self)return true end
function d_a:key(c_b)if
not self.get("editable")or not self.get("focused")then return false end
if ada(self,c_b)then return true end;local d_b=self.get("lines")local _ab=self.get("cursorX")
local aab=self.get("cursorY")
if c_b==keys.enter then
if self.get("autoPairEnabled")and
self.get("autoPairNewlineIndent")then local bab=self.get("lines")
local cab=self.get("cursorX")local dab=self.get("cursorY")local _bb=bab[dab]or""
local abb=_bb:sub(1,cab-1)local bbb=_bb:sub(cab)
local cbb=self.get("autoPairCharacters")or{}local dbb={}for bcb,ccb in pairs(cbb)do dbb[ccb]=bcb end;local _cb=abb:sub(-1)
local acb=bbb:sub(1,1)
if _cb~=""and acb~=""and cbb[_cb]==acb then bab[dab]=abb;table.insert(bab,
dab+1,"")table.insert(bab,dab+2,bbb)self.set("cursorY",
dab+1)self.set("cursorX",1)
self:updateViewport()self:updateRender()_da(self)return true end end;__b(self)elseif c_b==keys.backspace then a_b(self)elseif c_b==keys.left then
if _ab>1 then self.set("cursorX",
_ab-1)elseif aab>1 then self.set("cursorY",aab-1)self.set("cursorX",
#d_b[aab-1]+1)end elseif c_b==keys.right then if _ab<=#d_b[aab]then
self.set("cursorX",_ab+1)elseif aab<#d_b then self.set("cursorY",aab+1)
self.set("cursorX",1)end elseif c_b==keys.up and
aab>1 then self.set("cursorY",aab-1)
self.set("cursorX",math.min(_ab,#
d_b[aab-1]+1))elseif c_b==keys.down and aab<#d_b then
self.set("cursorY",aab+1)
self.set("cursorX",math.min(_ab,#d_b[aab+1]+1))end;self:updateRender()self:updateViewport()_da(self)return
true end
function d_a:mouse_scroll(c_b,d_b,_ab)if bda(self,c_b)then return true end
if self:isInBounds(d_b,_ab)then
local aab=self.get("scrollY")local bab=self.get("height")local cab=self.get("lines")local dab=math.max(0,#cab-
bab+2)
local _bb=math.max(0,math.min(dab,aab+c_b))self.set("scrollY",_bb)self:updateRender()return true end;return false end
function d_a:mouse_click(c_b,d_b,_ab)
if b_a.mouse_click(self,c_b,d_b,_ab)then
local aab,bab=self:getRelativePosition(d_b,_ab)local cab=self.get("scrollX")local dab=self.get("scrollY")local _bb=
(bab or 0)+ (dab or 0)
local abb=self.get("lines")or{}if _bb<1 then _bb=1 end
if _bb<=#abb and abb[_bb]~=nil then
self.set("cursorY",_bb)local bbb=#tostring(abb[_bb])
self.set("cursorX",math.min((aab or 1)+ (cab or 0),
bbb+1))end;self:updateRender()_da(self)return true end
if baa(self)then local aab=self._autoCompleteFrame;if
not
(aab and aab:isInBounds(d_b,_ab))and not self:isInBounds(d_b,_ab)then aba(self)end end;return false end
function d_a:paste(c_b)if
not self.get("editable")or not self.get("focused")then return false end
for d_b in c_b:gmatch(".")do if d_b=="\n"then
__b(self)else cda(self,d_b)end end;_da(self)return true end
function d_a:setText(c_b)local d_b={}
if c_b==""then d_b={""}else for _ab in(c_b.."\n"):gmatch("([^\n]*)\n")do
table.insert(d_b,_ab)end end;self.set("lines",d_b)aba(self,true)return self end
function d_a:getText()return table.concat(self.get("lines"),"\n")end
local function b_b(c_b,d_b)local _ab=d_b
local aab=string.rep(c_a[c_b.get("foreground")],#_ab)local bab=c_b.get("syntaxPatterns")
for cab,dab in ipairs(bab)do local _bb=1
while true do
local abb,bbb=_ab:find(dab.pattern,_bb)if not abb then break end;local cbb=bbb-abb+1
if cbb<=0 then
aab=aab:sub(1,abb-1)..
string.rep(c_a[dab.color],1)..aab:sub(abb+1)_bb=abb+1 else
aab=aab:sub(1,abb-1)..string.rep(c_a[dab.color],cbb)..aab:sub(
bbb+1)_bb=bbb+1 end end end;return _ab,aab end
function d_a:render()b_a.render(self)local c_b=self.get("lines")
local d_b=self.get("scrollX")local _ab=self.get("scrollY")local aab=self.get("width")
local bab=self.get("height")local cab=c_a[self.get("foreground")]
local dab=c_a[self.get("background")]
for y=1,bab do local _bb=y+_ab;local abb=c_b[_bb]or""local bbb,cbb=b_b(self,abb)local dbb=bbb:sub(d_b+1,d_b+
aab)local _cb=cbb:sub(d_b+1,d_b+aab)local acb=
aab-#dbb
if acb>0 then dbb=dbb..string.rep(" ",acb)_cb=_cb..
string.rep(c_a[self.get("foreground")],acb)end
self:blit(1,y,dbb,_cb,string.rep(dab,#dbb))end
if self.get("focused")then local _bb=self.get("cursorX")-d_b;local abb=
self.get("cursorY")-_ab;if _bb>=1 and _bb<=aab and abb>=1 and
abb<=bab then
self:setCursor(_bb,abb,true,self.get("cursorColor")or
self.get("foreground"))end end end
function d_a:destroy()
if
self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then self._autoCompleteFrame:destroy()end;self._autoCompleteFrame=nil;self._autoCompleteList=nil
self._autoCompletePopupWidth=nil;b_a.destroy(self)end;return d_a end
project["elements/Button.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")
local ba=require("libraries/utils").getCenteredPosition;local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"text",{default="Button",type="string",canTriggerRender=true})ca.defineEvent(ca,"mouse_click")
ca.defineEvent(ca,"mouse_up")function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",10)da.set("height",3)da.set("z",5)
return da end;function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","Button")end
function ca:render()
aa.render(self)local da=self.get("text")
da=da:sub(1,self.get("width"))
local _b,ab=ba(da,self.get("width"),self.get("height"))
self:textFg(_b,ab,da,self.get("foreground"))end;return ca end
project["elements/Label.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=require("libraries/utils").wrapText
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"text",{default="Label",type="string",canTriggerRender=true,setter=function(da,_b)
if(type(_b)=="function")then _b=_b()end
if(da.get("autoSize"))then da.set("width",#_b)else da.set("height",#
ba(_b,da.get("width")))end;return _b end})
ca.defineProperty(ca,"autoSize",{default=true,type="boolean",canTriggerRender=true,setter=function(da,_b)if(_b)then
da.set("width",#da.get("text"))else
da.set("height",#ba(da.get("text"),da.get("width")))end;return _b end})
function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("z",3)da.set("foreground",colors.black)
da.set("backgroundEnabled",false)return da end
function ca:init(da,_b)aa.init(self,da,_b)if(self.parent)then
self.set("background",self.parent.get("background"))
self.set("foreground",self.parent.get("foreground"))end
self.set("type","Label")return self end;function ca:getWrappedText()local da=self.get("text")
local _b=ba(da,self.get("width"))return _b end
function ca:render()
aa.render(self)local da=self.get("text")
if(self.get("autoSize"))then
self:textFg(1,1,da,self.get("foreground"))else local _b=ba(da,self.get("width"))for ab,bb in ipairs(_b)do
self:textFg(1,ab,bb,self.get("foreground"))end end end;return ca end
project["elements/SideNav.lua"] = function(...) local aa=require("elementManager")
local ba=require("elements/VisualElement")local ca=aa.getElement("Container")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"activeTab",{default=nil,type="number",allowNil=true,canTriggerRender=true,setter=function(ab,bb)
return bb end})
_b.defineProperty(_b,"sidebarWidth",{default=12,type="number",canTriggerRender=true})
_b.defineProperty(_b,"tabs",{default={},type="table"})
_b.defineProperty(_b,"sidebarBackground",{default=colors.gray,type="color",canTriggerRender=true})
_b.defineProperty(_b,"activeTabBackground",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"activeTabTextColor",{default=colors.black,type="color",canTriggerRender=true})
_b.defineProperty(_b,"sidebarScrollOffset",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"sidebarPosition",{default="left",type="string",canTriggerRender=true})_b.defineEvent(_b,"mouse_click")
_b.defineEvent(_b,"mouse_up")_b.defineEvent(_b,"mouse_scroll")function _b.new()
local ab=setmetatable({},_b):__init()ab.class=_b;ab.set("width",30)ab.set("height",15)
ab.set("z",10)return ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","SideNav")end
function _b:newTab(ab)local bb=self.get("tabs")or{}local cb=#bb+1
table.insert(bb,{id=cb,title=tostring(
ab or("Item "..cb))})self.set("tabs",bb)if not self.get("activeTab")then
self.set("activeTab",cb)end;self:updateTabVisibility()
local db=self;local _c={}
setmetatable(_c,{__index=function(ac,bc)
if
type(bc)=="string"and bc:sub(1,3)=="add"and type(db[bc])=="function"then
return
function(dc,...)
local _d=db[bc](db,...)
if _d then _d._tabId=cb;db.set("childrenSorted",false)
db.set("childrenEventsSorted",false)db:updateRender()end;return _d end end;local cc=db[bc]if type(cc)=="function"then
return function(dc,...)return cc(db,...)end end;return cc end})return _c end;_b.addTab=_b.newTab;function _b:setTab(ab,bb)ab._tabId=bb
self:updateTabVisibility()return self end
function _b:addElement(ab,bb)
local cb=ca.addElement(self,ab)local db=bb or self.get("activeTab")if db then cb._tabId=db
self:updateTabVisibility()end;return cb end
function _b:addChild(ab)ca.addChild(self,ab)if not ab._tabId then
local bb=self.get("tabs")or{}
if#bb>0 then ab._tabId=1;self:updateTabVisibility()end end;return self end;function _b:updateTabVisibility()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)end
function _b:setActiveTab(ab)
local bb=self.get("activeTab")if bb==ab then return self end;self.set("activeTab",ab)
self:updateTabVisibility()self:dispatchEvent("tabChanged",ab,bb)return self end
function _b:isChildVisible(ab)
if not ca.isChildVisible(self,ab)then return false end
if ab._tabId then return ab._tabId==self.get("activeTab")end;return true end
function _b:getContentXOffset()local ab=self:_getSidebarMetrics()return ab.sidebarWidth end
function _b:_getSidebarMetrics()local ab=self.get("tabs")or{}
local bb=self.get("height")or 1;local cb=self.get("sidebarWidth")or 12;local db=
self.get("sidebarScrollOffset")or 0
local _c=self.get("sidebarPosition")or"left"local ac={}local bc=1;local cc=#ab
for dc,_d in ipairs(ab)do local ad=1;local bd=bc-db;local cd=0;local dd=0
if bd<1 then cd=1 -bd end;if bd+ad-1 >bb then dd=(bd+ad-1)-bb end
if
bd+ad>1 and bd<=bb then local __a=math.max(1,bd)local a_a=ad-cd-dd
table.insert(ac,{id=_d.id,title=_d.title,y1=__a,y2=__a+a_a-1,height=ad,displayHeight=a_a,actualY=bc,startClip=cd,endClip=dd})end;bc=bc+ad end;return
{sidebarWidth=cb,sidebarPosition=_c,positions=ac,totalHeight=cc,scrollOffset=db,maxScroll=math.max(0,cc-bb)}end
function _b:mouse_click(ab,bb,cb)
if not ba.mouse_click(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self:_getSidebarMetrics()local bc=self.get("width")or 1;local cc=false;if
ac.sidebarPosition=="right"then cc=db> (bc-ac.sidebarWidth)else
cc=db<=ac.sidebarWidth end
if cc then if#ac.positions==0 then
return true end;for dc,_d in ipairs(ac.positions)do
if _c>=_d.y1 and _c<=_d.y2 then
self:setActiveTab(_d.id)self.set("focusedChild",nil)return true end end
return true end;return ca.mouse_click(self,ab,bb,cb)end
function _b:getRelativePosition(ab,bb)local cb=self:_getSidebarMetrics()
local db=self.get("width")or 1
if ab==nil or bb==nil then return ba.getRelativePosition(self)else
local _c,ac=ba.getRelativePosition(self,ab,bb)
if cb.sidebarPosition=="right"then return _c,ac else return _c-cb.sidebarWidth,ac end end end
function _b:multiBlit(ab,bb,cb,db,_c,ac,bc)local cc=self:_getSidebarMetrics()
if
cc.sidebarPosition=="right"then return ca.multiBlit(self,ab,bb,cb,db,_c,ac,bc)else
return ca.multiBlit(self,(ab or 1)+
cc.sidebarWidth,bb,cb,db,_c,ac,bc)end end
function _b:textFg(ab,bb,cb,db)local _c=self:_getSidebarMetrics()
if
_c.sidebarPosition=="right"then return ca.textFg(self,ab,bb,cb,db)else return
ca.textFg(self,(ab or 1)+_c.sidebarWidth,bb,cb,db)end end
function _b:textBg(ab,bb,cb,db)local _c=self:_getSidebarMetrics()
if
_c.sidebarPosition=="right"then return ca.textBg(self,ab,bb,cb,db)else return
ca.textBg(self,(ab or 1)+_c.sidebarWidth,bb,cb,db)end end
function _b:drawText(ab,bb,cb)local db=self:_getSidebarMetrics()
if
db.sidebarPosition=="right"then return ca.drawText(self,ab,bb,cb)else return
ca.drawText(self,(ab or 1)+db.sidebarWidth,bb,cb)end end
function _b:drawFg(ab,bb,cb)local db=self:_getSidebarMetrics()
if
db.sidebarPosition=="right"then return ca.drawFg(self,ab,bb,cb)else return
ca.drawFg(self,(ab or 1)+db.sidebarWidth,bb,cb)end end
function _b:drawBg(ab,bb,cb)local db=self:_getSidebarMetrics()
if
db.sidebarPosition=="right"then return ca.drawBg(self,ab,bb,cb)else return
ca.drawBg(self,(ab or 1)+db.sidebarWidth,bb,cb)end end
function _b:blit(ab,bb,cb,db,_c)local ac=self:_getSidebarMetrics()
if ac.sidebarPosition=="right"then return
ca.blit(self,ab,bb,cb,db,_c)else return
ca.blit(self,(ab or 1)+ac.sidebarWidth,bb,cb,db,_c)end end
function _b:mouse_up(ab,bb,cb)
if not ba.mouse_up(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self:_getSidebarMetrics()local bc=self.get("width")or 1;local cc=false;if
ac.sidebarPosition=="right"then cc=db> (bc-ac.sidebarWidth)else
cc=db<=ac.sidebarWidth end;if cc then return true end;return
ca.mouse_up(self,ab,bb,cb)end
function _b:mouse_release(ab,bb,cb)ba.mouse_release(self,ab,bb,cb)
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.get("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return end;return ca.mouse_release(self,ab,bb,cb)end
function _b:mouse_move(ab,bb,cb)
if ba.mouse_move(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.get("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return true end
local dc={self:getRelativePosition(bb,cb)}
local _d,ad=self:callChildrenEvent(true,"mouse_move",table.unpack(dc))if _d then return true end end;return false end
function _b:mouse_drag(ab,bb,cb)
if ba.mouse_drag(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.get("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return true end;return ca.mouse_drag(self,ab,bb,cb)end;return false end
function _b:scrollSidebar(ab)local bb=self:_getSidebarMetrics()local cb=
self.get("sidebarScrollOffset")or 0;local db=bb.maxScroll or 0;local _c=cb+
(ab*2)_c=math.max(0,math.min(db,_c))
self.set("sidebarScrollOffset",_c)return self end
function _b:mouse_scroll(ab,bb,cb)
if ba.mouse_scroll(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.get("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then self:scrollSidebar(ab)return true end;return
ca.mouse_scroll(self,ab,bb,cb)end;return false end
function _b:setCursor(ab,bb,cb,db)local _c=self:_getSidebarMetrics()
if self.parent then
local ac,bc=self:calculatePosition()local cc,dc
if _c.sidebarPosition=="right"then cc=ab+ac-1;dc=bb+bc-1 else cc=ab+ac-1 +
_c.sidebarWidth;dc=bb+bc-1 end
if

(cc<1)or(cc>self.parent.get("width"))or(dc<1)or(dc>self.parent.get("height"))then return self.parent:setCursor(cc,dc,false)end;return self.parent:setCursor(cc,dc,cb,db)end;return self end
function _b:render()ba.render(self)local ab=self.get("height")
local bb=self:_getSidebarMetrics()local cb=bb.sidebarWidth or 12;for y=1,ab do
ba.multiBlit(self,1,y,cb,1," ",da[self.get("foreground")],da[self.get("sidebarBackground")])end
local db=self.get("activeTab")
for _c,ac in ipairs(bb.positions)do
local bc=
(ac.id==db)and self.get("activeTabBackground")or self.get("sidebarBackground")local cc=(ac.id==db)and self.get("activeTabTextColor")or
self.get("foreground")local dc=
ac.displayHeight or(ac.y2 -ac.y1 +1)for dy=0,dc-1 do
ba.multiBlit(self,1,
ac.y1 +dy,cb,1," ",da[self.get("foreground")],da[bc])end;local _d=ac.title;if#_d>cb-2 then _d=_d:sub(1,
cb-2)end
ba.textFg(self,2,ac.y1,_d,cc)end
if not self.get("childrenSorted")then self:sortChildren()end
if not self.get("childrenEventsSorted")then for _c in pairs(self._values.childrenEvents or
{})do
self:sortChildrenEvents(_c)end end
for _c,ac in ipairs(self.get("visibleChildren")or{})do if ac==self then
error("CIRCULAR REFERENCE DETECTED!")return end;ac:render()ac:postRender()end end
function _b:sortChildrenEvents(ab)
local bb=self._values.childrenEvents and self._values.childrenEvents[ab]
if bb then local cb={}for db,_c in ipairs(bb)do
if self:isChildVisible(_c)then table.insert(cb,_c)end end
for i=2,#cb do local db=cb[i]
local _c=db.get("z")local ac=i-1
while ac>0 do local bc=cb[ac].get("z")if bc>_c then cb[ac+1]=cb[ac]
ac=ac-1 else break end end;cb[ac+1]=db end
self._values.visibleChildrenEvents=self._values.visibleChildrenEvents or{}self._values.visibleChildrenEvents[ab]=cb end;self.set("childrenEventsSorted",true)return self end;return _b end
project["elements/Input.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"text",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"cursorPos",{default=1,type="number"})
aa.defineProperty(aa,"viewOffset",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"maxLength",{default=nil,type="number"})
aa.defineProperty(aa,"placeholder",{default="...",type="string"})
aa.defineProperty(aa,"placeholderColor",{default=colors.gray,type="color"})
aa.defineProperty(aa,"focusedBackground",{default=colors.blue,type="color"})
aa.defineProperty(aa,"focusedForeground",{default=colors.white,type="color"})
aa.defineProperty(aa,"pattern",{default=nil,type="string"})
aa.defineProperty(aa,"cursorColor",{default=nil,type="number"})
aa.defineProperty(aa,"replaceChar",{default=nil,type="string",canTriggerRender=true})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"key")aa.defineEvent(aa,"char")
aa.defineEvent(aa,"paste")
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("width",8)ba.set("z",3)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Input")return self end
function aa:setCursor(ba,ca,da,_b)
ba=math.min(self.get("width"),math.max(1,ba))return d.setCursor(self,ba,ca,da,_b)end
function aa:char(ba)if not self.get("focused")then return false end
local ca=self.get("text")local da=self.get("cursorPos")local _b=self.get("maxLength")
local ab=self.get("pattern")if _b and#ca>=_b then return false end;if ab and not ba:match(ab)then return
false end
self.set("text",ca:sub(1,da-1)..ba..ca:sub(da))self.set("cursorPos",da+1)self:updateViewport()local bb=
self.get("cursorPos")-self.get("viewOffset")
self:setCursor(bb,1,true,
self.get("cursorColor")or self.get("foreground"))d.char(self,ba)return true end
function aa:key(ba,ca)if not self.get("focused")then return false end
local da=self.get("cursorPos")local _b=self.get("text")local ab=self.get("viewOffset")
local bb=self.get("width")
if ba==keys.left then if da>1 then self.set("cursorPos",da-1)
if da-1 <=ab then self.set("viewOffset",math.max(0,
da-2))end end elseif ba==keys.right then if da<=#_b then self.set("cursorPos",
da+1)if da-ab>=bb then
self.set("viewOffset",da-bb+1)end end elseif
ba==keys.backspace then if da>1 then
self.set("text",_b:sub(1,da-2).._b:sub(da))self.set("cursorPos",da-1)self:updateRender()
self:updateViewport()end end
local cb=self.get("cursorPos")-self.get("viewOffset")
self:setCursor(cb,1,true,self.get("cursorColor")or self.get("foreground"))d.key(self,ba,ca)return true end
function aa:mouse_click(ba,ca,da)
if d.mouse_click(self,ba,ca,da)then
local _b,ab=self:getRelativePosition(ca,da)local bb=self.get("text")local cb=self.get("viewOffset")
local db=#bb+1;local _c=math.min(db,cb+_b)self.set("cursorPos",_c)
local ac=_c-cb
self:setCursor(ac,1,true,self.get("cursorColor")or self.get("foreground"))return true end;return false end
function aa:updateViewport()local ba=self.get("width")
local ca=self.get("cursorPos")local da=self.get("viewOffset")
local _b=#self.get("text")
if ca-da>=ba then self.set("viewOffset",ca-ba+1)elseif ca<=da then self.set("viewOffset",
ca-1)end
self.set("viewOffset",math.max(0,math.min(self.get("viewOffset"),_b-ba+1)))return self end
function aa:focus()d.focus(self)
self:setCursor(self.get("cursorPos")-
self.get("viewOffset"),1,true,self.get("cursorColor")or self.get("foreground"))self:updateRender()end
function aa:blur()d.blur(self)
self:setCursor(1,1,false,self.get("cursorColor")or
self.get("foreground"))self:updateRender()end
function aa:paste(ba)if not self.get("focused")then return false end
local ca=self.get("text")local da=self.get("cursorPos")local _b=self.get("maxLength")
local ab=self.get("pattern")local bb=ca:sub(1,da-1)..ba..ca:sub(da)if
_b and#bb>_b then bb=bb:sub(1,_b)end;if ab and not bb:match(ab)then
return false end;self.set("text",bb)
self.set("cursorPos",da+#ba)self:updateViewport()end
function aa:render()local ba=self.get("text")local ca=self.get("viewOffset")
local da=self.get("width")local _b=self.get("placeholder")
local ab=self.get("focusedBackground")local bb=self.get("focusedForeground")
local cb=self.get("focused")local db,_c=self.get("width"),self.get("height")
local ac=self.get("replaceChar")
self:multiBlit(1,1,db,_c," ",_a[cb and bb or self.get("foreground")],_a[
cb and ab or self.get("background")])if
#ba==0 and#_b~=0 and self.get("focused")==false then
self:textFg(1,1,_b:sub(1,db),self.get("placeholderColor"))return end;if(cb)then
self:setCursor(
self.get("cursorPos")-ca,1,true,self.get("cursorColor")or self.get("foreground"))end
local bc=ba:sub(ca+1,ca+db)if ac and#ac>0 then bc=ac:rep(#bc)end
self:textFg(1,1,bc,self.get("foreground"))end;return aa end
project["elements/BigFont.lua"] = function(...) local _b=require("libraries/colorHex")
local ab={{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147","\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132","\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131","\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132","\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32","\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129","\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32","\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32","\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148","\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32","\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32","\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148","\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149","\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32","\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32","\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32","\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132","\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32","\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149","\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32","\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148","\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32","\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32","\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129","\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32","\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32","\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32","\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148","\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32","\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32","\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32","\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132","\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149","\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32","\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32","\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32","\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144","\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149","\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129"},{"000110000110110000110010101000000010000000100101","000000110110000000000010101000000010000000100101","000000000000000000000000000000000000000000000000","100010110100000010000110110000010100000100000110","000000110000000010110110000110000000000000110000","000000000000000000000000000000000000000000000000","000000110110000010000000100000100000000000000010","000000000110110100010000000010000000000000000100","000000000000000000000000000000000000000000000000","010000000000100110000000000000000000000110010000","000000000000000000000000000010000000010110000000","000000000000000000000000000000000000000000000000","011110110000000100100010110000000100000000000000","000000000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110000110110000000000000000000010100100010000000","000010000000000000110110000000000100010010000000","000000000000000000000000000000000000000000000000","010110010110100110110110010000000100000110110110","000000000000000000000110000000000110000000000000","000000000000000000000000000000000000000000000000","010100010110110000000000000000110000000010000000","110110000000000000110000110110100000000010000000","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","100100100100100100100100100100100100100100100100","000000110100110110000010000011110000000000011000","000000000100000000000010000011000110000000001000","000000000000000000000000000000000000000000000000","010000100100000000000000000100000000010010110000","000000000000000000000000000000110110110110110000","000000000000000000000000000000000000000000000000","110110110110110110000000110110110110110110110110","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","000000000000110110000110010000000000000000010010","000010000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110110110110000000000000","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110000000000000000010000","000000000000000000000000100000000000000110000110","000000000000000000000000000000000000000000000000"}}local bb={}local cb={}
do local dc=0;local _d=#ab[1]local ad=#ab[1][1]
for i=1,_d,3 do
for j=1,ad,3 do
local bd=string.char(dc)local cd={}cd[1]=ab[1][i]:sub(j,j+2)
cd[2]=ab[1][i+1]:sub(j,j+2)cd[3]=ab[1][i+2]:sub(j,j+2)local dd={}dd[1]=ab[2][i]:sub(j,
j+2)dd[2]=ab[2][i+1]:sub(j,j+2)dd[3]=ab[2][
i+2]:sub(j,j+2)cb[bd]={cd,dd}dc=dc+1 end end;bb[1]=cb end
local function db(dc,_d)local ad={["0"]="1",["1"]="0"}if dc<=#bb then return true end
for f=#bb+1,dc do local bd={}local cd=bb[
f-1]
for char=0,255 do local dd=string.char(char)local __a={}local a_a={}
local b_a=cd[dd][1]local c_a=cd[dd][2]
for i=1,#b_a do local d_a,_aa,aaa,baa,caa,daa={},{},{},{},{},{}
for j=1,#b_a[1]do
local _ba=cb[b_a[i]:sub(j,j)][1]table.insert(d_a,_ba[1])
table.insert(_aa,_ba[2])table.insert(aaa,_ba[3])
local aba=cb[b_a[i]:sub(j,j)][2]
if c_a[i]:sub(j,j)=="1"then
table.insert(baa,(aba[1]:gsub("[01]",ad)))
table.insert(caa,(aba[2]:gsub("[01]",ad)))
table.insert(daa,(aba[3]:gsub("[01]",ad)))else table.insert(baa,aba[1])
table.insert(caa,aba[2])table.insert(daa,aba[3])end end;table.insert(__a,table.concat(d_a))
table.insert(__a,table.concat(_aa))table.insert(__a,table.concat(aaa))
table.insert(a_a,table.concat(baa))table.insert(a_a,table.concat(caa))
table.insert(a_a,table.concat(daa))end;bd[dd]={__a,a_a}if _d then _d="Font"..f.."Yeld"..char
os.queueEvent(_d)os.pullEvent(_d)end end;bb[f]=bd end;return true end
local function _c(dc,_d,ad,bd,cd)
if not type(_d)=="string"then error("Not a String",3)end
local dd=type(ad)=="string"and ad:sub(1,1)or _b[ad]or
error("Wrong Front Color",3)
local __a=type(bd)=="string"and bd:sub(1,1)or _b[bd]or
error("Wrong Back Color",3)if(bb[dc]==nil)then db(3,false)end;local a_a=bb[dc]or
error("Wrong font size selected",3)if _d==""then
return{{""},{""},{""}}end;local b_a={}
for daa in _d:gmatch('.')do table.insert(b_a,daa)end;local c_a={}local d_a=#a_a[b_a[1]][1]
for nLine=1,d_a do local daa={}for i=1,#b_a do
daa[i]=
a_a[b_a[i]]and a_a[b_a[i]][1][nLine]or""end;c_a[nLine]=table.concat(daa)end;local _aa={}local aaa={}local baa={["0"]=dd,["1"]=__a}local caa={["0"]=__a,["1"]=dd}
for nLine=1,d_a
do local daa={}local _ba={}
for i=1,#b_a do local aba=
a_a[b_a[i]]and a_a[b_a[i]][2][nLine]or""
daa[i]=aba:gsub("[01]",cd and
{["0"]=ad:sub(i,i),["1"]=bd:sub(i,i)}or baa)
_ba[i]=aba:gsub("[01]",
cd and{["0"]=bd:sub(i,i),["1"]=ad:sub(i,i)}or caa)end;_aa[nLine]=table.concat(daa)
aaa[nLine]=table.concat(_ba)end;return{c_a,_aa,aaa}end;local ac=require("elementManager")
local bc=ac.getElement("VisualElement")local cc=setmetatable({},bc)cc.__index=cc
cc.defineProperty(cc,"text",{default="BigFont",type="string",canTriggerRender=true,setter=function(dc,_d)
dc.bigfontText=_c(dc.get("fontSize"),_d,dc.get("foreground"),dc.get("background"))return _d end})
cc.defineProperty(cc,"fontSize",{default=1,type="number",canTriggerRender=true,setter=function(dc,_d)
dc.bigfontText=_c(_d,dc.get("text"),dc.get("foreground"),dc.get("background"))return _d end})function cc.new()local dc=setmetatable({},cc):__init()
dc.class=cc;dc.set("width",16)dc.set("height",3)dc.set("z",5)
return dc end
function cc:init(dc,_d)
bc.init(self,dc,_d)self.set("type","BigFont")
self:observe("background",function(ad,bd)
ad.bigfontText=_c(ad.get("fontSize"),ad.get("text"),ad.get("foreground"),bd)end)
self:observe("foreground",function(ad,bd)
ad.bigfontText=_c(ad.get("fontSize"),ad.get("text"),bd,ad.get("background"))end)end
function cc:render()bc.render(self)
if(self.bigfontText)then
local dc,_d=self.get("x"),self.get("y")
for i=1,#self.bigfontText[1]do
local ad=self.bigfontText[1][i]:sub(1,self.get("width"))
local bd=self.bigfontText[2][i]:sub(1,self.get("width"))
local cd=self.bigfontText[3][i]:sub(1,self.get("width"))self:blit(dc,_d+i-1,ad,bd,cd)end end end;return cc end
project["elements/Switch.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"checked",{default=false,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"text",{default="",type="string",canTriggerRender=true})
ca.defineProperty(ca,"autoSize",{default=false,type="boolean"})
ca.defineProperty(ca,"onBackground",{default=colors.green,type="number",canTriggerRender=true})
ca.defineProperty(ca,"offBackground",{default=colors.red,type="number",canTriggerRender=true})ca.defineEvent(ca,"mouse_click")
ca.defineEvent(ca,"mouse_up")
function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",2)da.set("height",1)da.set("z",5)
da.set("backgroundEnabled",true)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Switch")end
function ca:mouse_click(da,_b,ab)if aa.mouse_click(self,da,_b,ab)then
self.set("checked",not self.get("checked"))return true end;return false end
function ca:render()local da=self.get("checked")local _b=self.get("text")
local ab=self.get("width")local bb=self.get("height")local cb=da and self.get("onBackground")or
self.get("offBackground")
self:multiBlit(1,1,ab,bb," ",ba[self.get("foreground")],ba[cb])local db=math.floor(ab/2)local _c=da and(ab-db+1)or 1
self:multiBlit(_c,1,db,bb," ",ba[self.get("foreground")],ba[self.get("background")])if _b~=""then
self:textFg(ab+2,1,_b,self.get("foreground"))end end;return ca end
project["elements/Frame.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=_a.getElement("Container")local ca=setmetatable({},ba)
ca.__index=ca
ca.defineProperty(ca,"draggable",{default=false,type="boolean",setter=function(da,_b)
if _b then da:listenEvent("mouse_click",true)
da:listenEvent("mouse_up",true)da:listenEvent("mouse_drag",true)end;return _b end})
ca.defineProperty(ca,"draggingMap",{default={{x=1,y=1,width="width",height=1}},type="table"})
ca.defineProperty(ca,"scrollable",{default=false,type="boolean",setter=function(da,_b)if _b then
da:listenEvent("mouse_scroll",true)end;return _b end})
function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",12)da.set("height",6)
da.set("background",colors.gray)da.set("z",10)return da end;function ca:init(da,_b)ba.init(self,da,_b)self.set("type","Frame")
return self end
function ca:mouse_click(da,_b,ab)
if
aa.mouse_click(self,da,_b,ab)then
if self.get("draggable")then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.get("draggingMap")
for _c,ac in ipairs(db)do local bc=ac.width or 1;local cc=ac.height or 1;if
type(bc)=="string"and bc=="width"then bc=self.get("width")elseif
type(bc)=="function"then bc=bc(self)end
if type(cc)==
"string"and cc=="height"then cc=self.get("height")elseif
type(cc)=="function"then cc=cc(self)end;local dc=ac.y or 1
if
bb>=ac.x and bb<=ac.x+bc-1 and cb>=dc and cb<=dc+cc-1 then
self.dragStartX=_b-self.get("x")self.dragStartY=ab-self.get("y")self.dragging=true
return true end end end;return ba.mouse_click(self,da,_b,ab)end;return false end
function ca:mouse_up(da,_b,ab)if self.dragging then self.dragging=false;self.dragStartX=nil
self.dragStartY=nil;return true end;return
ba.mouse_up(self,da,_b,ab)end
function ca:mouse_drag(da,_b,ab)
if self.get("clicked")and self.dragging then
local bb=_b-self.dragStartX;local cb=ab-self.dragStartY;self.set("x",bb)
self.set("y",cb)return true end
if not self.dragging then return ba.mouse_drag(self,da,_b,ab)end;return false end
function ca:getChildrenHeight()local da=0;local _b=self.get("children")
for ab,bb in ipairs(_b)do if
bb.get("visible")then local cb=bb.get("y")local db=bb.get("height")local _c=cb+db-1
if _c>da then da=_c end end end;return da end
function ca:mouse_scroll(da,_b,ab)if ba.mouse_scroll(self,da,_b,ab)then return true end
if
self.get("scrollable")then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.get("width")local _c=self.get("height")
if
bb>=1 and bb<=db and cb>=1 and cb<=_c then local ac=self:getChildrenHeight()
local bc=self.get("offsetY")local cc=math.max(0,ac-_c)local dc=bc+da
dc=math.max(0,math.min(cc,dc))self.set("offsetY",dc)return true end end;return false end;return ca end
project["elements/Container.lua"] = function(...) local da=require("elementManager")
local _b=require("errorManager")local ab=da.getElement("VisualElement")
local bb=require("libraries/expect")local cb=require("libraries/utils").split
local db=setmetatable({},ab)db.__index=db
db.defineProperty(db,"children",{default={},type="table"})
db.defineProperty(db,"childrenSorted",{default=true,type="boolean"})
db.defineProperty(db,"childrenEventsSorted",{default=true,type="boolean"})
db.defineProperty(db,"childrenEvents",{default={},type="table"})
db.defineProperty(db,"eventListenerCount",{default={},type="table"})
db.defineProperty(db,"focusedChild",{default=nil,type="table",allowNil=true,setter=function(bc,cc,dc)local _d=bc._values.focusedChild
if cc==_d then return cc end
if _d then
if _d:isType("Container")then _d.set("focusedChild",nil,true)end;_d.set("focused",false,true)end
if cc and not dc then cc.set("focused",true,true)if bc.parent then
bc.parent:setFocusedChild(bc)end end;return cc end})
db.defineProperty(db,"visibleChildren",{default={},type="table"})
db.defineProperty(db,"visibleChildrenEvents",{default={},type="table"})
db.defineProperty(db,"offsetX",{default=0,type="number",canTriggerRender=true,setter=function(bc,cc)bc.set("childrenSorted",false)
bc.set("childrenEventsSorted",false)return cc end})
db.defineProperty(db,"offsetY",{default=0,type="number",canTriggerRender=true,setter=function(bc,cc)bc.set("childrenSorted",false)
bc.set("childrenEventsSorted",false)return cc end})
db.combineProperties(db,"offset","offsetX","offsetY")
for bc,cc in pairs(da:getElementList())do
local dc=bc:sub(1,1):upper()..bc:sub(2)
if dc~="BaseFrame"then
db["add"..dc]=function(_d,...)bb(1,_d,"table")
local ad=_d.basalt.create(bc,...)_d:addChild(ad)ad:postInit()return ad end
db["addDelayed"..dc]=function(_d,ad)bb(1,_d,"table")
local bd=_d.basalt.create(bc,ad,true,_d)return bd end end end;function db.new()local bc=setmetatable({},db):__init()
bc.class=db;return bc end
function db:init(bc,cc)
ab.init(self,bc,cc)self.set("type","Container")
self:observe("width",function()
self.set("childrenSorted",false)self.set("childrenEventsSorted",false)end)
self:observe("height",function()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)end)end
function db:isChildVisible(bc)
if not bc:isType("VisualElement")then return false end;if(bc.get("visible")==false)then return false end;if(bc._destroyed)then return
false end
local cc,dc=self.get("width"),self.get("height")local _d,ad=self.get("offsetX"),self.get("offsetY")
local bd,cd=bc.get("x"),bc.get("y")local dd,__a=bc.get("width"),bc.get("height")local a_a;local b_a;if
(bc.get("ignoreOffset"))then a_a=bd;b_a=cd else a_a=bd-_d;b_a=cd-ad end;return

(a_a+dd>0)and(a_a<=cc)and(b_a+__a>0)and(b_a<=dc)end
function db:addChild(bc)
if bc==self then error("Cannot add container to itself")end;if(bc~=nil)then table.insert(self._values.children,bc)
bc.parent=self;bc:postInit()self.set("childrenSorted",false)
self:registerChildrenEvents(bc)end;return
self end
local function _c(bc,cc)local dc={}for _d,ad in ipairs(cc)do
if bc:isChildVisible(ad)and ad.get("visible")and not
ad._destroyed then table.insert(dc,ad)end end
for i=2,#dc do
local _d=dc[i]local ad=_d.get("z")local bd=i-1
while bd>0 do local cd=dc[bd].get("z")if cd>ad then
dc[bd+1]=dc[bd]bd=bd-1 else break end end;dc[bd+1]=_d end;return dc end
function db:clear()self.set("children",{})
self.set("childrenEvents",{})self.set("visibleChildren",{})
self.set("visibleChildrenEvents",{})self.set("childrenSorted",true)
self.set("childrenEventsSorted",true)return self end
function db:sortChildren()
self.set("visibleChildren",_c(self,self._values.children))self.set("childrenSorted",true)return self end
function db:sortChildrenEvents(bc)if self._values.childrenEvents[bc]then
self._values.visibleChildrenEvents[bc]=_c(self,self._values.childrenEvents[bc])end
self.set("childrenEventsSorted",true)return self end
function db:registerChildrenEvents(bc)if(bc._registeredEvents==nil)then return end
for cc in
pairs(bc._registeredEvents)do self:registerChildEvent(bc,cc)end;return self end
function db:registerChildEvent(bc,cc)
if not self._values.childrenEvents[cc]then
self._values.childrenEvents[cc]={}self._values.eventListenerCount[cc]=0;if self.parent then
self.parent:registerChildEvent(self,cc)end end
for dc,_d in ipairs(self._values.childrenEvents[cc])do if _d.get("id")==
bc.get("id")then return self end end;self.set("childrenEventsSorted",false)
table.insert(self._values.childrenEvents[cc],bc)self._values.eventListenerCount[cc]=
self._values.eventListenerCount[cc]+1;return self end
function db:removeChildrenEvents(bc)
if bc~=nil then
if(bc._registeredEvents==nil)then return self end;for cc in pairs(bc._registeredEvents)do
self:unregisterChildEvent(bc,cc)end end;return self end
function db:unregisterChildEvent(bc,cc)
if self._values.childrenEvents[cc]then
for dc,_d in
ipairs(self._values.childrenEvents[cc])do
if _d.get("id")==bc.get("id")then
table.remove(self._values.childrenEvents[cc],dc)self._values.eventListenerCount[cc]=
self._values.eventListenerCount[cc]-1
if
self._values.eventListenerCount[cc]<=0 then
self._values.childrenEvents[cc]=nil;self._values.eventListenerCount[cc]=nil;if self.parent then
self.parent:unregisterChildEvent(self,cc)end end;self.set("childrenEventsSorted",false)
self:updateRender()break end end end;return self end
function db:removeChild(bc)if bc==nil then return self end
for cc,dc in ipairs(self._values.children)do if
dc.get("id")==bc.get("id")then
table.remove(self._values.children,cc)bc.parent=nil;break end end;self:removeChildrenEvents(bc)self:updateRender()
self.set("childrenSorted",false)return self end
function db:getChild(bc)
if type(bc)=="string"then local cc=cb(bc,"/")
for dc,_d in
pairs(self._values.children)do if _d.get("name")==cc[1]then
if#cc==1 then return _d else if(_d:isType("Container"))then return
_d:find(table.concat(cc,"/",2))end end end end end;return nil end
local function ac(bc,cc,...)local dc={...}
if cc and cc:find("mouse_")then local _d,ad,bd=...
local cd,dd=bc.get("offsetX"),bc.get("offsetY")local __a,a_a=bc:getRelativePosition(ad+cd,bd+dd)
dc={_d,__a,a_a}end;return dc end
function db:callChildrenEvent(bc,cc,...)local dc=bc and self.get("visibleChildrenEvents")or
self.get("childrenEvents")
if
dc[cc]then local _d=dc[cc]for i=#_d,1,-1 do local ad=_d[i]
if(ad:dispatchEvent(cc,...))then return true,ad end end end
if(dc["*"])then local _d=dc["*"]for i=#_d,1,-1 do local ad=_d[i]
if(ad:dispatchEvent(cc,...))then return true,ad end end end;return false end
function db:handleEvent(bc,...)ab.handleEvent(self,bc,...)local cc=ac(self,bc,...)return
self:callChildrenEvent(false,bc,table.unpack(cc))end
function db:mouse_click(bc,cc,dc)
if ab.mouse_click(self,bc,cc,dc)then
local _d=ac(self,"mouse_click",bc,cc,dc)
local ad,bd=self:callChildrenEvent(true,"mouse_click",table.unpack(_d))
if(ad)then self.set("focusedChild",bd)return true end;self.set("focusedChild",nil)return true end;return false end
function db:mouse_up(bc,cc,dc)
if ab.mouse_up(self,bc,cc,dc)then local _d=ac(self,"mouse_up",bc,cc,dc)
local ad,bd=self:callChildrenEvent(true,"mouse_up",table.unpack(_d))if(ad)then return true end end;return false end
function db:mouse_release(bc,cc,dc)ab.mouse_release(self,bc,cc,dc)
local _d=ac(self,"mouse_release",bc,cc,dc)
self:callChildrenEvent(false,"mouse_release",table.unpack(_d))end
function db:mouse_move(bc,cc,dc)
if ab.mouse_move(self,bc,cc,dc)then
local _d=ac(self,"mouse_move",bc,cc,dc)
local ad,bd=self:callChildrenEvent(true,"mouse_move",table.unpack(_d))if(ad)then return true end end;return false end
function db:mouse_drag(bc,cc,dc)
if ab.mouse_drag(self,bc,cc,dc)then
local _d=ac(self,"mouse_drag",bc,cc,dc)
local ad,bd=self:callChildrenEvent(true,"mouse_drag",table.unpack(_d))if(ad)then return true end end;return false end
function db:mouse_scroll(bc,cc,dc)
if(ab.mouse_scroll(self,bc,cc,dc))then
local _d=ac(self,"mouse_scroll",bc,cc,dc)
local ad,bd=self:callChildrenEvent(true,"mouse_scroll",table.unpack(_d))return ad end;return false end;function db:key(bc)if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key",bc)end
return true end
function db:char(bc)if
self.get("focusedChild")then
return self.get("focusedChild"):dispatchEvent("char",bc)end;return true end;function db:key_up(bc)
if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key_up",bc)end;return true end
function db:multiBlit(bc,cc,dc,_d,ad,bd,cd)
local dd,__a=self.get("width"),self.get("height")dc=bc<1 and math.min(dc+bc-1,dd)or
math.min(dc,math.max(0,dd-bc+1))_d=cc<1 and math.min(
_d+cc-1,__a)or
math.min(_d,math.max(0,__a-cc+1))if dc<=0 or
_d<=0 then return self end
ab.multiBlit(self,math.max(1,bc),math.max(1,cc),dc,_d,ad,bd,cd)return self end
function db:textFg(bc,cc,dc,_d)local ad,bd=self.get("width"),self.get("height")if
cc<1 or cc>bd then return self end;local cd=bc<1 and(2 -bc)or 1
local dd=math.min(#dc-
cd+1,ad-math.max(1,bc)+1)if dd<=0 then return self end
ab.textFg(self,math.max(1,bc),math.max(1,cc),dc:sub(cd,cd+dd-1),_d)return self end
function db:textBg(bc,cc,dc,_d)local ad,bd=self.get("width"),self.get("height")if
cc<1 or cc>bd then return self end;local cd=bc<1 and(2 -bc)or 1
local dd=math.min(#dc-
cd+1,ad-math.max(1,bc)+1)if dd<=0 then return self end
ab.textBg(self,math.max(1,bc),math.max(1,cc),dc:sub(cd,cd+dd-1),_d)return self end
function db:drawText(bc,cc,dc)local _d,ad=self.get("width"),self.get("height")if cc<1 or
cc>ad then return self end;local bd=bc<1 and(2 -bc)or 1
local cd=math.min(
#dc-bd+1,_d-math.max(1,bc)+1)if cd<=0 then return self end
ab.drawText(self,math.max(1,bc),math.max(1,cc),dc:sub(bd,bd+cd-1))return self end
function db:drawFg(bc,cc,dc)local _d,ad=self.get("width"),self.get("height")if
cc<1 or cc>ad then return self end;local bd=bc<1 and(2 -bc)or 1
local cd=math.min(#dc-
bd+1,_d-math.max(1,bc)+1)if cd<=0 then return self end
ab.drawFg(self,math.max(1,bc),math.max(1,cc),dc:sub(bd,bd+cd-1))return self end
function db:drawBg(bc,cc,dc)local _d,ad=self.get("width"),self.get("height")if
cc<1 or cc>ad then return self end;local bd=bc<1 and(2 -bc)or 1
local cd=math.min(#dc-
bd+1,_d-math.max(1,bc)+1)if cd<=0 then return self end
ab.drawBg(self,math.max(1,bc),math.max(1,cc),dc:sub(bd,bd+cd-1))return self end
function db:blit(bc,cc,dc,_d,ad)local bd,cd=self.get("width"),self.get("height")if
cc<1 or cc>cd then return self end;local dd=bc<1 and(2 -bc)or 1
local __a=math.min(#dc-
dd+1,bd-math.max(1,bc)+1)
local a_a=math.min(#_d-dd+1,bd-math.max(1,bc)+1)
local b_a=math.min(#ad-dd+1,bd-math.max(1,bc)+1)if __a<=0 then return self end;local c_a=dc:sub(dd,dd+__a-1)local d_a=_d:sub(dd,
dd+a_a-1)local _aa=ad:sub(dd,dd+b_a-1)
ab.blit(self,math.max(1,bc),math.max(1,cc),c_a,d_a,_aa)return self end
function db:render()ab.render(self)if not self.get("childrenSorted")then
self:sortChildren()end
if
not self.get("childrenEventsSorted")then for bc in pairs(self._values.childrenEvents)do
self:sortChildrenEvents(bc)end end;for bc,cc in ipairs(self.get("visibleChildren"))do if cc==self then
_b.error("CIRCULAR REFERENCE DETECTED!")return end;cc:render()
cc:postRender()end end
function db:destroy()
if not self:isType("BaseFrame")then
for bc,cc in
ipairs(self._values.children)do if cc.destroy then cc:destroy()end end;self:removeAllObservers()ab.destroy(self)return self else
_b.header="Basalt Error"_b.error("Cannot destroy a BaseFrame.")end end;return db end
project["elements/Tree.lua"] = function(...) local aa=require("elements/VisualElement")local ba=string.sub
local ca=require("libraries/colorHex")local da=setmetatable({},aa)da.__index=da
da.defineProperty(da,"nodes",{default={},type="table",canTriggerRender=true,setter=function(ab,bb)if#bb>0 then
ab.get("expandedNodes")[bb[1]]=true end;return bb end})
da.defineProperty(da,"selectedNode",{default=nil,type="table",canTriggerRender=true})
da.defineProperty(da,"expandedNodes",{default={},type="table",canTriggerRender=true})
da.defineProperty(da,"scrollOffset",{default=0,type="number",canTriggerRender=true})
da.defineProperty(da,"horizontalOffset",{default=0,type="number",canTriggerRender=true})
da.defineProperty(da,"selectedForegroundColor",{default=colors.white,type="color"})
da.defineProperty(da,"selectedBackgroundColor",{default=colors.lightBlue,type="color"})da.defineEvent(da,"mouse_click")
da.defineEvent(da,"mouse_scroll")function da.new()local ab=setmetatable({},da):__init()
ab.class=da;ab.set("width",30)ab.set("height",10)ab.set("z",5)
return ab end
function da:init(ab,bb)
aa.init(self,ab,bb)self.set("type","Tree")return self end;function da:expandNode(ab)self.get("expandedNodes")[ab]=true
self:updateRender()return self end
function da:collapseNode(ab)self.get("expandedNodes")[ab]=
nil;self:updateRender()return self end;function da:toggleNode(ab)if self.get("expandedNodes")[ab]then
self:collapseNode(ab)else self:expandNode(ab)end
return self end
local function _b(ab,bb,cb,db)db=db or{}cb=
cb or 0;for _c,ac in ipairs(ab)do table.insert(db,{node=ac,level=cb})
if
bb[ac]and ac.children then _b(ac.children,bb,cb+1,db)end end;return db end
function da:mouse_click(ab,bb,cb)
if aa.mouse_click(self,ab,bb,cb)then
local db,_c=self:getRelativePosition(bb,cb)
local ac=_b(self.get("nodes"),self.get("expandedNodes"))local bc=_c+self.get("scrollOffset")
if ac[bc]then local cc=ac[bc]
local dc=cc.node
if db<=cc.level*2 +2 then self:toggleNode(dc)end;self.set("selectedNode",dc)
self:fireEvent("node_select",dc)end;return true end;return false end
function da:onSelect(ab)self:registerCallback("node_select",ab)return self end
function da:mouse_scroll(ab,bb,cb)
if aa.mouse_scroll(self,ab,bb,cb)then
local db=_b(self.get("nodes"),self.get("expandedNodes"))
local _c=math.max(0,#db-self.get("height"))
local ac=math.min(_c,math.max(0,self.get("scrollOffset")+ab))self.set("scrollOffset",ac)return true end;return false end
function da:getNodeSize()local ab,bb=0,0
local cb=_b(self.get("nodes"),self.get("expandedNodes"))for db,_c in ipairs(cb)do
ab=math.max(ab,_c.level+#_c.node.text)end;bb=#cb;return ab,bb end
function da:render()aa.render(self)
local ab=_b(self.get("nodes"),self.get("expandedNodes"))local bb=self.get("height")local cb=self.get("selectedNode")
local db=self.get("expandedNodes")local _c=self.get("scrollOffset")
local ac=self.get("horizontalOffset")
for y=1,bb do local bc=ab[y+_c]
if bc then local cc=bc.node;local dc=bc.level
local _d=string.rep("  ",dc)local ad=" "if cc.children and#cc.children>0 then
ad=db[cc]and"\31"or"\16"end;local bd=cc==cb
local cd=bd and
self.get("selectedBackgroundColor")or
(cc.background or cc.bg or self.get("background"))
local dd=bd and self.get("selectedForegroundColor")or(
cc.foreground or cc.fg or self.get("foreground"))
local __a=_d..ad.." ".. (cc.text or"Node")local a_a=ba(__a,ac+1,ac+self.get("width"))
local b_a=a_a..string.rep(" ",
self.get("width")-#a_a)
local c_a=ca[cd]:rep(#b_a)or ca[colors.black]:rep(#b_a)
local d_a=ca[dd]:rep(#b_a)or ca[colors.white]:rep(#b_a)self:blit(1,y,b_a,d_a,c_a)else
self:blit(1,y,string.rep(" ",self.get("width")),ca[self.get("foreground")]:rep(self.get("width")),ca[self.get("background")]:rep(self.get("width")))end end end;return da end
project["elements/DropDown.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"isOpen",{default=false,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"dropdownHeight",{default=5,type="number"})
ca.defineProperty(ca,"selectedText",{default="",type="string"})
ca.defineProperty(ca,"dropSymbol",{default="\31",type="string"})function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",16)da.set("height",1)da.set("z",8)
return da end
function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","DropDown")return self end
function ca:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
if cb==1 then self.set("isOpen",not
self.get("isOpen"))if
not self.get("isOpen")then self.set("height",1)else
self.set("height",1 +math.min(self.get("dropdownHeight"),#
self.get("items")))end
return true elseif
self.get("isOpen")and cb>1 and self.get("selectable")then local db=(cb-1)+self.get("offset")
local _c=self.get("items")
if db<=#_c then local ac=_c[db]
if type(ac)=="string"then ac={text=ac}_c[db]=ac end
if not self.get("multiSelection")then for bc,cc in ipairs(_c)do if type(cc)=="table"then
cc.selected=false end end end;ac.selected=not ac.selected
if ac.callback then ac.callback(self)end;self:fireEvent("select",db,ac)
self.set("isOpen",false)self.set("height",1)self:updateRender()return true end end;return false end
function ca:render()_a.render(self)local da=self.get("selectedText")
local _b=self:getSelectedItems()if#_b>0 then local ab=_b[1]da=ab.text or""
da=da:sub(1,self.get("width")-2)end
self:blit(1,1,da..string.rep(" ",self.get("width")-#
da-1).. (
self.get("isOpen")and"\31"or"\17"),string.rep(ba[self.get("foreground")],self.get("width")),string.rep(ba[self.get("background")],self.get("width")))
if self.get("isOpen")then local ab=self.get("items")
local bb=self.get("height")-1;local cb=self.get("offset")local db=self.get("width")
for i=1,bb do local _c=i+cb
local ac=ab[_c]
if ac then if type(ac)=="string"then ac={text=ac}ab[_c]=ac end
if
ac.separator then local bc=(ac.text or"-"):sub(1,1)
local cc=string.rep(bc,db)local dc=ac.foreground or self.get("foreground")local _d=
ac.background or self.get("background")self:textBg(1,
i+1,string.rep(" ",db),_d)
self:textFg(1,i+1,cc,dc)else local bc=ac.text;local cc=ac.selected;bc=bc:sub(1,db)
local dc=cc and(ac.selectedBackground or
self.get("selectedBackground"))or(ac.background or
self.get("background"))
local _d=
cc and(ac.selectedForeground or self.get("selectedForeground"))or(ac.foreground or self.get("foreground"))self:textBg(1,i+1,string.rep(" ",db),dc)self:textFg(1,
i+1,bc,_d)end end end end end;return ca end
project["elements/Display.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")
local da=require("libraries/utils").getCenteredPosition;local _b=require("libraries/utils").deepcopy
local ab=require("libraries/colorHex")local bb=setmetatable({},ca)bb.__index=bb;function bb.new()
local cb=setmetatable({},bb):__init()cb.class=bb;cb.set("width",25)cb.set("height",8)
cb.set("z",5)return cb end
function bb:init(cb,db)
ca.init(self,cb,db)self.set("type","Display")
self._window=window.create(db.getActiveFrame():getTerm(),1,1,self.get("width"),self.get("height"),false)local _c=self._window.reposition;local ac=self._window.blit
local bc=self._window.write
self._window.reposition=function(cc,dc,_d,ad)self.set("x",cc)self.set("y",dc)
self.set("width",_d)self.set("height",ad)_c(1,1,_d,ad)end
self._window.getPosition=function(cc)return cc.get("x"),cc.get("y")end
self._window.setVisible=function(cc)self.set("visible",cc)end
self._window.isVisible=function(cc)return cc.get("visible")end
self._window.blit=function(cc,dc,_d,ad,bd)ac(cc,dc,_d,ad,bd)self:updateRender()end
self._window.write=function(cc,dc,_d)bc(cc,dc,_d)self:updateRender()end
self:observe("width",function(cc,dc)local _d=cc._window;if _d then
_d.reposition(1,1,dc,cc.get("height"))end end)
self:observe("height",function(cc,dc)local _d=cc._window;if _d then
_d.reposition(1,1,cc.get("width"),dc)end end)end;function bb:getWindow()return self._window end
function bb:write(cb,db,_c,ac,bc)local cc=self._window
if cc then if ac then
cc.setTextColor(ac)end;if bc then cc.setBackgroundColor(bc)end
cc.setCursorPos(cb,db)cc.write(_c)end;self:updateRender()return self end
function bb:render()ca.render(self)local cb=self._window;local db,_c=cb.getSize()
if cb then for y=1,_c do
local ac,bc,cc=cb.getLine(y)self:blit(1,y,ac,bc,cc)end end end;return bb end
project["elements/LineChart.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=ba.getElement("Graph")
local _b=require("libraries/colorHex")local ab=setmetatable({},da)ab.__index=ab;function ab.new()
local cb=setmetatable({},ab):__init()cb.class=ab;return cb end
function ab:init(cb,db)
da.init(self,cb,db)self.set("type","LineChart")return self end
local function bb(cb,db,_c,ac,bc,cc,dc,_d)local ad=ac-db;local bd=bc-_c
local cd=math.max(math.abs(ad),math.abs(bd))
for i=0,cd do local dd=cd==0 and 0 or i/cd
local __a=math.floor(db+ad*dd)local a_a=math.floor(_c+bd*dd)
if

__a>=1 and __a<=cb.get("width")and a_a>=1 and a_a<=cb.get("height")then cb:blit(__a,a_a,cc,_b[dc],_b[_d])end end end
function ab:render()ca.render(self)local cb=self.get("width")
local db=self.get("height")local _c=self.get("minValue")local ac=self.get("maxValue")
local bc=self.get("series")
for cc,dc in pairs(bc)do
if(dc.visible)then local _d,ad;local bd=#dc.data
local cd=(cb-1)/math.max((bd-1),1)
for dd,__a in ipairs(dc.data)do local a_a=math.floor(( (dd-1)*cd)+1)local b_a=
(__a-_c)/ (ac-_c)
local c_a=math.floor(db- (b_a* (db-1)))c_a=math.max(1,math.min(c_a,db))if _d then
bb(self,_d,ad,a_a,c_a,dc.symbol,dc.bgColor,dc.fgColor)end;_d,ad=a_a,c_a end end end end;return ab end
project["elements/Graph.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"minValue",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"maxValue",{default=100,type="number",canTriggerRender=true})
ca.defineProperty(ca,"series",{default={},type="table",canTriggerRender=true})function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;return da end;function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","Graph")self.set("width",20)
self.set("height",10)return self end
function ca:addSeries(da,_b,ab,bb,cb)
local db=self.get("series")
table.insert(db,{name=da,symbol=_b or" ",bgColor=ab or colors.white,fgColor=bb or colors.black,pointCount=cb or self.get("width"),data={},visible=true})self:updateRender()return self end
function ca:removeSeries(da)local _b=self.get("series")for ab,bb in ipairs(_b)do if bb.name==da then
table.remove(_b,ab)break end end
self:updateRender()return self end
function ca:getSeries(da)local _b=self.get("series")for ab,bb in ipairs(_b)do
if bb.name==da then return bb end end;return nil end
function ca:changeSeriesVisibility(da,_b)local ab=self.get("series")for bb,cb in ipairs(ab)do if cb.name==da then
cb.visible=_b;break end end
self:updateRender()return self end
function ca:addPoint(da,_b)local ab=self.get("series")
for bb,cb in ipairs(ab)do if cb.name==da then
table.insert(cb.data,_b)
while#cb.data>cb.pointCount do table.remove(cb.data,1)end;break end end;self:updateRender()return self end
function ca:focusSeries(da)local _b=self.get("series")
for ab,bb in ipairs(_b)do if bb.name==da then
table.remove(_b,ab)table.insert(_b,bb)break end end;self:updateRender()return self end
function ca:setSeriesPointCount(da,_b)local ab=self.get("series")
for bb,cb in ipairs(ab)do if cb.name==da then
cb.pointCount=_b;while#cb.data>_b do table.remove(cb.data,1)end
break end end;self:updateRender()return self end
function ca:clear(da)local _b=self.get("series")
if da then for ab,bb in ipairs(_b)do
if bb.name==da then bb.data={}break end end else for ab,bb in ipairs(_b)do bb.data={}end end;return self end
function ca:render()aa.render(self)local da=self.get("width")
local _b=self.get("height")local ab=self.get("minValue")local bb=self.get("maxValue")
local cb=self.get("series")
for db,_c in pairs(cb)do
if(_c.visible)then local ac=#_c.data
local bc=(da-1)/math.max((ac-1),1)
for cc,dc in ipairs(_c.data)do local _d=math.floor(( (cc-1)*bc)+1)local ad=
(dc-ab)/ (bb-ab)
local bd=math.floor(_b- (ad* (_b-1)))bd=math.max(1,math.min(bd,_b))
self:blit(_d,bd,_c.symbol,ba[_c.bgColor],ba[_c.fgColor])end end end end;return ca end
project["elements/FlexBox.lua"] = function(...) local da=require("elementManager")
local _b=da.getElement("Container")local ab=setmetatable({},_b)ab.__index=ab
ab.defineProperty(ab,"flexDirection",{default="row",type="string"})
ab.defineProperty(ab,"flexSpacing",{default=1,type="number"})
ab.defineProperty(ab,"flexJustifyContent",{default="flex-start",type="string",setter=function(bc,cc)if not cc:match("^flex%-")then
cc="flex-"..cc end;return cc end})
ab.defineProperty(ab,"flexAlignItems",{default="flex-start",type="string",setter=function(bc,cc)if
not cc:match("^flex%-")and cc~="stretch"then cc="flex-"..cc end;return cc end})
ab.defineProperty(ab,"flexCrossPadding",{default=0,type="number"})
ab.defineProperty(ab,"flexWrap",{default=false,type="boolean"})
ab.defineProperty(ab,"flexUpdateLayout",{default=false,type="boolean"})
local bb={getHeight=function(bc)return 0 end,getWidth=function(bc)return 0 end,getZ=function(bc)return 1 end,getPosition=function(bc)return 0,0 end,getSize=function(bc)return 0,0 end,isType=function(bc)return
false end,getType=function(bc)return"lineBreak"end,getName=function(bc)return"lineBreak"end,setPosition=function(bc)
end,setParent=function(bc)end,setSize=function(bc)end,getFlexGrow=function(bc)return 0 end,getFlexShrink=function(bc)return 0 end,getFlexBasis=function(bc)return 0 end,init=function(bc)end,getVisible=function(bc)return
true end}
local function cb(bc,cc,dc,_d)local ad={}local bd={}local cd=0
for __a,a_a in pairs(bc.get("children"))do if a_a.get("visible")then
table.insert(bd,a_a)if a_a~=bb then cd=cd+1 end end end;if cd==0 then return ad end
if not _d then ad[1]={offset=1}
for __a,a_a in ipairs(bd)do if a_a==bb then local b_a=#ad+1;if
ad[b_a]==nil then ad[b_a]={offset=1}end else
table.insert(ad[#ad],a_a)end end else
local __a=cc=="row"and bc.get("width")or bc.get("height")local a_a={{}}local b_a=1
for c_a,d_a in ipairs(bd)do if d_a==bb then b_a=b_a+1;a_a[b_a]={}else
table.insert(a_a[b_a],d_a)end end
for c_a,d_a in ipairs(a_a)do
if#d_a==0 then ad[#ad+1]={offset=1}else local _aa={}local aaa={}local baa=0
for caa,daa in ipairs(d_a)do
local _ba=0
local aba=cc=="row"and daa.get("width")or daa.get("height")local bba=false
if cc=="row"then
local _ca,aca=pcall(function()return daa.get("intrinsicWidth")end)if _ca and aca then _ba=aca;bba=true end else
local _ca,aca=pcall(function()
return daa.get("intrinsicHeight")end)if _ca and aca then _ba=aca;bba=true end end;local cba=bba and _ba or aba;local dba=cba;if#aaa>0 then dba=dba+dc end
if
baa+dba<=__a or#aaa==0 then table.insert(aaa,daa)
baa=baa+dba else table.insert(_aa,aaa)aaa={daa}baa=cba end end;if#aaa>0 then table.insert(_aa,aaa)end;for caa,daa in ipairs(_aa)do
ad[#ad+1]={offset=1}
for _ba,aba in ipairs(daa)do table.insert(ad[#ad],aba)end end end end end;local dd={}
for __a,a_a in ipairs(ad)do if#a_a>0 then table.insert(dd,a_a)end end;return dd end
local function db(bc,cc,dc,_d)local ad={}
for dca,_da in ipairs(cc)do if _da~=bb then table.insert(ad,_da)end end;if#ad==0 then return end;local bd=bc.get("width")
local cd=bc.get("height")local dd=bc.get("flexAlignItems")
local __a=bc.get("flexCrossPadding")local a_a=bc.get("flexWrap")if bd<=0 then return end;local b_a=cd- (__a*2)if b_a<
1 then b_a=cd;__a=0 end;local c_a=math.max;local d_a=math.min
local _aa=math.floor;local aaa=math.ceil;local baa=0;local caa=0;local daa={}local _ba={}local aba={}
for dca,_da in ipairs(ad)do local ada=
_da.get("flexGrow")or 0
local bda=_da.get("flexShrink")or 0;local cda=_da.get("width")_ba[_da]=ada;aba[_da]=bda;daa[_da]=cda;if
ada>0 then caa=caa+ada else baa=baa+cda end end;local bba=#ad;local cba=(bba>1)and( (bba-1)*dc)or 0;local dba=
bd-baa-cba
if dba>0 and caa>0 then
for dca,_da in ipairs(ad)do local ada=_ba[_da]if ada>0 then
local bda=daa[_da]local cda=_aa((ada/caa)*dba)
_da.set("width",c_a(cda,1))end end elseif dba<0 then local dca=0;local _da={}for ada,bda in ipairs(ad)do local cda=aba[bda]if cda>0 then dca=dca+cda
table.insert(_da,bda)end end
if
dca>0 and#_da>0 then local ada=-dba;for bda,cda in ipairs(_da)do local dda=cda.get("width")
local __b=aba[cda]local a_b=__b/dca;local b_b=aaa(ada*a_b)
cda.set("width",c_a(1,dda-b_b))end end;baa=0
for ada,bda in ipairs(ad)do baa=baa+bda.get("width")end
if caa>0 then local ada={}local bda=0
for cda,dda in ipairs(ad)do if _ba[dda]>0 then table.insert(ada,dda)bda=bda+
dda.get("width")end end
if#ada>0 and bda>0 then local cda=c_a(_aa(bd*0.2),#ada)
local dda=d_a(cda,bd-cba)
for __b,a_b in ipairs(ada)do local b_b=_ba[a_b]local c_b=b_b/caa
local d_b=c_a(1,_aa(dda*c_b))a_b.set("width",d_b)end end end end;local _ca=1
for dca,_da in ipairs(ad)do _da.set("x",_ca)
if not a_a then
if dd=="stretch"then
_da.set("height",b_a)_da.set("y",1 +__a)else local bda=_da.get("height")local cda=1;if
dd=="flex-end"then cda=cd-bda+1 elseif dd=="flex-center"or dd=="center"then cda=
_aa((cd-bda)/2)+1 end
_da.set("y",c_a(1,cda))end end
local ada=_da.get("y")+_da.get("height")-1;if
ada>cd and(_da.get("flexShrink")or 0)>0 then
_da.set("height",c_a(1,cd-_da.get("y")+1))end;_ca=
_ca+_da.get("width")+dc end;local aca=ad[#ad]local bca=0;if aca then
bca=aca.get("x")+aca.get("width")-1 end;local cca=bd-bca
if cca>0 then
if _d=="flex-end"then for dca,_da in ipairs(ad)do _da.set("x",
_da.get("x")+cca)end elseif _d==
"flex-center"or _d=="center"then local dca=_aa(cca/2)for _da,ada in ipairs(ad)do ada.set("x",
ada.get("x")+dca)end end end end
local function _c(bc,cc,dc,_d)local ad={}
for dca,_da in ipairs(cc)do if _da~=bb then table.insert(ad,_da)end end;if#ad==0 then return end;local bd=bc.get("width")
local cd=bc.get("height")local dd=bc.get("flexAlignItems")
local __a=bc.get("flexCrossPadding")local a_a=bc.get("flexWrap")if cd<=0 then return end;local b_a=bd- (__a*2)if b_a<
1 then b_a=bd;__a=0 end;local c_a=math.max;local d_a=math.min
local _aa=math.floor;local aaa=math.ceil;local baa=0;local caa=0;local daa={}local _ba={}local aba={}
for dca,_da in ipairs(ad)do local ada=
_da.get("flexGrow")or 0
local bda=_da.get("flexShrink")or 0;local cda=_da.get("height")_ba[_da]=ada;aba[_da]=bda;daa[_da]=cda;if
ada>0 then caa=caa+ada else baa=baa+cda end end;local bba=#ad;local cba=(bba>1)and( (bba-1)*dc)or 0;local dba=
cd-baa-cba
if dba>0 and caa>0 then
for dca,_da in ipairs(ad)do local ada=_ba[_da]if ada>0 then
local bda=daa[_da]local cda=_aa((ada/caa)*dba)
_da.set("height",c_a(cda,1))end end elseif dba<0 then local dca=0;local _da={}for ada,bda in ipairs(ad)do local cda=aba[bda]if cda>0 then dca=dca+cda
table.insert(_da,bda)end end
if
dca>0 and#_da>0 then local ada=-dba
for bda,cda in ipairs(_da)do local dda=cda.get("height")
local __b=aba[cda]local a_b=__b/dca;local b_b=aaa(ada*a_b)
cda.set("height",c_a(1,dda-b_b))end end;baa=0
for ada,bda in ipairs(ad)do baa=baa+bda.get("height")end
if caa>0 then local ada={}local bda=0
for cda,dda in ipairs(ad)do if _ba[dda]>0 then table.insert(ada,dda)bda=bda+
dda.get("height")end end
if#ada>0 and bda>0 then local cda=c_a(_aa(cd*0.2),#ada)
local dda=d_a(cda,cd-cba)
for __b,a_b in ipairs(ada)do local b_b=_ba[a_b]local c_b=b_b/caa
local d_b=c_a(1,_aa(dda*c_b))a_b.set("height",d_b)end end end end;local _ca=1
for dca,_da in ipairs(ad)do _da.set("y",_ca)
if not a_a then
if dd=="stretch"then
_da.set("width",b_a)_da.set("x",1 +__a)else local bda=_da.get("width")local cda=1;if
dd=="flex-end"then cda=bd-bda+1 elseif dd=="flex-center"or dd=="center"then cda=
_aa((bd-bda)/2)+1 end
_da.set("x",c_a(1,cda))end end
local ada=_da.get("x")+_da.get("width")-1;if
ada>bd and(_da.get("flexShrink")or 0)>0 then
_da.set("width",c_a(1,bd-_da.get("x")+1))end;_ca=
_ca+_da.get("height")+dc end;local aca=ad[#ad]local bca=0;if aca then
bca=aca.get("y")+aca.get("height")-1 end;local cca=cd-bca
if cca>0 then
if _d=="flex-end"then for dca,_da in ipairs(ad)do _da.set("y",
_da.get("y")+cca)end elseif _d==
"flex-center"or _d=="center"then local dca=_aa(cca/2)for _da,ada in ipairs(ad)do ada.set("y",
ada.get("y")+dca)end end end end
local function ac(bc,cc,dc,_d,ad)
if bc.get("width")<=0 or bc.get("height")<=0 then return end
cc=(cc=="row"or cc=="column")and cc or"row"local bd,cd=bc.get("width"),bc.get("height")
local dd=
bd~=bc._lastLayoutWidth or cd~=bc._lastLayoutHeight;bc._lastLayoutWidth=bd;bc._lastLayoutHeight=cd
if
ad and dd and(bd>bc._lastLayoutWidth or
cd>bc._lastLayoutHeight)then
for b_a,c_a in pairs(bc.get("children"))do
if
c_a~=bb and c_a:getVisible()and
c_a.get("flexGrow")and c_a.get("flexGrow")>0 then
if cc=="row"then
local d_a,_aa=pcall(function()return c_a.get("intrinsicWidth")end)if d_a and _aa then c_a.set("width",_aa)end else
local d_a,_aa=pcall(function()return
c_a.get("intrinsicHeight")end)if d_a and _aa then c_a.set("height",_aa)end end end end end;local __a=cb(bc,cc,dc,ad)if#__a==0 then return end
local a_a=cc=="row"and db or _c
if cc=="row"and ad then local b_a=1
for c_a,d_a in ipairs(__a)do
if#d_a>0 then for aaa,baa in ipairs(d_a)do if baa~=bb then
baa.set("y",b_a)end end;a_a(bc,d_a,dc,_d)
local _aa=0;for aaa,baa in ipairs(d_a)do if baa~=bb then
_aa=math.max(_aa,baa.get("height"))end end;if c_a<
#__a then b_a=b_a+_aa+dc else b_a=b_a+_aa end end end elseif cc=="column"and ad then local b_a=1
for c_a,d_a in ipairs(__a)do
if#d_a>0 then for aaa,baa in ipairs(d_a)do if baa~=bb then
baa.set("x",b_a)end end;a_a(bc,d_a,dc,_d)
local _aa=0;for aaa,baa in ipairs(d_a)do
if baa~=bb then _aa=math.max(_aa,baa.get("width"))end end;if c_a<#__a then b_a=b_a+_aa+dc else b_a=
b_a+_aa end end end else for b_a,c_a in ipairs(__a)do a_a(bc,c_a,dc,_d)end end;bc:sortChildren()
bc.set("childrenEventsSorted",false)bc.set("flexUpdateLayout",false)end
function ab.new()local bc=setmetatable({},ab):__init()
bc.class=ab;bc.set("width",12)bc.set("height",6)
bc.set("background",colors.blue)bc.set("z",10)bc._lastLayoutWidth=0;bc._lastLayoutHeight=0
bc:observe("width",function()
bc.set("flexUpdateLayout",true)end)
bc:observe("height",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexDirection",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexSpacing",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexWrap",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexJustifyContent",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexAlignItems",function()bc.set("flexUpdateLayout",true)end)
bc:observe("flexCrossPadding",function()bc.set("flexUpdateLayout",true)end)return bc end;function ab:init(bc,cc)_b.init(self,bc,cc)self.set("type","FlexBox")
return self end
function ab:addChild(bc)
_b.addChild(self,bc)
if(bc~=bb)then
bc:instanceProperty("flexGrow",{default=0,type="number"})
bc:instanceProperty("flexShrink",{default=0,type="number"})
bc:instanceProperty("flexBasis",{default=0,type="number"})
bc:instanceProperty("intrinsicWidth",{default=bc.get("width"),type="number"})
bc:instanceProperty("intrinsicHeight",{default=bc.get("height"),type="number"})
bc:observe("flexGrow",function()self.set("flexUpdateLayout",true)end)
bc:observe("flexShrink",function()self.set("flexUpdateLayout",true)end)
bc:observe("width",function(cc,dc,_d)if bc.get("flexGrow")==0 then
bc.set("intrinsicWidth",dc)end
self.set("flexUpdateLayout",true)end)
bc:observe("height",function(cc,dc,_d)if bc.get("flexGrow")==0 then
bc.set("intrinsicHeight",dc)end
self.set("flexUpdateLayout",true)end)end;self.set("flexUpdateLayout",true)return self end
function ab:removeChild(bc)_b.removeChild(self,bc)
if(bc~=bb)then bc.setFlexGrow=nil;bc.setFlexShrink=
nil;bc.setFlexBasis=nil;bc.getFlexGrow=nil;bc.getFlexShrink=nil;bc.getFlexBasis=
nil;bc.set("flexGrow",nil)
bc.set("flexShrink",nil)bc.set("flexBasis",nil)end;self.set("flexUpdateLayout",true)return self end;function ab:addLineBreak()self:addChild(bb)return self end
function ab:render()
if
(self.get("flexUpdateLayout"))then
ac(self,self.get("flexDirection"),self.get("flexSpacing"),self.get("flexJustifyContent"),self.get("flexWrap"))end;_b.render(self)end;return ab end
project["elements/Table.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"columns",{default={},type="table",canTriggerRender=true,setter=function(ba,ca)local da={}
for _b,ab in
ipairs(ca)do
if type(ab)=="string"then da[_b]={name=ab,width=#ab+1}elseif type(ab)=="table"then
da[_b]={name=
ab.name or"",width=ab.width,minWidth=ab.minWidth or 3,maxWidth=ab.maxWidth or nil}end end;return da end})
aa.defineProperty(aa,"data",{default={},type="table",canTriggerRender=true,setter=function(ba,ca)ba.set("scrollOffset",0)
ba.set("selectedRow",nil)ba.set("sortColumn",nil)
ba.set("sortDirection","asc")return ca end})
aa.defineProperty(aa,"selectedRow",{default=nil,type="number",canTriggerRender=true})
aa.defineProperty(aa,"headerColor",{default=colors.blue,type="color"})
aa.defineProperty(aa,"selectedColor",{default=colors.lightBlue,type="color"})
aa.defineProperty(aa,"gridColor",{default=colors.gray,type="color"})
aa.defineProperty(aa,"sortColumn",{default=nil,type="number",canTriggerRender=true})
aa.defineProperty(aa,"sortDirection",{default="asc",type="string",canTriggerRender=true})
aa.defineProperty(aa,"scrollOffset",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"customSortFunction",{default={},type="table"})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"mouse_scroll")function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("width",30)ba.set("height",10)ba.set("z",5)
return ba end
function aa:init(ba,ca)
d.init(self,ba,ca)self.set("type","Table")return self end
function aa:addColumn(ba,ca)local da=self.get("columns")
table.insert(da,{name=ba,width=ca})self.set("columns",da)return self end;function aa:addData(...)local ba=self.get("data")table.insert(ba,{...})
self.set("data",ba)return self end
function aa:setColumnSortFunction(ba,ca)
local da=self.get("customSortFunction")da[ba]=ca;self.set("customSortFunction",da)return self end
function aa:setFormattedData(ba,ca)local da={}for _b,ab in ipairs(ba)do local bb={}for cb,db in ipairs(ab)do bb[cb]=db end;if ca and
ca[_b]then bb._sortValues=ca[_b]end
table.insert(da,bb)end
self.set("data",da)return self end
function aa:setData(ba,ca)if not ca then self.set("data",ba)return self end
local da={}
for _b,ab in ipairs(ba)do local bb={}for cb,db in ipairs(ab)do
if ca[cb]then bb[cb]=ca[cb](db)else bb[cb]=db end end;table.insert(da,bb)end;return self:setFormattedData(da,ba)end
function aa:calculateColumnWidths(ba,ca)local da={}local _b=ca;local ab={}local bb=0
for db,_c in ipairs(ba)do
da[db]={name=_c.name,width=_c.width,minWidth=_c.minWidth or 3,maxWidth=_c.maxWidth}
if type(_c.width)=="number"then
da[db].visibleWidth=math.max(_c.width,da[db].minWidth)if da[db].maxWidth then
da[db].visibleWidth=math.min(da[db].visibleWidth,da[db].maxWidth)end
_b=_b-da[db].visibleWidth;bb=bb+da[db].visibleWidth elseif type(_c.width)=="string"and
_c.width:match("%%$")then
local ac=tonumber(_c.width:match("(%d+)%%"))
if ac then da[db].visibleWidth=math.floor(ca*ac/100)
da[db].visibleWidth=math.max(da[db].visibleWidth,da[db].minWidth)if da[db].maxWidth then
da[db].visibleWidth=math.min(da[db].visibleWidth,da[db].maxWidth)end
_b=_b-da[db].visibleWidth;bb=bb+da[db].visibleWidth else table.insert(ab,db)end else table.insert(ab,db)end end
if#ab>0 and _b>0 then local db=math.floor(_b/#ab)
for _c,ac in ipairs(ab)do
da[ac].visibleWidth=math.max(db,da[ac].minWidth)if da[ac].maxWidth then
da[ac].visibleWidth=math.min(da[ac].visibleWidth,da[ac].maxWidth)end end end;local cb=0
for db,_c in ipairs(da)do cb=cb+ (_c.visibleWidth or 0)end;if cb>ca then local db=ca/cb
for _c,ac in ipairs(da)do if ac.visibleWidth then
ac.visibleWidth=math.max(1,math.floor(ac.visibleWidth*db))end end end
return da end
function aa:sortData(ba,ca)local da=self.get("data")
local _b=self.get("sortDirection")local ab=self.get("customSortFunction")local bb=ca or ab[ba]
if bb then
table.sort(da,function(cb,db)return
bb(cb,db,_b)end)else
table.sort(da,function(cb,db)if not cb or not db then return false end;local _c,ac
if cb._sortValues and
cb._sortValues[ba]then _c=cb._sortValues[ba]else _c=cb[ba]end;if db._sortValues and db._sortValues[ba]then ac=db._sortValues[ba]else
ac=db[ba]end
if type(_c)=="number"and
type(ac)=="number"then if _b=="asc"then return _c<ac else return _c>ac end else local bc=tostring(
_c or"")local cc=tostring(ac or"")if _b=="asc"then
return bc<cc else return bc>cc end end end)end;return self end
function aa:mouse_click(ba,ca,da)
if not d.mouse_click(self,ba,ca,da)then return false end;local _b,ab=self:getRelativePosition(ca,da)
if ab==1 then
local bb=self.get("columns")local cb=self.get("width")
local db=self:calculateColumnWidths(bb,cb)local _c=1
for ac,bc in ipairs(db)do
local cc=bc.visibleWidth or bc.width or 10
if _b>=_c and _b<_c+cc then
if self.get("sortColumn")==ac then
self.set("sortDirection",
self.get("sortDirection")=="asc"and"desc"or"asc")else self.set("sortColumn",ac)
self.set("sortDirection","asc")end;self:sortData(ac)break end;_c=_c+cc end end
if ab>1 then local bb=ab-2 +self.get("scrollOffset")if bb>=0 and bb<#
self.get("data")then
self.set("selectedRow",bb+1)end end;return true end
function aa:mouse_scroll(ba,ca,da)
if(d.mouse_scroll(self,ba,ca,da))then local _b=self.get("data")
local ab=self.get("height")local bb=ab-2;local cb=math.max(0,#_b-bb-1)
local db=math.min(cb,math.max(0,
self.get("scrollOffset")+ba))self.set("scrollOffset",db)return true end;return false end
function aa:render()d.render(self)local ba=self.get("columns")
local ca=self.get("data")local da=self.get("selectedRow")
local _b=self.get("sortColumn")local ab=self.get("scrollOffset")local bb=self.get("height")
local cb=self.get("width")local db=self:calculateColumnWidths(ba,cb)local _c=0;local ac=#db;for cc,dc in
ipairs(db)do if _c+dc.visibleWidth>cb then ac=cc-1;break end
_c=_c+dc.visibleWidth end;local bc=1
for cc,dc in ipairs(db)do
if cc>ac then break end;local _d=dc.name;if cc==_b then
_d=_d.. (
self.get("sortDirection")=="asc"and"\30"or"\31")end
self:textFg(bc,1,_d:sub(1,dc.visibleWidth),self.get("headerColor"))bc=bc+dc.visibleWidth end
for y=2,bb do local cc=y-2 +ab;local dc=ca[cc+1]
if dc and(cc+1)<=#ca then bc=1
local _d=(cc+1)==da and
self.get("selectedColor")or self.get("background")
for ad,bd in ipairs(db)do if ad>ac then break end;local cd=tostring(dc[ad]or"")local dd=cd..string.rep(" ",
bd.visibleWidth-#cd)if
ad<ac then
dd=string.sub(dd,1,bd.visibleWidth-1).." "end
local __a=string.sub(dd,1,bd.visibleWidth)
local a_a=string.rep(_a[self.get("foreground")],bd.visibleWidth)local b_a=string.rep(_a[_d],bd.visibleWidth)
self:blit(bc,y,__a,a_a,b_a)bc=bc+bd.visibleWidth end else
self:blit(1,y,string.rep(" ",self.get("width")),string.rep(_a[self.get("foreground")],self.get("width")),string.rep(_a[self.get("background")],self.get("width")))end end end;return aa end
project["elements/Menu.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"separatorColor",{default=colors.gray,type="color"})
function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",30)da.set("height",1)
da.set("background",colors.gray)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Menu")return self end
function ca:setItems(da)local _b={}local ab=0
for bb,cb in ipairs(da)do
if cb.separator then
table.insert(_b,{text=cb.text or"|",selectable=false})ab=ab+1 else local db=" "..cb.text.." "cb.text=db
table.insert(_b,cb)ab=ab+#db end end;self.set("width",ab)return aa.setItems(self,_b)end
function ca:render()_a.render(self)local da=1
for _b,ab in ipairs(self.get("items"))do if type(ab)==
"string"then ab={text=" "..ab.." "}
self.get("items")[_b]=ab end;local bb=ab.selected
local cb=
ab.selectable==false and self.get("separatorColor")or(bb and(ab.selectedForeground or
self.get("selectedForeground"))or(ab.foreground or
self.get("foreground")))
local db=
bb and(ab.selectedBackground or self.get("selectedBackground"))or(ab.background or self.get("background"))
self:blit(da,1,ab.text,string.rep(ba[cb],#ab.text),string.rep(ba[db],#ab.text))da=da+#ab.text end end
function ca:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end
if(self.get("selectable")==false)then return false end
local bb=select(1,self:getRelativePosition(_b,ab))local cb=1
for db,_c in ipairs(self.get("items"))do
if
bb>=cb and bb<cb+#_c.text then
if _c.selectable~=false then if type(_c)=="string"then _c={text=_c}
self.get("items")[db]=_c end
if
not self.get("multiSelection")then for ac,bc in ipairs(self.get("items"))do
if type(bc)=="table"then bc.selected=false end end end;_c.selected=not _c.selected
if _c.callback then _c.callback(self)end;self:fireEvent("select",db,_c)end;return true end;cb=cb+#_c.text end;return false end;return ca end
project["elements/Slider.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"step",{default=1,type="number",canTriggerRender=true})
aa.defineProperty(aa,"max",{default=100,type="number"})
aa.defineProperty(aa,"horizontal",{default=true,type="boolean",canTriggerRender=true,setter=function(ba,ca)if ca then ba.set("backgroundEnabled",false)else
ba.set("backgroundEnabled",true)end end})
aa.defineProperty(aa,"barColor",{default=colors.gray,type="color",canTriggerRender=true})
aa.defineProperty(aa,"sliderColor",{default=colors.blue,type="color",canTriggerRender=true})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"mouse_drag")aa.defineEvent(aa,"mouse_up")
aa.defineEvent(aa,"mouse_scroll")
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("width",8)ba.set("height",1)
ba.set("backgroundEnabled",false)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Slider")end
function aa:getValue()local ba=self.get("step")local ca=self.get("max")
local da=
self.get("horizontal")and self.get("width")or self.get("height")return math.floor((ba-1)* (ca/ (da-1)))end
function aa:mouse_click(ba,ca,da)
if self:isInBounds(ca,da)then
local _b,ab=self:getRelativePosition(ca,da)
local bb=self.get("horizontal")and _b or ab;local cb=self.get("horizontal")and self.get("width")or
self.get("height")
self.set("step",math.min(cb,math.max(1,bb)))self:updateRender()return true end;return false end;aa.mouse_drag=aa.mouse_click
function aa:mouse_scroll(ba,ca,da)
if self:isInBounds(ca,da)then
local _b=self.get("step")local ab=self.get("horizontal")and self.get("width")or
self.get("height")
self.set("step",math.min(ab,math.max(1,
_b+ba)))self:updateRender()return true end;return false end
function aa:render()d.render(self)local ba=self.get("width")
local ca=self.get("height")local da=self.get("horizontal")local _b=self.get("step")local ab=
da and"\140"or" "
local bb=string.rep(ab,da and ba or ca)
if da then self:textFg(1,1,bb,self.get("barColor"))
self:textBg(_b,1," ",self.get("sliderColor"))else local cb=self.get("background")
for y=1,ca do self:textBg(1,y," ",cb)end
self:textBg(1,_b," ",self.get("sliderColor"))end end;return aa end
project["elements/ScrollBar.lua"] = function(...) local aa=require("elements/VisualElement")
local ba=require("libraries/colorHex")local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"value",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"min",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"max",{default=100,type="number",canTriggerRender=true})
ca.defineProperty(ca,"step",{default=10,type="number"})
ca.defineProperty(ca,"dragMultiplier",{default=1,type="number"})
ca.defineProperty(ca,"symbol",{default=" ",type="string",canTriggerRender=true})
ca.defineProperty(ca,"symbolColor",{default=colors.gray,type="color",canTriggerRender=true})
ca.defineProperty(ca,"symbolBackgroundColor",{default=colors.black,type="color",canTriggerRender=true})
ca.defineProperty(ca,"backgroundSymbol",{default="\127",type="string",canTriggerRender=true})
ca.defineProperty(ca,"attachedElement",{default=nil,type="table"})
ca.defineProperty(ca,"attachedProperty",{default=nil,type="string"})
ca.defineProperty(ca,"minValue",{default=0,type="number"})
ca.defineProperty(ca,"maxValue",{default=100,type="number"})
ca.defineProperty(ca,"orientation",{default="vertical",type="string",canTriggerRender=true})
ca.defineProperty(ca,"handleSize",{default=2,type="number",canTriggerRender=true})ca.defineEvent(ca,"mouse_click")
ca.defineEvent(ca,"mouse_release")ca.defineEvent(ca,"mouse_drag")
ca.defineEvent(ca,"mouse_scroll")
function ca.new()local ab=setmetatable({},ca):__init()
ab.class=ca;ab.set("width",1)ab.set("height",10)return ab end;function ca:init(ab,bb)aa.init(self,ab,bb)self.set("type","ScrollBar")return
self end
function ca:attach(ab,bb)
self.set("attachedElement",ab)self.set("attachedProperty",bb.property)self.set("minValue",
bb.min or 0)
self.set("maxValue",bb.max or 100)
ab:observe(bb.property,function(cb,db)
if db then local _c=self.get("minValue")
local ac=self.get("maxValue")if _c==ac then return end
self.set("value",math.floor((db-_c)/ (ac-_c)*100 +0.5))end end)return self end
function ca:updateAttachedElement()local ab=self.get("attachedElement")
if not ab then return end;local bb=self.get("value")local cb=self.get("minValue")
local db=self.get("maxValue")if type(cb)=="function"then cb=cb()end;if type(db)=="function"then
db=db()end;local _c=cb+ (bb/100)* (db-cb)ab.set(self.get("attachedProperty"),math.floor(
_c+0.5))
return self end;local function da(ab)
return
ab.get("orientation")=="vertical"and ab.get("height")or ab.get("width")end
local function _b(ab,bb,cb)
local db,_c=ab:getRelativePosition(bb,cb)return
ab.get("orientation")=="vertical"and _c or db end
function ca:mouse_click(ab,bb,cb)
if aa.mouse_click(self,ab,bb,cb)then local db=da(self)
local _c=self.get("value")local ac=self.get("handleSize")local bc=
math.floor((_c/100)* (db-ac))+1;local cc=_b(self,bb,cb)
if
cc>=bc and cc<bc+ac then self.dragOffset=cc-bc else local dc=( (cc-1)/ (db-ac))*100
self.set("value",math.min(100,math.max(0,dc)))self:updateAttachedElement()end;return true end end
function ca:mouse_drag(ab,bb,cb)
if(aa.mouse_drag(self,ab,bb,cb))then local db=da(self)
local _c=self.get("handleSize")local ac=self.get("dragMultiplier")local bc=_b(self,bb,cb)
bc=math.max(1,math.min(db,bc))local cc=bc- (self.dragOffset or 0)local dc=
(cc-1)/ (db-_c)*100 *ac
self.set("value",math.min(100,math.max(0,dc)))self:updateAttachedElement()return true end end
function ca:mouse_scroll(ab,bb,cb)
if not self:isInBounds(bb,cb)then return false end;ab=ab>0 and-1 or 1;local db=self.get("step")
local _c=self.get("value")local ac=_c-ab*db
self.set("value",math.min(100,math.max(0,ac)))self:updateAttachedElement()return true end
function ca:render()aa.render(self)local ab=da(self)local bb=self.get("value")
local cb=self.get("handleSize")local db=self.get("symbol")local _c=self.get("symbolColor")
local ac=self.get("symbolBackgroundColor")local bc=self.get("backgroundSymbol")local cc=self.get("orientation")==
"vertical"local dc=
math.floor((bb/100)* (ab-cb))+1
for i=1,ab do
if cc then
self:blit(1,i,bc,ba[self.get("foreground")],ba[self.get("background")])else
self:blit(i,1,bc,ba[self.get("foreground")],ba[self.get("background")])end end
for i=dc,dc+cb-1 do if cc then self:blit(1,i,db,ba[_c],ba[ac])else
self:blit(i,1,db,ba[_c],ba[ac])end end end;return ca end
project["elements/VisualElement.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("BaseElement")local da=require("libraries/colorHex")
local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"x",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"y",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"z",{default=1,type="number",canTriggerRender=true,setter=function(cb,db)
if cb.parent then cb.parent:sortChildren()end;return db end})
_b.defineProperty(_b,"width",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"height",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"background",{default=colors.black,type="color",canTriggerRender=true})
_b.defineProperty(_b,"foreground",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"clicked",{default=false,type="boolean"})
_b.defineProperty(_b,"hover",{default=false,type="boolean"})
_b.defineProperty(_b,"backgroundEnabled",{default=true,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderTop",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderBottom",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderLeft",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderRight",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderColor",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"focused",{default=false,type="boolean",setter=function(cb,db,_c)local ac=cb.get("focused")
if db==ac then return db end;if db then cb:focus()else cb:blur()end;if not _c and cb.parent then
if db then
cb.parent:setFocusedChild(cb)else cb.parent:setFocusedChild(nil)end end;return db end})
_b.defineProperty(_b,"visible",{default=true,type="boolean",canTriggerRender=true,setter=function(cb,db)
if(cb.parent~=nil)then
cb.parent.set("childrenSorted",false)cb.parent.set("childrenEventsSorted",false)end;if(db==false)then cb.set("clicked",false)end;return db end})
_b.defineProperty(_b,"ignoreOffset",{default=false,type="boolean"})_b.combineProperties(_b,"position","x","y")
_b.combineProperties(_b,"size","width","height")
_b.combineProperties(_b,"color","foreground","background")_b.defineEvent(_b,"focus")
_b.defineEvent(_b,"blur")
_b.registerEventCallback(_b,"Click","mouse_click","mouse_up")
_b.registerEventCallback(_b,"ClickUp","mouse_up","mouse_click")
_b.registerEventCallback(_b,"Drag","mouse_drag","mouse_click","mouse_up")
_b.registerEventCallback(_b,"Scroll","mouse_scroll")
_b.registerEventCallback(_b,"Enter","mouse_enter","mouse_move")
_b.registerEventCallback(_b,"LeEave","mouse_leave","mouse_move")_b.registerEventCallback(_b,"Focus","focus","blur")
_b.registerEventCallback(_b,"Blur","blur","focus")_b.registerEventCallback(_b,"Key","key","key_up")
_b.registerEventCallback(_b,"Char","char")_b.registerEventCallback(_b,"KeyUp","key_up","key")
local ab,bb=math.max,math.min;function _b.new()local cb=setmetatable({},_b):__init()
cb.class=_b;return cb end
function _b:init(cb,db)
ca.init(self,cb,db)self.set("type","VisualElement")
self:observe("x",function()if self.parent then
self.parent.set("childrenSorted",false)end end)
self:observe("y",function()if self.parent then
self.parent.set("childrenSorted",false)end end)
self:observe("width",function()if self.parent then
self.parent.set("childrenSorted",false)end end)
self:observe("height",function()if self.parent then
self.parent.set("childrenSorted",false)end end)
self:observe("visible",function()if self.parent then
self.parent.set("childrenSorted",false)end end)end
function _b:multiBlit(cb,db,_c,ac,bc,cc,dc)local _d,ad=self:calculatePosition()cb=cb+_d-1
db=db+ad-1;self.parent:multiBlit(cb,db,_c,ac,bc,cc,dc)end
function _b:textFg(cb,db,_c,ac)local bc,cc=self:calculatePosition()cb=cb+bc-1
db=db+cc-1;self.parent:textFg(cb,db,_c,ac)end
function _b:textBg(cb,db,_c,ac)local bc,cc=self:calculatePosition()cb=cb+bc-1
db=db+cc-1;self.parent:textBg(cb,db,_c,ac)end
function _b:drawText(cb,db,_c)local ac,bc=self:calculatePosition()cb=cb+ac-1
db=db+bc-1;self.parent:drawText(cb,db,_c)end
function _b:drawFg(cb,db,_c)local ac,bc=self:calculatePosition()cb=cb+ac-1
db=db+bc-1;self.parent:drawFg(cb,db,_c)end
function _b:drawBg(cb,db,_c)local ac,bc=self:calculatePosition()cb=cb+ac-1
db=db+bc-1;self.parent:drawBg(cb,db,_c)end
function _b:blit(cb,db,_c,ac,bc)local cc,dc=self:calculatePosition()cb=cb+cc-1
db=db+dc-1;self.parent:blit(cb,db,_c,ac,bc)end
function _b:isInBounds(cb,db)local _c,ac=self.get("x"),self.get("y")
local bc,cc=self.get("width"),self.get("height")if(self.get("ignoreOffset"))then
if(self.parent)then
cb=cb-self.parent.get("offsetX")db=db-self.parent.get("offsetY")end end;return
cb>=_c and cb<=
_c+bc-1 and db>=ac and db<=ac+cc-1 end
function _b:mouse_click(cb,db,_c)if self:isInBounds(db,_c)then self.set("clicked",true)
self:fireEvent("mouse_click",cb,self:getRelativePosition(db,_c))return true end;return
false end
function _b:mouse_up(cb,db,_c)if self:isInBounds(db,_c)then self.set("clicked",false)
self:fireEvent("mouse_up",cb,self:getRelativePosition(db,_c))return true end;return
false end
function _b:mouse_release(cb,db,_c)
self:fireEvent("mouse_release",cb,self:getRelativePosition(db,_c))self.set("clicked",false)end
function _b:mouse_move(cb,db,_c)if(db==nil)or(_c==nil)then return false end
local ac=self.get("hover")
if(self:isInBounds(db,_c))then if(not ac)then self.set("hover",true)
self:fireEvent("mouse_enter",self:getRelativePosition(db,_c))end;return true else if(ac)then
self.set("hover",false)
self:fireEvent("mouse_leave",self:getRelativePosition(db,_c))end end;return false end
function _b:mouse_scroll(cb,db,_c)if(self:isInBounds(db,_c))then
self:fireEvent("mouse_scroll",cb,self:getRelativePosition(db,_c))return true end;return false end
function _b:mouse_drag(cb,db,_c)if(self.get("clicked"))then
self:fireEvent("mouse_drag",cb,self:getRelativePosition(db,_c))return true end;return false end;function _b:focus()self:fireEvent("focus")end;function _b:blur()
self:fireEvent("blur")
pcall(function()
self:setCursor(1,1,false,self.get and self.get("foreground"))end)end
function _b:addBorder(cb,db)
local _c=nil;local ac=nil
if type(cb)=="table"and
(cb.color or cb.top~=nil or cb.left~=nil)then _c=cb.color;ac=cb else _c=cb;ac=db end
if ac then
if ac.top~=nil then self.set("borderTop",ac.top)end
if ac.bottom~=nil then self.set("borderBottom",ac.bottom)end
if ac.left~=nil then self.set("borderLeft",ac.left)end
if ac.right~=nil then self.set("borderRight",ac.right)end else self.set("borderTop",true)
self.set("borderBottom",true)self.set("borderLeft",true)
self.set("borderRight",true)end;if _c then self.set("borderColor",_c)end;return self end
function _b:removeBorder()self.set("borderTop",false)
self.set("borderBottom",false)self.set("borderLeft",false)
self.set("borderRight",false)return self end;function _b:key(cb,db)
if(self.get("focused"))then self:fireEvent("key",cb,db)end end;function _b:key_up(cb)if(self.get("focused"))then
self:fireEvent("key_up",cb)end end
function _b:char(cb)if
(self.get("focused"))then self:fireEvent("char",cb)end end
function _b:calculatePosition()local cb,db=self.get("x"),self.get("y")
if not
self.get("ignoreOffset")then if self.parent~=nil then
local _c,ac=self.parent.get("offsetX"),self.parent.get("offsetY")cb=cb-_c;db=db-ac end end;return cb,db end
function _b:getAbsolutePosition(cb,db)local _c,ac=self.get("x"),self.get("y")if(cb~=nil)then
_c=_c+cb-1 end;if(db~=nil)then ac=ac+db-1 end;local bc=self.parent
while bc do
local cc,dc=bc.get("x"),bc.get("y")_c=_c+cc-1;ac=ac+dc-1;bc=bc.parent end;return _c,ac end
function _b:getRelativePosition(cb,db)if(cb==nil)or(db==nil)then
cb,db=self.get("x"),self.get("y")end;local _c,ac=1,1;if self.parent then
_c,ac=self.parent:getRelativePosition()end
local bc,cc=self.get("x"),self.get("y")return cb- (bc-1)- (_c-1),db- (cc-1)- (ac-1)end
function _b:setCursor(cb,db,_c,ac)
if self.parent then local bc,cc=self:calculatePosition()
if
(cb+bc-1 <1)or(
cb+bc-1 >self.parent.get("width"))or(db+cc-1 <1)or(db+cc-1 >
self.parent.get("height"))then return self.parent:setCursor(
cb+bc-1,db+cc-1,false)end
return self.parent:setCursor(cb+bc-1,db+cc-1,_c,ac)end;return self end
function _b:prioritize()
if(self.parent)then local cb=self.parent;cb:removeChild(self)
cb:addChild(self)self:updateRender()end;return self end
function _b:render()
if(not self.get("backgroundEnabled"))then return end;local cb,db=self.get("width"),self.get("height")
local _c=da[self.get("foreground")]local ac=da[self.get("background")]
self:multiBlit(1,1,cb,db," ",_c,ac)
if
(self.get("borderTop")or self.get("borderBottom")or
self.get("borderLeft")or self.get("borderRight"))then
local bc=self.get("borderColor")or self.get("foreground")local cc=da[bc]or _c;if self.get("borderTop")then
self:textFg(1,1,("\131"):rep(cb),bc)end;if self.get("borderBottom")then
self:multiBlit(1,db,cb,1,"\143",ac,cc)end;if self.get("borderLeft")then
self:multiBlit(1,1,1,db,"\149",cc,ac)end;if self.get("borderRight")then
self:multiBlit(cb,1,1,db,"\149",ac,cc)end
if self.get("borderTop")and
self.get("borderLeft")then self:blit(1,1,"\151",cc,ac)end;if self.get("borderTop")and self.get("borderRight")then
self:blit(cb,1,"\148",ac,cc)end
if self.get("borderBottom")and
self.get("borderLeft")then self:blit(1,db,"\138",ac,cc)end;if self.get("borderBottom")and self.get("borderRight")then
self:blit(cb,db,"\133",ac,cc)end end end;function _b:postRender()end;function _b:destroy()self.set("visible",false)
ca.destroy(self)end;return _b end
project["elements/ProgressBar.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"progress",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"showPercentage",{default=false,type="boolean"})
aa.defineProperty(aa,"progressColor",{default=colors.black,type="color"})
aa.defineProperty(aa,"direction",{default="right",type="string"})
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("width",25)ba.set("height",3)return ba end;function aa:init(ba,ca)d.init(self,ba,ca)
self.set("type","ProgressBar")end
function aa:render()d.render(self)
local ba=self.get("width")local ca=self.get("height")
local da=math.min(100,math.max(0,self.get("progress")))local _b=math.floor((ba*da)/100)
local ab=math.floor((ca*da)/100)local bb=self.get("direction")
local cb=self.get("progressColor")
if bb=="right"then
self:multiBlit(1,1,_b,ca," ",_a[self.get("foreground")],_a[cb])elseif bb=="left"then
self:multiBlit(ba-_b+1,1,_b,ca," ",_a[self.get("foreground")],_a[cb])elseif bb=="up"then
self:multiBlit(1,ca-ab+1,ba,ab," ",_a[self.get("foreground")],_a[cb])elseif bb=="down"then
self:multiBlit(1,1,ba,ab," ",_a[self.get("foreground")],_a[cb])end
if self.get("showPercentage")then local db=tostring(da).."%"local _c=math.floor(
(ba-#db)/2)+1
local ac=math.floor((ca-1)/2)+1
self:textFg(_c,ac,db,self.get("foreground"))end end;return aa end
project["elements/CheckBox.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"checked",{default=false,type="boolean",canTriggerRender=true})
d.defineProperty(d,"text",{default=" ",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.get("checkedText")
local ca=math.max(#aa,#ba)if(_a.get("autoSize"))then _a.set("width",ca)end;return aa end})
d.defineProperty(d,"checkedText",{default="x",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.get("text")
local ca=math.max(#aa,#ba)if(_a.get("autoSize"))then _a.set("width",ca)end;return aa end})
d.defineProperty(d,"autoSize",{default=true,type="boolean"})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_up")function d.new()local _a=setmetatable({},d):__init()_a.class=d
_a.set("backgroundEnabled",false)return _a end
function d:init(_a,aa)
c.init(self,_a,aa)self.set("type","CheckBox")end
function d:mouse_click(_a,aa,ba)if c.mouse_click(self,_a,aa,ba)then
self.set("checked",not self.get("checked"))return true end;return false end
function d:render()c.render(self)local _a=self.get("checked")
local aa=self.get("text")local ba=self.get("checkedText")
local ca=string.sub(_a and ba or aa,1,self.get("width"))self:textFg(1,1,ca,self.get("foreground"))end;return d end
project["elements/BaseElement.lua"] = function(...) local _a=require("propertySystem")
local aa=require("libraries/utils").uuid;local ba=require("errorManager")local ca=setmetatable({},_a)
ca.__index=ca
ca.defineProperty(ca,"type",{default={"BaseElement"},type="string",setter=function(da,_b)if type(_b)=="string"then
table.insert(da._values.type,1,_b)return da._values.type end;return _b end,getter=function(da,_b,ab)if
ab~=nil and ab<1 then return da._values.type end;return da._values.type[
ab or 1]end})
ca.defineProperty(ca,"id",{default="",type="string",readonly=true})
ca.defineProperty(ca,"name",{default="",type="string"})
ca.defineProperty(ca,"eventCallbacks",{default={},type="table"})
ca.defineProperty(ca,"enabled",{default=true,type="boolean"})
function ca.defineEvent(da,_b,ab)
if not rawget(da,'_eventConfigs')then da._eventConfigs={}end;da._eventConfigs[_b]={requires=ab and ab or _b}end
function ca.registerEventCallback(da,_b,...)
local ab=_b:match("^on")and _b or"on".._b;local bb={...}local cb=bb[1]
da[ab]=function(db,...)
for _c,ac in ipairs(bb)do if not db._registeredEvents[ac]then
db:listenEvent(ac,true)end end;db:registerCallback(cb,...)return db end end;function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;return da end
function ca:init(da,_b)
if self._initialized then return self end;self._initialized=true;self._props=da;self._values.id=aa()
self.basalt=_b;self._registeredEvents={}local ab=getmetatable(self).__index
local bb={}ab=self.class
while ab do
if type(ab)=="table"and ab._eventConfigs then for cb,db in
pairs(ab._eventConfigs)do if not bb[cb]then bb[cb]=db end end end
ab=getmetatable(ab)and getmetatable(ab).__index end
for cb,db in pairs(bb)do self._registeredEvents[db.requires]=true end;if self._callbacks then
for cb,db in pairs(self._callbacks)do self[db]=function(_c,...)
_c:registerCallback(cb,...)return _c end end end
return self end
function ca:postInit()if self._postInitialized then return self end
self._postInitialized=true;if(self._props)then
for da,_b in pairs(self._props)do self.set(da,_b)end end;self._props=nil;return self end;function ca:isType(da)
for _b,ab in ipairs(self._values.type)do if ab==da then return true end end;return false end
function ca:listenEvent(da,_b)_b=
_b~=false
if
_b~= (self._registeredEvents[da]or false)then
if _b then self._registeredEvents[da]=true;if self.parent then
self.parent:registerChildEvent(self,da)end else self._registeredEvents[da]=nil
if
self.parent then self.parent:unregisterChildEvent(self,da)end end end;return self end
function ca:registerCallback(da,_b)if not self._registeredEvents[da]then
self:listenEvent(da,true)end
if
not self._values.eventCallbacks[da]then self._values.eventCallbacks[da]={}end
table.insert(self._values.eventCallbacks[da],_b)return self end
function ca:fireEvent(da,...)
if self.get("eventCallbacks")[da]then for _b,ab in
ipairs(self.get("eventCallbacks")[da])do local bb=ab(self,...)return bb end end;return self end
function ca:dispatchEvent(da,...)
if self.get("enabled")==false then return false end;if self[da]then return self[da](self,...)end;return
self:handleEvent(da,...)end;function ca:handleEvent(da,...)return false end;function ca:onChange(da,_b)
self:observe(da,_b)return self end
function ca:getBaseFrame()if self.parent then return
self.parent:getBaseFrame()end;return self end;function ca:destroy()
if(self.parent)then self.parent:removeChild(self)end;self._destroyed=true;self:removeAllObservers()
self:setFocused(false)end;function ca:updateRender()
if
(self.parent)then self.parent:updateRender()else self._renderUpdate=true end;return self end;return ca end
project["elements/List.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"items",{default={},type="table",canTriggerRender=true})
d.defineProperty(d,"selectable",{default=true,type="boolean"})
d.defineProperty(d,"multiSelection",{default=false,type="boolean"})
d.defineProperty(d,"offset",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"selectedBackground",{default=colors.blue,type="color"})
d.defineProperty(d,"selectedForeground",{default=colors.white,type="color"})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_scroll")
function d.new()local _a=setmetatable({},d):__init()_a.class=d
_a.set("width",16)_a.set("height",8)_a.set("z",5)
_a.set("background",colors.gray)return _a end
function d:init(_a,aa)c.init(self,_a,aa)self.set("type","List")return self end;function d:addItem(_a)local aa=self.get("items")table.insert(aa,_a)
self:updateRender()return self end
function d:removeItem(_a)
local aa=self.get("items")table.remove(aa,_a)self:updateRender()return self end
function d:clear()self.set("items",{})self:updateRender()return self end
function d:getSelectedItems()local _a={}for aa,ba in ipairs(self.get("items"))do
if
type(ba)=="table"and ba.selected then local ca=ba;ca.index=aa;table.insert(_a,ca)end end;return _a end
function d:getSelectedItem()local _a=self.get("items")for aa,ba in ipairs(_a)do if
type(ba)=="table"and ba.selected then return ba end end;return
nil end
function d:mouse_click(_a,aa,ba)
if
self:isInBounds(aa,ba)and self.get("selectable")then local ca,da=self:getRelativePosition(aa,ba)
local _b=da+self.get("offset")local ab=self.get("items")
if _b<=#ab then local bb=ab[_b]if type(bb)=="string"then
bb={text=bb}ab[_b]=bb end;if
not self.get("multiSelection")then
for cb,db in ipairs(ab)do if type(db)=="table"then db.selected=false end end end
bb.selected=not bb.selected;if bb.callback then bb.callback(self)end
self:fireEvent("mouse_click",_a,aa,ba)self:fireEvent("select",_b,bb)self:updateRender()end;return true end;return false end
function d:mouse_scroll(_a,aa,ba)
if self:isInBounds(aa,ba)then local ca=self.get("offset")
local da=math.max(0,#
self.get("items")-self.get("height"))ca=math.min(da,math.max(0,ca+_a))
self.set("offset",ca)self:fireEvent("mouse_scroll",_a,aa,ba)return true end;return false end
function d:onSelect(_a)self:registerCallback("select",_a)return self end
function d:scrollToBottom()
local _a=math.max(0,#self.get("items")-self.get("height"))self.set("offset",_a)return self end;function d:scrollToTop()self.set("offset",0)return self end
function d:render()
c.render(self)local _a=self.get("items")local aa=self.get("height")
local ba=self.get("offset")local ca=self.get("width")
for i=1,aa do local da=i+ba;local _b=_a[da]
if _b then if
type(_b)=="string"then _b={text=_b}_a[da]=_b end
if _b.separator then
local ab=(_b.text or"-"):sub(1,1)local bb=string.rep(ab,ca)
local cb=_b.foreground or self.get("foreground")local db=_b.background or self.get("background")
self:textBg(1,i,string.rep(" ",ca),db)self:textFg(1,i,bb:sub(1,ca),cb)else local ab=_b.text
local bb=_b.selected
local cb=
bb and(_b.selectedBackground or self.get("selectedBackground"))or(_b.background or self.get("background"))
local db=
bb and(_b.selectedForeground or self.get("selectedForeground"))or(_b.foreground or self.get("foreground"))self:textBg(1,i,string.rep(" ",ca),cb)
self:textFg(1,i,ab:sub(1,ca),db)end end end end;return d end
project["plugins/canvas.lua"] = function(...) local ba=require("libraries/colorHex")
local ca=require("errorManager")local da={}da.__index=da;local _b,ab=string.sub,string.rep
function da.new(cb)
local db=setmetatable({},da)db.commands={pre={},post={}}db.type="pre"db.element=cb;return db end
function da:clear()self.commands={pre={},post={}}return self end;function da:getValue(cb)
if type(cb)=="function"then return cb(self.element)end;return cb end
function da:setType(cb)if
cb=="pre"or cb=="post"then self.type=cb else
ca.error("Invalid type. Use 'pre' or 'post'.")end;return self end
function da:addCommand(cb)
local db=#self.commands[self.type]+1;self.commands[self.type][db]=cb;return db end
function da:setCommand(cb,db)self.commands[cb]=db;return self end;function da:removeCommand(cb)
table.remove(self.commands[self.type],cb)return self end
function da:text(cb,db,_c,ac,bc)
return
self:addCommand(function(cc)
local dc,_d=self:getValue(cb),self:getValue(db)local ad=self:getValue(_c)local bd=self:getValue(ac)
local cd=self:getValue(bc)
local dd=type(bd)=="number"and ba[bd]:rep(#_c)or bd
local __a=type(cd)=="number"and ba[cd]:rep(#_c)or cd;cc:drawText(dc,_d,ad)
if dd then cc:drawFg(dc,_d,dd)end;if __a then cc:drawBg(dc,_d,__a)end end)end;function da:bg(cb,db,_c)return
self:addCommand(function(ac)ac:drawBg(cb,db,_c)end)end
function da:fg(cb,db,_c)return self:addCommand(function(ac)
ac:drawFg(cb,db,_c)end)end
function da:rect(cb,db,_c,ac,bc,cc,dc)
return
self:addCommand(function(_d)local ad,bd=self:getValue(cb),self:getValue(db)
local cd,dd=self:getValue(_c),self:getValue(ac)local __a=self:getValue(bc)local a_a=self:getValue(cc)
local b_a=self:getValue(dc)if(type(a_a)=="number")then a_a=ba[a_a]end;if
(type(b_a)=="number")then b_a=ba[b_a]end
local c_a=b_a and _b(b_a:rep(cd),1,cd)local d_a=a_a and _b(a_a:rep(cd),1,cd)local _aa=__a and
_b(__a:rep(cd),1,cd)
for i=0,dd-1 do
if b_a then _d:drawBg(ad,bd+i,c_a)end;if a_a then _d:drawFg(ad,bd+i,d_a)end;if __a then
_d:drawText(ad,bd+i,_aa)end end end)end
function da:line(cb,db,_c,ac,bc,cc,dc)
local function _d(cd,dd,__a,a_a)local b_a={}local c_a=0;local d_a=math.abs(__a-cd)
local _aa=math.abs(a_a-dd)local aaa=(cd<__a)and 1 or-1
local baa=(dd<a_a)and 1 or-1;local caa=d_a-_aa
while true do c_a=c_a+1;b_a[c_a]={x=cd,y=dd}if
(cd==__a)and(dd==a_a)then break end;local daa=caa*2
if daa>-_aa then caa=caa-_aa;cd=cd+aaa end;if daa<d_a then caa=caa+d_a;dd=dd+baa end end;return b_a end;local ad=false;local bd
if
type(cb)=="function"or type(db)=="function"or type(_c)=="function"or
type(ac)=="function"then ad=true else
bd=_d(self:getValue(cb),self:getValue(db),self:getValue(_c),self:getValue(ac))end
return
self:addCommand(function(cd)if ad then
bd=_d(self:getValue(cb),self:getValue(db),self:getValue(_c),self:getValue(ac))end
local dd=self:getValue(bc)local __a=self:getValue(cc)local a_a=self:getValue(dc)local b_a=
type(__a)=="number"and ba[__a]or __a;local c_a=type(a_a)==
"number"and ba[a_a]or a_a
for d_a,_aa in
ipairs(bd)do local aaa=math.floor(_aa.x)local baa=math.floor(_aa.y)if dd then
cd:drawText(aaa,baa,dd)end;if b_a then cd:drawFg(aaa,baa,b_a)end;if c_a then
cd:drawBg(aaa,baa,c_a)end end end)end
function da:ellipse(cb,db,_c,ac,bc,cc,dc)
local function _d(bd,cd,dd,__a)local a_a={}local b_a=0;local c_a=dd*dd;local d_a=__a*__a;local _aa=0;local aaa=__a;local baa=d_a-c_a*__a+
0.25 *c_a;local caa=0;local daa=2 *c_a*aaa
local function _ba(aba,bba)b_a=b_a+1;a_a[b_a]={x=
bd+aba,y=cd+bba}b_a=b_a+1
a_a[b_a]={x=bd-aba,y=cd+bba}b_a=b_a+1;a_a[b_a]={x=bd+aba,y=cd-bba}b_a=b_a+1;a_a[b_a]={x=bd-aba,y=
cd-bba}end;_ba(_aa,aaa)
while caa<daa do _aa=_aa+1;caa=caa+2 *d_a
if baa<0 then
baa=baa+d_a+caa else aaa=aaa-1;daa=daa-2 *c_a;baa=baa+d_a+caa-daa end;_ba(_aa,aaa)end;baa=
d_a* (_aa+0.5)* (_aa+0.5)+c_a* (aaa-1)* (aaa-1)-c_a*d_a;while aaa>0 do
aaa=aaa-1;daa=daa-2 *c_a;if baa>0 then baa=baa+c_a-daa else _aa=_aa+1
caa=caa+2 *d_a;baa=baa+c_a-daa+caa end
_ba(_aa,aaa)end
return a_a end;local ad=_d(cb,db,_c,ac)
return
self:addCommand(function(bd)local cd=self:getValue(bc)
local dd=self:getValue(cc)local __a=self:getValue(dc)
local a_a=type(dd)=="number"and ba[dd]or dd
local b_a=type(__a)=="number"and ba[__a]or __a
for c_a,d_a in pairs(ad)do local _aa=math.floor(d_a.x)local aaa=math.floor(d_a.y)if cd then
bd:drawText(_aa,aaa,cd)end;if a_a then bd:drawFg(_aa,aaa,a_a)end;if b_a then
bd:drawBg(_aa,aaa,b_a)end end end)end;local bb={hooks={}}
function bb.setup(cb)
cb.defineProperty(cb,"canvas",{default=nil,type="table",getter=function(db)if not db._values.canvas then
db._values.canvas=da.new(db)end;return db._values.canvas end})end;function bb.hooks.render(cb)local db=cb.get("canvas")
if
db and#db.commands.pre>0 then for _c,ac in pairs(db.commands.pre)do ac(cb)end end end
function bb.hooks.postRender(cb)
local db=cb.get("canvas")if db and#db.commands.post>0 then for _c,ac in pairs(db.commands.post)do
ac(cb)end end end;return{VisualElement=bb,API=da} end
project["plugins/theme.lua"] = function(...) local ab=require("errorManager")
local bb={default={background=colors.lightGray,foreground=colors.black},BaseFrame={background=colors.white,foreground=colors.black,Frame={background=colors.black,names={basaltDebugLogClose={background=colors.blue,foreground=colors.white}}},Button={background="{self.clicked and colors.black or colors.cyan}",foreground="{self.clicked and colors.cyan or colors.black}"},names={basaltDebugLog={background=colors.red,foreground=colors.white},test={background="{self.clicked and colors.black or colors.green}",foreground="{self.clicked and colors.green or colors.black}"}}}}local cb={default=bb}local db="default"
local _c={hooks={postInit={pre=function(ad)if ad._postInitialized then return ad end
ad:applyTheme()end}}}
function _c.____getElementPath(ad,bd)if bd then table.insert(bd,1,ad._values.type)else
bd={ad._values.type}end;local cd=ad.parent;if cd then return
cd.____getElementPath(cd,bd)else return bd end end
local function ac(ad,bd)local cd=ad
for i=1,#bd do local dd=false;local __a=bd[i]for a_a,b_a in ipairs(__a)do
if cd[b_a]then cd=cd[b_a]dd=true;break end end;if not dd then return nil end end;return cd end
local function bc(ad,bd)local cd={}
if ad.default then for dd,__a in pairs(ad.default)do
if type(__a)~="table"then cd[dd]=__a end end;if ad.default[bd]then
for dd,__a in
pairs(ad.default[bd])do if type(__a)~="table"then cd[dd]=__a end end end end;return cd end
local function cc(ad,bd,cd,dd,__a)
if
bd.default and bd.default.names and bd.default.names[dd]then for a_a,b_a in pairs(bd.default.names[dd])do
if type(b_a)~="table"then ad[a_a]=b_a end end end
if

bd.default and bd.default[cd]and bd.default[cd].names and bd.default[cd].names[dd]then
for a_a,b_a in pairs(bd.default[cd].names[dd])do if
type(b_a)~="table"then ad[a_a]=b_a end end end;if __a and __a.names and __a.names[dd]then
for a_a,b_a in pairs(__a.names[dd])do if
type(b_a)~="table"then ad[a_a]=b_a end end end end
local function dc(ad,bd,cd,dd)local __a={}local a_a=ac(ad,bd)
if a_a then for b_a,c_a in pairs(a_a)do
if type(c_a)~="table"then __a[b_a]=c_a end end end;if next(__a)==nil then __a=bc(ad,cd)end
cc(__a,ad,cd,dd,a_a)return __a end
function _c:applyTheme(ad)local bd=self:getTheme()
if(bd~=nil)then
for cd,dd in pairs(bd)do
local __a=self._properties[cd]
if(__a)then
if( (__a.type)=="color")then if(type(dd)=="string")then
if(colors[dd])then dd=colors[dd]end end end;self.set(cd,dd)end end end
if(ad~=false)then if(self:isType("Container"))then local cd=self.get("children")
for dd,__a in
ipairs(cd)do if(__a and __a.applyTheme)then __a:applyTheme()end end end end;return self end
function _c:getTheme()local ad=self:____getElementPath()
local bd=self.get("type")local cd=self.get("name")return dc(cb[db],ad,bd,cd)end;local _d={}function _d.setTheme(ad)cb.default=ad end
function _d.getTheme()return cb.default end
function _d.loadTheme(ad)local bd=fs.open(ad,"r")
if bd then local cd=bd.readAll()bd.close()
cb.default=textutils.unserializeJSON(cd)if not cb.default then
ab.error("Failed to load theme from "..ad)end else
ab.error("Could not open theme file: "..ad)end end;return{BaseElement=_c,API=_d} end
project["plugins/reactive.lua"] = function(...) local bb=require("errorManager")
local cb=require("propertySystem")local db={colors=true,math=true,clamp=true,round=true}
local _c={clamp=function(cd,dd,__a)return
math.min(math.max(cd,dd),__a)end,round=function(cd)
return math.floor(cd+0.5)end,floor=math.floor,ceil=math.ceil,abs=math.abs}
local function ac(cd)return
{parent=cd:find("parent%."),self=cd:find("self%."),other=cd:find("[^(parent)][^(self)]%.")}end
local function bc(cd,dd,__a)local a_a=ac(cd)
if a_a.parent and not dd.parent then
bb.header="Reactive evaluation error"
bb.error("Expression uses parent but no parent available")return function()return nil end end;cd=cd:gsub("^{(.+)}$","%1")
cd=cd:gsub("([%w_]+)%$([%w_]+)",function(_aa,aaa)
if _aa=="self"then return
string.format('__getState("%s")',aaa)elseif _aa=="parent"then return
string.format('__getParentState("%s")',aaa)else return
string.format('__getElementState("%s", "%s")',_aa,aaa)end end)
cd=cd:gsub("([%w_]+)%.([%w_]+)",function(_aa,aaa)if db[_aa]then return _aa.."."..aaa end;if
tonumber(_aa)then return _aa.."."..aaa end;return
string.format('__getProperty("%s", "%s")',_aa,aaa)end)
local b_a=setmetatable({colors=colors,math=math,tostring=tostring,tonumber=tonumber,__getState=function(_aa)return dd:getState(_aa)end,__getParentState=function(_aa)return
dd.parent:getState(_aa)end,__getElementState=function(_aa,aaa)if tonumber(_aa)then return nil end
local baa=dd:getBaseFrame():getChild(_aa)if not baa then bb.header="Reactive evaluation error"
bb.error("Could not find element: ".._aa)return nil end;return
baa:getState(aaa).value end,__getProperty=function(_aa,aaa)if
tonumber(_aa)then return nil end
if _aa=="self"then return dd.get(aaa)elseif _aa=="parent"then return
dd.parent.get(aaa)else local baa=dd.parent:getChild(_aa)if not baa then
bb.header="Reactive evaluation error"
bb.error("Could not find element: ".._aa)return nil end
return baa.get(aaa)end end},{__index=_c})if(dd._properties[__a].type=="string")then
cd="tostring("..cd..")"elseif(dd._properties[__a].type=="number")then
cd="tonumber("..cd..")"end;local c_a,d_a=load(
"return "..cd,"reactive","t",b_a)
if not c_a then
bb.header="Reactive evaluation error"bb.error("Invalid expression: "..d_a)return
function()return nil end end;return c_a end
local function cc(cd,dd)
for __a in cd:gmatch("([%w_]+)%.")do
if not db[__a]then
if __a=="self"then elseif __a=="parent"then
if not dd.parent then
bb.header="Reactive evaluation error"bb.error("No parent element available")return false end else
if(tonumber(__a)==nil)then local a_a=dd.parent:getChild(__a)if not a_a then
bb.header="Reactive evaluation error"
bb.error("Referenced element not found: "..__a)return false end end end end end;return true end;local dc=setmetatable({},{__mode="k"})
local _d=setmetatable({},{__mode="k",__index=function(cd,dd)cd[dd]={}
return cd[dd]end})
local function ad(cd,dd,__a)local a_a=ac(dd)
if _d[cd][__a]then for c_a,d_a in ipairs(_d[cd][__a])do
d_a.target:removeObserver(d_a.property,d_a.callback)end end;local b_a={}
for c_a,d_a in dd:gmatch("([%w_]+)%.([%w_]+)")do
if not db[c_a]then local _aa
if
c_a=="self"and a_a.self then _aa=cd elseif c_a=="parent"and a_a.parent then _aa=cd.parent elseif a_a.other then
_aa=cd:getBaseFrame():getChild(c_a)end;if _aa then
local aaa={target=_aa,property=d_a,callback=function()cd:updateRender()end}_aa:observe(d_a,aaa.callback)
table.insert(b_a,aaa)end end end;_d[cd][__a]=b_a end
cb.addSetterHook(function(cd,dd,__a,a_a)
if type(__a)=="string"and __a:match("^{.+}$")then
local b_a=__a:gsub("^{(.+)}$","%1")local c_a=ac(b_a)
if c_a.parent and not cd.parent then return a_a.default end;if not cc(b_a,cd)then return a_a.default end;ad(cd,b_a,dd)if not
dc[cd]then dc[cd]={}end;if not dc[cd][__a]then local d_a=bc(__a,cd,dd)
dc[cd][__a]=d_a end
return
function(d_a)if
cd._destroyed or(c_a.parent and not cd.parent)then return a_a.default end
local _aa,aaa=pcall(dc[cd][__a])
if not _aa then if aaa and aaa:match("attempt to index.-nil value")then return
a_a.default end
bb.header="Reactive evaluation error"
if type(aaa)=="string"then
bb.error("Error evaluating expression: "..aaa)else bb.error("Error evaluating expression")end;return a_a.default end;return aaa end end end)local bd={}
bd.hooks={destroy=function(cd)
if _d[cd]then
for dd,__a in pairs(_d[cd])do for a_a,b_a in ipairs(__a)do
b_a.target:removeObserver(b_a.property,b_a.callback)end end;_d[cd]=nil;dc[cd]=nil end end}return{BaseElement=bd} end
project["plugins/state.lua"] = function(...) local _a=require("propertySystem")
local aa=require("errorManager")local ba={}function ba.setup(da)
da.defineProperty(da,"states",{default={},type="table"})
da.defineProperty(da,"stateObserver",{default={},type="table"})end
function ba:initializeState(da,_b,ab,bb)
local cb=self.get("states")if cb[da]then
aa.error("State '"..da.."' already exists")return self end;local db=bb or"states/"..
self.get("name")..".state"local _c={}
if ab and
fs.exists(db)then local ac=fs.open(db,"r")_c=
textutils.unserialize(ac.readAll())or{}ac.close()end;cb[da]={value=ab and _c[da]or _b,persist=ab}
return self end;local ca={}
function ca:setState(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("states")local cb=ab.get("stateObserver")
if not bb[da]then aa.error("State '"..
da.."' not initialized")end
if bb[da].persist then
local db="states/"..ab.get("name")..".state"local _c={}
if fs.exists(db)then local cc=fs.open(db,"r")_c=
textutils.unserialize(cc.readAll())or{}cc.close()end;_c[da]=_b;local ac=fs.getDir(db)if not fs.exists(ac)then
fs.makeDir(ac)end;local bc=fs.open(db,"w")
bc.write(textutils.serialize(_c))bc.close()end;bb[da].value=_b
if cb[da]then for db,_c in ipairs(cb[da])do _c(da,_b)end end;for db,_c in pairs(bb)do
if _c.computed then _c.value=_c.computeFn(self)if cb[db]then for ac,bc in ipairs(cb[db])do
bc(db,_c.value)end end end end
return self end
function ca:getState(da)local _b=self:getBaseFrame()local ab=_b.get("states")if
not ab[da]then
aa.error("State '"..da.."' not initialized")end;if ab[da].computed then
return ab[da].computeFn(self)end;return ab[da].value end
function ca:onStateChange(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("states")[da]if not bb then
aa.error("Cannot observe state '"..da.."': State not initialized")return self end
local cb=ab.get("stateObserver")if not cb[da]then cb[da]={}end;table.insert(cb[da],_b)
return self end
function ca:removeStateChange(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("stateObserver")
if bb[da]then for cb,db in ipairs(bb[da])do
if db==_b then table.remove(bb[da],cb)break end end end;return self end
function ca:computed(da,_b)local ab=self:getBaseFrame()local bb=ab.get("states")if bb[da]then
aa.error(
"Computed state '"..da.."' already exists")return self end
bb[da]={computeFn=_b,value=_b(self),computed=true}return self end
function ca:bind(da,_b)_b=_b or da;local ab=self:getBaseFrame()local bb=false
if
self.get(da)~=nil then self.set(da,ab:getState(_b))end
self:onChange(da,function(cb,db)if bb then return end;bb=true;cb:setState(_b,db)bb=false end)
self:onStateChange(_b,function(cb,db)if bb then return end;bb=true;if self.get(da)~=nil then
self.set(da,db)end;bb=false end)return self end;return{BaseElement=ca,BaseFrame=ba} end
project["plugins/xml.lua"] = function(...) local ab=require("errorManager")local bb=require("log")
local cb={new=function(ad)
return
{tag=ad,value=nil,attributes={},children={},addChild=function(bd,cd)
table.insert(bd.children,cd)end,addAttribute=function(bd,cd,dd)bd.attributes[cd]=dd end}end}
local db=function(ad,bd)
local cd,dd=string.gsub(bd,"(%w+)=([\"'])(.-)%2",function(b_a,c_a,d_a)
ad:addAttribute(b_a,"\""..d_a.."\"")end)
local __a,a_a=string.gsub(bd,"(%w+)={(.-)}",function(b_a,c_a)ad:addAttribute(b_a,c_a)end)end
local _c={parseText=function(ad)local bd={}local cd=cb.new()table.insert(bd,cd)local dd,__a,a_a,b_a,c_a;local d_a,_aa=1,1
while
true do
dd,_aa,__a,a_a,b_a,c_a=string.find(ad,"<(%/?)([%w_:]+)(.-)(%/?)>",d_a)if not dd then break end;local aaa=string.sub(ad,d_a,dd-1)if not
string.find(aaa,"^%s*$")then local baa=(cd.value or"")..aaa
bd[#bd].value=baa end
if c_a=="/"then local baa=cb.new(a_a)
db(baa,b_a)cd:addChild(baa)elseif __a==""then local baa=cb.new(a_a)db(baa,b_a)
table.insert(bd,baa)cd=baa else local baa=table.remove(bd)cd=bd[#bd]
if#bd<1 then ab.error(
"XMLParser: nothing to close with "..a_a)end;if baa.tag~=a_a then
ab.error("XMLParser: trying to close "..baa.tag.." with "..a_a)end;cd:addChild(baa)end;d_a=_aa+1 end;if#bd>1 then
error("XMLParser: unclosed "..bd[#bd].tag)end;return cd.children end}
local function ac(ad)local bd={}local cd=1
while true do local dd,__a,a_a=ad:find("%${([^}]+)}",cd)
if not dd then break end
table.insert(bd,{start=dd,ending=__a,expression=a_a,raw=ad:sub(dd,__a)})cd=__a+1 end;return bd end
local function bc(ad,bd)if not ad then return ad end;if
ad:sub(1,1)=="\""and ad:sub(-1)=="\""then ad=ad:sub(2,-2)end;local cd=ac(ad)
for dd,__a in ipairs(cd)do
local a_a=__a.expression;local b_a=__a.start-1;local c_a=__a.ending+1;if bd[a_a]then ad=ad:sub(1,b_a)..
tostring(bd[a_a])..ad:sub(c_a)else
ab.error(
"XMLParser: variable '"..a_a.."' not found in scope")end end
if ad:match("^%s*<!%[CDATA%[.*%]%]>%s*$")then
local dd=ad:match("<!%[CDATA%[(.*)%]%]>")local __a=_ENV;for a_a,b_a in pairs(bd)do __a[a_a]=b_a end;return
load("return "..dd,nil,"bt",__a)()end
if ad=="true"then return true elseif ad=="false"then return false elseif colors[ad]then return colors[ad]elseif tonumber(ad)then return
tonumber(ad)else return ad end end
local function cc(ad,bd)local cd={}
for dd,__a in pairs(ad.children)do
if __a.tag=="item"or __a.tag=="entry"then
local a_a={}
for b_a,c_a in pairs(__a.attributes)do a_a[b_a]=bc(c_a,bd)end;for b_a,c_a in pairs(__a.children)do
if c_a.value then a_a[c_a.tag]=bc(c_a.value,bd)elseif#
c_a.children>0 then a_a[c_a.tag]=cc(c_a)end end
table.insert(cd,a_a)else if __a.value then cd[__a.tag]=bc(__a.value,bd)elseif#__a.children>0 then
cd[__a.tag]=cc(__a)end end end;return cd end;local dc={}function dc.setup(ad)
ad.defineProperty(ad,"customXML",{default={attributes={},children={}},type="table"})end
function dc:fromXML(ad,bd)
if(ad.attributes)then
for cd,dd in
pairs(ad.attributes)do
if(self._properties[cd])then self.set(cd,bc(dd,bd))elseif self[cd]then
if(
cd:sub(1,2)=="on")then local __a=dd:gsub("\"","")
if(bd[__a])then if
(type(bd[__a])~="function")then
ab.error("XMLParser: variable '"..__a..
"' is not a function for element '"..self:getType().."' "..cd)end
self[cd](self,bd[__a])else
ab.error("XMLParser: variable '"..__a.."' not found in scope")end else
ab.error("XMLParser: property '"..cd..
"' not found in element '"..self:getType().."'")end else local __a=self.get("customXML")
__a.attributes[cd]=bc(dd,bd)end end end
if(ad.children)then
for cd,dd in pairs(ad.children)do
if(self._properties[dd.tag])then if(
self._properties[dd.tag].type=="table")then self.set(dd.tag,cc(dd,bd))else
self.set(dd.tag,bc(dd.value,bd))end else local __a={}
if(dd.children)then
for a_a,b_a in
pairs(dd.children)do
if(b_a.tag=="param")then
table.insert(__a,bc(b_a.value,bd))elseif(b_a.tag=="table")then table.insert(__a,cc(b_a,bd))end end end
if(self[dd.tag])then if(#__a>0)then
self[dd.tag](self,table.unpack(__a))elseif(dd.value)then self[dd.tag](self,bc(dd.value,bd))else
self[dd.tag](self)end else
local a_a=self.get("customXML")dd.value=bc(dd.value,bd)a_a.children[dd.tag]=dd end end end end;return self end;local _d={}
function _d:loadXML(ad,bd)bd=bd or{}local cd=_c.parseText(ad)
self:fromXML(cd,bd)
if(cd)then
for dd,__a in ipairs(cd)do
local a_a=__a.tag:sub(1,1):upper()..__a.tag:sub(2)if self["add"..a_a]then local b_a=self["add"..a_a](self)
b_a:fromXML(__a,bd)end end end;return self end
function _d:fromXML(ad,bd)dc.fromXML(self,ad,bd)
if(ad.children)then
for cd,dd in ipairs(ad.children)do local __a=
dd.tag:sub(1,1):upper()..dd.tag:sub(2)
if
self["add"..__a]then local a_a=self["add"..__a](self)a_a:fromXML(dd,bd)end end end;return self end;return{API=_c,Container=_d,BaseElement=dc} end
project["plugins/debug.lua"] = function(...) local _b=require("log")local ab=require("libraries/colorHex")
local bb=10;local cb=false;local db={ERROR=1,WARN=2,INFO=3,DEBUG=4}
local function _c(dc)
local _d={renderCount=0,eventCount={},lastRender=os.epoch("utc"),properties={},children={}}
return
{trackProperty=function(ad,bd)_d.properties[ad]=bd end,trackRender=function()
_d.renderCount=_d.renderCount+1;_d.lastRender=os.epoch("utc")end,trackEvent=function(ad)_d.eventCount[ad]=(
_d.eventCount[ad]or 0)+1 end,dump=function()return
{type=dc.get("type"),id=dc.get("id"),stats=_d}end}end;local ac={}
function ac.debug(dc,_d)dc._debugger=_c(dc)dc._debugLevel=_d or db.INFO;return dc end;function ac.dumpDebug(dc)if not dc._debugger then return end
return dc._debugger.dump()end;local bc={}
function bc.openConsole(dc)
if
not dc._debugFrame then local _d=dc.get("width")local ad=dc.get("height")
dc._debugFrame=dc:addFrame("basaltDebugLog"):setWidth(_d):setHeight(ad):listenEvent("mouse_scroll",true)
dc._debugFrame:addButton("basaltDebugLogClose"):setWidth(9):setHeight(1):setX(
_d-8):setY(ad):setText("Close"):onClick(function()
dc:closeConsole()end)dc._debugFrame._scrollOffset=0
dc._debugFrame._processedLogs={}
local function bd(b_a,c_a)local d_a={}while#b_a>0 do local _aa=b_a:sub(1,c_a)table.insert(d_a,_aa)b_a=b_a:sub(
c_a+1)end;return d_a end
local function cd()local b_a={}local c_a=dc._debugFrame.get("width")
for d_a,_aa in
ipairs(_b._logs)do local aaa=bd(_aa.message,c_a)for baa,caa in ipairs(aaa)do
table.insert(b_a,{text=caa,level=_aa.level})end end;return b_a end;local dd=#cd()-dc.get("height")dc._scrollOffset=dd
local __a=dc._debugFrame.render
dc._debugFrame.render=function(b_a)__a(b_a)b_a._processedLogs=cd()
local c_a=b_a.get("height")-2;local d_a=#b_a._processedLogs;local _aa=math.max(0,d_a-c_a)
b_a._scrollOffset=math.min(b_a._scrollOffset,_aa)
for i=1,c_a-2 do local aaa=i+b_a._scrollOffset
local baa=b_a._processedLogs[aaa]
if baa then
local caa=

baa.level==_b.LEVEL.ERROR and colors.red or baa.level==
_b.LEVEL.WARN and colors.yellow or baa.level==_b.LEVEL.DEBUG and colors.lightGray or colors.white;b_a:textFg(2,i,baa.text,caa)end end end;local a_a=dc._debugFrame.dispatchEvent
dc._debugFrame.dispatchEvent=function(b_a,c_a,d_a,...)
if
(c_a=="mouse_scroll")then
b_a._scrollOffset=math.max(0,b_a._scrollOffset+d_a)b_a:updateRender()return true else return a_a(b_a,c_a,d_a,...)end end end
dc._debugFrame.set("width",dc.get("width"))
dc._debugFrame.set("height",dc.get("height"))dc._debugFrame.set("visible",true)return dc end
function bc.closeConsole(dc)if dc._debugFrame then
dc._debugFrame.set("visible",false)end;return dc end;function bc.toggleConsole(dc)if dc._debugFrame and dc._debugFrame:getVisible()then
dc:closeConsole()else dc:openConsole()end
return dc end
local cc={}
function cc.debugChildren(dc,_d)dc:debug(_d)for ad,bd in pairs(dc.get("children"))do if bd.debug then
bd:debug(_d)end end;return dc end;return{BaseElement=ac,Container=cc,BaseFrame=bc} end
project["plugins/animation.lua"] = function(...) local aa={}
local ba={linear=function(ab)return ab end,easeInQuad=function(ab)return ab*ab end,easeOutQuad=function(ab)return
1 - (1 -ab)* (1 -ab)end,easeInOutQuad=function(ab)if ab<0.5 then return 2 *ab*ab end;return 1 - (
-2 *ab+2)^2 /2 end}local ca={}ca.__index=ca
function ca.new(ab,bb,cb,db,_c)local ac=setmetatable({},ca)ac.element=ab
ac.type=bb;ac.args=cb;ac.duration=db or 1;ac.startTime=0;ac.isPaused=false
ac.handlers=aa[bb]ac.easing=_c;return ac end;function ca:start()self.startTime=os.epoch("local")/1000;if
self.handlers.start then self.handlers.start(self)end
return self end
function ca:update(ab)local bb=math.min(1,
ab/self.duration)
local cb=ba[self.easing](bb)return self.handlers.update(self,cb)end;function ca:complete()if self.handlers.complete then
self.handlers.complete(self)end end
local da={}da.__index=da
function da.registerAnimation(ab,bb)aa[ab]=bb
da[ab]=function(cb,...)local db={...}local _c="linear"
if(
type(db[#db])=="string")then _c=table.remove(db,#db)end;local ac=table.remove(db,#db)
return cb:addAnimation(ab,db,ac,_c)end end;function da.registerEasing(ab,bb)ba[ab]=bb end
function da.new(ab)local bb={}bb.element=ab
bb.sequences={{}}bb.sequenceCallbacks={}bb.currentSequence=1;bb.timer=nil
setmetatable(bb,da)return bb end
function da:sequence()table.insert(self.sequences,{})self.currentSequence=#
self.sequences;self.sequenceCallbacks[self.currentSequence]={start=nil,update=nil,complete=
nil}return self end
function da:onStart(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].start=ab;return self end
function da:onUpdate(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].update=ab;return self end
function da:onComplete(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].complete=ab;return self end
function da:addAnimation(ab,bb,cb,db)local _c=ca.new(self.element,ab,bb,cb,db)
table.insert(self.sequences[self.currentSequence],_c)return self end
function da:start()self.currentSequence=1;self.timer=nil
if
(self.sequenceCallbacks[self.currentSequence])then if(self.sequenceCallbacks[self.currentSequence].start)then
self.sequenceCallbacks[self.currentSequence].start(self.element)end end
if
#self.sequences[self.currentSequence]>0 then self.timer=os.startTimer(0.05)for ab,bb in
ipairs(self.sequences[self.currentSequence])do bb:start()end end;return self end
function da:event(ab,bb)
if ab=="timer"and bb==self.timer then
local cb=os.epoch("local")/1000;local db=true;local _c={}
local ac=self.sequenceCallbacks[self.currentSequence]
for bc,cc in ipairs(self.sequences[self.currentSequence])do
local dc=cb-cc.startTime;local _d=dc/cc.duration;local ad=cc:update(dc)if ac and ac.update then
ac.update(self.element,_d)end;if not ad then table.insert(_c,cc)db=false else
cc:complete()end end
if db then
if ac and ac.complete then ac.complete(self.element)end
if self.currentSequence<#self.sequences then
self.currentSequence=self.currentSequence+1;_c={}
local bc=self.sequenceCallbacks[self.currentSequence]if bc and bc.start then bc.start(self.element)end
for cc,dc in
ipairs(self.sequences[self.currentSequence])do dc:start()table.insert(_c,dc)end end end;if#_c>0 then self.timer=os.startTimer(0.05)end
return true end end
function da:stop()if self.timer then pcall(os.cancelTimer,self.timer)
self.timer=nil end
for ab,bb in ipairs(self.sequences)do for cb,db in ipairs(bb)do
pcall(function()if db and
db.complete then db:complete()end end)end end;if
self.element and type(self.element.set)=="function"then
pcall(function()self.element.set("animation",nil)end)end end
da.registerAnimation("move",{start=function(ab)ab.startX=ab.element.get("x")
ab.startY=ab.element.get("y")end,update=function(ab,bb)local cb=ab.startX+
(ab.args[1]-ab.startX)*bb;local db=ab.startY+
(ab.args[2]-ab.startY)*bb
ab.element.set("x",math.floor(cb))ab.element.set("y",math.floor(db))return bb>=1 end,complete=function(ab)
ab.element.set("x",ab.args[1])ab.element.set("y",ab.args[2])end})
da.registerAnimation("resize",{start=function(ab)ab.startW=ab.element.get("width")
ab.startH=ab.element.get("height")end,update=function(ab,bb)local cb=ab.startW+
(ab.args[1]-ab.startW)*bb;local db=ab.startH+
(ab.args[2]-ab.startH)*bb
ab.element.set("width",math.floor(cb))ab.element.set("height",math.floor(db))
return bb>=1 end,complete=function(ab)
ab.element.set("width",ab.args[1])ab.element.set("height",ab.args[2])end})
da.registerAnimation("moveOffset",{start=function(ab)ab.startX=ab.element.get("offsetX")
ab.startY=ab.element.get("offsetY")end,update=function(ab,bb)local cb=ab.startX+ (ab.args[1]-ab.startX)*
bb;local db=ab.startY+ (ab.args[2]-
ab.startY)*bb
ab.element.set("offsetX",math.floor(cb))ab.element.set("offsetY",math.floor(db))return
bb>=1 end,complete=function(ab)
ab.element.set("offsetX",ab.args[1])ab.element.set("offsetY",ab.args[2])end})
da.registerAnimation("number",{start=function(ab)
ab.startValue=ab.element.get(ab.args[1])ab.targetValue=ab.args[2]end,update=function(ab,bb)
local cb=
ab.startValue+ (ab.targetValue-ab.startValue)*bb
ab.element.set(ab.args[1],math.floor(cb))return bb>=1 end,complete=function(ab)
ab.element.set(ab.args[1],ab.targetValue)end})
da.registerAnimation("entries",{start=function(ab)
ab.startColor=ab.element.get(ab.args[1])ab.colorList=ab.args[2]end,update=function(ab,bb)
local cb=ab.colorList;local db=math.floor(#cb*bb)+1;if db>#cb then db=#cb end
ab.element.set(ab.args[1],cb[db])end,complete=function(ab)
ab.element.set(ab.args[1],ab.colorList[
#ab.colorList])end})
da.registerAnimation("morphText",{start=function(ab)local bb=ab.element.get(ab.args[1])
local cb=ab.args[2]local db=math.max(#bb,#cb)
local _c=string.rep(" ",math.floor(db-#bb)/2)ab.startText=_c..bb.._c
ab.targetText=cb..string.rep(" ",db-#cb)ab.length=db end,update=function(ab,bb)
local cb=""
for i=1,ab.length do local db=ab.startText:sub(i,i)
local _c=ab.targetText:sub(i,i)
if bb<0.5 then
cb=cb.. (math.random()>bb*2 and db or" ")else cb=cb..
(math.random()> (bb-0.5)*2 and" "or _c)end end;ab.element.set(ab.args[1],cb)return bb>=1 end,complete=function(ab)
ab.element.set(ab.args[1],ab.targetText:gsub("%s+$",""))end})
da.registerAnimation("typewrite",{start=function(ab)ab.targetText=ab.args[2]
ab.element.set(ab.args[1],"")end,update=function(ab,bb)
local cb=math.floor(#ab.targetText*bb)
ab.element.set(ab.args[1],ab.targetText:sub(1,cb))return bb>=1 end})
da.registerAnimation("fadeText",{start=function(ab)ab.chars={}for i=1,#ab.args[2]do
ab.chars[i]={char=ab.args[2]:sub(i,i),visible=false}end end,update=function(ab,bb)
local cb=""for db,_c in ipairs(ab.chars)do
if math.random()<bb then _c.visible=true end
cb=cb.. (_c.visible and _c.char or" ")end
ab.element.set(ab.args[1],cb)return bb>=1 end})
da.registerAnimation("scrollText",{start=function(ab)ab.width=ab.element.get("width")ab.startText=
ab.element.get(ab.args[1])or""
ab.targetText=ab.args[2]or""ab.startText=tostring(ab.startText)
ab.targetText=tostring(ab.targetText)end,update=function(ab,bb)
local cb=ab.width
if bb<0.5 then local db=bb/0.5;local _c=math.floor(cb*db)
local ac=(
ab.startText:sub(_c+1)..string.rep(" ",cb)):sub(1,cb)ab.element.set(ab.args[1],ac)else
local db=(bb-0.5)/0.5;local _c=math.floor(cb* (1 -db))
local ac=string.rep(" ",_c)..ab.targetText;local bc=ac:sub(1,cb)ab.element.set(ab.args[1],bc)end;return bb>=1 end,complete=function(ab)local bb=(
ab.targetText..string.rep(" ",ab.width))
ab.element.set(ab.args[1],bb)end})
da.registerAnimation("marquee",{start=function(ab)ab.width=ab.element.get("width")ab.text=tostring(
ab.args[2]or"")
ab.speed=tonumber(ab.args[3])or 0.15;ab.offset=0;ab.lastShift=-1
ab.padded=ab.text..string.rep(" ",ab.width)end,update=function(ab,bb)local cb=
os.epoch("local")/1000 -ab.startTime
local db=math.max(0.01,ab.speed)local _c=math.floor(cb/db)
if _c~=ab.lastShift then ab.lastShift=_c
local ac=#ab.padded;local bc=(_c%ac)+1;local cc=ab.padded..ab.padded
local dc=cc:sub(bc,bc+ab.width-1)ab.element.set(ab.args[1],dc)end;return false end,complete=function(ab)
end})local _b={hooks={}}
function _b.hooks.handleEvent(ab,bb,...)if bb=="timer"then local cb=ab.get("animation")if cb then
cb:event(bb,...)end end end
function _b.setup(ab)
ab.defineProperty(ab,"animation",{default=nil,type="table"})ab.defineEvent(ab,"timer")end
function _b.stopAnimation(ab)local bb=ab.get("animation")
if
bb and type(bb.stop)=="function"then bb:stop()else ab.set("animation",nil)end;return ab end
function _b:animate()local ab=da.new(self)self.set("animation",ab)return ab end;return{VisualElement=_b} end
project["plugins/benchmark.lua"] = function(...) local ca=require("log")local da=setmetatable({},{__mode="k"})local function _b()return
{methods={}}end
local function ab(_c,ac)local bc=_c[ac]
if not da[_c]then da[_c]=_b()end
if not da[_c].methods[ac]then
da[_c].methods[ac]={calls=0,totalTime=0,minTime=math.huge,maxTime=0,lastTime=0,startTime=0,path={},methodName=ac,originalMethod=bc}end
_c[ac]=function(cc,...)cc:startProfile(ac)local dc=bc(cc,...)
cc:endProfile(ac)return dc end end;local bb={}
function bb:startProfile(_c)local ac=da[self]if not ac then ac=_b()da[self]=ac end;if not
ac.methods[_c]then
ac.methods[_c]={calls=0,totalTime=0,minTime=math.huge,maxTime=0,lastTime=0,startTime=0,path={},methodName=_c}end
local bc=ac.methods[_c]bc.startTime=os.clock()*1000;bc.path={}local cc=self;while cc do
table.insert(bc.path,1,
cc.get("name")or cc.get("id"))cc=cc.parent end;return self end
function bb:endProfile(_c)local ac=da[self]
if not ac or not ac.methods[_c]then return self end;local bc=ac.methods[_c]local cc=os.clock()*1000
local dc=cc-bc.startTime;bc.calls=bc.calls+1;bc.totalTime=bc.totalTime+dc
bc.minTime=math.min(bc.minTime,dc)bc.maxTime=math.max(bc.maxTime,dc)bc.lastTime=dc;return self end
function bb:benchmark(_c)if not self[_c]then
ca.error("Method ".._c.." does not exist")return self end;da[self]=_b()
da[self].methodName=_c;da[self].isRunning=true;ab(self,_c)return self end
function bb:logBenchmark(_c)local ac=da[self]
if not ac or not ac.methods[_c]then return self end;local bc=ac.methods[_c]
if bc then local cc=
bc.calls>0 and(bc.totalTime/bc.calls)or 0
ca.info(string.format(
"Benchmark results for %s.%s: "..
"Path: %s ".."Calls: %d "..
"Average time: %.2fms ".."Min time: %.2fms ".."Max time: %.2fms "..
"Last time: %.2fms ".."Total time: %.2fms",table.concat(bc.path,"."),bc.methodName,table.concat(bc.path,"/"),bc.calls,cc,
bc.minTime~=math.huge and bc.minTime or 0,bc.maxTime,bc.lastTime,bc.totalTime))end;return self end
function bb:stopBenchmark(_c)local ac=da[self]
if not ac or not ac.methods[_c]then return self end;local bc=ac.methods[_c]if bc and bc.originalMethod then
self[_c]=bc.originalMethod end;ac.methods[_c]=nil;if
not next(ac.methods)then da[self]=nil end;return self end
function bb:getBenchmarkStats(_c)local ac=da[self]
if not ac or not ac.methods[_c]then return nil end;local bc=ac.methods[_c]return
{averageTime=bc.totalTime/bc.calls,totalTime=bc.totalTime,calls=bc.calls,minTime=bc.minTime,maxTime=bc.maxTime,lastTime=bc.lastTime}end;local cb={}
function cb:benchmarkContainer(_c)self:benchmark(_c)
for ac,bc in
pairs(self.get("children"))do bc:benchmark(_c)if bc:isType("Container")then
bc:benchmarkContainer(_c)end end;return self end
function cb:logContainerBenchmarks(_c,ac)ac=ac or 0;local bc=string.rep("  ",ac)local cc=0;local dc={}
for ad,bd in
pairs(self.get("children"))do local cd=da[bd]
if cd and cd.methods[_c]then local dd=cd.methods[_c]
cc=cc+dd.totalTime
table.insert(dc,{element=bd,type=bd.get("type"),calls=dd.calls,totalTime=dd.totalTime,avgTime=dd.totalTime/dd.calls})end end;local _d=da[self]
if _d and _d.methods[_c]then local ad=_d.methods[_c]
local bd=ad.totalTime-cc;local cd=bd/ad.calls
ca.info(string.format("%sBenchmark %s (%s): ".."%.2fms/call (Self: %.2fms/call) "..
"[Total: %dms, Calls: %d]",bc,self.get("type"),_c,
ad.totalTime/ad.calls,cd,ad.totalTime,ad.calls))
if#dc>0 then
for dd,__a in ipairs(dc)do
if __a.element:isType("Container")then __a.element:logContainerBenchmarks(_c,
ac+1)else
ca.info(string.format("%s> %s: %.2fms/call [Total: %dms, Calls: %d]",
bc.." ",__a.type,__a.avgTime,__a.totalTime,__a.calls))end end end end;return self end
function cb:stopContainerBenchmark(_c)
for ac,bc in pairs(self.get("children"))do if bc:isType("Container")then
bc:stopContainerBenchmark(_c)else bc:stopBenchmark(_c)end end;self:stopBenchmark(_c)return self end;local db={}
function db.start(_c,ac)ac=ac or{}local bc=_b()bc.name=_c
bc.startTime=os.clock()*1000;bc.custom=true;bc.calls=0;bc.totalTime=0;bc.minTime=math.huge;bc.maxTime=0
bc.lastTime=0;da[_c]=bc end
function db.stop(_c)local ac=da[_c]if not ac or not ac.custom then return end;local bc=
os.clock()*1000;local cc=bc-ac.startTime;ac.calls=ac.calls+1;ac.totalTime=
ac.totalTime+cc;ac.minTime=math.min(ac.minTime,cc)
ac.maxTime=math.max(ac.maxTime,cc)ac.lastTime=cc
ca.info(string.format("Custom Benchmark '%s': "..
"Calls: %d ".."Average time: %.2fms "..
"Min time: %.2fms "..
"Max time: %.2fms ".."Last time: %.2fms ".."Total time: %.2fms",_c,ac.calls,
ac.totalTime/ac.calls,ac.minTime,ac.maxTime,ac.lastTime,ac.totalTime))end
function db.getStats(_c)local ac=da[_c]if not ac then return nil end;return
{averageTime=ac.totalTime/ac.calls,totalTime=ac.totalTime,calls=ac.calls,minTime=ac.minTime,maxTime=ac.maxTime,lastTime=ac.lastTime}end;function db.clear(_c)da[_c]=nil end;function db.clearAll()for _c,ac in pairs(da)do
if ac.custom then da[_c]=nil end end end;return
{BaseElement=bb,Container=cb,API=db} end
project["elementManager.lua"] = function(...) local ab=table.pack(...)
local bb=fs.getDir(ab[2]or"basalt")local cb=ab[1]if(bb==nil)then
error("Unable to find directory "..
ab[2].." please report this bug to our discord.")end
local db=require("log")local _c=package.path;local ac="path;/path/?.lua;/path/?/init.lua;"
local bc=ac:gsub("path",bb)local cc={}cc._elements={}cc._plugins={}cc._APIs={}
local dc=fs.combine(bb,"elements")local _d=fs.combine(bb,"plugins")
db.info("Loading elements from "..dc)
if fs.exists(dc)then
for ad,bd in ipairs(fs.list(dc))do local cd=bd:match("(.+).lua")if cd then db.debug(
"Found element: "..cd)
cc._elements[cd]={class=nil,plugins={},loaded=false}end end end;db.info("Loading plugins from ".._d)
if
fs.exists(_d)then
for ad,bd in ipairs(fs.list(_d))do local cd=bd:match("(.+).lua")
if cd then
db.debug("Found plugin: "..cd)local dd=require(fs.combine("plugins",cd))
if
type(dd)=="table"then
for __a,a_a in pairs(dd)do if(__a~="API")then
if(cc._plugins[__a]==nil)then cc._plugins[__a]={}end;table.insert(cc._plugins[__a],a_a)else
cc._APIs[cd]=a_a end end end end end end
if(minified)then if(minified_elementDirectory==nil)then
error("Unable to find minified_elementDirectory please report this bug to our discord.")end;for ad,bd in
pairs(minified_elementDirectory)do
cc._elements[ad:gsub(".lua","")]={class=nil,plugins={},loaded=false}end;if
(minified_pluginDirectory==nil)then
error("Unable to find minified_pluginDirectory please report this bug to our discord.")end
for ad,bd in
pairs(minified_pluginDirectory)do local cd=ad:gsub(".lua","")
local dd=require(fs.combine("plugins",cd))
if type(dd)=="table"then
for __a,a_a in pairs(dd)do
if(__a~="API")then if(cc._plugins[__a]==nil)then
cc._plugins[__a]={}end
table.insert(cc._plugins[__a],a_a)else cc._APIs[cd]=a_a end end end end end
function cc.loadElement(ad)
if not cc._elements[ad].loaded then
package.path=bc.."rom/?"local bd=require(fs.combine("elements",ad))
package.path=_c;cc._elements[ad]={class=bd,plugins=bd.plugins,loaded=true}db.debug(
"Loaded element: "..ad)
if(cc._plugins[ad]~=nil)then
for cd,dd in
pairs(cc._plugins[ad])do if(dd.setup)then dd.setup(bd)end
if(dd.hooks)then
for __a,a_a in pairs(dd.hooks)do
local b_a=bd[__a]if(type(b_a)~="function")then
error("Element "..
ad.." does not have a method "..__a)end
if(type(a_a)=="function")then
bd[__a]=function(c_a,...)
local d_a=b_a(c_a,...)local _aa=a_a(c_a,...)return _aa==nil and d_a or _aa end elseif(type(a_a)=="table")then
bd[__a]=function(c_a,...)if a_a.pre then a_a.pre(c_a,...)end
local d_a=b_a(c_a,...)if a_a.post then a_a.post(c_a,...)end;return d_a end end end end;for __a,a_a in pairs(dd)do
if __a~="setup"and __a~="hooks"then bd[__a]=a_a end end end end end end
function cc.getElement(ad)if not cc._elements[ad].loaded then
cc.loadElement(ad)end;return cc._elements[ad].class end;function cc.getElementList()return cc._elements end;function cc.getAPI(ad)
return cc._APIs[ad]end;return cc end
project["log.lua"] = function(...) local aa={}aa._logs={}aa._enabled=false;aa._logToFile=false
aa._logFile="basalt.log"fs.delete(aa._logFile)
aa.LEVEL={DEBUG=1,INFO=2,WARN=3,ERROR=4}
local ba={[aa.LEVEL.DEBUG]="Debug",[aa.LEVEL.INFO]="Info",[aa.LEVEL.WARN]="Warn",[aa.LEVEL.ERROR]="Error"}
local ca={[aa.LEVEL.DEBUG]=colors.lightGray,[aa.LEVEL.INFO]=colors.white,[aa.LEVEL.WARN]=colors.yellow,[aa.LEVEL.ERROR]=colors.red}function aa.setLogToFile(ab)aa._logToFile=ab end
function aa.setEnabled(ab)aa._enabled=ab end;local function da(ab)
if aa._logToFile then local bb=io.open(aa._logFile,"a")if bb then
bb:write(ab.."\n")bb:close()end end end
local function _b(ab,...)if
not aa._enabled then return end;local bb=os.date("%H:%M:%S")
local cb=debug.getinfo(3,"Sl")local db=cb.source:match("@?(.*)")local _c=cb.currentline
local ac=string.format("[%s:%d]",db:match("([^/\\]+)%.lua$"),_c)local bc="["..ba[ab].."]"local cc=""
for _d,ad in ipairs(table.pack(...))do if _d>1 then cc=
cc.." "end;cc=cc..tostring(ad)end;local dc=string.format("%s %s%s %s",bb,ac,bc,cc)da(dc)
table.insert(aa._logs,{time=bb,level=ab,message=cc})end;function aa.debug(...)_b(aa.LEVEL.DEBUG,...)end;function aa.info(...)
_b(aa.LEVEL.INFO,...)end
function aa.warn(...)_b(aa.LEVEL.WARN,...)end;function aa.error(...)_b(aa.LEVEL.ERROR,...)end;return aa end
project["propertySystem.lua"] = function(...) local ba=require("libraries/utils").deepCopy
local ca=require("libraries/expect")local da=require("errorManager")local _b={}_b.__index=_b
_b._properties={}local ab={}_b._setterHooks={}function _b.addSetterHook(cb)
table.insert(_b._setterHooks,cb)end
local function bb(cb,db,_c,ac)for bc,cc in ipairs(_b._setterHooks)do
local dc=cc(cb,db,_c,ac)if dc~=nil then _c=dc end end;return _c end
function _b.defineProperty(cb,db,_c)
if not rawget(cb,'_properties')then cb._properties={}end
cb._properties[db]={type=_c.type,default=_c.default,canTriggerRender=_c.canTriggerRender,getter=_c.getter,setter=_c.setter,allowNil=_c.allowNil}local ac=db:sub(1,1):upper()..db:sub(2)
cb[
"get"..ac]=function(bc,...)ca(1,bc,"element")local cc=bc._values[db]
if type(cc)==
"function"and _c.type~="function"then cc=cc(bc)end
return _c.getter and _c.getter(bc,cc,...)or cc end
cb["set"..ac]=function(bc,cc,...)ca(1,bc,"element")cc=bb(bc,db,cc,_c)if
type(cc)~="function"then
if _c.type=="table"then if cc==nil then
if not _c.allowNil then ca(2,cc,_c.type)end end else ca(2,cc,_c.type)end end;if
_c.setter then cc=_c.setter(bc,cc,...)end
bc:_updateProperty(db,cc)return bc end end
function _b.combineProperties(cb,db,...)local _c={...}for bc,cc in pairs(_c)do
if not cb._properties[cc]then da.error("Property not found: "..
cc)end end;local ac=
db:sub(1,1):upper()..db:sub(2)
cb["get"..ac]=function(bc)
ca(1,bc,"element")local cc={}
for dc,_d in pairs(_c)do table.insert(cc,bc.get(_d))end;return table.unpack(cc)end
cb["set"..ac]=function(bc,...)ca(1,bc,"element")local cc={...}for dc,_d in pairs(_c)do
bc.set(_d,cc[dc])end;return bc end end
function _b.blueprint(cb,db,_c,ac)
if not ab[cb]then
local cc={basalt=_c,__isBlueprint=true,_values=db or{},_events={},render=function()end,dispatchEvent=function()end,init=function()end}
cc.loaded=function(_d,ad)_d.loadedCallback=ad;return cc end
cc.create=function(_d)local ad=cb.new()ad:init({},_d.basalt)for bd,cd in pairs(_d._values)do
ad._values[bd]=cd end;for bd,cd in pairs(_d._events)do
for dd,__a in ipairs(cd)do ad[bd](ad,__a)end end
if(ac~=nil)then ac:addChild(ad)end;ad:updateRender()_d.loadedCallback(ad)
ad:postInit()return ad end;local dc=cb
while dc do
if rawget(dc,'_properties')then for _d,ad in pairs(dc._properties)do
if
type(ad.default)=="table"then cc._values[_d]=ba(ad.default)else cc._values[_d]=ad.default end end end
dc=getmetatable(dc)and rawget(getmetatable(dc),'__index')end;ab[cb]=cc end;local bc={_values={},_events={},loadedCallback=function()end}
bc.get=function(cc)
local dc=bc._values[cc]local _d=cb._properties[cc]if
type(dc)=="function"and _d.type~="function"then dc=dc(bc)end;return dc end
bc.set=function(cc,dc)bc._values[cc]=dc;return bc end
setmetatable(bc,{__index=function(cc,dc)
if dc:match("^on%u")then return
function(_d,ad)
cc._events[dc]=cc._events[dc]or{}table.insert(cc._events[dc],ad)return cc end end
if dc:match("^get%u")then
local _d=dc:sub(4,4):lower()..dc:sub(5)return function()return cc._values[_d]end end;if dc:match("^set%u")then
local _d=dc:sub(4,4):lower()..dc:sub(5)
return function(ad,bd)cc._values[_d]=bd;return cc end end
return ab[cb][dc]end})return bc end
function _b.createFromBlueprint(cb,db,_c)local ac=cb.new({},_c)
for bc,cc in pairs(db._values)do if type(cc)=="table"then
ac._values[bc]=ba(cc)else ac._values[bc]=cc end end;return ac end
function _b:__init()self._values={}self._observers={}
self.set=function(bc,cc,...)
local dc=self._values[bc]local _d=self._properties[bc]
if(_d~=nil)then if(_d.setter)then
cc=_d.setter(self,cc,...)end
if _d.canTriggerRender then self:updateRender()end;self._values[bc]=bb(self,bc,cc,_d)if
dc~=cc and self._observers[bc]then
for ad,bd in ipairs(self._observers[bc])do bd(self,cc,dc)end end end end
self.get=function(bc,...)local cc=self._values[bc]local dc=self._properties[bc]
if
(dc==nil)then da.error("Property not found: "..bc)return end;if type(cc)=="function"and dc.type~="function"then
cc=cc(self)end;return
dc.getter and dc.getter(self,cc,...)or cc end;local cb={}local db=getmetatable(self).__index
while db do if
rawget(db,'_properties')then
for bc,cc in pairs(db._properties)do if not cb[bc]then cb[bc]=cc end end end;db=getmetatable(db)and
rawget(getmetatable(db),'__index')end;self._properties=cb;local _c=getmetatable(self)local ac=_c.__index
setmetatable(self,{__index=function(bc,cc)
local dc=self._properties[cc]
if dc then local _d=self._values[cc]if
type(_d)=="function"and dc.type~="function"then _d=_d(self)end;return _d end
if type(ac)=="function"then return ac(bc,cc)else return ac[cc]end end,__newindex=function(bc,cc,dc)
local _d=self._properties[cc]
if _d then if _d.setter then dc=_d.setter(self,dc)end
dc=bb(self,cc,dc,_d)self:_updateProperty(cc,dc)else rawset(bc,cc,dc)end end,__tostring=function(bc)return
string.format("Object: %s (id: %s)",bc._values.type,bc.id)end})
for bc,cc in pairs(cb)do if self._values[bc]==nil then
if type(cc.default)=="table"then
self._values[bc]=ba(cc.default)else self._values[bc]=cc.default end end end;return self end
function _b:_updateProperty(cb,db)local _c=self._values[cb]
if type(_c)=="function"then _c=_c(self)end;self._values[cb]=db
local ac=type(db)=="function"and db(self)or db
if _c~=ac then
if self._properties[cb].canTriggerRender then self:updateRender()end
if self._observers[cb]then for bc,cc in ipairs(self._observers[cb])do
cc(self,ac,_c)end end end;return self end
function _b:observe(cb,db)
self._observers[cb]=self._observers[cb]or{}table.insert(self._observers[cb],db)return self end
function _b:removeObserver(cb,db)
if self._observers[cb]then
for _c,ac in ipairs(self._observers[cb])do if ac==db then
table.remove(self._observers[cb],_c)
if#self._observers[cb]==0 then self._observers[cb]=nil end;break end end end;return self end;function _b:removeAllObservers(cb)
if cb then self._observers[cb]=nil else self._observers={}end;return self end
function _b:instanceProperty(cb,db)
_b.defineProperty(self,cb,db)self._values[cb]=db.default;return self end
function _b:removeProperty(cb)self._values[cb]=nil;self._properties[cb]=nil;self._observers[cb]=
nil
local db=cb:sub(1,1):upper()..cb:sub(2)self["get"..db]=nil;self["set"..db]=nil;return self end
function _b:getPropertyConfig(cb)return self._properties[cb]end;return _b end
project["main.lua"] = function(...) local ad=require("elementManager")
local bd=require("errorManager")local cd=require("propertySystem")
local dd=require("libraries/expect")local __a={}__a.traceback=true;__a._events={}__a._schedule={}
__a._eventQueue={}__a._plugins={}__a.isRunning=false;__a.LOGGER=require("log")
if(minified)then
__a.path=fs.getDir(shell.getRunningProgram())else __a.path=fs.getDir(select(2,...))end;local a_a=nil;local b_a=nil;local c_a={}local d_a=type;local _aa={}local aaa=10;local baa=0;local caa=false
local function daa()
if(caa)then return end;baa=os.startTimer(0.2)caa=true end
local function _ba(aca)for _=1,aca do local bca=_aa[1]if(bca)then bca:create()end
table.remove(_aa,1)end end;local function aba(aca,bca)
if(aca=="timer")then if(bca==baa)then _ba(aaa)caa=false;baa=0;if(#_aa>0)then daa()end
return true end end end
function __a.create(aca,bca,cca,dca)if(
d_a(bca)=="string")then bca={name=bca}end
if(bca==nil)then bca={name=aca}end;local _da=ad.getElement(aca)
if(cca)then
local ada=cd.blueprint(_da,bca,__a,dca)table.insert(_aa,ada)daa()return ada else local ada=_da.new()
ada:init(bca,__a)return ada end end
function __a.createFrame()local aca=__a.create("BaseFrame")aca:postInit()if
(a_a==nil)then a_a=tostring(term.current())
__a.setActiveFrame(aca,true)end;return aca end;function __a.getElementManager()return ad end
function __a.getErrorManager()return bd end
function __a.getMainFrame()local aca=tostring(term.current())if(c_a[aca]==nil)then
a_a=aca;__a.createFrame()end;return c_a[aca]end
function __a.setActiveFrame(aca,bca)local cca=aca:getTerm()if(bca==nil)then bca=true end
if(cca~=nil)then c_a[tostring(cca)]=
bca and aca or nil;aca:updateRender()end end;function __a.getActiveFrame(aca)if(aca==nil)then aca=term.current()end;return
c_a[tostring(aca)]end
function __a.setFocus(aca)if
(b_a==aca)then return end
if(b_a~=nil)then b_a:dispatchEvent("blur")end;b_a=aca
if(b_a~=nil)then b_a:dispatchEvent("focus")end end;function __a.getFocus()return b_a end
function __a.schedule(aca)dd(1,aca,"function")
local bca=coroutine.create(aca)local cca,dca=coroutine.resume(bca)
if(cca)then
table.insert(__a._schedule,{coroutine=bca,filter=dca})else bd.header="Basalt Schedule Error"bd.error(dca)end;return bca end
function __a.removeSchedule(aca)
for bca,cca in ipairs(__a._schedule)do if(cca.coroutine==aca)then
table.remove(__a._schedule,bca)return true end end;return false end
local bba={mouse_click=true,mouse_up=true,mouse_scroll=true,mouse_drag=true}local cba={key=true,key_up=true,char=true}
local function dba(aca,...)if(aca=="terminate")then __a.stop()
return end;if aba(aca,...)then return end;local bca={...}
local function cca()
if(bba[aca])then if
c_a[a_a]then
c_a[a_a]:dispatchEvent(aca,table.unpack(bca))end elseif(cba[aca])then if(b_a~=nil)then
b_a:dispatchEvent(aca,table.unpack(bca))end else for bda,cda in pairs(c_a)do
cda:dispatchEvent(aca,table.unpack(bca))end end end
for bda,cda in pairs(__a._eventQueue)do
if
coroutine.status(cda.coroutine)=="suspended"then
if cda.filter==aca or cda.filter==nil then cda.filter=nil
local dda,__b=coroutine.resume(cda.coroutine,aca,...)
if not dda then bd.header="Basalt Event Error"bd.error(__b)end;cda.filter=__b end end;if coroutine.status(cda.coroutine)=="dead"then
table.remove(__a._eventQueue,bda)end end;local dca={coroutine=coroutine.create(cca),filter=aca}
local _da,ada=coroutine.resume(dca.coroutine,aca,...)
if(not _da)then bd.header="Basalt Event Error"bd.error(ada)end;if(ada~=nil)then dca.filter=ada end
table.insert(__a._eventQueue,dca)
for bda,cda in ipairs(__a._schedule)do
if
coroutine.status(cda.coroutine)=="suspended"then
if aca==cda.filter or cda.filter==nil then cda.filter=nil
local dda,__b=coroutine.resume(cda.coroutine,aca,...)
if(not dda)then bd.header="Basalt Schedule Error"bd.error(__b)end;cda.filter=__b end end;if(coroutine.status(cda.coroutine)=="dead")then
__a.removeSchedule(cda.coroutine)end end;if __a._events[aca]then
for bda,cda in ipairs(__a._events[aca])do cda(...)end end end;local function _ca()
for aca,bca in pairs(c_a)do bca:render()bca:postRender()end end
function __a.update(...)local aca=function(...)__a.isRunning=true
dba(...)_ca()end
local bca,cca=pcall(aca,...)
if not(bca)then bd.header="Basalt Runtime Error"bd.error(cca)end;__a.isRunning=false end;function __a.stop()__a.isRunning=false;term.clear()
term.setCursorPos(1,1)end
function __a.run(aca)if(__a.isRunning)then
bd.error("Basalt is already running")end;if(aca==nil)then __a.isRunning=true else
__a.isRunning=aca end
local function bca()_ca()while __a.isRunning do
dba(os.pullEventRaw())if(__a.isRunning)then _ca()end end end
while __a.isRunning do local cca,dca=pcall(bca)if not(cca)then bd.header="Basalt Runtime Error"
bd.error(dca)end end end;function __a.getElementClass(aca)return ad.getElement(aca)end;function __a.getAPI(aca)return
ad.getAPI(aca)end
function __a.onEvent(aca,bca)dd(1,aca,"string")
dd(2,bca,"function")
if not __a._events[aca]then __a._events[aca]={}end;table.insert(__a._events[aca],bca)end
function __a.removeEvent(aca,bca)dd(1,aca,"string")dd(2,bca,"function")if not
__a._events[aca]then return false end;for cca,dca in ipairs(__a._events[aca])do
if
dca==bca then table.remove(__a._events[aca],cca)return true end end;return false end
function __a.triggerEvent(aca,...)dd(1,aca,"string")
if __a._events[aca]then
for bca,cca in
ipairs(__a._events[aca])do local dca,_da=pcall(cca,...)if not dca then bd.header="Basalt Event Callback Error"
bd.error(
"Error in event callback for '"..aca.."': "..tostring(_da))end end end end;return __a end
project["libraries/colorHex.lua"] = function(...) local b={}for i=0,15 do b[2 ^i]=("%x"):format(i)
b[("%x"):format(i)]=2 ^i end;return b end
project["libraries/utils.lua"] = function(...) local d,_a=math.floor,string.len;local aa={}
function aa.getCenteredPosition(ba,ca,da)local _b=_a(ba)local ab=d(
(ca-_b+1)/2 +0.5)local bb=d(da/2 +0.5)return ab,bb end
function aa.deepCopy(ba)if type(ba)~="table"then return ba end;local ca={}for da,_b in pairs(ba)do
ca[aa.deepCopy(da)]=aa.deepCopy(_b)end;return ca end
function aa.copy(ba)local ca={}for da,_b in pairs(ba)do ca[da]=_b end;return ca end;function aa.reverse(ba)local ca={}for i=#ba,1,-1 do table.insert(ca,ba[i])end
return ca end
function aa.uuid()
return
string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff),
math.random(0,0x0fff)+0x4000,math.random(0,0x3fff)+0x8000,math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff))end
function aa.split(ba,ca)local da={}for _b in(ba..ca):gmatch("(.-)"..ca)do
table.insert(da,_b)end;return da end;function aa.removeTags(ba)return ba:gsub("{[^}]+}","")end
function aa.wrapText(ba,ca)if
ba==nil then return{}end;ba=aa.removeTags(ba)local da={}
local _b=aa.split(ba,"\n\n")
for ab,bb in ipairs(_b)do
if#bb==0 then table.insert(da,"")if ab<#_b then
table.insert(da,"")end else local cb=aa.split(bb,"\n")
for db,_c in ipairs(cb)do
local ac=aa.split(_c," ")local bc=""
for cc,dc in ipairs(ac)do if#bc==0 then bc=dc elseif#bc+#dc+1 <=ca then bc=bc.." "..dc else
table.insert(da,bc)bc=dc end end;if#bc>0 then table.insert(da,bc)end end;if ab<#_b then table.insert(da,"")end end end;return da end;return aa end
project["libraries/expect.lua"] = function(...) local c=require("errorManager")
local function d(_a,aa,ba)local ca=type(aa)
if ba=="element"then if ca=="table"and
aa.get("type")~=nil then return true end end
if ba=="color"then if ca=="number"then return true end;if
ca=="string"and colors[aa]then return true end end;if ca~=ba then c.header="Basalt Type Error"
c.error(string.format("Bad argument #%d: expected %s, got %s",_a,ba,ca))end;return true end;return d end
return project["main.lua"]()