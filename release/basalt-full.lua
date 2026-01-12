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
minified_elementDirectory["ScrollFrame"] = {}
minified_elementDirectory["TabControl"] = {}
minified_elementDirectory["TextBox"] = {}
minified_elementDirectory["Button"] = {}
minified_elementDirectory["Label"] = {}
minified_elementDirectory["SideNav"] = {}
minified_elementDirectory["Input"] = {}
minified_elementDirectory["Toast"] = {}
minified_elementDirectory["BigFont"] = {}
minified_elementDirectory["Switch"] = {}
minified_elementDirectory["Frame"] = {}
minified_elementDirectory["Container"] = {}
minified_elementDirectory["Dialog"] = {}
minified_elementDirectory["Tree"] = {}
minified_elementDirectory["DropDown"] = {}
minified_elementDirectory["Display"] = {}
minified_elementDirectory["Breadcrumb"] = {}
minified_elementDirectory["LineChart"] = {}
minified_elementDirectory["Graph"] = {}
minified_elementDirectory["Table"] = {}
minified_elementDirectory["Menu"] = {}
minified_elementDirectory["Slider"] = {}
minified_elementDirectory["ScrollBar"] = {}
minified_elementDirectory["VisualElement"] = {}
minified_elementDirectory["ProgressBar"] = {}
minified_elementDirectory["CheckBox"] = {}
minified_elementDirectory["BaseElement"] = {}
minified_elementDirectory["ContextMenu"] = {}
minified_elementDirectory["List"] = {}
minified_elementDirectory["Collection"] = {}
minified_elementDirectory["Accordion"] = {}
minified_pluginDirectory["store"] = {}
minified_pluginDirectory["canvas"] = {}
minified_pluginDirectory["theme"] = {}
minified_pluginDirectory["reactive"] = {}
minified_pluginDirectory["xml"] = {}
minified_pluginDirectory["debug"] = {}
minified_pluginDirectory["animation"] = {}
minified_pluginDirectory["benchmark"] = {}
minified_pluginDirectory["responsive"] = {}
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
project["elements/BaseFrame.lua"] = function(...) local aa=require("elementManager")
local ba=aa.getElement("Container")local ca=require("render")local da=setmetatable({},ba)da.__index=da
local function _b(ab)
local bb,cb=pcall(function()return
peripheral.getType(ab)end)if bb then return true end;return false end
da.defineProperty(da,"term",{default=nil,type="table",setter=function(ab,bb)ab._peripheralName=nil;if
ab.basalt.getActiveFrame(ab._values.term)==ab then
ab.basalt.setActiveFrame(ab,false)end;if
bb==nil or bb.setCursorPos==nil then return bb end;if(_b(bb))then
ab._peripheralName=peripheral.getName(bb)end;ab._values.term=bb
if
ab.basalt.getActiveFrame(bb)==nil then ab.basalt.setActiveFrame(ab)end;ab._render=ca.new(bb)ab._renderUpdate=true;local cb,db=bb.getSize()
ab.set("width",cb)ab.set("height",db)return bb end})function da.new()local ab=setmetatable({},da):__init()
ab.class=da;return ab end;function da:init(ab,bb)
ba.init(self,ab,bb)self.set("term",term.current())
self.set("type","BaseFrame")return self end
function da:multiBlit(ab,bb,cb,db,_c,ac,bc)if
(ab<1)then cb=cb+ab-1;ab=1 end;if(bb<1)then db=db+bb-1;bb=1 end
self._render:multiBlit(ab,bb,cb,db,_c,ac,bc)end;function da:textFg(ab,bb,cb,db)if ab<1 then cb=string.sub(cb,1 -ab)ab=1 end
self._render:textFg(ab,bb,cb,db)end;function da:textBg(ab,bb,cb,db)if ab<1 then cb=string.sub(cb,1 -
ab)ab=1 end
self._render:textBg(ab,bb,cb,db)end;function da:drawText(ab,bb,cb)if ab<1 then cb=string.sub(cb,
1 -ab)ab=1 end
self._render:text(ab,bb,cb)end
function da:drawFg(ab,bb,cb)if ab<1 then
cb=string.sub(cb,1 -ab)ab=1 end;self._render:fg(ab,bb,cb)end;function da:drawBg(ab,bb,cb)if ab<1 then cb=string.sub(cb,1 -ab)ab=1 end
self._render:bg(ab,bb,cb)end
function da:blit(ab,bb,cb,db,_c)
if ab<1 then
cb=string.sub(cb,1 -ab)db=string.sub(db,1 -ab)_c=string.sub(_c,1 -ab)ab=1 end;self._render:blit(ab,bb,cb,db,_c)end;function da:setCursor(ab,bb,cb,db)local _c=self.get("term")
self._render:setCursor(ab,bb,cb,db)end
function da:monitor_touch(ab,bb,cb)
local db=self.get("term")if db==nil then return end
if(_b(db))then if self._peripheralName==ab then
self:mouse_click(1,bb,cb)
self.basalt.schedule(function()sleep(0.1)self:mouse_up(1,bb,cb)end)end end end;function da:mouse_click(ab,bb,cb)ba.mouse_click(self,ab,bb,cb)
self.basalt.setFocus(self)end
function da:mouse_up(ab,bb,cb)
ba.mouse_up(self,ab,bb,cb)ba.mouse_release(self,ab,bb,cb)end
function da:term_resize()local ab,bb=self.get("term").getSize()
if(ab==
self.get("width")and bb==self.get("height"))then return end;self.set("width",ab)self.set("height",bb)
self._render:setSize(ab,bb)self._renderUpdate=true end
function da:key(ab)self:fireEvent("key",ab)ba.key(self,ab)end
function da:key_up(ab)self:fireEvent("key_up",ab)ba.key_up(self,ab)end
function da:char(ab)self:fireEvent("char",ab)ba.char(self,ab)end
function da:dispatchEvent(ab,...)local bb=self.get("term")if bb==nil then return end;if(_b(bb))then if
ab=="mouse_click"then return end end
ba.dispatchEvent(self,ab,...)end;function da:render()
if(self._renderUpdate)then if self._render~=nil then ba.render(self)
self._render:render()self._renderUpdate=false end end end
return da end
project["elements/Timer.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("BaseElement")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"interval",{default=1,type="number"})
aa.defineProperty(aa,"action",{default=function()end,type="function"})
aa.defineProperty(aa,"running",{default=false,type="boolean"})
aa.defineProperty(aa,"amount",{default=-1,type="number"})aa.defineEvent(aa,"timer")function aa.new()
local ba=setmetatable({},aa):__init()ba.class=aa;return ba end;function aa:init(ba,ca)
_a.init(self,ba,ca)self.set("type","Timer")end
function aa:start()
if
not self.running then self.running=true
local ba=self.getResolved("interval")self.timerId=os.startTimer(ba)end;return self end
function aa:stop()if self.running then self.running=false
os.cancelTimer(self.timerId)end;return self end
function aa:dispatchEvent(ba,...)_a.dispatchEvent(self,ba,...)
if ba=="timer"then
local ca=select(1,...)
if ca==self.timerId then self.action()
local da=self.getResolved("amount")if da>0 then self.set("amount",da-1)end;if da~=0 then
self.timerId=os.startTimer(self.getResolved("interval"))end end end end;return aa end
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
if b_a==nil then b_a=""end;dd=dd or"Unknown error"
local c_a=a_a(self.program,dd,b_a:gsub(dd,""))if(c_a==false)then self.filter=nil;return cd,dd end end;_b.header="Basalt Program Error ".._c;_b.error(dd)end
if coroutine.status(self.coroutine)=="dead"then
self.program.set("running",false)self.program.set("program",nil)
local __a=self.program.get("doneCallback")if __a then __a(self.program,cd,dd)end end else _b.header="Basalt Program Error ".._c
_b.error("File not found")end else _b.header="Basalt Program Error"
_b.error("Program ".._c.." not found")end end
function bb:resize(_c,ac)
if type(_c)~="number"or type(ac)~="number"then return end;self.window.reposition(1,1,_c,ac)
self:resume("term_resize",_c,ac)end
function bb:resume(_c,...)local ac={...}if(_c:find("mouse_"))then
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
local dc=self.getResolved("program")if dc then
dc:resize(self.get("width"),self.get("height"))end end)
self:observe("height",function(bc,cc)local dc=self.getResolved("program")if dc then
dc:resize(self.get("width"),self.get("height"))end end)return self end
function ab:execute(_c,ac,bc,...)self.set("path",_c)self.set("running",true)
local cc=bb.new(self,ac,bc)self.set("program",cc)cc:setArgs(...)
cc:run(_c,self.getResolved("width"),self.getResolved("height"),...)self:updateRender()return self end;function ab:stop()local _c=self.getResolved("program")if _c then _c:stop()
self.set("running",false)self.set("program",nil)end
return self end;function ab:sendEvent(_c,...)
self:dispatchEvent(_c,...)return self end;function ab:onError(_c)
self.set("errorCallback",_c)return self end;function ab:onDone(_c)
self.set("doneCallback",_c)return self end
function ab:dispatchEvent(_c,...)
local ac=self.getResolved("program")local bc=da.dispatchEvent(self,_c,...)
if ac then ac:resume(_c,...)
if
(self:hasState("focused"))then local cc=ac.window.getCursorBlink()
local dc,_d=ac.window.getCursorPos()
self:setCursor(dc,_d,cc,ac.window.getTextColor())end;self:updateRender()end;return bc end
function ab:focus()
if(da.focus(self))then local _c=self.getResolved("program")if _c then
local ac=_c.window.getCursorBlink()local bc,cc=_c.window.getCursorPos()
self:setCursor(bc,cc,ac,_c.window.getTextColor())end end end
function ab:render()da.render(self)local _c=self.getResolved("program")
if _c then
local ac,bc=_c.window.getSize()for y=1,bc do local cc,dc,_d=_c.window.getLine(y)if cc then
self:blit(1,y,cc,dc,_d)end end end end;return ab end
project["elements/Image.lua"] = function(...) local aa=require("elementManager")
local ba=aa.getElement("VisualElement")local ca=setmetatable({},ba)ca.__index=ca
ca.defineProperty(ca,"bimg",{default={{}},type="table",canTriggerRender=true})
ca.defineProperty(ca,"currentFrame",{default=1,type="number",canTriggerRender=true})
ca.defineProperty(ca,"autoResize",{default=false,type="boolean"})
ca.defineProperty(ca,"offsetX",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"offsetY",{default=0,type="number",canTriggerRender=true})
ca.combineProperties(ca,"offset","offsetX","offsetY")
function ca.new()local ab=setmetatable({},ca):__init()
ab.class=ca;ab.set("width",12)ab.set("height",6)
ab.set("background",colors.black)ab.set("z",5)return ab end;function ca:init(ab,bb)ba.init(self,ab,bb)self.set("type","Image")
return self end
function ca:resizeImage(ab,bb)
local cb=self.getResolved("bimg")
for db,_c in ipairs(cb)do local ac={}
for y=1,bb do local bc=string.rep(" ",ab)
local cc=string.rep("f",ab)local dc=string.rep("0",ab)
if _c[y]and _c[y][1]then local _d=_c[y][1]
local ad=_c[y][2]local bd=_c[y][3]
bc=(_d..string.rep(" ",ab)):sub(1,ab)
cc=(ad..string.rep("f",ab)):sub(1,ab)
dc=(bd..string.rep("0",ab)):sub(1,ab)end;ac[y]={bc,cc,dc}end;cb[db]=ac end;self:updateRender()return self end
function ca:getImageSize()local ab=self.getResolved("bimg")if
not ab[1]or not ab[1][1]then return 0,0 end;return#ab[1][1][1],#ab[1]end
function ca:getPixelData(ab,bb)
local cb=self.getResolved("bimg")[self.getResolved("currentFrame")]if not cb or not cb[bb]then return end;local db=cb[bb][1]
local _c=cb[bb][2]local ac=cb[bb][3]
if not db or not _c or not ac then return end;local bc=tonumber(_c:sub(ab,ab),16)
local cc=tonumber(ac:sub(ab,ab),16)local dc=db:sub(ab,ab)return bc,cc,dc end
local function da(ab,bb)
local cb=ab.getResolved("bimg")[ab.getResolved("currentFrame")]if not cb then cb={}
ab.getResolved("bimg")[ab.getResolved("currentFrame")]=cb end
if not cb[bb]then cb[bb]={"","",""}end;return cb end
local function _b(ab,bb,cb)if not ab.getResolved("autoResize")then return end
local db=ab.getResolved("bimg")local _c=bb;local ac=cb
for bc,cc in ipairs(db)do for dc,_d in pairs(cc)do _c=math.max(_c,#_d[1])
ac=math.max(ac,dc)end end
for bc,cc in ipairs(db)do
for y=1,ac do if not cc[y]then cc[y]={"","",""}end;local dc=cc[y]while#dc[1]<
_c do dc[1]=dc[1].." "end;while#dc[2]<_c do
dc[2]=dc[2].."f"end;while#dc[3]<_c do dc[3]=dc[3].."0"end end end end
function ca:setText(ab,bb,cb)if
type(cb)~="string"or#cb<1 or ab<1 or bb<1 then return self end
if
not self.getResolved("autoResize")then local ac,bc=self:getImageSize()if bb>bc then return self end end;local db=da(self,bb)if self.getResolved("autoResize")then
_b(self,ab+#cb-1,bb)else local ac=#db[bb][1]if ab>ac then return self end
cb=cb:sub(1,ac-ab+1)end
local _c=db[bb][1]
db[bb][1]=_c:sub(1,ab-1)..cb.._c:sub(ab+#cb)self:updateRender()return self end
function ca:getText(ab,bb,cb)if not ab or not bb then return""end
local db=self.getResolved("bimg")[self.getResolved("currentFrame")]if not db or not db[bb]then return""end;local _c=db[bb][1]if not _c then
return""end
if cb then return _c:sub(ab,ab+cb-1)else return _c:sub(ab,ab)end end
function ca:setFg(ab,bb,cb)if
type(cb)~="string"or#cb<1 or ab<1 or bb<1 then return self end
if
not self.getResolved("autoResize")then local ac,bc=self:getImageSize()if bb>bc then return self end end;local db=da(self,bb)if self.getResolved("autoResize")then
_b(self,ab+#cb-1,bb)else local ac=#db[bb][2]if ab>ac then return self end
cb=cb:sub(1,ac-ab+1)end
local _c=db[bb][2]
db[bb][2]=_c:sub(1,ab-1)..cb.._c:sub(ab+#cb)self:updateRender()return self end
function ca:getFg(ab,bb,cb)if not ab or not bb then return""end
local db=self.getResolved("bimg")[self.getResolved("currentFrame")]if not db or not db[bb]then return""end;local _c=db[bb][2]if not _c then
return""end
if cb then return _c:sub(ab,ab+cb-1)else return _c:sub(ab)end end
function ca:setBg(ab,bb,cb)if
type(cb)~="string"or#cb<1 or ab<1 or bb<1 then return self end
if
not self.getResolved("autoResize")then local ac,bc=self:getImageSize()if bb>bc then return self end end;local db=da(self,bb)if self.getResolved("autoResize")then
_b(self,ab+#cb-1,bb)else local ac=#db[bb][3]if ab>ac then return self end
cb=cb:sub(1,ac-ab+1)end
local _c=db[bb][3]
db[bb][3]=_c:sub(1,ab-1)..cb.._c:sub(ab+#cb)self:updateRender()return self end
function ca:getBg(ab,bb,cb)if not ab or not bb then return""end
local db=self.getResolved("bimg")[self.getResolved("currentFrame")]if not db or not db[bb]then return""end;local _c=db[bb][3]if not _c then
return""end
if cb then return _c:sub(ab,ab+cb-1)else return _c:sub(ab)end end
function ca:setPixel(ab,bb,cb,db,_c)if cb then self:setText(ab,bb,cb)end;if db then
self:setFg(ab,bb,db)end;if _c then self:setBg(ab,bb,_c)end;return self end
function ca:applyPalette()
local ab=self.getResolved("bimg")[self.getResolved("currentFrame")]if not ab then return self end;if not ab.palette then return self end
local bb=self:getBaseFrame():getTerm()self.oldPalette={}local cb=ab.palette
for db,_c in pairs(cb)do
if type(_c)=="table"then
local bc,cc,dc=_c[1],_c[2],_c[3]
bb.setPaletteColor(2 ^db,colors.packRGB(bc,cc,dc))else bb.setPaletteColor(2 ^db,_c)end;local ac=bb.getPaletteColor(db)self.oldPalette[db]=ac end;self:updateRender()return self end
function ca:undoPalette()if not self.oldPalette then return self end
local ab=self:getBaseFrame():getTerm()
for bb,cb in pairs(self.oldPalette)do ab.setPaletteColor(2 ^bb,cb)end;self.oldPalette=nil;self:updateRender()return self end
function ca:nextFrame()if not self.getResolved("bimg").animation then
return self end;local ab=self.getResolved("bimg")
local bb=self.getResolved("currentFrame")local cb=bb+1;if cb>#ab then cb=1 end;self.set("currentFrame",cb)
return self end
function ca:addFrame()local ab=self.getResolved("bimg")
local bb=ab.width or#ab[1][1][1]local cb=ab.height or#ab[1]local db={}local _c=string.rep(" ",bb)
local ac=string.rep("f",bb)local bc=string.rep("0",bb)for y=1,cb do db[y]={_c,ac,bc}end
table.insert(ab,db)return self end;function ca:updateFrame(ab,bb)local cb=self.getResolved("bimg")cb[ab]=bb
self:updateRender()return self end;function ca:getFrame(ab)
local bb=self.getResolved("bimg")
return bb[ab or self.getResolved("currentFrame")]end
function ca:getMetadata()local ab={}
local bb=self.getResolved("bimg")
for cb,db in pairs(bb)do if(type(db)=="string")then ab[cb]=db end end;return ab end
function ca:setMetadata(ab,bb)if(type(ab)=="table")then
for db,_c in pairs(ab)do self:setMetadata(db,_c)end;return self end
local cb=self.getResolved("bimg")if(type(bb)=="string")then cb[ab]=bb end;return self end
function ca:render()ba.render(self)
local ab=self.getResolved("bimg")[self.getResolved("currentFrame")]if not ab then return end;local bb=self.getResolved("offsetX")
local cb=self.getResolved("offsetY")local db=self.getResolved("width")
local _c=self.getResolved("height")
for y=1,_c do local ac=y+cb;local bc=ab[ac]
if bc then local cc=bc[1]local dc=bc[2]local _d=bc[3]
if cc and dc and _d then local ad=db-
math.max(0,bb)
if ad>0 then if bb<0 then local bd=math.abs(bb)+1
cc=cc:sub(bd)dc=dc:sub(bd)_d=_d:sub(bd)end
cc=cc:sub(1,ad)dc=dc:sub(1,ad)_d=_d:sub(1,ad)
self:blit(math.max(1,1 +bb),y,cc,dc,_d)end end end end end;return ca end
project["elements/BarChart.lua"] = function(...) local aa=require("elementManager")
local ba=aa.getElement("VisualElement")local ca=aa.getElement("Graph")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b;function _b.new()
local ab=setmetatable({},_b):__init()ab.class=_b;return ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","BarChart")return self end
function _b:render()ba.render(self)local ab=self.getResolved("width")
local bb=self.getResolved("height")local cb=self.getResolved("minValue")
local db=self.getResolved("maxValue")local _c=self.getResolved("series")local ac=0;local bc={}for ad,bd in pairs(_c)do
if(bd.visible)then if#
bd.data>0 then ac=ac+1;table.insert(bc,bd)end end end;local cc=ac;local dc=1
local _d=math.min(bc[1]and
bc[1].pointCount or 0,math.floor((ab+dc)/ (cc+dc)))
for groupIndex=1,_d do local ad=( (groupIndex-1)* (cc+dc))+1
for bd,cd in ipairs(bc)do
local dd=cd.data[groupIndex]
if dd then local __a=ad+ (bd-1)local a_a=(dd-cb)/ (db-cb)
local b_a=math.floor(bb- (a_a* (bb-1)))b_a=math.max(1,math.min(b_a,bb))for barY=b_a,bb do
self:blit(__a,barY,cd.symbol,da[cd.fgColor],da[cd.bgColor])end end end end end;return _b end
project["elements/ComboBox.lua"] = function(...) local aa=require("elements/VisualElement")
local ba=require("elements/List")local ca=require("elements/DropDown")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"editable",{default=true,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"text",{default="",type="string",canTriggerRender=true,setter=function(ab,bb)ab.set("cursorPos",#bb+1)
ab:updateViewport()return bb end})
_b.defineProperty(_b,"cursorPos",{default=1,type="number"})
_b.defineProperty(_b,"viewOffset",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"autoComplete",{default=false,type="boolean"})
_b.defineProperty(_b,"manuallyOpened",{default=false,type="boolean"})function _b.new()local ab=setmetatable({},_b):__init()
ab.class=_b;ab.set("width",16)ab.set("height",1)ab.set("z",8)
return ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","ComboBox")
self.set("cursorPos",1)self.set("viewOffset",0)return self end
function _b:getFilteredItems()local ab=self.getResolved("items")or{}
local bb=self.getResolved("text"):lower()if
not self.getResolved("autoComplete")or#bb==0 then return ab end;local cb={}
for db,_c in ipairs(ab)do local ac=""if
type(_c)=="string"then ac=_c:lower()elseif type(_c)=="table"and _c.text then
ac=_c.text:lower()end;if ac:find(bb,1,true)then
table.insert(cb,_c)end end;return cb end
function _b:updateFilteredDropdown()
if not self.getResolved("autoComplete")then return end;local ab=self:getFilteredItems()local bb=#ab>0 and
#self.getResolved("text")>0
if bb then
self:setState("opened")self.set("manuallyOpened",false)local cb=
self.getResolved("dropdownHeight")or 5;local db=math.min(cb,#ab)self.set("height",
1 +db)else self:unsetState("opened")
self.set("manuallyOpened",false)self.set("height",1)end;self:updateRender()end
function _b:updateViewport()local ab=self.getResolved("text")
local bb=self.getResolved("cursorPos")local cb=self.getResolved("width")
local db=self.getResolved("dropSymbol")local _c=cb-#db;if _c<1 then _c=1 end
local ac=self.getResolved("viewOffset")
if bb-ac>_c then ac=bb-_c elseif bb-1 <ac then ac=math.max(0,bb-1)end;self.set("viewOffset",ac)end
function _b:char(ab)
if not self.getResolved("editable")then return end;if not self:hasState("focused")then return end
local bb=self.getResolved("text")local cb=self.getResolved("cursorPos")local db=bb:sub(1,cb-1)..
ab..bb:sub(cb)self.set("text",db)self.set("cursorPos",
cb+1)self:updateViewport()
if
self.getResolved("autoComplete")then self:updateFilteredDropdown()else self:updateRender()end end
function _b:key(ab,bb)
if not self.getResolved("editable")then return end;if not self:hasState("focused")then return end
local cb=self.getResolved("text")local db=self.getResolved("cursorPos")
if ab==keys.left then self.set("cursorPos",math.max(1,
db-1))
self:updateViewport()elseif ab==keys.right then
self.set("cursorPos",math.min(#cb+1,db+1))self:updateViewport()elseif ab==keys.backspace then
if db>1 then local _c=cb:sub(1,db-2)..
cb:sub(db)self.set("text",_c)
self.set("cursorPos",db-1)self:updateViewport()
if self.getResolved("autoComplete")then
self:updateFilteredDropdown()else self:updateRender()end end elseif ab==keys.delete then
if db<=#cb then
local _c=cb:sub(1,db-1)..cb:sub(db+1)self.set("text",_c)self:updateViewport()
if
self.getResolved("autoComplete")then self:updateFilteredDropdown()else self:updateRender()end end elseif ab==keys.home then self.set("cursorPos",1)
self:updateViewport()elseif ab==keys["end"]then self.set("cursorPos",#cb+1)
self:updateViewport()elseif ab==keys.enter then
if self:hasState("opened")then
self:unsetState("opened")else self:setState("opened")end;self:updateRender()end end
function _b:mouse_click(ab,bb,cb)
if not aa.mouse_click(self,ab,bb,cb)then return false end;local db,_c=self:getRelativePosition(bb,cb)
local ac=self.getResolved("width")local bc=self.getResolved("dropSymbol")
local cc=self:hasState("opened")
if _c==1 then
if db>=ac-#bc+1 and db<=ac then
if cc then
self:unsetState("opened")self.set("height",1)
self.set("manuallyOpened",false)else self:setState("opened")
local dc=self.getResolved("items")or{}
local _d=self.getResolved("dropdownHeight")or 5;local ad=math.min(_d,#dc)self.set("height",1 +ad)
self.set("manuallyOpened",true)end;self:updateRender()return true end
if db<=ac-#bc and self.getResolved("editable")then
local dc=self.getResolved("text")local _d=self.getResolved("viewOffset")local ad=#dc+1
local bd=math.min(ad,_d+db)self.set("cursorPos",bd)
if not cc then
self:setState("opened")local cd=self.getResolved("items")or{}local dd=
self.getResolved("dropdownHeight")or 5;local __a=math.min(dd,#cd)self.set("height",
1 +__a)
self.set("manuallyOpened",true)end;self:updateRender()return true end;return true elseif cc and _c>1 then return ca.mouse_click(self,ab,bb,cb)end;return false end
function _b:mouse_up(ab,bb,cb)
if self:hasState("opened")then
local db,_c=self:getRelativePosition(bb,cb)
if _c>1 and self.getResolved("selectable")and
not self._scrollBarDragging then
local ac=(_c-1)+self.getResolved("offset")local bc;if self.getResolved("autoComplete")and
not self.getResolved("manuallyOpened")then bc=self:getFilteredItems()else
bc=self.getResolved("items")end
if ac<=
#bc then local cc=bc[ac]
if type(cc)=="string"then cc={text=cc}bc[ac]=cc end;if not self.getResolved("multiSelection")then
for dc,_d in
ipairs(self.getResolved("items"))do if type(_d)=="table"then _d.selected=false end end end
cc.selected=true
if cc.text then self.set("text",cc.text)
self.set("cursorPos",#cc.text+1)self:updateViewport()end;if cc.callback then cc.callback(self)end
self:fireEvent("select",ac,cc)self:unsetState("opened")
self:unsetState("clicked")self.set("height",1)
self.set("manuallyOpened",false)self:updateRender()return true end end;return ca.mouse_up(self,ab,bb,cb)end;return
aa.mouse_up and aa.mouse_up(self,ab,bb,cb)or false end
function _b:render()aa.render(self)local ab=self.getResolved("text")
local bb=self.getResolved("width")local cb=self.getResolved("dropSymbol")
local db=self:hasState("focused")local _c=self:hasState("opened")
local ac=self.getResolved("viewOffset")local bc=self.getResolved("selectedText")
local cc=self.getResolved("background")local dc=self.getResolved("foreground")local _d=ab;local ad=bb-#cb
if
#ab==0 and not db and#bc>0 then _d=bc;dc=colors.gray end;if#_d>0 then _d=_d:sub(ac+1,ac+ad)end;_d=_d..
string.rep(" ",ad-#_d)
local bd=_d.. (_c and"\31"or"\17")
self:blit(1,1,bd,string.rep(da[dc],bb),string.rep(da[cc],bb))
if db and self.getResolved("editable")then
local cd=self.getResolved("cursorPos")local dd=cd-ac
if dd>=1 and dd<=ad then self:setCursor(dd,1,true,dc)end end
if _c then local cd=self.getResolved("height")
local dd=self.getResolved("items")
if self.getResolved("autoComplete")and
not self.getResolved("manuallyOpened")then dd=self:getFilteredItems()end
local __a=math.min(self.getResolved("dropdownHeight"),#dd)local a_a=self._values.items;self._values.items=dd
self.set("height",__a)ba.render(self,1)self._values.items=a_a
self.set("height",cd)
self:blit(1,1,bd,string.rep(da[dc],bb),string.rep(da[cc],bb))
if db and self.getResolved("editable")then
local b_a=self.getResolved("cursorPos")local c_a=b_a-ac;if c_a>=1 and c_a<=ad then
self:setCursor(c_a,1,true,dc)end end end end;return _b end
project["elements/ScrollFrame.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("Container")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"showScrollBar",{default=true,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"scrollBarSymbol",{default=" ",type="string",canTriggerRender=true})
ca.defineProperty(ca,"scrollBarBackgroundSymbol",{default="\127",type="string",canTriggerRender=true})
ca.defineProperty(ca,"scrollBarColor",{default=colors.lightGray,type="color",canTriggerRender=true})
ca.defineProperty(ca,"scrollBarBackgroundColor",{default=colors.gray,type="color",canTriggerRender=true})
ca.defineProperty(ca,"scrollBarBackgroundColor2",{default=colors.black,type="color",canTriggerRender=true})
ca.defineProperty(ca,"contentWidth",{default=0,type="number",getter=function(da)local _b=0;local ab=da.getResolved("children")for bb,cb in
ipairs(ab)do local db=cb.get("x")local _c=cb.get("width")local ac=db+_c-1
if ac>_b then _b=ac end end;return _b end})
ca.defineProperty(ca,"contentHeight",{default=0,type="number",getter=function(da)local _b=0;local ab=da.getResolved("children")for bb,cb in
ipairs(ab)do local db=cb.get("y")local _c=cb.get("height")local ac=db+_c-1
if ac>_b then _b=ac end end;return _b end})ca.defineEvent(ca,"mouse_click")
ca.defineEvent(ca,"mouse_drag")ca.defineEvent(ca,"mouse_up")
ca.defineEvent(ca,"mouse_scroll")function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",20)da.set("height",10)da.set("z",10)return
da end
function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","ScrollFrame")return self end
function ca:mouse_click(da,_b,ab)
if aa.mouse_click(self,da,_b,ab)then
local bb,cb=self:getRelativePosition(_b,ab)local db=self.getResolved("width")
local _c=self.getResolved("height")local ac=self.getResolved("showScrollBar")
local bc=self.getResolved("contentWidth")local cc=self.getResolved("contentHeight")
local dc=ac and bc>db;local _d=dc and _c-1 or _c;local ad=ac and cc>_d
local bd=ad and db-1 or db
if ad and bb==db and(not dc or cb<_c)then local cd=_d
local dd=math.max(1,math.floor((_d/cc)*cd))local __a=cc-_d
local a_a=__a>0 and
(self.getResolved("offsetY")/__a*100)or 0
local b_a=math.floor((a_a/100)* (cd-dd))+1
if cb>=b_a and cb<b_a+dd then self._scrollBarDragging=true
self._scrollBarDragOffset=cb-b_a else local c_a=( (cb-1)/ (cd-dd))*100
local d_a=math.floor((c_a/100)*__a+0.5)
self.set("offsetY",math.max(0,math.min(__a,d_a)))end;return true end
if dc and cb==_c and(not ad or bb<db)then local cd=bd
local dd=math.max(1,math.floor((bd/bc)*cd))local __a=bc-bd
local a_a=__a>0 and
(self.getResolved("offsetX")/__a*100)or 0
local b_a=math.floor((a_a/100)* (cd-dd))+1
if bb>=b_a and bb<b_a+dd then self._hScrollBarDragging=true;self._hScrollBarDragOffset=bb-
b_a else local c_a=( (bb-1)/ (cd-dd))*100;local d_a=math.floor((
c_a/100)*__a+0.5)
self.set("offsetX",math.max(0,math.min(__a,d_a)))end;return true end;return true end;return false end
function ca:mouse_drag(da,_b,ab)
if self._scrollBarDragging then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.getResolved("height")local _c=self.getResolved("contentWidth")
local ac=self.getResolved("contentHeight")local bc=self.getResolved("width")local cc=
self.getResolved("showScrollBar")and _c>bc
local dc=cc and db-1 or db;local _d=dc
local ad=math.max(1,math.floor((dc/ac)*_d))local bd=ac-dc;cb=math.max(1,math.min(_d,cb))local cd=cb- (
self._scrollBarDragOffset or 0)local dd=
( (cd-1)/ (_d-ad))*100
local __a=math.floor((dd/100)*bd+0.5)
self.set("offsetY",math.max(0,math.min(bd,__a)))return true end
if self._hScrollBarDragging then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.getResolved("width")local _c=self.getResolved("contentWidth")
local ac=self.getResolved("contentHeight")local bc=self.getResolved("height")local cc=
self.getResolved("showScrollBar")and _c>db
local dc=cc and bc-1 or bc
local _d=self.getResolved("showScrollBar")and ac>dc;local ad=_d and db-1 or db;local bd=ad
local cd=math.max(1,math.floor((ad/_c)*bd))local dd=_c-ad;bb=math.max(1,math.min(bd,bb))local __a=bb- (
self._hScrollBarDragOffset or 0)local a_a=
( (__a-1)/ (bd-cd))*100
local b_a=math.floor((a_a/100)*dd+0.5)
self.set("offsetX",math.max(0,math.min(dd,b_a)))return true end;return
aa.mouse_drag and aa.mouse_drag(self,da,_b,ab)or false end
function ca:mouse_up(da,_b,ab)if self._scrollBarDragging then self._scrollBarDragging=false
self._scrollBarDragOffset=nil;return true end
if self._hScrollBarDragging then
self._hScrollBarDragging=false;self._hScrollBarDragOffset=nil;return true end;return
aa.mouse_up and aa.mouse_up(self,da,_b,ab)or false end
function ca:mouse_scroll(da,_b,ab)
if self:isInBounds(_b,ab)then
local bb,cb=self.getResolved("offsetX"),self.getResolved("offsetY")local db,_c=self:getRelativePosition(_b+bb,ab+cb)
local ac,bc=self:callChildrenEvent(true,"mouse_scroll",da,db,_c)if ac then return true end;local cc=self.getResolved("height")
local dc=self.getResolved("width")local _d=self.getResolved("offsetY")
local ad=self.getResolved("offsetX")local bd=self.getResolved("contentWidth")
local cd=self.getResolved("contentHeight")
local dd=self.getResolved("showScrollBar")and bd>dc;local __a=dd and cc-1 or cc
local a_a=self.getResolved("showScrollBar")and cd>__a;local b_a=a_a and dc-1 or dc
if a_a then local c_a=math.max(0,cd-__a)local d_a=math.min(c_a,math.max(0,
_d+da))
self.set("offsetY",d_a)elseif dd then local c_a=math.max(0,bd-b_a)
local d_a=math.min(c_a,math.max(0,ad+da))self.set("offsetX",d_a)end;return true end;return false end
function ca:render()aa.render(self)local da=self.getResolved("height")
local _b=self.getResolved("width")local ab=self.getResolved("offsetY")
local bb=self.getResolved("offsetX")local cb=self.getResolved("showScrollBar")
local db=self.getResolved("contentWidth")local _c=self.getResolved("contentHeight")
local ac=cb and db>_b;local bc=ac and da-1 or da;local cc=cb and _c>bc
local dc=cc and _b-1 or _b
if cc then local _d=bc
local ad=math.max(1,math.floor((bc/_c)*_d))local bd=_c-bc
local cd=self.getResolved("scrollBarBackgroundSymbol")local dd=self.getResolved("scrollBarColor")
local __a=self.getResolved("scrollBarBackgroundColor")local a_a=self.getResolved("scrollBarBackgroundColor2")local b_a=
bd>0 and(ab/bd*100)or 0;local c_a=
math.floor((b_a/100)* (_d-ad))+1;for i=1,_d do
if i>=c_a and i<c_a+ad then
self:blit(_b,i," ",ba[dd],ba[dd])else self:blit(_b,i,cd,ba[__a],ba[a_a])end end end
if ac then local _d=dc
local ad=math.max(1,math.floor((dc/db)*_d))local bd=db-dc
local cd=self.getResolved("scrollBarBackgroundSymbol")local dd=self.getResolved("scrollBarColor")
local __a=self.getResolved("scrollBarBackgroundColor")local a_a=self.getResolved("scrollBarBackgroundColor2")local b_a=
bd>0 and(bb/bd*100)or 0;local c_a=
math.floor((b_a/100)* (_d-ad))+1;for i=1,_d do
if i>=c_a and i<c_a+ad then
self:blit(i,da," ",ba[dd],ba[dd])else self:blit(i,da,cd,ba[__a],ba[a_a])end end end;if cc and ac then local _d=self.getResolved("background")
self:blit(_b,da," ",ba[_d],ba[_d])end end;return ca end
project["elements/TabControl.lua"] = function(...) local aa=require("elementManager")
local ba=require("elements/VisualElement")local ca=aa.getElement("Container")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"activeTab",{default=nil,type="number",allowNil=true,canTriggerRender=true,setter=function(ab,bb)
return bb end})
_b.defineProperty(_b,"tabHeight",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"tabs",{default={},type="table"})
_b.defineProperty(_b,"headerBackground",{default=colors.gray,type="color",canTriggerRender=true})
_b.defineProperty(_b,"activeTabBackground",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"activeTabTextColor",{default=colors.black,type="color",canTriggerRender=true})
_b.defineProperty(_b,"scrollableTab",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"tabScrollOffset",{default=0,type="number",canTriggerRender=true})_b.defineEvent(_b,"mouse_click")
_b.defineEvent(_b,"mouse_up")_b.defineEvent(_b,"mouse_scroll")function _b.new()
local ab=setmetatable({},_b):__init()ab.class=_b;ab.set("width",20)ab.set("height",10)
ab.set("z",10)return ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","TabControl")end
function _b:newTab(ab)local bb=self.getResolved("tabs")or{}
local cb=#bb+1
table.insert(bb,{id=cb,title=tostring(ab or("Tab "..cb))})self.set("tabs",bb)if
not self.getResolved("activeTab")then self.set("activeTab",cb)end
self:updateTabVisibility()local db=self;local _c={}
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
local cb=ca.addElement(self,ab)local db=bb or self.getResolved("activeTab")if db then
cb._tabId=db;self:updateTabVisibility()end;return cb end
function _b:addChild(ab)ca.addChild(self,ab)if not ab._tabId then
local bb=self.getResolved("tabs")or{}
if#bb>0 then ab._tabId=1;self:updateTabVisibility()end end;return self end;function _b:updateTabVisibility()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)end
function _b:setActiveTab(ab)
local bb=self.getResolved("activeTab")if bb==ab then return self end;self.set("activeTab",ab)
self:updateTabVisibility()self:dispatchEvent("tabChanged",ab,bb)return self end
function _b:isChildVisible(ab)
if not ca.isChildVisible(self,ab)then return false end;if ab._tabId then
return ab._tabId==self.getResolved("activeTab")end;return true end
function _b:getContentYOffset()local ab=self:_getHeaderMetrics()return ab.headerHeight end
function _b:_getHeaderMetrics()local ab=self.getResolved("tabs")or{}local bb=
self.getResolved("width")or 1
local cb=self.getResolved("tabHeight")or 1;local db=self.getResolved("scrollableTab")local _c={}
if db then local ac=
self.getResolved("tabScrollOffset")or 0;local bc=1;local cc=0
for dc,_d in ipairs(ab)do
local ad=#_d.title+2;if ad>bb then ad=bb end;local bd=bc-ac;local cd=0;local dd=0;if bd<1 then cd=1 -bd end;if
bd+ad-1 >bb then dd=(bd+ad-1)-bb end
if bd+ad>1 and bd<=bb then
local __a=math.max(1,bd)local a_a=ad-cd-dd
table.insert(_c,{id=_d.id,title=_d.title,line=1,x1=__a,x2=__a+a_a-1,width=ad,displayWidth=a_a,actualX=bc,startClip=cd,endClip=dd})end;bc=bc+ad end;cc=bc-1;return
{headerHeight=1,lines=1,positions=_c,totalWidth=cc,scrollOffset=ac,maxScroll=math.max(0,cc-bb)}else local ac=1;local bc=1
for _d,ad in ipairs(ab)do local bd=#
ad.title+2;if bd>bb then bd=bb end
if bc+bd-1 >bb then ac=ac+1;bc=1 end
table.insert(_c,{id=ad.id,title=ad.title,line=ac,x1=bc,x2=bc+bd-1,width=bd})bc=bc+bd end;local cc=ac;local dc=math.max(cb,cc)
return{headerHeight=dc,lines=cc,positions=_c}end end
function _b:mouse_click(ab,bb,cb)
if not ba.mouse_click(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self:_getHeaderMetrics()
if _c<=ac.headerHeight then if#ac.positions==0 then return true end
for bc,cc in
ipairs(ac.positions)do
if cc.line==_c and db>=cc.x1 and db<=cc.x2 then
self:setActiveTab(cc.id)self.set("focusedChild",nil)return true end end;return true end;return ca.mouse_click(self,ab,bb,cb)end
function _b:getRelativePosition(ab,bb)
local cb=self:_getHeaderMetrics().headerHeight
if ab==nil or bb==nil then return ba.getRelativePosition(self)else
local db,_c=ba.getRelativePosition(self,ab,bb)return db,_c-cb end end
function _b:multiBlit(ab,bb,cb,db,_c,ac,bc)local cc=self:_getHeaderMetrics().headerHeight;return ca.multiBlit(self,ab,(
bb or 1)+cc,cb,db,_c,ac,bc)end
function _b:textFg(ab,bb,cb,db)local _c=self:_getHeaderMetrics().headerHeight;return ca.textFg(self,ab,(
bb or 1)+_c,cb,db)end
function _b:textBg(ab,bb,cb,db)local _c=self:_getHeaderMetrics().headerHeight;return ca.textBg(self,ab,(
bb or 1)+_c,cb,db)end
function _b:drawText(ab,bb,cb)local db=self:_getHeaderMetrics().headerHeight;return ca.drawText(self,ab,(
bb or 1)+db,cb)end
function _b:drawFg(ab,bb,cb)local db=self:_getHeaderMetrics().headerHeight;return ca.drawFg(self,ab,(
bb or 1)+db,cb)end
function _b:drawBg(ab,bb,cb)local db=self:_getHeaderMetrics().headerHeight;return ca.drawBg(self,ab,(
bb or 1)+db,cb)end
function _b:blit(ab,bb,cb,db,_c)local ac=self:_getHeaderMetrics().headerHeight;return ca.blit(self,ab,(
bb or 1)+ac,cb,db,_c)end
function _b:mouse_up(ab,bb,cb)
if not ba.mouse_up(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self:_getHeaderMetrics().headerHeight;if _c<=ac then return true end;return ca.mouse_up(self,ab,bb,cb)end
function _b:mouse_release(ab,bb,cb)ba.mouse_release(self,ab,bb,cb)
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getHeaderMetrics().headerHeight
if _c<=ac then return end;return ca.mouse_release(self,ab,bb,cb)end
function _b:mouse_move(ab,bb,cb)
if ba.mouse_move(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getHeaderMetrics().headerHeight;if _c<=ac then
return true end
local bc={self:getRelativePosition(bb,cb)}
local cc,dc=self:callChildrenEvent(true,"mouse_move",table.unpack(bc))if cc then return true end end;return false end
function _b:mouse_drag(ab,bb,cb)
if ba.mouse_drag(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getHeaderMetrics().headerHeight;if _c<=ac then
return true end;return ca.mouse_drag(self,ab,bb,cb)end;return false end
function _b:scrollTabs(ab)
if not self.getResolved("scrollableTab")then return self end;local bb=self:_getHeaderMetrics()local cb=
self.getResolved("tabScrollOffset")or 0;local db=bb.maxScroll or 0;local _c=cb+ (
ab*5)_c=math.max(0,math.min(db,_c))
self.set("tabScrollOffset",_c)return self end
function _b:mouse_scroll(ab,bb,cb)
if ba.mouse_scroll(self,ab,bb,cb)then
local db=self:_getHeaderMetrics().headerHeight
if
self.getResolved("scrollableTab")and cb==self.getResolved("y")then self:scrollTabs(ab)return true end;return ca.mouse_scroll(self,ab,bb,cb)end;return false end
function _b:setCursor(ab,bb,cb,db)local _c=self:_getHeaderMetrics().headerHeight
if
self.parent then local ac,bc=self:calculatePosition()local cc=ab+ac-1
local dc=bb+bc-1 +_c
if

(cc<1)or(cc>self.parent.get("width"))or(dc<1)or(dc>self.parent.get("height"))then return self.parent:setCursor(cc,dc,false)end;return self.parent:setCursor(cc,dc,cb,db)end;return self end
function _b:render()ba.render(self)local ab=self.getResolved("width")
local bb=self.getResolved("foreground")local cb=self.getResolved("headerBackground")
local db=self:_getHeaderMetrics()local _c=db.headerHeight or 1
ba.multiBlit(self,1,1,ab,_c," ",da[bb],da[cb])local ac=self.getResolved("activeTab")
for bc,cc in ipairs(db.positions)do
local dc=
(cc.id==ac)and self.getResolved("activeTabBackground")or cb;local _d=
(cc.id==ac)and self.getResolved("activeTabTextColor")or bb
ba.multiBlit(self,cc.x1,cc.line,
cc.displayWidth or(cc.x2 -cc.x1 +1),1," ",da[bb],da[dc])local ad=cc.title;local bd=1 + (cc.startClip or 0)
local cd=#cc.title- (cc.startClip or
0)- (cc.endClip or 0)if cd>0 then ad=cc.title:sub(bd,bd+cd-1)local dd=cc.x1;if
(cc.startClip or 0)==0 then dd=dd+1 end
ba.textFg(self,dd,cc.line,ad,_d)end end;if not self.getResolved("childrenSorted")then
self:sortChildren()end
if
not self.getResolved("childrenEventsSorted")then for bc in pairs(self._values.childrenEvents or{})do
self:sortChildrenEvents(bc)end end
for bc,cc in
ipairs(self.getResolved("visibleChildren")or{})do
if cc==self then error("CIRCULAR REFERENCE DETECTED!")return end;cc:render()cc:postRender()end end
function _b:sortChildrenEvents(ab)
local bb=self._values.childrenEvents and self._values.childrenEvents[ab]
if bb then local cb={}for db,_c in ipairs(bb)do
if self:isChildVisible(_c)then table.insert(cb,_c)end end
for i=2,#cb do local db=cb[i]
local _c=db.get("z")local ac=i-1
while ac>0 do local bc=cb[ac].get("z")if bc>_c then cb[ac+1]=cb[ac]
ac=ac-1 else break end end;cb[ac+1]=db end
self._values.visibleChildrenEvents=self._values.visibleChildrenEvents or{}self._values.visibleChildrenEvents[ab]=cb end;self.set("childrenEventsSorted",true)return self end;return _b end
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
d_b and not d_b._destroyed and d_b.get and d_b.get("visible")end;local function caa(c_b)
return
c_b.getResolved("autoCompleteShowBorder")and 1 or 0 end
local function daa(c_b)local d_b=c_b._autoCompleteFrame
local _ab=c_b._autoCompleteList;if not d_b or d_b._destroyed then return end
d_b:setBackground(c_b.getResolved("autoCompleteBackground"))
d_b:setForeground(c_b.getResolved("autoCompleteForeground"))
if _ab and not _ab._destroyed then
_ab:setBackground(c_b.getResolved("autoCompleteBackground"))
_ab:setForeground(c_b.getResolved("autoCompleteForeground"))
_ab:setSelectedBackground(c_b.getResolved("autoCompleteSelectedBackground"))
_ab:setSelectedForeground(c_b.getResolved("autoCompleteSelectedForeground"))_ab:updateRender()end;aaa(c_b)_aa(c_b)d_b:updateRender()end
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
local cab=bab.insert or bab.text or""if cab==""then return end;local dab=c_b.getResolved("lines")
local _bb=c_b.getResolved("cursorY")local abb=c_b.getResolved("cursorX")local bbb=dab[_bb]or""local cbb=
c_b._autoCompleteTokenStart or abb;if cbb<1 then cbb=1 end
local dbb=bbb:sub(1,cbb-1)local _cb=bbb:sub(abb)dab[_bb]=dbb..cab.._cb
c_b.set("cursorX",cbb+#cab)c_b:updateViewport()c_b:updateRender()
aba(c_b,true)
c_b:fireEvent("auto_complete_accept",cab,bab.source or bab)end
local function cba(c_b)
if not c_b.getResolved("autoCompleteEnabled")then return nil end;local d_b=c_b._autoCompleteFrame;if d_b and not d_b._destroyed then
return c_b._autoCompleteList end;local _ab=c_b:getBaseFrame()if not _ab or not
_ab.addFrame then return nil end
d_b=_ab:addFrame({width=c_b.getResolved("width"),height=1,x=1,y=1,visible=false,background=c_b.getResolved("autoCompleteBackground"),foreground=c_b.getResolved("autoCompleteForeground"),ignoreOffset=true,z=
c_b.getResolved("z")+c_b.getResolved("autoCompleteZOffset")})d_b:setIgnoreOffset(true)d_b:setVisible(false)
local aab=caa(c_b)
local bab=d_b:addList({x=aab+1,y=aab+1,width=math.max(1,d_b.get("width")-aab*2),height=math.max(1,
d_b.get("height")-aab*2),selectable=true,multiSelection=false,background=c_b.getResolved("autoCompleteBackground"),foreground=c_b.getResolved("autoCompleteForeground")})
bab:setSelectedBackground(c_b.getResolved("autoCompleteSelectedBackground"))
bab:setSelectedForeground(c_b.getResolved("autoCompleteSelectedForeground"))bab:setOffset(0)
bab:onSelect(function(cab,dab,_bb)if not baa(c_b)then return end
_ba(c_b,dab)
if c_b.getResolved("autoCompleteAcceptOnClick")then bba(c_b,_bb)end end)c_b._autoCompleteFrame=d_b;c_b._autoCompleteList=bab;daa(c_b)return bab end
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
_ab:removeCommand(d_b._autoCompleteBorderCommand)d_b._autoCompleteBorderCommand=nil end;if not c_b.getResolved("autoCompleteShowBorder")then
d_b:updateRender()return end;local aab=
c_b.getResolved("autoCompleteBorderColor")or colors.black
local bab=_ab:addCommand(function(cab)local dab=
cab.get("width")or 0;local _bb=cab.get("height")or 0;if dab<1 or
_bb<1 then return end
local abb=cab.get("background")or colors.black;local bbb=c_a[abb]or c_a[colors.black]local cbb=c_a[aab]or
c_a[colors.black]
cab:textFg(1,1,("\131"):rep(dab),aab)cab:multiBlit(1,_bb,dab,1,"\143",bbb,cbb)
cab:multiBlit(1,1,1,_bb,"\149",cbb,bbb)cab:multiBlit(dab,1,1,_bb,"\149",bbb,cbb)
cab:blit(1,1,"\151",cbb,bbb)cab:blit(dab,1,"\148",bbb,cbb)
cab:blit(1,_bb,"\138",bbb,cbb)cab:blit(dab,_bb,"\133",bbb,cbb)end)d_b._autoCompleteBorderCommand=bab;d_b:updateRender()end
local function dba(c_b)local d_b=c_b.getResolved("lines")
local _ab=c_b.getResolved("cursorY")local aab=c_b.getResolved("cursorX")local bab=d_b[_ab]or""local cab=bab:sub(1,math.max(
aab-1,0))local dab=
c_b.getResolved("autoCompleteTokenPattern")or"[%w_]+"local _bb=""
if
dab~=""then _bb=cab:match("("..dab..")$")or""end;local abb=aab-#_bb;if abb<1 then abb=1 end;return _bb,abb end
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
local function bca(c_b,d_b)local _ab=c_b.getResolved("autoCompleteProvider")local aab={}
if _ab then
local abb,bbb=pcall(_ab,c_b,d_b)if abb and type(bbb)=="table"then aab=bbb end else aab=
c_b.getResolved("autoCompleteItems")or{}end;local bab={}
local cab=c_b.getResolved("autoCompleteCaseInsensitive")local dab=cab and d_b:lower()or d_b
aca(aab,function(abb)local bbb=_ca(abb)
if bbb and
bbb.text then
local cbb=cab and bbb.text:lower()or bbb.text;if dab==""or cbb:find(dab,1,true)==1 then
table.insert(bab,bbb)end end end)local _bb=c_b.getResolved("autoCompleteMaxItems")
if#bab>_bb then while
#bab>_bb do table.remove(bab)end end;return bab end
local function cca(c_b,d_b)local _ab=0
for _bb,abb in ipairs(d_b)do local bbb=abb;if type(abb)=="table"then
bbb=
abb.text or abb.label or abb.value or abb.insert or abb[1]end;if bbb~=nil then
local cbb=#tostring(bbb)if cbb>_ab then _ab=cbb end end end;local aab=c_b.getResolved("autoCompleteMaxWidth")
local bab=c_b.getResolved("width")if aab and aab>0 then bab=math.min(bab,aab)end
local cab=caa(c_b)local dab=c_b:getBaseFrame()
if dab and dab.get then
local _bb=dab.get("width")if _bb and _bb>0 then local abb=_bb-cab*2;if abb<1 then abb=1 end
bab=math.min(bab,abb)end end;_ab=math.min(_ab,bab)return math.max(1,_ab)end
local function dca(c_b,d_b,_ab)local aab=c_b._autoCompleteFrame;local bab=c_b._autoCompleteList;if
not aab or aab._destroyed then return end;local cab=caa(c_b)
local dab=math.max(1,_ab or c_b.getResolved("width"))local _bb=math.max(1,d_b or 1)local abb=c_b:getBaseFrame()if not abb then
return end;local bbb=abb.get and abb.get("width")local cbb=abb.get and
abb.get("height")
if bbb and bbb>0 then local bac=bbb-cab*2;if bac<1 then
bac=1 end;if dab>bac then dab=bac end end;if cbb and cbb>0 then local bac=cbb-cab*2;if bac<1 then bac=1 end
if _bb>bac then _bb=bac end end;local dbb=dab+cab*2
local _cb=_bb+cab*2;local acb,bcb=c_b:calculatePosition()
local ccb=c_b.getResolved("scrollX")or 0;local dcb=c_b.getResolved("scrollY")or 0
local _db=(
c_b._autoCompleteTokenStart or c_b.getResolved("cursorX"))local adb=_db-ccb
adb=math.max(1,math.min(c_b.getResolved("width"),adb))local bdb=c_b.getResolved("cursorY")-dcb
bdb=math.max(1,math.min(c_b.getResolved("height"),bdb))local cdb=c_b.getResolved("autoCompleteOffsetX")
local ddb=c_b.getResolved("autoCompleteOffsetY")local __c=acb+adb-1 +cdb;local a_c=__c-cab
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
aab:setZ(c_b.getResolved("z")+c_b.getResolved("autoCompleteZOffset"))aaa(c_b,dab,_bb)if bab and not bab._destroyed then
bab:updateRender()end;aab:updateRender()end
local function _da(c_b)if not c_b.getResolved("autoCompleteEnabled")then
aba(c_b,true)return end;if
not c_b:hasState("focused")then aba(c_b,true)return end;local d_b,_ab=dba(c_b)
c_b._autoCompleteToken=d_b;c_b._autoCompleteTokenStart=_ab;if
#d_b<c_b.getResolved("autoCompleteMinChars")then aba(c_b)return end;local aab=bca(c_b,d_b)if
#aab==0 then aba(c_b)return end;local bab=cba(c_b)if not bab then return end
bab:setOffset(0)bab:setItems(aab)c_b._autoCompleteSuggestions=aab
_ba(c_b,1,true)local cab=cca(c_b,aab)c_b._autoCompletePopupWidth=cab
dca(c_b,#aab,cab)daa(c_b)
c_b._autoCompleteFrame:setVisible(true)c_b._autoCompleteList:updateRender()
c_b._autoCompleteFrame:updateRender()c_b:fireEvent("auto_complete_open",d_b,aab)end
local function ada(c_b,d_b)if not baa(c_b)then return false end
if d_b==keys.tab or(d_b==keys.enter and
c_b.getResolved("autoCompleteAcceptOnEnter"))then
bba(c_b)return true elseif d_b==keys.up then
_ba(c_b,(c_b._autoCompleteIndex or 1)-1)return true elseif d_b==keys.down then
_ba(c_b,(c_b._autoCompleteIndex or 1)+1)return true elseif d_b==keys.pageUp then
local _ab=(c_b._autoCompleteList and
c_b._autoCompleteList.get("height"))or 1
_ba(c_b,(c_b._autoCompleteIndex or 1)-_ab)return true elseif d_b==keys.pageDown then
local _ab=(c_b._autoCompleteList and
c_b._autoCompleteList.get("height"))or 1
_ba(c_b,(c_b._autoCompleteIndex or 1)+_ab)return true elseif
d_b==keys.escape and c_b.getResolved("autoCompleteCloseOnEscape")then aba(c_b)return true end;return false end
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
self.getResolved("autoCompleteEnabled")and self:hasState("focused")then _da(self)end end;local function aab()daa(self)end
local function bab()
if baa(self)then
local cab=rawget(self,"_autoCompleteSuggestions")or{}
dca(self,math.max(#cab,1),rawget(self,"_autoCompletePopupWidth")or
self.getResolved("width"))end end
self:observe("autoCompleteEnabled",function(cab,dab)if not dab then aba(self,true)elseif self:hasState("focused")then
_da(self)end end)self:observe("foreground",aab)
self:observe("background",aab)self:observe("autoCompleteBackground",aab)
self:observe("autoCompleteForeground",aab)
self:observe("autoCompleteSelectedBackground",aab)
self:observe("autoCompleteSelectedForeground",aab)self:observe("autoCompleteBorderColor",aab)
self:observe("autoCompleteZOffset",function()
if

self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
self._autoCompleteFrame:setZ(self.getResolved("z")+
self.getResolved("autoCompleteZOffset"))end end)
self:observe("z",function()
if
self._autoCompleteFrame and not self._autoCompleteFrame._destroyed then
self._autoCompleteFrame:setZ(self.getResolved("z")+
self.getResolved("autoCompleteZOffset"))end end)
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
table.insert(self.getResolved("syntaxPatterns"),{pattern=c_b,color=d_b})return self end
function d_a:removeSyntaxPattern(c_b)local d_b=
self.getResolved("syntaxPatterns")or{}
if type(c_b)~="number"then return self end
if c_b>=1 and c_b<=#d_b then table.remove(d_b,c_b)
self.set("syntaxPatterns",d_b)self:updateRender()end;return self end;function d_a:clearSyntaxPatterns()self.set("syntaxPatterns",{})
self:updateRender()return self end
local function cda(c_b,d_b)
local _ab=c_b.getResolved("lines")local aab=c_b.getResolved("cursorX")
local bab=c_b.getResolved("cursorY")local cab=_ab[bab]
_ab[bab]=cab:sub(1,aab-1)..d_b..cab:sub(aab)c_b.set("cursorX",aab+1)c_b:updateViewport()
c_b:updateRender()end
local function dda(c_b,d_b)for i=1,#d_b do cda(c_b,d_b:sub(i,i))end end
local function __b(c_b)local d_b=c_b.getResolved("lines")
local _ab=c_b.getResolved("cursorX")local aab=c_b.getResolved("cursorY")local bab=d_b[aab]
local cab=bab:sub(_ab)d_b[aab]=bab:sub(1,_ab-1)
table.insert(d_b,aab+1,cab)c_b.set("cursorX",1)c_b.set("cursorY",aab+1)
c_b:updateViewport()c_b:updateRender()end
local function a_b(c_b)local d_b=c_b.getResolved("lines")
local _ab=c_b.getResolved("cursorX")local aab=c_b.getResolved("cursorY")local bab=d_b[aab]
if _ab>1 then d_b[aab]=bab:sub(1,
_ab-2)..bab:sub(_ab)
c_b.set("cursorX",_ab-1)elseif aab>1 then local cab=d_b[aab-1]c_b.set("cursorX",#cab+1)c_b.set("cursorY",
aab-1)d_b[aab-1]=cab..bab
table.remove(d_b,aab)end;c_b:updateViewport()c_b:updateRender()end
function d_a:updateViewport()local c_b=self.getResolved("cursorX")
local d_b=self.getResolved("cursorY")local _ab=self.getResolved("scrollX")
local aab=self.getResolved("scrollY")local bab=self.getResolved("width")
local cab=self.getResolved("height")
if c_b-_ab>bab then self.set("scrollX",c_b-bab)elseif c_b-_ab<1 then self.set("scrollX",
c_b-1)end
if d_b-aab>cab then self.set("scrollY",d_b-cab)elseif d_b-aab<1 then self.set("scrollY",
d_b-1)end;return self end
function d_a:char(c_b)
if not self.getResolved("editable")or not
self:hasState("focused")then return false end;local d_b=self.getResolved("autoPairEnabled")
if d_b and#c_b==1 then local _ab=
self.getResolved("autoPairCharacters")or{}
local aab=self.getResolved("lines")local bab=self.getResolved("cursorX")
local cab=self.getResolved("cursorY")local dab=aab[cab]or""local _bb=dab:sub(bab,bab)local abb=_ab[c_b]
if abb then
cda(self,c_b)
if self.getResolved("autoPairSkipClosing")then
if _bb~=abb then cda(self,abb)self.set("cursorX",
self.getResolved("cursorX")-1)end else cda(self,abb)
self.set("cursorX",self.getResolved("cursorX")-1)end;_da(self)return true end
if self.getResolved("autoPairOverType")then for bbb,cbb in pairs(_ab)do
if c_b==cbb and _bb==cbb then self.set("cursorX",
bab+1)_da(self)return true end end end end;cda(self,c_b)_da(self)return true end
function d_a:key(c_b)
if not self.getResolved("editable")or
not self:hasState("focused")then return false end;if ada(self,c_b)then return true end
local d_b=self.getResolved("lines")local _ab=self.getResolved("cursorX")
local aab=self.getResolved("cursorY")
if c_b==keys.enter then
if self.getResolved("autoPairEnabled")and
self.getResolved("autoPairNewlineIndent")then
local bab=self.getResolved("lines")local cab=self.getResolved("cursorX")
local dab=self.getResolved("cursorY")local _bb=bab[dab]or""local abb=_bb:sub(1,cab-1)
local bbb=_bb:sub(cab)
local cbb=self.getResolved("autoPairCharacters")or{}local dbb={}for bcb,ccb in pairs(cbb)do dbb[ccb]=bcb end;local _cb=abb:sub(-1)
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
local aab=self.getResolved("scrollY")local bab=self.getResolved("height")
local cab=self.getResolved("lines")local dab=math.max(0,#cab-bab+2)
local _bb=math.max(0,math.min(dab,aab+c_b))self.set("scrollY",_bb)self:updateRender()return true end;return false end
function d_a:mouse_click(c_b,d_b,_ab)
if b_a.mouse_click(self,c_b,d_b,_ab)then
local aab,bab=self:getRelativePosition(d_b,_ab)local cab=self.getResolved("scrollX")
local dab=self.getResolved("scrollY")local _bb=(bab or 0)+ (dab or 0)
local abb=self.getResolved("lines")or{}if _bb<1 then _bb=1 end
if _bb<=#abb and abb[_bb]~=nil then
self.set("cursorY",_bb)local bbb=#tostring(abb[_bb])
self.set("cursorX",math.min((aab or 1)+ (cab or 0),
bbb+1))end;self:updateRender()_da(self)return true end
if baa(self)then local aab=self._autoCompleteFrame;if
not
(aab and aab:isInBounds(d_b,_ab))and not self:isInBounds(d_b,_ab)then aba(self)end end;return false end
function d_a:paste(c_b)
if not self.getResolved("editable")or not
self:hasState("focused")then return false end;for d_b in c_b:gmatch(".")do
if d_b=="\n"then __b(self)else cda(self,d_b)end end;_da(self)return true end
function d_a:setText(c_b)local d_b={}
if c_b==""then d_b={""}else for _ab in(c_b.."\n"):gmatch("([^\n]*)\n")do
table.insert(d_b,_ab)end end;self.set("lines",d_b)aba(self,true)return self end;function d_a:getText()
return table.concat(self.getResolved("lines"),"\n")end
local function b_b(c_b,d_b)local _ab=d_b;local aab=string.rep(c_a[c_b.getResolved("foreground")],
#_ab)
local bab=c_b.getResolved("syntaxPatterns")
for cab,dab in ipairs(bab)do local _bb=1
while true do local abb,bbb=_ab:find(dab.pattern,_bb)
if not abb then break end;local cbb=bbb-abb+1
if cbb<=0 then
aab=aab:sub(1,abb-1)..
string.rep(c_a[dab.color],1)..aab:sub(abb+1)_bb=abb+1 else
aab=aab:sub(1,abb-1)..string.rep(c_a[dab.color],cbb)..aab:sub(
bbb+1)_bb=bbb+1 end end end;return _ab,aab end
function d_a:render()b_a.render(self)local c_b=self.getResolved("lines")
local d_b=self.getResolved("scrollX")local _ab=self.getResolved("scrollY")
local aab=self.getResolved("width")local bab=self.getResolved("height")
local cab=self.getResolved("foreground")local dab=self.getResolved("background")local _bb=c_a[cab]
local abb=c_a[dab]
for y=1,bab do local bbb=y+_ab;local cbb=c_b[bbb]or""local dbb,_cb=b_b(self,cbb)local acb=dbb:sub(d_b+1,d_b+
aab)local bcb=_cb:sub(d_b+1,d_b+aab)local ccb=
aab-#acb;if ccb>0 then acb=acb..string.rep(" ",ccb)bcb=bcb..
string.rep(c_a[cab],ccb)end;self:blit(1,y,acb,bcb,string.rep(abb,
#acb))end
if self:hasState("focused")then
local bbb=self.getResolved("cursorX")-d_b;local cbb=self.getResolved("cursorY")-_ab;if bbb>=1 and
bbb<=aab and cbb>=1 and cbb<=bab then
self:setCursor(bbb,cbb,true,
self.getResolved("cursorColor")or cab)end end end
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
aa.render(self)local da=self.getResolved("text")
da=da:sub(1,self.getResolved("width"))
local _b,ab=ba(da,self.getResolved("width"),self.getResolved("height"))
self:textFg(_b,ab,da,self.getResolved("foreground"))end;return ca end
project["elements/Label.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=require("libraries/utils").wrapText
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"text",{default="Label",type="string",canTriggerRender=true,setter=function(da,_b)
if(type(_b)=="function")then _b=_b()end
if(da.getResolved("autoSize"))then da.set("width",#_b)else da.set("height",#
ba(_b,da.getResolved("width")))end;return _b end})
ca.defineProperty(ca,"autoSize",{default=true,type="boolean",canTriggerRender=true,setter=function(da,_b)if(_b)then
da.set("width",#da.getResolved("text"))else
da.set("height",#
ba(da.getResolved("text"),da.getResolved("width")))end;return _b end})
function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("z",3)da.set("backgroundEnabled",false)return da end;function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Label")
return self end
function ca:getWrappedText()
local da=self.getResolved("text")local _b=ba(da,self.getResolved("width"))return _b end
function ca:render()aa.render(self)local da=self.getResolved("text")
if
(self.getResolved("autoSize"))then
self:textFg(1,1,da,self.getResolved("foreground"))else local _b=ba(da,self.getResolved("width"))for ab,bb in ipairs(_b)do
self:textFg(1,ab,bb,self.getResolved("foreground"))end end end;return ca end
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
function _b:newTab(ab)local bb=self.getResolved("tabs")or{}
local cb=#bb+1
table.insert(bb,{id=cb,title=tostring(ab or("Item "..cb))})self.set("tabs",bb)if
not self.getResolved("activeTab")then self.set("activeTab",cb)end
self:updateTabVisibility()local db=self;local _c={}
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
local cb=ca.addElement(self,ab)local db=bb or self.getResolved("activeTab")if db then
cb._tabId=db;self:updateTabVisibility()end;return cb end
function _b:addChild(ab)ca.addChild(self,ab)if not ab._tabId then
local bb=self.getResolved("tabs")or{}
if#bb>0 then ab._tabId=1;self:updateTabVisibility()end end;return self end;function _b:updateTabVisibility()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)end
function _b:setActiveTab(ab)
local bb=self.getResolved("activeTab")if bb==ab then return self end;self.set("activeTab",ab)
self:updateTabVisibility()self:dispatchEvent("tabChanged",ab,bb)return self end
function _b:isChildVisible(ab)
if not ca.isChildVisible(self,ab)then return false end;if ab._tabId then
return ab._tabId==self.getResolved("activeTab")end;return true end
function _b:getContentXOffset()local ab=self:_getSidebarMetrics()return ab.sidebarWidth end
function _b:_getSidebarMetrics()local ab=self.getResolved("tabs")or{}local bb=
self.getResolved("height")or 1
local cb=self.getResolved("sidebarWidth")or 12
local db=self.getResolved("sidebarScrollOffset")or 0
local _c=self.getResolved("sidebarPosition")or"left"local ac={}local bc=1;local cc=#ab
for dc,_d in ipairs(ab)do local ad=1;local bd=bc-db;local cd=0;local dd=0
if bd<1 then cd=1 -bd end;if bd+ad-1 >bb then dd=(bd+ad-1)-bb end
if
bd+ad>1 and bd<=bb then local __a=math.max(1,bd)local a_a=ad-cd-dd
table.insert(ac,{id=_d.id,title=_d.title,y1=__a,y2=__a+a_a-1,height=ad,displayHeight=a_a,actualY=bc,startClip=cd,endClip=dd})end;bc=bc+ad end;return
{sidebarWidth=cb,sidebarPosition=_c,positions=ac,totalHeight=cc,scrollOffset=db,maxScroll=math.max(0,cc-bb)}end
function _b:mouse_click(ab,bb,cb)
if not ba.mouse_click(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self:_getSidebarMetrics()local bc=self.getResolved("width")or 1;local cc=false;if
ac.sidebarPosition=="right"then cc=db> (bc-ac.sidebarWidth)else
cc=db<=ac.sidebarWidth end
if cc then if#ac.positions==0 then
return true end;for dc,_d in ipairs(ac.positions)do
if _c>=_d.y1 and _c<=_d.y2 then
self:setActiveTab(_d.id)self.set("focusedChild",nil)return true end end
return true end;return ca.mouse_click(self,ab,bb,cb)end
function _b:getRelativePosition(ab,bb)local cb=self:_getSidebarMetrics()local db=
self.getResolved("width")or 1
if ab==nil or bb==nil then return
ba.getRelativePosition(self)else local _c,ac=ba.getRelativePosition(self,ab,bb)
if
cb.sidebarPosition=="right"then return _c,ac else return _c-cb.sidebarWidth,ac end end end
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
local ac=self:_getSidebarMetrics()local bc=self.getResolved("width")or 1;local cc=false;if
ac.sidebarPosition=="right"then cc=db> (bc-ac.sidebarWidth)else
cc=db<=ac.sidebarWidth end;if cc then return true end;return
ca.mouse_up(self,ab,bb,cb)end
function _b:mouse_release(ab,bb,cb)ba.mouse_release(self,ab,bb,cb)
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.getResolved("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return end;return ca.mouse_release(self,ab,bb,cb)end
function _b:mouse_move(ab,bb,cb)
if ba.mouse_move(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.getResolved("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return true end
local dc={self:getRelativePosition(bb,cb)}
local _d,ad=self:callChildrenEvent(true,"mouse_move",table.unpack(dc))if _d then return true end end;return false end
function _b:mouse_drag(ab,bb,cb)
if ba.mouse_drag(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.getResolved("width")or 1;local cc=false
if ac.sidebarPosition=="right"then
cc=db> (bc-ac.sidebarWidth)else cc=db<=ac.sidebarWidth end;if cc then return true end;return ca.mouse_drag(self,ab,bb,cb)end;return false end
function _b:scrollSidebar(ab)local bb=self:_getSidebarMetrics()local cb=
self.getResolved("sidebarScrollOffset")or 0
local db=bb.maxScroll or 0;local _c=cb+ (ab*2)_c=math.max(0,math.min(db,_c))
self.set("sidebarScrollOffset",_c)return self end
function _b:mouse_scroll(ab,bb,cb)
if ba.mouse_scroll(self,ab,bb,cb)then
local db,_c=ba.getRelativePosition(self,bb,cb)local ac=self:_getSidebarMetrics()
local bc=self.getResolved("width")or 1;local cc=false
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
function _b:render()ba.render(self)local ab=self.getResolved("height")
local bb=self.getResolved("foreground")local cb=self.getResolved("sidebarBackground")
local db=self:_getSidebarMetrics()local _c=db.sidebarWidth or 12;for y=1,ab do
ba.multiBlit(self,1,y,_c,1," ",da[bb],da[cb])end
local ac=self.getResolved("activeTab")
for bc,cc in ipairs(db.positions)do local dc=
(cc.id==ac)and self.getResolved("activeTabBackground")or cb
local _d=
(cc.id==ac)and self.getResolved("activeTabTextColor")or bb;local ad=cc.displayHeight or(cc.y2 -cc.y1 +1)for dy=0,ad-1
do
ba.multiBlit(self,1,cc.y1 +dy,_c,1," ",da[bb],da[dc])end;local bd=cc.title;if#bd>_c-2 then
bd=bd:sub(1,_c-2)end;ba.textFg(self,2,cc.y1,bd,_d)end;if not self.getResolved("childrenSorted")then
self:sortChildren()end
if
not self.getResolved("childrenEventsSorted")then for bc in pairs(self._values.childrenEvents or{})do
self:sortChildrenEvents(bc)end end
for bc,cc in
ipairs(self.getResolved("visibleChildren")or{})do
if cc==self then error("CIRCULAR REFERENCE DETECTED!")return end;cc:render()cc:postRender()end end
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
aa.defineProperty(aa,"text",{default="",type="string",canTriggerRender=true,setter=function(ba,ca)
ba.set("cursorPos",math.min(
#ca+1,ba.getResolved("cursorPos")))ba:updateViewport()return ca end})
aa.defineProperty(aa,"cursorPos",{default=1,type="number"})
aa.defineProperty(aa,"viewOffset",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"maxLength",{default=nil,type="number"})
aa.defineProperty(aa,"placeholder",{default="...",type="string"})
aa.defineProperty(aa,"placeholderColor",{default=colors.gray,type="color"})
aa.defineProperty(aa,"pattern",{default=nil,type="string"})
aa.defineProperty(aa,"cursorColor",{default=nil,type="number"})
aa.defineProperty(aa,"replaceChar",{default=nil,type="string",canTriggerRender=true})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"mouse_up")aa.defineEvent(aa,"key")aa.defineEvent(aa,"char")
aa.defineEvent(aa,"paste")
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("width",8)ba.set("z",3)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Input")return self end
function aa:setCursor(ba,ca,da,_b)
ba=math.min(self.getResolved("width"),math.max(1,ba))return d.setCursor(self,ba,ca,da,_b)end
function aa:char(ba)
if not self:hasState("focused")then return false end;local ca=self.getResolved("text")
local da=self.getResolved("cursorPos")local _b=self.getResolved("maxLength")
local ab=self.getResolved("pattern")if _b and#ca>=_b then return false end;if ab and not ba:match(ab)then return
false end
self.set("text",ca:sub(1,da-1)..ba..ca:sub(da))self.set("cursorPos",da+1)self:updateViewport()
local bb=
self.getResolved("cursorPos")-self.getResolved("viewOffset")
self:setCursor(bb,1,true,self.getResolved("cursorColor")or
self.getResolved("foreground"))d.char(self,ba)return true end
function aa:key(ba,ca)
if not self:hasState("focused")then return false end;local da=self.getResolved("cursorPos")
local _b=self.getResolved("text")local ab=self.getResolved("viewOffset")
local bb=self.getResolved("width")
if ba==keys.left then if da>1 then self.set("cursorPos",da-1)
if da-1 <=ab then self.set("viewOffset",math.max(0,
da-2))end end elseif ba==keys.right then if da<=#_b then self.set("cursorPos",
da+1)if da-ab>=bb then
self.set("viewOffset",da-bb+1)end end elseif
ba==keys.backspace then if da>1 then
self.set("text",_b:sub(1,da-2).._b:sub(da))self.set("cursorPos",da-1)self:updateRender()
self:updateViewport()end elseif
ba==keys.delete then
if da<=#_b then
self.set("text",_b:sub(1,da-1).._b:sub(da+1))self:updateRender()self:updateViewport()end elseif ba==keys.home then self.set("cursorPos",1)
self.set("viewOffset",0)elseif ba==keys["end"]then self.set("cursorPos",#_b+1)self:set("viewOffset",math.max(0,
#_b-bb+1))elseif
ba==keys.enter then
self:fireEvent("submit",self.getResolved("text"))end
local cb=self.getResolved("cursorPos")-self.getResolved("viewOffset")
self:setCursor(cb,1,true,self.getResolved("cursorColor")or
self.getResolved("foreground"))d.key(self,ba,ca)return true end
function aa:mouse_click(ba,ca,da)
if d.mouse_click(self,ba,ca,da)then
local _b,ab=self:getRelativePosition(ca,da)local bb=self.getResolved("text")
local cb=self.getResolved("viewOffset")local db=#bb+1;local _c=math.min(db,cb+_b)
self.set("cursorPos",_c)local ac=_c-cb
self:setCursor(ac,1,true,self.getResolved("cursorColor")or
self.getResolved("foreground"))return true end;return false end
function aa:updateViewport()local ba=self.getResolved("width")
local ca=self.getResolved("cursorPos")local da=self.getResolved("viewOffset")local _b=#
self.getResolved("text")
if ca-da>=ba then
self.set("viewOffset",ca-ba+1)elseif ca<=da then self.set("viewOffset",ca-1)end
self.set("viewOffset",math.max(0,math.min(self.getResolved("viewOffset"),_b-ba+1)))return self end
function aa:onSubmit(ba)self:registerCallback("submit",ba)return self end
function aa:focus()d.focus(self)
self:setCursor(self.getResolved("cursorPos")-
self.getResolved("viewOffset"),1,true,self.getResolved("cursorColor")or
self.getResolved("foreground"))self:updateRender()end
function aa:blur()d.blur(self)
self:setCursor(1,1,false,self.getResolved("cursorColor")or
self.getResolved("foreground"))self:updateRender()end
function aa:paste(ba)
if not self:hasState("focused")then return false end;local ca=self.getResolved("text")
local da=self.getResolved("cursorPos")local _b=self.getResolved("maxLength")
local ab=self.getResolved("pattern")local bb=ca:sub(1,da-1)..ba..ca:sub(da)if
_b and#bb>_b then bb=bb:sub(1,_b)end;if ab and not bb:match(ab)then
return false end;self.set("text",bb)
self.set("cursorPos",da+#ba)self:updateViewport()end
function aa:render()local ba=self.getResolved("text")
local ca=self.getResolved("viewOffset")local da=self.getResolved("placeholder")
local _b=self:hasState("focused")
local ab,bb=self.getResolved("width"),self.getResolved("height")local cb=self.getResolved("replaceChar")
self:multiBlit(1,1,ab,bb," ",_a[self.getResolved("foreground")],_a[self.getResolved("background")])if#ba==0 and#da~=0 and not _b then
self:textFg(1,1,da:sub(1,ab),self.getResolved("placeholderColor"))return end;if(_b)then
self:setCursor(
self.getResolved("cursorPos")-ca,1,true,self.getResolved("cursorColor")or
self.getResolved("foreground"))end;local db=ba:sub(ca+1,
ca+ab)
if cb and#cb>0 then db=cb:rep(#db)end
self:textFg(1,1,db,self.getResolved("foreground"))end;return aa end
project["elements/Toast.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("VisualElement")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"title",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"message",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"duration",{default=3,type="number"})
aa.defineProperty(aa,"toastType",{default="default",type="string",canTriggerRender=true})
aa.defineProperty(aa,"callback",{default=nil,type="function"})
aa.defineProperty(aa,"autoHide",{default=true,type="boolean"})
aa.defineProperty(aa,"active",{default=false,type="boolean",canTriggerRender=true})
aa.defineProperty(aa,"colorMap",{default={success=colors.green,error=colors.red,warning=colors.orange,info=colors.lightBlue,default=colors.gray},type="table"})aa.defineEvent(aa,"timer")function aa.new()
local ba=setmetatable({},aa):__init()ba.class=aa;ba.set("width",30)ba.set("height",3)
ba.set("z",100)return ba end;function aa:init(ba,ca)
_a.init(self,ba,ca)return self end
function aa:show(ba,ca,da,_b)local ab,bb,cb
if type(ca)=="string"then ab=ba
bb=ca;cb=da or self.getResolved("duration")elseif type(ca)==
"number"then ab=""bb=ba;cb=ca else ab=""bb=ba
cb=self.getResolved("duration")end;self.set("title",ab)self.set("message",bb)
self.set("active",true)self.set("callback",_b)if self._hideTimerId then
os.cancelTimer(self._hideTimerId)self._hideTimerId=nil end
if
self.getResolved("autoHide")and cb>0 then self._hideTimerId=os.startTimer(cb)end;return self end
function aa:hide()self.set("active",false)self.set("title","")
self.set("message","")if self._hideTimerId then os.cancelTimer(self._hideTimerId)
self._hideTimerId=nil end;return self end;function aa:success(ba,ca,da,_b)self.set("toastType","success")
return self:show(ba,ca,da,_b)end
function aa:error(ba,ca,da,_b)
self.set("toastType","error")return self:show(ba,ca,da,_b)end;function aa:warning(ba,ca,da,_b)self.set("toastType","warning")
return self:show(ba,ca,da,_b)end
function aa:info(ba,ca,da,_b)
self.set("toastType","info")return self:show(ba,ca,da,_b)end
function aa:dispatchEvent(ba,...)_a.dispatchEvent(self,ba,...)
if ba=="timer"then
local ca=select(1,...)
if ca==self._hideTimerId then self._hideTimerId=nil
local da=self.getResolved("callback")if da then da(self)end;self:hide()end end end
function aa:render()_a.render(self)
if not self.getResolved("active")then return end;local ba=self.getResolved("width")
local ca=self.getResolved("height")local da=self.getResolved("title")
local _b=self.getResolved("message")local ab=self.getResolved("toastType")
local bb=self.getResolved("colorMap")local cb=bb[ab]or bb.default
local db=self.getResolved("foreground")local _c=1;local ac=1;if da~=""then local bc=da:sub(1,ba-_c+1)
self:textFg(_c,ac,bc,cb)ac=ac+1 end
if _b~=""and ac<=ca then
local bc=ba-_c+1;local cc={}
for _d in _b:gmatch("%S+")do table.insert(cc,_d)end;local dc=""
for _d,ad in ipairs(cc)do if#dc+#ad+1 >bc then if ac<=ca then
self:textFg(_c,ac,dc,db)ac=ac+1;dc=ad else break end else
dc=dc==""and ad or dc.." "..ad end end
if dc~=""and ac<=ca then self:textFg(_c,ac,dc,db)end end end;return aa end
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
dc.bigfontText=_c(dc.getResolved("fontSize"),_d,dc.getResolved("foreground"),dc.getResolved("background"))return _d end})
cc.defineProperty(cc,"fontSize",{default=1,type="number",canTriggerRender=true,setter=function(dc,_d)
dc.bigfontText=_c(_d,dc.getResolved("text"),dc.getResolved("foreground"),dc.getResolved("background"))return _d end})function cc.new()local dc=setmetatable({},cc):__init()
dc.class=cc;dc.set("width",16)dc.set("height",3)dc.set("z",5)
return dc end
function cc:init(dc,_d)
bc.init(self,dc,_d)self.set("type","BigFont")
self:observe("background",function(ad)
ad.bigfontText=_c(ad.getResolved("fontSize"),ad.getResolved("text"),ad.getResolved("foreground"),ad.getResolved("background"))end)
self:observe("foreground",function(ad)
ad.bigfontText=_c(ad.getResolved("fontSize"),ad.getResolved("text"),ad.getResolved("foreground"),ad.getResolved("background"))end)end
function cc:render()bc.render(self)
if(self.bigfontText)then
local dc=self.getResolved("width")
for i=1,#self.bigfontText[1]do
local _d=self.bigfontText[1][i]:sub(1,dc)
local ad=self.bigfontText[2][i]:sub(1,dc)
local bd=self.bigfontText[3][i]:sub(1,dc)self:blit(1,i,_d,ad,bd)end end end;return cc end
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
self.set("checked",not self.getResolved("checked"))return true end;return false end
function ca:render()local da=self.getResolved("checked")
local _b=self.getResolved("text")local ab=self.getResolved("width")
local bb=self.getResolved("height")local cb=self.getResolved("foreground")
local db=da and
self.getResolved("onBackground")or self.getResolved("offBackground")self:multiBlit(1,1,ab,bb," ",ba[cb],ba[db])
local _c=math.floor(ab/2)local ac=da and(ab-_c+1)or 1
self:multiBlit(ac,1,_c,bb," ",ba[cb],ba[self.getResolved("background")])if _b~=""then self:textFg(ab+2,1,_b,cb)end end;return ca end
project["elements/Frame.lua"] = function(...) local aa=require("elementManager")
local ba=aa.getElement("VisualElement")local ca=aa.getElement("Container")local da=setmetatable({},ca)
da.__index=da
da.defineProperty(da,"draggable",{default=false,type="boolean"})
da.defineProperty(da,"draggingMap",{default={{x=1,y=1,width="width",height=1}},type="table"})
da.defineProperty(da,"scrollable",{default=false,type="boolean"})da.defineEvent(da,"mouse_click")
da.defineEvent(da,"mouse_drag")da.defineEvent(da,"mouse_up")
da.defineEvent(da,"mouse_scroll")function da.new()local ab=setmetatable({},da):__init()
ab.class=da;ab.set("width",12)ab.set("height",6)ab.set("z",10)
return ab end
function da:init(ab,bb)
ca.init(self,ab,bb)self.set("type","Frame")return self end
function da:mouse_click(ab,bb,cb)
if self:isInBounds(bb,cb)then
if self.getResolved("draggable")then
local db,_c=self:getRelativePosition(bb,cb)local ac=self.getResolved("draggingMap")
for bc,cc in ipairs(ac)do
local dc=cc.width or 1;local _d=cc.height or 1
if type(dc)=="string"and dc=="width"then
dc=self.getResolved("width")elseif type(dc)=="function"then dc=dc(self)end
if type(_d)=="string"and _d=="height"then
_d=self.getResolved("height")elseif type(_d)=="function"then _d=_d(self)end;local ad=cc.y or 1
if
db>=cc.x and db<=cc.x+dc-1 and _c>=ad and _c<=ad+_d-1 then
self.dragStartX=bb-self.getResolved("x")self.dragStartY=cb-self.getResolved("y")
self.dragging=true;return true end end end;return ca.mouse_click(self,ab,bb,cb)end;return false end
function da:mouse_up(ab,bb,cb)if self.dragging then self.dragging=false;self.dragStartX=nil
self.dragStartY=nil;return true end;return
ca.mouse_up(self,ab,bb,cb)end
function da:mouse_drag(ab,bb,cb)
if self.dragging then local db=bb-self.dragStartX
local _c=cb-self.dragStartY;self.set("x",db)self.set("y",_c)return true end;return ca.mouse_drag(self,ab,bb,cb)end
function da:getChildrenHeight()local ab=0;local bb=self.getResolved("children")
for cb,db in ipairs(bb)do if
db.get("visible")then local _c=db.get("y")local ac=db.get("height")local bc=_c+ac-1
if bc>ab then ab=bc end end end;return ab end
local function _b(ab,bb,...)local cb={...}
if bb and bb:find("mouse_")then local db,_c,ac=...
local bc,cc=ab.getResolved("offsetX"),ab.getResolved("offsetY")local dc,_d=ab:getRelativePosition(_c+bc,ac+cc)
cb={db,dc,_d}end;return cb end
function da:mouse_scroll(ab,bb,cb)
if(ba.mouse_scroll(self,ab,bb,cb))then
local db=_b(self,"mouse_scroll",ab,bb,cb)
local _c,ac=self:callChildrenEvent(true,"mouse_scroll",table.unpack(db))if _c then return true end
if self.getResolved("scrollable")then
local bc=self.getResolved("height")local cc=self:getChildrenHeight()
local dc=self.getResolved("offsetY")local _d=math.max(0,cc-bc)local ad=dc+ab
ad=math.max(0,math.min(_d,ad))self.set("offsetY",ad)return true end end;return false end;return da end
project["elements/Container.lua"] = function(...) local _b=require("elementManager")
local ab=require("errorManager")local bb=_b.getElement("VisualElement")
local cb=require("layoutManager")local db=require("libraries/expect")
local _c=require("libraries/utils").split;local ac=setmetatable({},bb)ac.__index=ac
ac.defineProperty(ac,"children",{default={},type="table"})
ac.defineProperty(ac,"childrenSorted",{default=true,type="boolean"})
ac.defineProperty(ac,"childrenEventsSorted",{default=true,type="boolean"})
ac.defineProperty(ac,"childrenEvents",{default={},type="table"})
ac.defineProperty(ac,"eventListenerCount",{default={},type="table"})
ac.defineProperty(ac,"focusedChild",{default=nil,type="table",allowNil=true,setter=function(dc,_d,ad)local bd=dc._values.focusedChild
if _d==bd then return _d end
if bd then
if bd:isType("Container")then bd.set("focusedChild",nil,true)end;bd:setFocused(false,true)end;if _d and not ad then _d:setFocused(true,true)if dc.parent then
dc.parent:setFocusedChild(dc)end end;return
_d end})
ac.defineProperty(ac,"visibleChildren",{default={},type="table"})
ac.defineProperty(ac,"visibleChildrenEvents",{default={},type="table"})
ac.defineProperty(ac,"offsetX",{default=0,type="number",canTriggerRender=true,setter=function(dc,_d)dc.set("childrenSorted",false)
dc.set("childrenEventsSorted",false)return _d end})
ac.defineProperty(ac,"offsetY",{default=0,type="number",canTriggerRender=true,setter=function(dc,_d)dc.set("childrenSorted",false)
dc.set("childrenEventsSorted",false)return _d end})
ac.combineProperties(ac,"offset","offsetX","offsetY")
for dc,_d in pairs(_b:getElementList())do
local ad=dc:sub(1,1):upper()..dc:sub(2)
if ad~="BaseFrame"then
ac["add"..ad]=function(bd,...)db(1,bd,"table")
local cd=bd.basalt.create(dc,...)bd:addChild(cd)return cd end
ac["addDelayed"..ad]=function(bd,cd)db(1,bd,"table")
local dd=bd.basalt.create(dc,cd,true,bd)return dd end end end;function ac.new()local dc=setmetatable({},ac):__init()
dc.class=ac;return dc end
function ac:init(dc,_d)
bb.init(self,dc,_d)self.set("type","Container")
self:observe("width",function()
self.set("childrenSorted",false)self.set("childrenEventsSorted",false)
self:updateRender()end)
self:observe("height",function()self.set("childrenSorted",false)
self.set("childrenEventsSorted",false)self:updateRender()end)end
function ac:isChildVisible(dc)
if not dc:isType("VisualElement")then return false end;if(dc.get("visible")==false)then return false end;if(dc._destroyed)then return
false end
local _d,ad=self.getResolved("width"),self.getResolved("height")
local bd,cd=self.getResolved("offsetX"),self.getResolved("offsetY")local dd,__a=dc.get("x"),dc.get("y")
local a_a,b_a=dc.get("width"),dc.get("height")local c_a;local d_a
if(dc.get("ignoreOffset"))then c_a=dd;d_a=__a else c_a=dd-bd;d_a=__a-cd end;return
(c_a+a_a>0)and(c_a<=_d)and(d_a+b_a>0)and(d_a<=ad)end
function ac:addChild(dc)
if dc==self then error("Cannot add container to itself")end;if(dc~=nil)then table.insert(self._values.children,dc)
dc.parent=self;dc:postInit()self.set("childrenSorted",false)
self:registerChildrenEvents(dc)end;return
self end
local function bc(dc,_d)local ad={}for bd,cd in ipairs(_d)do
if dc:isChildVisible(cd)and cd.get("visible")and not
cd._destroyed then table.insert(ad,cd)end end
for i=2,#ad do
local bd=ad[i]local cd=bd.get("z")local dd=i-1
while dd>0 do local __a=ad[dd].get("z")if __a>cd then
ad[dd+1]=ad[dd]dd=dd-1 else break end end;ad[dd+1]=bd end;return ad end
function ac:clear()self.set("children",{})
self.set("childrenEvents",{})self.set("visibleChildren",{})
self.set("visibleChildrenEvents",{})self.set("childrenSorted",true)
self.set("childrenEventsSorted",true)return self end
function ac:sortChildren()self.set("childrenSorted",true)if self._layoutInstance then
self:updateLayout()end
self.set("visibleChildren",bc(self,self._values.children))return self end
function ac:sortChildrenEvents(dc)if self._values.childrenEvents[dc]then
self._values.visibleChildrenEvents[dc]=bc(self,self._values.childrenEvents[dc])end
self.set("childrenEventsSorted",true)return self end
function ac:registerChildrenEvents(dc)if(dc._registeredEvents==nil)then return end
for _d in
pairs(dc._registeredEvents)do self:registerChildEvent(dc,_d)end;return self end
function ac:registerChildEvent(dc,_d)
if not self._values.childrenEvents[_d]then
self._values.childrenEvents[_d]={}self._values.eventListenerCount[_d]=0;if self.parent then
self.parent:registerChildEvent(self,_d)end end
for ad,bd in ipairs(self._values.childrenEvents[_d])do if bd.get("id")==
dc.get("id")then return self end end;self.set("childrenEventsSorted",false)
table.insert(self._values.childrenEvents[_d],dc)self._values.eventListenerCount[_d]=
self._values.eventListenerCount[_d]+1;return self end
function ac:removeChildrenEvents(dc)
if dc~=nil then
if(dc._registeredEvents==nil)then return self end;for _d in pairs(dc._registeredEvents)do
self:unregisterChildEvent(dc,_d)end end;return self end
function ac:unregisterChildEvent(dc,_d)
if self._values.childrenEvents[_d]then
for ad,bd in
ipairs(self._values.childrenEvents[_d])do
if bd.get("id")==dc.get("id")then
table.remove(self._values.childrenEvents[_d],ad)self._values.eventListenerCount[_d]=
self._values.eventListenerCount[_d]-1
if
self._values.eventListenerCount[_d]<=0 then
self._values.childrenEvents[_d]=nil;self._values.eventListenerCount[_d]=nil;if self.parent then
self.parent:unregisterChildEvent(self,_d)end end;self.set("childrenEventsSorted",false)break end end end;return self end
function ac:removeChild(dc)if dc==nil then return self end
for _d,ad in ipairs(self._values.children)do if
ad.get("id")==dc.get("id")then
table.remove(self._values.children,_d)dc.parent=nil;break end end;self:removeChildrenEvents(dc)self:updateRender()
self.set("childrenSorted",false)return self end
function ac:getChild(dc)
if type(dc)=="string"then local _d=_c(dc,"/")
for ad,bd in
pairs(self._values.children)do if bd.get("name")==_d[1]then
if#_d==1 then return bd else if(bd:isType("Container"))then return
bd:find(table.concat(_d,"/",2))end end end end end;return nil end
local function cc(dc,_d,...)local ad={...}
if _d and _d:find("mouse_")then local bd,cd,dd=...
local __a,a_a=dc.getResolved("offsetX"),dc.getResolved("offsetY")local b_a,c_a=dc:getRelativePosition(cd+__a,dd+a_a)
ad={bd,b_a,c_a}end;return ad end
function ac:callChildrenEvent(dc,_d,...)
if
dc and not self.getResolved("childrenEventsSorted")then for bd in pairs(self._values.childrenEvents)do
self:sortChildrenEvents(bd)end end
local ad=dc and self.getResolved("visibleChildrenEvents")or
self.getResolved("childrenEvents")
if ad[_d]then local bd=ad[_d]for i=#bd,1,-1 do local cd=bd[i]
if(cd:dispatchEvent(_d,...))then return true,cd end end end
if(ad["*"])then local bd=ad["*"]for i=#bd,1,-1 do local cd=bd[i]
if(cd:dispatchEvent(_d,...))then return true,cd end end end;return false end
function ac:handleEvent(dc,...)bb.handleEvent(self,dc,...)local _d=cc(self,dc,...)return
self:callChildrenEvent(false,dc,table.unpack(_d))end
function ac:mouse_click(dc,_d,ad)
if bb.mouse_click(self,dc,_d,ad)then
local bd=cc(self,"mouse_click",dc,_d,ad)
local cd,dd=self:callChildrenEvent(true,"mouse_click",table.unpack(bd))
if(cd)then self.set("focusedChild",dd)return true end;self.set("focusedChild",nil)return true end;return false end
function ac:mouse_up(dc,_d,ad)self:mouse_release(dc,_d,ad)
if bb.mouse_up(self,dc,_d,ad)then
local bd=cc(self,"mouse_up",dc,_d,ad)
local cd,dd=self:callChildrenEvent(true,"mouse_up",table.unpack(bd))if(cd)then return true end end;return false end
function ac:mouse_release(dc,_d,ad)bb.mouse_release(self,dc,_d,ad)
local bd=cc(self,"mouse_release",dc,_d,ad)
self:callChildrenEvent(false,"mouse_release",table.unpack(bd))end
function ac:mouse_move(dc,_d,ad)
if bb.mouse_move(self,dc,_d,ad)then
local bd=cc(self,"mouse_move",dc,_d,ad)
local cd,dd=self:callChildrenEvent(true,"mouse_move",table.unpack(bd))if(cd)then return true end end;return false end
function ac:mouse_drag(dc,_d,ad)
if bb.mouse_drag(self,dc,_d,ad)then
local bd=cc(self,"mouse_drag",dc,_d,ad)
local cd,dd=self:callChildrenEvent(true,"mouse_drag",table.unpack(bd))if(cd)then return true end end;return false end
function ac:mouse_scroll(dc,_d,ad)
if(bb.mouse_scroll(self,dc,_d,ad))then
local bd=cc(self,"mouse_scroll",dc,_d,ad)
local cd,dd=self:callChildrenEvent(true,"mouse_scroll",table.unpack(bd))return true end;return false end
function ac:key(dc)
if self.getResolved("focusedChild")then return
self.getResolved("focusedChild"):dispatchEvent("key",dc)end;return true end
function ac:char(dc)
if self.getResolved("focusedChild")then return
self.getResolved("focusedChild"):dispatchEvent("char",dc)end;return true end
function ac:key_up(dc)
if self.getResolved("focusedChild")then return
self.getResolved("focusedChild"):dispatchEvent("key_up",dc)end;return true end
function ac:multiBlit(dc,_d,ad,bd,cd,dd,__a)
local a_a,b_a=self.getResolved("width"),self.getResolved("height")ad=dc<1 and math.min(ad+dc-1,a_a)or
math.min(ad,math.max(0,a_a-dc+1))bd=_d<1 and math.min(
bd+_d-1,b_a)or
math.min(bd,math.max(0,b_a-_d+1))if ad<=0 or
bd<=0 then return self end
bb.multiBlit(self,math.max(1,dc),math.max(1,_d),ad,bd,cd,dd,__a)return self end
function ac:textFg(dc,_d,ad,bd)
local cd,dd=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>dd then return self end
local __a=dc<1 and(2 -dc)or 1
local a_a=math.min(#ad-__a+1,cd-math.max(1,dc)+1)if a_a<=0 then return self end
bb.textFg(self,math.max(1,dc),math.max(1,_d),ad:sub(__a,
__a+a_a-1),bd)return self end
function ac:textBg(dc,_d,ad,bd)
local cd,dd=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>dd then return self end
local __a=dc<1 and(2 -dc)or 1
local a_a=math.min(#ad-__a+1,cd-math.max(1,dc)+1)if a_a<=0 then return self end
bb.textBg(self,math.max(1,dc),math.max(1,_d),ad:sub(__a,
__a+a_a-1),bd)return self end
function ac:drawText(dc,_d,ad)
local bd,cd=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>cd then return self end
local dd=dc<1 and(2 -dc)or 1
local __a=math.min(#ad-dd+1,bd-math.max(1,dc)+1)if __a<=0 then return self end
bb.drawText(self,math.max(1,dc),math.max(1,_d),ad:sub(dd,
dd+__a-1))return self end
function ac:drawFg(dc,_d,ad)
local bd,cd=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>cd then return self end
local dd=dc<1 and(2 -dc)or 1
local __a=math.min(#ad-dd+1,bd-math.max(1,dc)+1)if __a<=0 then return self end
bb.drawFg(self,math.max(1,dc),math.max(1,_d),ad:sub(dd,dd+__a-1))return self end
function ac:drawBg(dc,_d,ad)
local bd,cd=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>cd then return self end
local dd=dc<1 and(2 -dc)or 1
local __a=math.min(#ad-dd+1,bd-math.max(1,dc)+1)if __a<=0 then return self end
bb.drawBg(self,math.max(1,dc),math.max(1,_d),ad:sub(dd,dd+__a-1))return self end
function ac:blit(dc,_d,ad,bd,cd)
local dd,__a=self.getResolved("width"),self.getResolved("height")if _d<1 or _d>__a then return self end
local a_a=dc<1 and(2 -dc)or 1
local b_a=math.min(#ad-a_a+1,dd-math.max(1,dc)+1)
local c_a=math.min(#bd-a_a+1,dd-math.max(1,dc)+1)
local d_a=math.min(#cd-a_a+1,dd-math.max(1,dc)+1)if b_a<=0 then return self end;local _aa=ad:sub(a_a,a_a+b_a-1)local aaa=bd:sub(a_a,
a_a+c_a-1)
local baa=cd:sub(a_a,a_a+d_a-1)
bb.blit(self,math.max(1,dc),math.max(1,_d),_aa,aaa,baa)return self end
function ac:render()bb.render(self)if
not self.getResolved("childrenSorted")then self:sortChildren()end
if not
self.getResolved("childrenEventsSorted")then for dc in pairs(self._values.childrenEvents)do
self:sortChildrenEvents(dc)end end
for dc,_d in ipairs(self.getResolved("visibleChildren"))do if _d==self then
ab.error("CIRCULAR REFERENCE DETECTED!")return end;_d:render()
_d:postRender()end end
function ac:applyLayout(dc,_d)
if self._layoutInstance then cb.destroy(self._layoutInstance)end;self._layoutInstance=cb.apply(self,dc)if _d then
self._layoutInstance.options=_d end;return self end;function ac:updateLayout()
if self._layoutInstance then cb.update(self._layoutInstance)end;return self end
function ac:clearLayout()
if
self._layoutInstance then local dc=require("layoutManager")
dc.destroy(self._layoutInstance)self._layoutInstance=nil end;return self end
function ac:destroy()
if not self:isType("BaseFrame")then
for dc,_d in
ipairs(self._values.children)do if _d.destroy then _d:destroy()end end;self:removeAllObservers()bb.destroy(self)return self else
ab.header="Basalt Error"ab.error("Cannot destroy a BaseFrame.")end end;return ac end
project["elements/Dialog.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("Frame")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"title",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"primaryColor",{default=colors.lime,type="color"})
aa.defineProperty(aa,"secondaryColor",{default=colors.lightGray,type="color"})
aa.defineProperty(aa,"buttonForeground",{default=colors.black,type="color"})
aa.defineProperty(aa,"modal",{default=true,type="boolean"})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"close")
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("z",100)ba.set("width",30)
ba.set("height",10)ba.set("background",colors.gray)
ba.set("foreground",colors.white)ba.set("borderColor",colors.cyan)return ba end
function aa:init(ba,ca)_a.init(self,ba,ca)
self:addBorder({left=true,right=true,top=true,bottom=true})self.set("type","Dialog")return self end
function aa:show()self:center()self.set("visible",true)if
self.getResolved("modal")then self:setFocused(true)end;return self end;function aa:close()self.set("visible",false)
self:fireEvent("close")return self end
function aa:alert(ba,ca,da)self:clear()
self.set("title",ba)self.set("height",8)
self:addLabel({text=ca,x=2,y=3,width=self.getResolved("width")-3,height=3,foreground=colors.white})local _b=10;local ab=
math.floor((self.getResolved("width")-_b)/2)+1
self:addButton({text="OK",x=ab,y=
self.getResolved("height")-2,width=_b,height=1,background=self.getResolved("primaryColor"),foreground=self.getResolved("buttonForeground")}):onClick(function()if
da then da()end;self:close()end)return self:show()end
function aa:confirm(ba,ca,da)self:clear()self.set("title",ba)
self.set("height",8)
self:addLabel({text=ca,x=2,y=3,width=self.getResolved("width")-3,height=3,foreground=colors.white})local _b=10;local ab=2;local bb=_b*2 +ab
local cb=math.floor(
(self.getResolved("width")-bb)/2)+1
self:addButton({text="Cancel",x=cb,y=self.getResolved("height")-2,width=_b,height=1,background=self.getResolved("secondaryColor"),foreground=self.getResolved("buttonForeground")}):onClick(function()if
da then da(false)end;self:close()end)
self:addButton({text="OK",x=cb+_b+ab,y=self.getResolved("height")-2,width=_b,height=1,background=self.getResolved("primaryColor"),foreground=self.getResolved("buttonForeground")}):onClick(function()if
da then da(true)end;self:close()end)return self:show()end
function aa:prompt(ba,ca,da,_b)self:clear()self.set("title",ba)
self.set("height",11)
self:addLabel({text=ca,x=2,y=3,foreground=colors.white})
local ab=self:addInput({x=2,y=5,width=self.getResolved("width")-3,height=1,defaultText=da or"",background=colors.white,foreground=colors.black})local bb=10;local cb=2;local db=bb*2 +cb
local _c=math.floor(
(self.getResolved("width")-db)/2)+1
self:addButton({text="Cancel",x=_c,y=self.getResolved("height")-2,width=bb,height=1,background=self.getResolved("secondaryColor"),foreground=self.getResolved("buttonForeground")}):onClick(function()if
_b then _b(nil)end;self:close()end)
self:addButton({text="OK",x=_c+bb+cb,y=self.getResolved("height")-2,width=bb,height=1,background=self.getResolved("primaryColor"),foreground=self.getResolved("buttonForeground")}):onClick(function()if
_b then _b(ab.get("text")or"")end
self:close()end)return self:show()end
function aa:render()_a.render(self)local ba=self.getResolved("title")if
ba~=""then local ca=self.getResolved("width")local da=ba:sub(1,ca-4)
self:textFg(2,2,da,colors.white)end end
function aa:mouse_click(ba,ca,da)
if self.getResolved("modal")then if self:isInBounds(ca,da)then return
_a.mouse_click(self,ba,ca,da)end;return true end;return _a.mouse_click(self,ba,ca,da)end
function aa:mouse_drag(ba,ca,da)
if self.getResolved("modal")then if self:isInBounds(ca,da)then
return _a.mouse_drag and
_a.mouse_drag(self,ba,ca,da)or false end;return true end;return
_a.mouse_drag and _a.mouse_drag(self,ba,ca,da)or false end
function aa:mouse_up(ba,ca,da)
if self.getResolved("modal")then if self:isInBounds(ca,da)then
return _a.mouse_up and
_a.mouse_up(self,ba,ca,da)or false end;return true end;return
_a.mouse_up and _a.mouse_up(self,ba,ca,da)or false end
function aa:mouse_scroll(ba,ca,da)
if self.getResolved("modal")then if self:isInBounds(ca,da)then
return _a.mouse_scroll and
_a.mouse_scroll(self,ba,ca,da)or false end;return true end;return
_a.mouse_scroll and _a.mouse_scroll(self,ba,ca,da)or false end;return aa end
project["elements/Tree.lua"] = function(...) local aa=require("elements/VisualElement")local ba=string.sub
local ca=require("libraries/colorHex")
local function da(ab,bb,cb,db)db=db or{}cb=cb or 0;for _c,ac in ipairs(ab)do
table.insert(db,{node=ac,level=cb})
if bb[ac]and ac.children then da(ac.children,bb,cb+1,db)end end;return db end;local _b=setmetatable({},aa)_b.__index=_b
_b.defineProperty(_b,"nodes",{default={},type="table",canTriggerRender=true,setter=function(ab,bb)if#bb>0 then
ab.getResolved("expandedNodes")[bb[1]]=true end;return bb end})
_b.defineProperty(_b,"selectedNode",{default=nil,type="table",canTriggerRender=true})
_b.defineProperty(_b,"expandedNodes",{default={},type="table",canTriggerRender=true})
_b.defineProperty(_b,"offset",{default=0,type="number",canTriggerRender=true,setter=function(ab,bb)return math.max(0,bb)end})
_b.defineProperty(_b,"horizontalOffset",{default=0,type="number",canTriggerRender=true,setter=function(ab,bb)return math.max(0,bb)end})
_b.defineProperty(_b,"selectedForegroundColor",{default=colors.white,type="color"})
_b.defineProperty(_b,"selectedBackgroundColor",{default=colors.lightBlue,type="color"})
_b.defineProperty(_b,"showScrollBar",{default=true,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"scrollBarSymbol",{default=" ",type="string",canTriggerRender=true})
_b.defineProperty(_b,"scrollBarBackground",{default="\127",type="string",canTriggerRender=true})
_b.defineProperty(_b,"scrollBarColor",{default=colors.lightGray,type="color",canTriggerRender=true})
_b.defineProperty(_b,"scrollBarBackgroundColor",{default=colors.gray,type="color",canTriggerRender=true})_b.defineEvent(_b,"mouse_click")
_b.defineEvent(_b,"mouse_drag")_b.defineEvent(_b,"mouse_up")
_b.defineEvent(_b,"mouse_scroll")function _b.new()local ab=setmetatable({},_b):__init()
ab.class=_b;ab.set("width",30)ab.set("height",10)ab.set("z",5)
return ab end
function _b:init(ab,bb)
aa.init(self,ab,bb)self.set("type","Tree")return self end
function _b:expandNode(ab)
self.getResolved("expandedNodes")[ab]=true;self:updateRender()return self end
function _b:collapseNode(ab)
self.getResolved("expandedNodes")[ab]=nil;self:updateRender()return self end
function _b:toggleNode(ab)
if self.getResolved("expandedNodes")[ab]then
self:collapseNode(ab)else self:expandNode(ab)end;return self end
function _b:mouse_click(ab,bb,cb)
if aa.mouse_click(self,ab,bb,cb)then
local db,_c=self:getRelativePosition(bb,cb)local ac=self.getResolved("width")
local bc=self.getResolved("height")
local cc=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local dc=self.getResolved("showScrollBar")
local _d,ad=self:getNodeSize()local bd=dc and _d>ac;local cd=bd and bc-1 or bc
local dd=dc and#cc>cd
if dd and db==ac and(not bd or _c<bc)then
local a_a=bd and bc-1 or bc
local b_a=math.max(1,math.floor((cd/#cc)*a_a))local c_a=#cc-cd
local d_a=c_a>0 and
(self.getResolved("offset")/c_a*100)or 0
local _aa=math.floor((d_a/100)* (a_a-b_a))+1
if _c>=_aa and _c<_aa+b_a then self._scrollBarDragging=true;self._scrollBarDragOffset=_c-
_aa else local aaa=( (_c-1)/ (a_a-b_a))*100;local baa=math.floor((
aaa/100)*c_a+0.5)
self.set("offset",math.max(0,math.min(c_a,baa)))end;return true end
if bd and _c==bc and(not dd or db<ac)then
local a_a=dd and ac-1 or ac
local b_a=math.max(1,math.floor((a_a/_d)*a_a))local c_a=_d-a_a
local d_a=c_a>0 and(
self.getResolved("horizontalOffset")/c_a*100)or 0
local _aa=math.floor((d_a/100)* (a_a-b_a))+1
if db>=_aa and db<_aa+b_a then self._hScrollBarDragging=true;self._hScrollBarDragOffset=
db-_aa else local aaa=( (db-1)/ (a_a-b_a))*100;local baa=math.floor((
aaa/100)*c_a+0.5)
self.set("horizontalOffset",math.max(0,math.min(c_a,baa)))end;return true end;local __a=_c+self.getResolved("offset")
if cc[__a]then
local a_a=cc[__a]local b_a=a_a.node
if db<=a_a.level*2 +2 then self:toggleNode(b_a)end;self.set("selectedNode",b_a)
self:fireEvent("node_select",b_a)end;return true end;return false end
function _b:onSelect(ab)self:registerCallback("node_select",ab)return self end
function _b:mouse_drag(ab,bb,cb)
if self._scrollBarDragging then local db,_c=self:getRelativePosition(bb,cb)
local ac=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local bc=self.getResolved("height")
local cc,dc=self:getNodeSize()
local _d=self.getResolved("showScrollBar")and cc>self.getResolved("width")local ad=_d and bc-1 or bc;local bd=ad
local cd=math.max(1,math.floor((ad/#ac)*bd))local dd=#ac-ad;_c=math.max(1,math.min(bd,_c))local __a=_c- (
self._scrollBarDragOffset or 0)local a_a=
( (__a-1)/ (bd-cd))*100
local b_a=math.floor((a_a/100)*dd+0.5)
self.set("offset",math.max(0,math.min(dd,b_a)))return true end
if self._hScrollBarDragging then local db,_c=self:getRelativePosition(bb,cb)
local ac=self.getResolved("width")local bc,cc=self:getNodeSize()
local dc=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local _d=self.getResolved("height")local ad=
self.getResolved("showScrollBar")and bc>ac
local bd=ad and _d-1 or _d
local cd=self.getResolved("showScrollBar")and#dc>bd;local dd=cd and ac-1 or ac
local __a=math.max(1,math.floor((dd/bc)*dd))local a_a=bc-dd;db=math.max(1,math.min(dd,db))local b_a=db- (
self._hScrollBarDragOffset or 0)local c_a=
( (b_a-1)/ (dd-__a))*100
local d_a=math.floor((c_a/100)*a_a+0.5)
self.set("horizontalOffset",math.max(0,math.min(a_a,d_a)))return true end;return
aa.mouse_drag and aa.mouse_drag(self,ab,bb,cb)or false end
function _b:mouse_up(ab,bb,cb)if self._scrollBarDragging then self._scrollBarDragging=false
self._scrollBarDragOffset=nil;return true end
if self._hScrollBarDragging then
self._hScrollBarDragging=false;self._hScrollBarDragOffset=nil;return true end;return
aa.mouse_up and aa.mouse_up(self,ab,bb,cb)or false end
function _b:mouse_scroll(ab,bb,cb)
if aa.mouse_scroll(self,ab,bb,cb)then
local db=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local _c=self.getResolved("height")
local ac=self.getResolved("width")local bc=self.getResolved("showScrollBar")
local cc,dc=self:getNodeSize()local _d=bc and cc>ac;local ad=_d and _c-1 or _c
local bd=math.max(0,#db-ad)
local cd=math.min(bd,math.max(0,self.getResolved("offset")+ab))self.set("offset",cd)return true end;return false end
function _b:getNodeSize()local ab,bb=0,0
local cb=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local db=self.getResolved("expandedNodes")
for _c,ac in ipairs(cb)do
local bc=ac.node;local cc=ac.level;local dc=string.rep("  ",cc)local _d=" "
if bc.children and
#bc.children>0 then _d=db[bc]and"\31"or"\16"end
local ad=dc.._d.." ".. (bc.text or"Node")ab=math.max(ab,#ad)end;bb=#cb;return ab,bb end
function _b:render()aa.render(self)
local ab=da(self.getResolved("nodes"),self.getResolved("expandedNodes"))local bb=self.getResolved("height")
local cb=self.getResolved("width")local db=self.getResolved("selectedNode")
local _c=self.getResolved("expandedNodes")local ac=self.getResolved("offset")
local bc=self.getResolved("horizontalOffset")local cc=self.getResolved("showScrollBar")
local dc,_d=self:getNodeSize()local ad=cc and dc>cb;local bd=ad and bb-1 or bb
local cd=cc and#ab>bd;local dd=cd and cb-1 or cb
for y=1,bd do local _aa=ab[y+ac]
if _aa then local aaa=_aa.node
local baa=_aa.level;local caa=string.rep("  ",baa)local daa=" "
if
aaa.children and#aaa.children>0 then daa=_c[aaa]and"\31"or"\16"end;local _ba=aaa==db
local aba=
_ba and self.getResolved("selectedBackgroundColor")or
(aaa.background or aaa.bg or self.getResolved("background"))
local bba=_ba and self.getResolved("selectedForegroundColor")or
(
aaa.foreground or aaa.fg or self.getResolved("foreground"))
local cba=caa..daa.." ".. (aaa.text or"Node")local dba=ba(cba,bc+1,bc+dd)
local _ca=dba..string.rep(" ",dd-#dba)
local aca=ca[aba]:rep(#_ca)or ca[colors.black]:rep(#_ca)
local bca=ca[bba]:rep(#_ca)or ca[colors.white]:rep(#_ca)self:blit(1,y,_ca,bca,aca)else
self:blit(1,y,string.rep(" ",dd),ca[self.getResolved("foreground")]:rep(dd),ca[self.getResolved("background")]:rep(dd))end end;local __a=self.getResolved("scrollBarSymbol")
local a_a=self.getResolved("scrollBarBackground")local b_a=self.getResolved("scrollBarColor")
local c_a=self.getResolved("scrollBarBackgroundColor")local d_a=self.getResolved("foreground")
if cd then
local _aa=ad and bb-1 or bb
local aaa=math.max(1,math.floor((bd/#ab)*_aa))local baa=#ab-bd;local caa=baa>0 and(ac/baa*100)or 0
local daa=math.floor((
caa/100)* (_aa-aaa))+1
for i=1,_aa do self:blit(cb,i,a_a,ca[d_a],ca[c_a])end;for i=daa,math.min(_aa,daa+aaa-1)do
self:blit(cb,i,__a,ca[b_a],ca[c_a])end end
if ad then local _aa=cd and cb-1 or cb
local aaa=math.max(1,math.floor((_aa/dc)*_aa))local baa=dc-dd;local caa=baa>0 and(bc/baa*100)or 0
local daa=math.floor((
caa/100)* (_aa-aaa))+1
for i=1,_aa do self:blit(i,bb,a_a,ca[d_a],ca[c_a])end;for i=daa,math.min(_aa,daa+aaa-1)do
self:blit(i,bb,__a,ca[b_a],ca[c_a])end end;if cd and ad then
self:blit(cb,bb," ",ca[d_a],ca[self.getResolved("background")])end end;return _b end
project["elements/DropDown.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"dropdownHeight",{default=5,type="number"})
ca.defineProperty(ca,"selectedText",{default="",type="string"})
ca.defineProperty(ca,"dropSymbol",{default="\31",type="string"})
ca.defineProperty(ca,"undropSymbol",{default="\17",type="string"})function ca.new()local da=setmetatable({},ca):__init()
da.class=ca;da.set("width",16)da.set("height",1)da.set("z",8)
return da end;function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","DropDown")
self:registerState("opened",nil,200)return self end
function ca:mouse_click(da,_b,ab)
if
not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
local db=self:hasState("opened")
if cb==1 then
if db then self.set("height",1)self:unsetState("opened")else
self.set("height",
1 +
math.min(self.getResolved("dropdownHeight"),#self.getResolved("items")))self:setState("opened")end;return true elseif db and cb>1 then return aa.mouse_click(self,da,_b,ab-1)end;return false end
function ca:mouse_drag(da,_b,ab)if self:hasState("opened")then
return aa.mouse_drag(self,da,_b,ab-1)end;return
_a.mouse_drag and _a.mouse_drag(self,da,_b,ab)or false end
function ca:mouse_up(da,_b,ab)
if self:hasState("opened")then
local bb,cb=self:getRelativePosition(_b,ab)
if cb>1 and self.getResolved("selectable")and
not self._scrollBarDragging then
local db=(cb-1)+self.getResolved("offset")local _c=self.getResolved("items")
if db<=#_c then local ac=_c[db]if
type(ac)=="string"then ac={text=ac}_c[db]=ac end
if not
self.getResolved("multiSelection")then for bc,cc in ipairs(_c)do
if type(cc)=="table"then cc.selected=false end end end;ac.selected=not ac.selected
if ac.callback then ac.callback(self)end;self:fireEvent("select",db,ac)
self:unsetState("opened")self:unsetState("clicked")self.set("height",1)
self:updateRender()return true end end;aa.mouse_up(self,da,_b,ab-1)
self:unsetState("clicked")return true end;return
_a.mouse_up and _a.mouse_up(self,da,_b,ab)or false end
function ca:render()_a.render(self)local da=self.getResolved("width")
local _b=self.getResolved("height")local ab=self.getResolved("selectedText")
local bb=self:hasState("opened")local cb=self:getSelectedItems()if#cb>0 then local db=cb[1]
ab=db.text or""ab=ab:sub(1,da-2)end
if bb then local db=_b
local _c=math.min(self.getResolved("dropdownHeight"),
#self.getResolved("items"))self.set("height",_c)aa.render(self,1)
self.set("height",db)end
self:blit(1,1,ab..
string.rep(" ",da-#ab-1).. (
bb and self.getResolved("dropSymbol")or self.getResolved("undropSymbol")),string.rep(ba[self.getResolved("foreground")],da),string.rep(ba[self.getResolved("background")],da))end;function ca:focus()_a.focus(self)self:prioritize()
self:setState("opened")end
function ca:blur()_a.blur(self)
self:unsetState("opened")self.set("height",1)self:updateRender()end;return ca end
project["elements/Display.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("VisualElement")local aa=setmetatable({},_a)aa.__index=aa;function aa.new()
local ba=setmetatable({},aa):__init()ba.class=aa;ba.set("width",25)ba.set("height",8)
ba.set("z",5)return ba end
function aa:init(ba,ca)
_a.init(self,ba,ca)self.set("type","Display")
self._window=window.create(ca.getActiveFrame():getTerm(),1,1,self.getResolved("width"),self.getResolved("height"),false)local da=self._window.reposition;local _b=self._window.blit
local ab=self._window.write
self._window.reposition=function(bb,cb,db,_c)self.set("x",bb)self.set("y",cb)
self.set("width",db)self.set("height",_c)da(1,1,db,_c)end;self._window.getPosition=function(bb)
return bb.getResolved("x"),bb.getResolved("y")end;self._window.setVisible=function(bb)
self.set("visible",bb)end;self._window.isVisible=function(bb)return
bb.getResolved("visible")end
self._window.blit=function(bb,cb,db,_c,ac)
_b(bb,cb,db,_c,ac)self:updateRender()end
self._window.write=function(bb,cb,db)ab(bb,cb,db)self:updateRender()end
self:observe("width",function(bb,cb)local db=bb._window;if db then
db.reposition(1,1,cb,bb.getResolved("height"))end end)
self:observe("height",function(bb,cb)local db=bb._window;if db then
db.reposition(1,1,bb.getResolved("width"),cb)end end)end;function aa:getWindow()return self._window end
function aa:write(ba,ca,da,_b,ab)local bb=self._window
if bb then if _b then
bb.setTextColor(_b)end;if ab then bb.setBackgroundColor(ab)end
bb.setCursorPos(ba,ca)bb.write(da)end;self:updateRender()return self end
function aa:render()_a.render(self)local ba=self._window;local ca,da=ba.getSize()
if ba then for y=1,da do
local _b,ab,bb=ba.getLine(y)self:blit(1,y,_b,ab,bb)end end end;return aa end
project["elements/Breadcrumb.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("VisualElement")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"path",{default={},type="table",canTriggerRender=true})
aa.defineProperty(aa,"separator",{default=" > ",type="string",canTriggerRender=true})
aa.defineProperty(aa,"clickable",{default=true,type="boolean"})
aa.defineProperty(aa,"autoSize",{default=true,type="boolean"})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"mouse_up")
function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;ba.set("z",5)ba.set("height",1)
ba.set("backgroundEnabled",false)return ba end;function aa:init(ba,ca)_a.init(self,ba,ca)
self.set("type","Breadcrumb")end
function aa:mouse_click(ba,ca,da)if not
self.getResolved("clickable")then return false end
if
_a.mouse_click(self,ba,ca,da)then local _b=self.getResolved("path")
local ab=self.getResolved("separator")local bb=1
for cb,db in ipairs(_b)do local _c=#db;if ca>=bb and ca<bb+_c then
self:fireEvent("select",cb,{table.unpack(_b,1,cb)})return true end;bb=bb+_c;if cb<#_b then
bb=bb+#ab end end end;return false end
function aa:onSelect(ba)self:registerCallback("select",ba)return self end
function aa:render()local ba=self.getResolved("path")
local ca=self.getResolved("separator")local da=self.getResolved("foreground")
local _b=self.getResolved("clickable")local ab=self.getResolved("width")local bb=""for _c,ac in ipairs(ba)do bb=bb..ac;if
_c<#ba then bb=bb..ca end end
if
self.getResolved("autoSize")then self.getResolved("width",#bb)else if#bb>ab then local _c="... > "
local ac=ab-#_c
if ac>0 then bb=_c..bb:sub(-ac)else bb=_c:sub(1,ab)end end end;local cb=1;local db
for _c in bb:gmatch("[^"..ca.."]+")do db=da
self:textFg(cb,1,_c,db)cb=cb+#_c;local ac=bb:find(ca,cb,true)if ac then
self:textFg(cb,1,ca,_b and colors.gray or
colors.lightGray)cb=cb+#ca end end end;return aa end
project["elements/LineChart.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=ba.getElement("Graph")
local _b=require("libraries/colorHex")local ab=setmetatable({},da)ab.__index=ab;function ab.new()
local cb=setmetatable({},ab):__init()cb.class=ab;return cb end
function ab:init(cb,db)
da.init(self,cb,db)self.set("type","LineChart")return self end
local function bb(cb,db,_c,ac,bc,cc,dc,_d)local ad=ac-db;local bd=bc-_c
local cd=math.max(math.abs(ad),math.abs(bd))
for i=0,cd do local dd=cd==0 and 0 or i/cd
local __a=math.floor(db+ad*dd)local a_a=math.floor(_c+bd*dd)if __a>=1 and
__a<=cb.getResolved("width")and a_a>=1 and
a_a<=cb.getResolved("height")then
cb:blit(__a,a_a,cc,_b[dc],_b[_d])end end end
function ab:render()ca.render(self)local cb=self.getResolved("width")
local db=self.getResolved("height")local _c=self.getResolved("minValue")
local ac=self.getResolved("maxValue")local bc=self.getResolved("series")
for cc,dc in pairs(bc)do
if(dc.visible)then local _d,ad
local bd=#dc.data;local cd=(cb-1)/math.max((bd-1),1)
for dd,__a in ipairs(dc.data)do local a_a=math.floor(( (
dd-1)*cd)+1)
local b_a=(__a-_c)/ (ac-_c)local c_a=math.floor(db- (b_a* (db-1)))
c_a=math.max(1,math.min(c_a,db))if _d then
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
local db=self.getResolved("series")
table.insert(db,{name=da,symbol=_b or" ",bgColor=ab or colors.white,fgColor=bb or colors.black,pointCount=cb or
self.getResolved("width"),data={},visible=true})self:updateRender()return self end
function ca:removeSeries(da)local _b=self.getResolved("series")for ab,bb in ipairs(_b)do if bb.name==da then
table.remove(_b,ab)break end end
self:updateRender()return self end
function ca:getSeries(da)local _b=self.getResolved("series")for ab,bb in ipairs(_b)do if bb.name==da then
return bb end end;return nil end
function ca:changeSeriesVisibility(da,_b)local ab=self.getResolved("series")for bb,cb in ipairs(ab)do if
cb.name==da then cb.visible=_b;break end end
self:updateRender()return self end
function ca:addPoint(da,_b)local ab=self.getResolved("series")
for bb,cb in ipairs(ab)do if cb.name==da then
table.insert(cb.data,_b)
while#cb.data>cb.pointCount do table.remove(cb.data,1)end;break end end;self:updateRender()return self end
function ca:focusSeries(da)local _b=self.getResolved("series")
for ab,bb in ipairs(_b)do if bb.name==da then
table.remove(_b,ab)table.insert(_b,bb)break end end;self:updateRender()return self end
function ca:setSeriesPointCount(da,_b)local ab=self.getResolved("series")
for bb,cb in ipairs(ab)do if
cb.name==da then cb.pointCount=_b
while#cb.data>_b do table.remove(cb.data,1)end;break end end;self:updateRender()return self end
function ca:clear(da)local _b=self.getResolved("series")
if da then for ab,bb in ipairs(_b)do if bb.name==da then
bb.data={}break end end else for ab,bb in ipairs(_b)do
bb.data={}end end;return self end
function ca:render()aa.render(self)local da=self.getResolved("width")
local _b=self.getResolved("height")local ab=self.getResolved("minValue")
local bb=self.getResolved("maxValue")local cb=self.getResolved("series")
for db,_c in pairs(cb)do
if(_c.visible)then
local ac=#_c.data;local bc=(da-1)/math.max((ac-1),1)
for cc,dc in ipairs(_c.data)do local _d=math.floor(( (
cc-1)*bc)+1)
local ad=(dc-ab)/ (bb-ab)local bd=math.floor(_b- (ad* (_b-1)))
bd=math.max(1,math.min(bd,_b))
self:blit(_d,bd,_c.symbol,ba[_c.bgColor],ba[_c.fgColor])end end end end;return ca end
project["elements/Table.lua"] = function(...) local _a=require("elements/Collection")
local aa=require("libraries/colorHex")local ba=setmetatable({},_a)ba.__index=ba
ba.defineProperty(ba,"columns",{default={},type="table",canTriggerRender=true,setter=function(da,_b)local ab={}
for bb,cb in
ipairs(_b)do
if type(cb)=="string"then ab[bb]={name=cb,width=#cb+1}elseif type(cb)=="table"then
ab[bb]={name=
cb.name or"",width=cb.width,minWidth=cb.minWidth or 3,maxWidth=cb.maxWidth or nil}end end;return ab end})
ba.defineProperty(ba,"headerColor",{default=colors.blue,type="color"})
ba.defineProperty(ba,"gridColor",{default=colors.gray,type="color"})
ba.defineProperty(ba,"sortColumn",{default=nil,type="number",canTriggerRender=true})
ba.defineProperty(ba,"sortDirection",{default="asc",type="string",canTriggerRender=true})
ba.defineProperty(ba,"customSortFunction",{default={},type="table"})
ba.defineProperty(ba,"offset",{default=0,type="number",canTriggerRender=true,setter=function(da,_b)
local ab=math.max(0,#da.getResolved("items")- (
da.getResolved("height")-1))return math.min(ab,math.max(0,_b))end})
ba.defineProperty(ba,"showScrollBar",{default=true,type="boolean",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarSymbol",{default=" ",type="string",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarBackground",{default="\127",type="string",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarColor",{default=colors.lightGray,type="color",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarBackgroundColor",{default=colors.gray,type="color",canTriggerRender=true})ba.defineEvent(ba,"mouse_click")
ba.defineEvent(ba,"mouse_drag")ba.defineEvent(ba,"mouse_up")
ba.defineEvent(ba,"mouse_scroll")
local ca={cells={type="table",default={}},_sortValues={type="table",default={}},selected={type="boolean",default=false},text={type="string",default=""}}function ba.new()local da=setmetatable({},ba):__init()
da.class=ba;da.set("width",30)da.set("height",10)da.set("z",5)
return da end
function ba:init(da,_b)
_a.init(self,da,_b)self._entrySchema=ca;self.set("type","Table")
self:observe("sortColumn",function()if
self.getResolved("sortColumn")then
self:sortByColumn(self.getResolved("sortColumn"))end end)return self end;function ba:addRow(...)local da={...}
_a.addItem(self,{cells=da,_sortValues=da,text=table.concat(da," ")})return self end;function ba:removeRow(da)
local _b=self.getResolved("items")
if _b[da]then table.remove(_b,da)self.set("items",_b)end;return self end;function ba:getRow(da)
local _b=self.getResolved("items")return _b[da]end
function ba:updateCell(da,_b,ab)
local bb=self.getResolved("items")if bb[da]and bb[da].cells then bb[da].cells[_b]=ab
self.set("items",bb)end;return self end
function ba:getSelectedRow()local da=self.getResolved("items")for _b,ab in ipairs(da)do local bb=ab._data and
ab._data.selected or ab.selected;if bb then
return ab end end;return nil end;function ba:clearData()self.set("items",{})return self end
function ba:addColumn(da,_b)
local ab=self.getResolved("columns")table.insert(ab,{name=da,width=_b})
self.set("columns",ab)return self end
function ba:setColumnSortFunction(da,_b)
local ab=self.getResolved("customSortFunction")ab[da]=_b;self.set("customSortFunction",ab)return self end
function ba:setData(da,_b)self:clearData()
for ab,bb in ipairs(da)do local cb={}local db={}
for _c,ac in ipairs(bb)do db[_c]=ac;if _b and
_b[_c]then cb[_c]=_b[_c](ac)else cb[_c]=ac end end
_a.addItem(self,{cells=cb,_sortValues=db,text=table.concat(cb," ")})end;return self end
function ba:getData()local da=self.getResolved("items")local _b={}for ab,bb in ipairs(da)do local cb=bb._data and
bb._data.cells or bb.cells;if cb then
table.insert(_b,cb)end end
return _b end
function ba:calculateColumnWidths(da,_b)local ab={}local bb=_b;local cb={}local db=0
for ac,bc in ipairs(da)do
ab[ac]={name=bc.name,width=bc.width,minWidth=bc.minWidth or 3,maxWidth=bc.maxWidth}
if type(bc.width)=="number"then
ab[ac].visibleWidth=math.max(bc.width,ab[ac].minWidth)if ab[ac].maxWidth then
ab[ac].visibleWidth=math.min(ab[ac].visibleWidth,ab[ac].maxWidth)end
bb=bb-ab[ac].visibleWidth;db=db+ab[ac].visibleWidth elseif type(bc.width)=="string"and
bc.width:match("%%$")then
local cc=tonumber(bc.width:match("(%d+)%%"))
if cc then ab[ac].visibleWidth=math.floor(_b*cc/100)
ab[ac].visibleWidth=math.max(ab[ac].visibleWidth,ab[ac].minWidth)if ab[ac].maxWidth then
ab[ac].visibleWidth=math.min(ab[ac].visibleWidth,ab[ac].maxWidth)end
bb=bb-ab[ac].visibleWidth;db=db+ab[ac].visibleWidth else table.insert(cb,ac)end else table.insert(cb,ac)end end
if#cb>0 and bb>0 then local ac=math.floor(bb/#cb)
for bc,cc in ipairs(cb)do
ab[cc].visibleWidth=math.max(ac,ab[cc].minWidth)if ab[cc].maxWidth then
ab[cc].visibleWidth=math.min(ab[cc].visibleWidth,ab[cc].maxWidth)end end end;local _c=0
for ac,bc in ipairs(ab)do _c=_c+ (bc.visibleWidth or 0)end;if _c>_b then local ac=_b/_c
for bc,cc in ipairs(ab)do if cc.visibleWidth then
cc.visibleWidth=math.max(1,math.floor(cc.visibleWidth*ac))end end end
return ab end
function ba:sortByColumn(da,_b)local ab=self.getResolved("items")
local bb=self.getResolved("sortDirection")local cb=self.getResolved("customSortFunction")
local db=_b or cb[da]
if db then
table.sort(ab,function(_c,ac)return db(_c,ac,bb)end)else
table.sort(ab,function(_c,ac)
local bc=_c._data and _c._data.cells or _c.cells
local cc=ac._data and ac._data.cells or ac.cells
local dc=_c._data and _c._data._sortValues or _c._sortValues
local _d=ac._data and ac._data._sortValues or ac._sortValues
if not _c or not ac or not bc or not cc then return false end;local ad,bd;if dc and dc[da]then ad=dc[da]else ad=bc[da]end;if _d and _d[da]then
bd=_d[da]else bd=cc[da]end
if
type(ad)=="number"and type(bd)=="number"then if bb=="asc"then return ad<bd else return ad>bd end else
local cd=tostring(ad or"")local dd=tostring(bd or"")
if bb=="asc"then return cd<dd else return cd>dd end end end)end;self.set("items",ab)return self end
function ba:onRowSelect(da)self:registerCallback("rowSelect",da)return self end
function ba:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
local db=self.getResolved("width")local _c=self.getResolved("height")
local ac=self.getResolved("items")local bc=self.getResolved("showScrollBar")local cc=_c-1
if
bc and#ac>cc and bb==db and cb>1 then local dc=_c-1;local _d=#ac-cc;local ad=math.max(1,math.floor((
cc/#ac)*dc))
local bd=_d>0 and(
self.getResolved("offset")/_d*100)or 0
local cd=math.floor((bd/100)* (dc-ad))+1;local dd=cb-1
if dd>=cd and dd<cd+ad then self._scrollBarDragging=true;self._scrollBarDragOffset=
dd-cd else local __a=( (dd-1)/ (dc-ad))*100;local a_a=math.floor((
__a/100)*_d+0.5)
self.set("offset",math.max(0,math.min(_d,a_a)))end;return true end
if cb==1 then local dc=self.getResolved("columns")
local _d=self:calculateColumnWidths(dc,db)local ad=1
for bd,cd in ipairs(_d)do
local dd=cd.visibleWidth or cd.width or 10
if bb>=ad and bb<ad+dd then
if self.getResolved("sortColumn")==bd then
self.set("sortDirection",
self.getResolved("sortDirection")=="asc"and"desc"or"asc")else self.set("sortColumn",bd)
self.set("sortDirection","asc")end;self:sortByColumn(bd)self:updateRender()return true end;ad=ad+dd end;return true end
if cb>1 then local dc=cb-2 +self.getResolved("offset")
if dc>=0 and
dc<#ac then local _d=dc+1
for ad,bd in ipairs(ac)do if bd._data then bd._data.selected=false else
bd.selected=false end end
if ac[_d]then if ac[_d]._data then ac[_d]._data.selected=true else
ac[_d].selected=true end
self:fireEvent("rowSelect",_d,ac[_d])self:updateRender()end end;return true end;return true end
function ba:mouse_drag(da,_b,ab)
if self._scrollBarDragging then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.getResolved("items")local _c=self.getResolved("height")local ac=_c-1;local bc=_c-1;local cc=math.max(1,math.floor((
ac/#db)*bc))
local dc=#db-ac;local _d=cb-1;_d=math.max(1,math.min(bc,_d))local ad=_d- (
self._scrollBarDragOffset or 0)local bd=
( (ad-1)/ (bc-cc))*100
local cd=math.floor((bd/100)*dc+0.5)
self.set("offset",math.max(0,math.min(dc,cd)))return true end;return
_a.mouse_drag and _a.mouse_drag(self,da,_b,ab)or false end
function ba:mouse_up(da,_b,ab)if self._scrollBarDragging then self._scrollBarDragging=false
self._scrollBarDragOffset=nil;return true end
return _a.mouse_up and
_a.mouse_up(self,da,_b,ab)or false end
function ba:mouse_scroll(da,_b,ab)
if _a.mouse_scroll(self,da,_b,ab)then
local bb=self.getResolved("items")local cb=self.getResolved("height")local db=cb-1
local _c=math.max(0,#bb-db)
local ac=math.min(_c,math.max(0,self.getResolved("offset")+da))self.set("offset",ac)self:updateRender()return true end;return false end
function ba:render()_a.render(self)local da=self.getResolved("columns")
local _b=self.getResolved("items")local ab=self.getResolved("sortColumn")
local bb=self.getResolved("offset")local cb=self.getResolved("height")
local db=self.getResolved("width")local _c=self.getResolved("showScrollBar")
local ac=self.getResolved("background")local bc=self.getResolved("foreground")local cc=cb-1
local dc=_c and#_b>cc;local _d=dc and db-1 or db
local ad=self:calculateColumnWidths(da,_d)local bd=0;local cd=#ad
for __a,a_a in ipairs(ad)do
if bd+a_a.visibleWidth>_d then cd=__a-1;break end;bd=bd+a_a.visibleWidth end;local dd=1
for __a,a_a in ipairs(ad)do if __a>cd then break end;local b_a=a_a.name
if __a==ab then b_a=b_a..
(
self.getResolved("sortDirection")=="asc"and"\30"or"\31")end
self:textFg(dd,1,b_a:sub(1,a_a.visibleWidth),self.getResolved("headerColor"))dd=dd+a_a.visibleWidth end;if dd<=_d then
self:textBg(dd,1,string.rep(" ",_d-dd+1),ac)end
for y=2,cb do local __a=y-2 +bb;local a_a=_b[__a+1]
if a_a then local b_a=a_a._data and
a_a._data.cells or a_a.cells
local c_a=a_a._data and
a_a._data.selected or a_a.selected
if b_a then dd=1
local d_a=c_a and self.getResolved("selectedBackground")or ac
for _aa,aaa in ipairs(ad)do if _aa>cd then break end;local baa=tostring(b_a[_aa]or"")
local caa=
baa..string.rep(" ",aaa.visibleWidth-#baa)if _aa<cd then
caa=string.sub(caa,1,aaa.visibleWidth-1).." "end
local daa=string.sub(caa,1,aaa.visibleWidth)local _ba=string.rep(aa[bc],aaa.visibleWidth)
local aba=string.rep(aa[d_a],aaa.visibleWidth)self:blit(dd,y,daa,_ba,aba)dd=dd+aaa.visibleWidth end;if dd<=_d then
self:textBg(dd,y,string.rep(" ",_d-dd+1),d_a)end end else
self:blit(1,y,string.rep(" ",_d),string.rep(aa[bc],_d),string.rep(aa[ac],_d))end end
if dc then local __a=cb-1
local a_a=math.max(1,math.floor((cc/#_b)*__a))local b_a=#_b-cc;local c_a=b_a>0 and(bb/b_a*100)or 0
local d_a=math.floor((
c_a/100)* (__a-a_a))+1;local _aa=self.getResolved("scrollBarSymbol")
local aaa=self.getResolved("scrollBarBackground")local baa=self.getResolved("scrollBarColor")
local caa=self.getResolved("scrollBarBackgroundColor")
for i=2,cb do self:blit(db,i,aaa,aa[bc],aa[caa])end;for i=d_a,math.min(__a,d_a+a_a-1)do
self:blit(db,i+1,_aa,aa[baa],aa[caa])end end end;return ba end
project["elements/Menu.lua"] = function(...) local aa=require("elements/VisualElement")
local ba=require("elements/List")local ca=require("libraries/colorHex")
local da=setmetatable({},ba)da.__index=da
da.defineProperty(da,"separatorColor",{default=colors.gray,type="color"})
da.defineProperty(da,"spacing",{default=1,type="number",canTriggerRender=true})
da.defineProperty(da,"openDropdown",{default=nil,type="table",allowNil=true,canTriggerRender=true})
da.defineProperty(da,"dropdownBackground",{default=colors.black,type="color",canTriggerRender=true})
da.defineProperty(da,"dropdownForeground",{default=colors.white,type="color",canTriggerRender=true})
da.defineProperty(da,"horizontalOffset",{default=0,type="number",canTriggerRender=true,setter=function(ab,bb)
local cb=math.max(0,ab:getTotalWidth()-ab.getResolved("width"))return math.min(cb,math.max(0,bb))end})
da.defineProperty(da,"maxWidth",{default=nil,type="number",canTriggerRender=true})
local _b={text={type="string",default="Entry"},bg={type="number",default=nil},fg={type="number",default=nil},selectedBg={type="number",default=nil},selectedFg={type="number",default=
nil},callback={type="function",default=nil},dropdown={type="table",default=nil}}function da.new()local ab=setmetatable({},da):__init()
ab.class=da;ab.set("width",30)ab.set("height",1)ab.set("z",8)
return ab end
function da:init(ab,bb)
ba.init(self,ab,bb)self._entrySchema=_b;self.set("type","Menu")
self:observe("items",function()
local cb=self.getResolved("maxWidth")if cb then
self.set("width",math.min(cb,self:getTotalWidth()),true)else
self.set("width",self:getTotalWidth(),true)end end)return self end
function da:getTotalWidth()local ab=self.getResolved("items")
local bb=self.getResolved("spacing")local cb=0
for db,_c in ipairs(ab)do if type(_c)=="table"then cb=cb+#_c.text else cb=cb+
#tostring(_c)+2 end;if db<#ab then
cb=cb+bb end end;return cb end
function da:render()aa.render(self)local ab=self.getResolved("width")
local bb=self.getResolved("spacing")local cb=self.getResolved("horizontalOffset")
local db=self.getResolved("items")local _c={}local ac=1
for cc,dc in ipairs(db)do if type(dc)=="string"then
dc={text=" "..dc.." "}db[cc]=dc end
_c[cc]={startX=ac,endX=ac+#dc.text-1,text=dc.text,item=dc}ac=ac+#dc.text;if cc<#db and bb>0 then ac=ac+bb end end
for cc,dc in ipairs(_c)do local _d=dc.item;local ad=dc.startX-cb;local bd=dc.endX-cb
if ad>ab then break end
if bd>=1 then local cd=math.max(1,ad)local dd=math.min(ab,bd)
local __a=math.max(1,1 -ad+1)
local a_a=math.min(#dc.text,#dc.text- (bd-ab))local b_a=dc.text:sub(__a,a_a)
if#b_a>0 then local c_a=_d.selected
local d_a=
_d.selectable==false and self.getResolved("separatorColor")or
(
c_a and(
_d.selectedForeground or self.getResolved("selectedForeground"))or(_d.foreground or self.getResolved("foreground")))
local _aa=c_a and
(_d.selectedBackground or self.getResolved("selectedBackground"))or
(_d.background or self.getResolved("background"))
self:blit(cd,1,b_a,string.rep(ca[d_a],#b_a),string.rep(ca[_aa],#b_a))end
if cc<#db and bb>0 then local c_a=dc.endX+1 -cb;local d_a=c_a+bb-1
if d_a>=1 and
c_a<=ab then local _aa=math.max(1,c_a)local aaa=math.min(ab,d_a)
local baa=aaa-_aa+1
if baa>0 then local caa=string.rep(" ",baa)
self:blit(_aa,1,caa,string.rep(ca[self.getResolved("foreground")],baa),string.rep(ca[self.getResolved("background")],baa))end end end end end;local bc=self.getResolved("openDropdown")if bc then
self:renderDropdown(bc)end end
function da:renderDropdown(ab)local bb=self.getResolved("dropdownBackground")
local cb=self.getResolved("dropdownForeground")
for db,_c in ipairs(ab.items)do local ac=ab.y+db-1
local bc=_c.text or _c.label or""local cc=bc=="---"local dc=ca[_c.background or bb]
local _d=ca[_c.foreground or cb]local ad=string.rep(" ",ab.width)
self:blit(ab.x,ac,ad,string.rep(_d,ab.width),string.rep(dc,ab.width))
if cc then local bd=string.rep("-",ab.width)
self:blit(ab.x,ac,bd,string.rep(ca[colors.gray],ab.width),string.rep(dc,ab.width))else
if#bc>ab.width-2 then bc=bc:sub(1,ab.width-2)end
self:textFg(ab.x+1,ac,bc,_c.foreground or cb)end end end
function da:mouse_click(ab,bb,cb)local db=self.getResolved("openDropdown")
if db then
local ad,bd=self:getRelativePosition(bb,cb)
if self:isInsideDropdown(ad,bd,db)then
return self:handleDropdownClick(ad,bd,db)else self:hideDropdown()end end
if not aa.mouse_click(self,ab,bb,cb)then return false end
if(self.getResolved("selectable")==false)then return false end
local _c=select(1,self:getRelativePosition(bb,cb))local ac=self.getResolved("horizontalOffset")
local bc=self.getResolved("spacing")local cc=self.getResolved("items")local dc=_c+ac;local _d=1
for ad,bd in ipairs(cc)do
local cd=#bd.text
if dc>=_d and dc<_d+cd then
if bd.selectable~=false then if type(bd)=="string"then
bd={text=bd}cc[ad]=bd end
if
bd.dropdown and#bd.dropdown>0 then self:showDropdown(ad,bd,_d-ac)return true end;if not self.getResolved("multiSelection")then
for dd,__a in ipairs(cc)do if
type(__a)=="table"then __a.selected=false end end end;bd.selected=not
bd.selected;if bd.callback then bd.callback(self)end
self:fireEvent("select",ad,bd)end;return true end;_d=_d+cd;if ad<#cc and bc>0 then _d=_d+bc end end;return false end
function da:mouse_scroll(ab,bb,cb)
if aa.mouse_scroll(self,ab,bb,cb)then
local db=self.getResolved("horizontalOffset")
local _c=math.max(0,self:getTotalWidth()-self.getResolved("width"))db=math.min(_c,math.max(0,db+ (ab*3)))
self.set("horizontalOffset",db)return true end;return false end
function da:showDropdown(ab,bb,cb)local db=bb.dropdown;if not db or#db==0 then return end;local _c=8;for cc,dc in
ipairs(db)do local _d=dc.text or dc.label or""
if#_d+2 >_c then _c=#_d+2 end end;local ac=#db
local bc=self.getResolved("height")
self.set("openDropdown",{index=ab,items=db,x=cb,y=bc+1,width=_c,height=ac})self:updateRender()end;function da:hideDropdown()self.set("openDropdown",nil)
self:updateRender()end
function da:isInsideDropdown(ab,bb,cb)return
ab>=cb.x and
ab<cb.x+cb.width and bb>=cb.y and bb<cb.y+cb.height end
function da:handleDropdownClick(ab,bb,cb)local db=bb-cb.y+1
if db>=1 and db<=#cb.items then
local _c=cb.items[db]if _c.text=="---"or _c.label=="---"or _c.disabled then return
true end
if _c.callback then
_c.callback(self,_c)elseif _c.onClick then _c.onClick(self,_c)end;self:hideDropdown()return true end;return false end;return da end
project["elements/Slider.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"step",{default=1,type="number",canTriggerRender=true})
d.defineProperty(d,"max",{default=100,type="number"})
d.defineProperty(d,"horizontal",{default=true,type="boolean",canTriggerRender=true,setter=function(_a,aa)if aa then _a.set("backgroundEnabled",false)else
_a.set("backgroundEnabled",true)end end})
d.defineProperty(d,"barColor",{default=colors.gray,type="color",canTriggerRender=true})
d.defineProperty(d,"sliderColor",{default=colors.blue,type="color",canTriggerRender=true})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_drag")d.defineEvent(d,"mouse_up")
d.defineEvent(d,"mouse_scroll")
function d.new()local _a=setmetatable({},d):__init()_a.class=d
_a.set("width",8)_a.set("height",1)
_a.set("backgroundEnabled",false)return _a end
function d:init(_a,aa)c.init(self,_a,aa)self.set("type","Slider")end
function d:getValue()local _a=self.getResolved("step")
local aa=self.getResolved("max")
local ba=
self.getResolved("horizontal")and self.getResolved("width")or self.getResolved("height")return math.floor((_a-1)* (aa/ (ba-1)))end
function d:mouse_click(_a,aa,ba)
if self:isInBounds(aa,ba)then
local ca,da=self:getRelativePosition(aa,ba)
local _b=self.getResolved("horizontal")and ca or da
local ab=
self.getResolved("horizontal")and self.getResolved("width")or self.getResolved("height")
self.set("step",math.min(ab,math.max(1,_b)))self:updateRender()return true end;return false end;d.mouse_drag=d.mouse_click
function d:mouse_scroll(_a,aa,ba)
if self:isInBounds(aa,ba)then
local ca=self.getResolved("step")
local da=
self.getResolved("horizontal")and self.getResolved("width")or self.getResolved("height")
self.set("step",math.min(da,math.max(1,ca+_a)))self:updateRender()return true end;return false end
function d:render()c.render(self)local _a=self.getResolved("width")
local aa=self.getResolved("height")local ba=self.getResolved("horizontal")
local ca=self.getResolved("step")local da=ba and"\140"or" "
local _b=string.rep(da,ba and _a or aa)
if ba then
self:textFg(1,1,_b,self.getResolved("barColor"))
self:textBg(ca,1," ",self.getResolved("sliderColor"))else local ab=self.getResolved("background")for y=1,aa do
self:textBg(1,y," ",ab)end
self:textBg(1,ca," ",self.getResolved("sliderColor"))end end;return d end
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
if db then local _c=self.getResolved("minValue")
local ac=self.getResolved("maxValue")if _c==ac then return end
self.set("value",math.floor((db-_c)/ (ac-_c)*100 +0.5))end end)return self end
function ca:updateAttachedElement()local ab=self.getResolved("attachedElement")if not ab then
return end;local bb=self.getResolved("value")
local cb=self.getResolved("minValue")local db=self.getResolved("maxValue")if type(cb)=="function"then
cb=cb()end;if type(db)=="function"then db=db()end;local _c=cb+ (bb/100)* (
db-cb)
ab.set(self.getResolved("attachedProperty"),math.floor(
_c+0.5))return self end
local function da(ab)return
ab.getResolved("orientation")=="vertical"and
ab.getResolved("height")or ab.getResolved("width")end
local function _b(ab,bb,cb)local db,_c=ab:getRelativePosition(bb,cb)return

ab.getResolved("orientation")=="vertical"and _c or db end
function ca:mouse_click(ab,bb,cb)
if aa.mouse_click(self,ab,bb,cb)then local db=da(self)
local _c=self.getResolved("value")local ac=self.getResolved("handleSize")local bc=
math.floor((_c/100)* (db-ac))+1;local cc=_b(self,bb,cb)
if
cc>=bc and cc<bc+ac then self.dragOffset=cc-bc else local dc=( (cc-1)/ (db-ac))*100
self.set("value",math.min(100,math.max(0,dc)))self:updateAttachedElement()end;return true end end
function ca:mouse_drag(ab,bb,cb)
if(aa.mouse_drag(self,ab,bb,cb))then local db=da(self)
local _c=self.getResolved("handleSize")local ac=self.getResolved("dragMultiplier")
local bc=_b(self,bb,cb)bc=math.max(1,math.min(db,bc))
local cc=bc- (self.dragOffset or 0)local dc=(cc-1)/ (db-_c)*100 *ac
self.set("value",math.min(100,math.max(0,dc)))self:updateAttachedElement()return true end end
function ca:mouse_scroll(ab,bb,cb)
if not self:isInBounds(bb,cb)then return false end;ab=ab>0 and-1 or 1;local db=self.getResolved("step")
local _c=self.getResolved("value")local ac=_c-ab*db
self.set("value",math.min(100,math.max(0,ac)))self:updateAttachedElement()return true end
function ca:render()aa.render(self)local ab=da(self)
local bb=self.getResolved("value")local cb=self.getResolved("handleSize")
local db=self.getResolved("symbol")local _c=self.getResolved("symbolColor")
local ac=self.getResolved("symbolBackgroundColor")local bc=self.getResolved("backgroundSymbol")local cc=
self.getResolved("orientation")=="vertical"
local dc=self.getResolved("foreground")local _d=self.getResolved("background")local ad=
math.floor((bb/100)* (ab-cb))+1;for i=1,ab do
if cc then
self:blit(1,i,bc,ba[dc],ba[_d])else self:blit(i,1,bc,ba[dc],ba[_d])end end;for i=ad,ad+cb-1 do
if cc then
self:blit(1,i,db,ba[_c],ba[ac])else self:blit(i,1,db,ba[_c],ba[ac])end end end;return ca end
project["elements/VisualElement.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("BaseElement")local da=require("libraries/colorHex")
local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"x",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"y",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"z",{default=1,type="number",canTriggerRender=true,setter=function(cb,db)
if cb.parent then cb.parent:sortChildren()end;return db end})
_b.defineProperty(_b,"constraints",{default={},type="table"})
_b.defineProperty(_b,"width",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"height",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"background",{default=colors.black,type="color",canTriggerRender=true})
_b.defineProperty(_b,"foreground",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"backgroundEnabled",{default=true,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderTop",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderBottom",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderLeft",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderRight",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"borderColor",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"visible",{default=true,type="boolean",canTriggerRender=true,setter=function(cb,db)
if(cb.parent~=nil)then
cb.parent.set("childrenSorted",false)cb.parent.set("childrenEventsSorted",false)end;if(db==false)then cb:unsetState("clicked")end;return db end})
_b.defineProperty(_b,"ignoreOffset",{default=false,type="boolean"})
_b.defineProperty(_b,"layoutConfig",{default={},type="table"})_b.combineProperties(_b,"position","x","y")
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
self:registerState("disabled",nil,1000)self:registerState("clicked",nil,500)
self:registerState("hover",nil,400)self:registerState("focused",nil,300)
self:registerState("dragging",nil,600)
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
function _b:setConstraint(cb,db,_c,ac)local bc=self.get("constraints")if bc[cb]then
self:_removeConstraintObservers(cb,bc[cb])end
bc[cb]={element=db,property=_c,offset=ac or 0}self.set("constraints",bc)
self:_addConstraintObservers(cb,bc[cb])self._constraintsDirty=true;self:updateRender()return self end
function _b:setLayoutConfigProperty(cb,db)local _c=self.getResolved("layoutConfig")
_c[cb]=db;self.set("layoutConfig",_c)return self end;function _b:getLayoutConfigProperty(cb)local db=self.getResolved("layoutConfig")
return db[cb]end
function _b:resolveAllConstraints()if
not self._constraintsDirty then return self end
local cb=self.getResolved("constraints")if not cb or not next(cb)then return self end
local db={"width","height","left","right","top","bottom","x","y","centerX","centerY"}
for _c,ac in ipairs(db)do if cb[ac]then local bc=self:_resolveConstraint(ac,cb[ac])
self:_applyConstraintValue(ac,bc,cb)end end;self._constraintsDirty=false;return self end
function _b:_applyConstraintValue(cb,db,_c)
if cb=="x"or cb=="left"then self.set("x",db)elseif cb=="y"or
cb=="top"then self.set("y",db)elseif cb=="right"then
if _c.left then
local ac=self:_resolveConstraint("left",_c.left)local bc=db-ac+1;self.set("width",bc)self.set("x",ac)else
local ac=self.getResolved("width")self.set("x",db-ac+1)end elseif cb=="bottom"then
if _c.top then
local ac=self:_resolveConstraint("top",_c.top)local bc=db-ac+1;self.set("height",bc)self.set("y",ac)else
local ac=self.getResolved("height")self.set("y",db-ac+1)end elseif cb=="centerX"then local ac=self.getResolved("width")self.set("x",db-
math.floor(ac/2))elseif cb=="centerY"then
local ac=self.getResolved("height")self.set("y",db-math.floor(ac/2))elseif
cb=="width"then self.set("width",db)elseif cb=="height"then self.set("height",db)end end
function _b:_addConstraintObservers(cb,db)local _c=db.element;local ac=db.property
if _c=="parent"then _c=self.parent end;if not _c then return end
local bc=function()self._constraintsDirty=true
self:resolveAllConstraints()self:updateRender()end
if not self._constraintObserverCallbacks then self._constraintObserverCallbacks={}end;if not self._constraintObserverCallbacks[cb]then
self._constraintObserverCallbacks[cb]={}end;local cc={}
if
ac=="left"or ac=="x"then cc={"x"}elseif ac=="right"then cc={"x","width"}elseif ac=="top"or ac=="y"then cc={"y"}elseif ac==
"bottom"then cc={"y","height"}elseif ac=="centerX"then cc={"x","width"}elseif ac=="centerY"then
cc={"y","height"}elseif ac=="width"then cc={"width"}elseif ac=="height"then cc={"height"}end;for dc,_d in ipairs(cc)do _c:observe(_d,bc)
table.insert(self._constraintObserverCallbacks[cb],{element=_c,property=_d,callback=bc})end end
function _b:_removeConstraintObservers(cb,db)
if not self._constraintObserverCallbacks or not
self._constraintObserverCallbacks[cb]then return end;for _c,ac in ipairs(self._constraintObserverCallbacks[cb])do
ac.element:removeObserver(ac.property,ac.callback)end;self._constraintObserverCallbacks[cb]=
nil end
function _b:_removeAllConstraintObservers()
if not self._constraintObserverCallbacks then return end
for cb,db in pairs(self._constraintObserverCallbacks)do for _c,ac in ipairs(db)do
ac.element:removeObserver(ac.property,ac.callback)end end;self._constraintObserverCallbacks=nil end
function _b:removeConstraint(cb)local db=self.getResolved("constraints")db[cb]=nil
self.set("constraints",db)self:updateConstraints()return self end
function _b:updateConstraints()local cb=self.getResolved("constraints")
for db,_c in pairs(cb)do
local ac=self:_resolveConstraint(db,_c)
if db=="x"or db=="left"then self.set("x",ac)elseif db=="y"or db=="top"then
self.set("y",ac)elseif db=="right"then local bc=self.getResolved("width")
self.set("x",ac-bc+1)elseif db=="bottom"then local bc=self.getResolved("height")
self.set("y",ac-bc+1)elseif db=="centerX"then local bc=self.getResolved("width")self.set("x",ac-
math.floor(bc/2))elseif db=="centerY"then
local bc=self.getResolved("height")self.set("y",ac-math.floor(bc/2))elseif
db=="width"then self.set("width",ac)elseif db=="height"then self.set("height",ac)end end end
function _b:_resolveConstraint(cb,db)local _c=db.element;local ac=db.property;local bc=db.offset;if _c=="parent"then
_c=self.parent end
if not _c then return self.getResolved(cb)or 1 end;local cc
if ac=="left"or ac=="x"then cc=_c.get("x")elseif ac=="right"then cc=_c.get("x")+
_c.get("width")-1 elseif ac=="top"or ac=="y"then
cc=_c.get("y")elseif ac=="bottom"then
cc=_c.get("y")+_c.get("height")-1 elseif ac=="centerX"then
cc=_c.get("x")+math.floor(_c.get("width")/2)elseif ac=="centerY"then
cc=_c.get("y")+math.floor(_c.get("height")/2)elseif ac=="width"then cc=_c.get("width")elseif ac=="height"then cc=_c.get("height")end
if type(bc)=="number"then if bc>-1 and bc<1 and bc~=0 then
return math.floor(cc*bc)else return cc+bc end end;return cc end;function _b:alignRight(cb,db)db=db or 0
return self:setConstraint("right",cb,"right",db)end;function _b:alignLeft(cb,db)db=db or 0;return
self:setConstraint("left",cb,"left",db)end
function _b:alignTop(cb,db)db=
db or 0;return self:setConstraint("top",cb,"top",db)end;function _b:alignBottom(cb,db)db=db or 0
return self:setConstraint("bottom",cb,"bottom",db)end
function _b:centerHorizontal(cb,db)db=db or 0;return
self:setConstraint("centerX",cb,"centerX",db)end;function _b:centerVertical(cb,db)db=db or 0
return self:setConstraint("centerY",cb,"centerY",db)end;function _b:centerIn(cb)return
self:centerHorizontal(cb):centerVertical(cb)end
function _b:rightOf(cb,db)
db=db or 0;return self:setConstraint("left",cb,"right",db)end;function _b:leftOf(cb,db)db=db or 0
return self:setConstraint("right",cb,"left",-db)end;function _b:below(cb,db)db=db or 0;return
self:setConstraint("top",cb,"bottom",db)end
function _b:above(cb,db)
db=db or 0;return self:setConstraint("bottom",cb,"top",-db)end;function _b:stretchWidth(cb,db)db=db or 0
return self:setConstraint("left",cb,"left",db):setConstraint("right",cb,"right",
-db)end;function _b:stretchHeight(cb,db)db=
db or 0
return self:setConstraint("top",cb,"top",db):setConstraint("bottom",cb,"bottom",
-db)end;function _b:stretch(cb,db)return
self:stretchWidth(cb,db):stretchHeight(cb,db)end
function _b:widthPercent(cb,db)return self:setConstraint("width",cb,"width",
db/100)end;function _b:heightPercent(cb,db)
return self:setConstraint("height",cb,"height",db/100)end;function _b:matchWidth(cb,db)db=db or 0;return
self:setConstraint("width",cb,"width",db)end;function _b:matchHeight(cb,db)db=
db or 0
return self:setConstraint("height",cb,"height",db)end;function _b:fillParent(cb)return
self:stretch("parent",cb)end;function _b:fillWidth(cb)return
self:stretchWidth("parent",cb)end;function _b:fillHeight(cb)return
self:stretchHeight("parent",cb)end;function _b:center()return
self:centerIn("parent")end;function _b:toRight(cb)return
self:alignRight("parent",- (cb or 0))end;function _b:toLeft(cb)return self:alignLeft("parent",
cb or 0)end;function _b:toTop(cb)return self:alignTop("parent",
cb or 0)end
function _b:toBottom(cb)return self:alignBottom("parent",
- (cb or 0))end
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
function _b:isInBounds(cb,db)
local _c,ac=self.getResolved("x"),self.getResolved("y")
local bc,cc=self.getResolved("width"),self.getResolved("height")
if(self.getResolved("ignoreOffset"))then if(self.parent)then cb=cb-
self.parent.get("offsetX")
db=db-self.parent.get("offsetY")end end;return
cb>=_c and cb<=_c+bc-1 and db>=ac and db<=ac+cc-1 end
function _b:mouse_click(cb,db,_c)if self:isInBounds(db,_c)then self:setState("clicked")
self:fireEvent("mouse_click",cb,self:getRelativePosition(db,_c))return true end;return
false end
function _b:mouse_up(cb,db,_c)
if self:isInBounds(db,_c)then self:unsetState("clicked")
self:unsetState("dragging")
self:fireEvent("mouse_up",cb,self:getRelativePosition(db,_c))return true end;return false end
function _b:mouse_release(cb,db,_c)
self:fireEvent("mouse_release",cb,self:getRelativePosition(db,_c))self:unsetState("clicked")
self:unsetState("dragging")end
function _b:mouse_move(cb,db,_c)if(db==nil)or(_c==nil)then return false end
local ac=self.getResolved("hover")
if(self:isInBounds(db,_c))then if(not ac)then self.set("hover",true)
self:fireEvent("mouse_enter",self:getRelativePosition(db,_c))end;return true else if(ac)then
self.set("hover",false)
self:fireEvent("mouse_leave",self:getRelativePosition(db,_c))end end;return false end
function _b:mouse_scroll(cb,db,_c)if(self:isInBounds(db,_c))then
self:fireEvent("mouse_scroll",cb,self:getRelativePosition(db,_c))return true end;return false end
function _b:mouse_drag(cb,db,_c)if(self:hasState("clicked"))then
self:fireEvent("mouse_drag",cb,self:getRelativePosition(db,_c))return true end;return false end
function _b:setFocused(cb,db)local _c=self:hasState("focused")
if cb==_c then return self end
if cb then self:setState("focused")self:focus()
if
not db and self.parent then self.parent:setFocusedChild(self)end else self:unsetState("focused")self:blur()
if
not db and self.parent then self.parent:setFocusedChild(nil)end end;return self end
function _b:isFocused()return self:hasState("focused")end;function _b:focus()self:fireEvent("focus")end;function _b:blur()
self:fireEvent("blur")
pcall(function()
self:setCursor(1,1,false,self.get and self.getResolved("foreground"))end)end;function _b:isFocused()return
self:hasState("focused")end
function _b:addBorder(cb,db)local _c=nil;local ac=nil
if
type(cb)==
"table"and(cb.color or cb.top~=nil or cb.left~=nil)then _c=cb.color;ac=cb else _c=cb;ac=db end
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
if(self:hasState("focused"))then self:fireEvent("key",cb,db)end end
function _b:key_up(cb)if
(self:hasState("focused"))then self:fireEvent("key_up",cb)end end;function _b:char(cb)
if(self:hasState("focused"))then self:fireEvent("char",cb)end end
function _b:calculatePosition()
self:resolveAllConstraints()local cb,db=self.getResolved("x"),self.getResolved("y")
if not
self.getResolved("ignoreOffset")then if self.parent~=nil then
local _c,ac=self.parent.get("offsetX"),self.parent.get("offsetY")cb=cb-_c;db=db-ac end end;return cb,db end
function _b:getAbsolutePosition(cb,db)
local _c,ac=self.getResolved("x"),self.getResolved("y")if(cb~=nil)then _c=_c+cb-1 end;if(db~=nil)then ac=ac+db-1 end
local bc=self.parent;while bc do local cc,dc=bc.get("x"),bc.get("y")_c=_c+cc-1;ac=ac+dc-1
bc=bc.parent end;return _c,ac end
function _b:getRelativePosition(cb,db)if(cb==nil)or(db==nil)then
cb,db=self.getResolved("x"),self.getResolved("y")end;local _c,ac=1,1;if self.parent then
_c,ac=self.parent:getRelativePosition()end
local bc,cc=self.getResolved("x"),self.getResolved("y")return cb- (bc-1)- (_c-1),db- (cc-1)- (ac-1)end
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
if(not self.getResolved("backgroundEnabled"))then return end
local cb,db=self.getResolved("width"),self.getResolved("height")local _c=da[self.getResolved("foreground")]
local ac=da[self.getResolved("background")]
local bc,cc,dc,_d=self.getResolved("borderTop"),self.getResolved("borderBottom"),self.getResolved("borderLeft"),self.getResolved("borderRight")self:multiBlit(1,1,cb,db," ",_c,ac)
if
(bc or cc or dc or _d)then
local ad=self.getResolved("borderColor")or self.getResolved("foreground")local bd=da[ad]or _c;if bc then
self:textFg(1,1,("\131"):rep(cb),ad)end;if cc then
self:multiBlit(1,db,cb,1,"\143",ac,bd)end;if dc then
self:multiBlit(1,1,1,db,"\149",bd,ac)end;if _d then
self:multiBlit(cb,1,1,db,"\149",ac,bd)end
if bc and dc then self:blit(1,1,"\151",bd,ac)end;if bc and _d then self:blit(cb,1,"\148",ac,bd)end;if
cc and dc then self:blit(1,db,"\138",ac,bd)end;if cc and _d then
self:blit(cb,db,"\133",ac,bd)end end end;function _b:postRender()end
function _b:destroy()
self:_removeAllConstraintObservers()self.set("visible",false)ca.destroy(self)end;return _b end
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
local ba=self.getResolved("width")local ca=self.getResolved("height")
local da=math.min(100,math.max(0,self.getResolved("progress")))local _b=math.floor((ba*da)/100)
local ab=math.floor((ca*da)/100)local bb=self.getResolved("direction")
local cb=self.getResolved("progressColor")local db=self.getResolved("foreground")
if bb=="right"then
self:multiBlit(1,1,_b,ca," ",_a[db],_a[cb])elseif bb=="left"then
self:multiBlit(ba-_b+1,1,_b,ca," ",_a[db],_a[cb])elseif bb=="up"then
self:multiBlit(1,ca-ab+1,ba,ab," ",_a[db],_a[cb])elseif bb=="down"then
self:multiBlit(1,1,ba,ab," ",_a[db],_a[cb])end
if self.getResolved("showPercentage")then local _c=tostring(da).."%"local ac=math.floor((
ba-#_c)/2)+1;local bc=
math.floor((ca-1)/2)+1;self:textFg(ac,bc,_c,db)end end;return aa end
project["elements/CheckBox.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"checked",{default=false,type="boolean",canTriggerRender=true})
d.defineProperty(d,"text",{default=" ",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.getResolved("checkedText")local ca=math.max(#aa,
#ba)if(_a.getResolved("autoSize"))then
_a.set("width",ca)end;return aa end})
d.defineProperty(d,"checkedText",{default="x",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.getResolved("text")
local ca=math.max(#aa,#ba)
if(_a.getResolved("autoSize"))then _a.set("width",ca)end;return aa end})
d.defineProperty(d,"autoSize",{default=true,type="boolean"})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_up")function d.new()local _a=setmetatable({},d):__init()_a.class=d
_a.set("backgroundEnabled",false)return _a end
function d:init(_a,aa)
c.init(self,_a,aa)self.set("type","CheckBox")end
function d:mouse_click(_a,aa,ba)if c.mouse_click(self,_a,aa,ba)then
self.set("checked",not self.getResolved("checked"))return true end;return false end
function d:render()c.render(self)local _a=self.getResolved("checked")
local aa=self.getResolved("text")local ba=self.getResolved("checkedText")
local ca=string.sub(_a and ba or aa,1,self.getResolved("width"))
self:textFg(1,1,ca,self.getResolved("foreground"))end;return d end
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
ca.defineProperty(ca,"states",{default={},type="table",canTriggerRender=true})
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
self.basalt=_b;self._registeredEvents={}self._registeredStates={}
self._cachedActiveStates=nil;local ab=getmetatable(self).__index;local bb={}ab=self.class
while ab do
if
type(ab)=="table"and ab._eventConfigs then for cb,db in pairs(ab._eventConfigs)do if not bb[cb]then
bb[cb]=db end end end
ab=getmetatable(ab)and getmetatable(ab).__index end
for cb,db in pairs(bb)do self._registeredEvents[db.requires]=true end;if self._callbacks then
for cb,db in pairs(self._callbacks)do self[db]=function(_c,...)
_c:registerCallback(cb,...)return _c end end end
return self end
function ca:postInit()if self._postInitialized then return self end
self._postInitialized=true;self._modifiedProperties={}if(self._props)then for da,_b in pairs(self._props)do
self.set(da,_b)end end
self._props=nil;return self end;function ca:isType(da)
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
table.insert(self._values.eventCallbacks[da],_b)return self end;function ca:registerState(da,_b,ab)
self._registeredStates[da]={condition=_b,priority=ab or 0}return self end
function ca:setState(da,_b)
local ab=self.getResolved("states")if not _b and self._registeredStates[da]then
_b=self._registeredStates[da].priority end;ab[da]=_b or 0
self.set("states",ab)self._cachedActiveStates=nil;return self end
function ca:unsetState(da)local _b=self.get("states")if _b[da]~=nil then _b[da]=nil
self.set("states",_b)self._cachedActiveStates=nil end
return self end
function ca:hasState(da)local _b=self.get("states")return _b[da]~=nil end
function ca:getCurrentState()local da=self.get("states")local _b=-math.huge;local ab=nil;for bb,cb in
pairs(da)do if cb>_b then _b=cb;ab=bb end end;return ab end
function ca:getActiveStates()
if self._cachedActiveStates then return self._cachedActiveStates end;local da=self.get("states")local _b={}for ab,bb in pairs(da)do
table.insert(_b,{name=ab,priority=bb})end
table.sort(_b,function(ab,bb)
return ab.priority>bb.priority end)self._cachedActiveStates=_b;return _b end
function ca:updateConditionalStates()
for da,_b in pairs(self._registeredStates)do
if _b.condition then
local ab=_b.condition(self)if ab then self:setState(da,_b.priority)else
self:unsetState(da)end end end;return self end
function ca:registerResponsiveState(da,_b,ab)local bb=100;local cb={}
if type(ab)=="number"then bb=ab elseif type(ab)=="table"then bb=
ab.priority or 100;cb=ab.observe or{}end;local db;local _c=type(_b)=="string"
if _c then
db=self:_parseResponsiveExpression(_b)local ac=self:_detectDependencies(_b)for bc,cc in ipairs(ac)do
table.insert(cb,cc)end else db=_b end;self:registerState(da,db,bb)
for ac,bc in ipairs(cb)do
local cc=bc.element or bc[1]local dc=bc.property or bc[2]if cc and dc then
cc:observe(dc,function()
self:updateConditionalStates()end)end end;self:updateConditionalStates()return self end
function ca:_parseResponsiveExpression(da)local _b={colors=true,math=true,clamp=true,round=true}
local ab={clamp=function(ac,bc,cc)return
math.min(math.max(ac,bc),cc)end,round=function(ac)
return math.floor(ac+0.5)end,floor=math.floor,ceil=math.ceil,abs=math.abs}
da=da:gsub("([%w_]+)%.([%w_]+)",function(ac,bc)
if _b[ac]or tonumber(ac)then return ac.."."..bc end
return string.format('__getProperty("%s", "%s")',ac,bc)end)local bb=self
local cb=setmetatable({colors=colors,math=math,tostring=tostring,tonumber=tonumber,__getProperty=function(ac,bc)
if ac=="self"then
if bb._properties[bc]then return bb.get(bc)end elseif ac=="parent"then if bb.parent and bb.parent._properties[bc]then return
bb.parent.get(bc)end else
local cc=bb:getBaseFrame():getChild(ac)
if cc and cc._properties[bc]then return cc.get(bc)end end;return nil end},{__index=ab})local db,_c=load("return "..da,"responsive","t",cb)
if not db then error(
"Invalid responsive expression: ".._c)end;return
function(ac)local bc,cc=pcall(db)return bc and cc or false end end
function ca:_detectDependencies(da)local _b={}
local ab={colors=true,math=true,clamp=true,round=true}
for bb,cb in da:gmatch("([%w_]+)%.([%w_]+)")do
if not ab[bb]and not tonumber(bb)then
local db;if bb=="self"then db=self elseif bb=="parent"then db=self.parent else
db=self:getBaseFrame():getChild(bb)end;if db then
table.insert(_b,{element=db,property=cb})end end end;return _b end;function ca:unregisterState(da)self._stateRegistry[da]=nil
self:unsetState(da)return self end
function ca:fireEvent(da,...)
if
self.getResolved("eventCallbacks")[da]then local _b;for ab,bb in
ipairs(self.getResolved("eventCallbacks")[da])do _b=bb(self,...)end;return _b end;return self end
function ca:dispatchEvent(da,...)
if self.getResolved("enabled")==false then return false end;if self[da]then return self[da](self,...)end;return
self:handleEvent(da,...)end;function ca:handleEvent(da,...)return false end;function ca:onChange(da,_b)
self:observe(da,_b)return self end
function ca:getBaseFrame()if self.parent then return
self.parent:getBaseFrame()end;return self end;function ca:destroy()
if(self.parent)then self.parent:removeChild(self)end;self._destroyed=true;self:removeAllObservers()
self:setFocused(false)end;function ca:updateRender()
if
(self.parent)then self.parent:updateRender()else self._renderUpdate=true end;return self end;return ca end
project["elements/ContextMenu.lua"] = function(...) local aa=require("elementManager")
local ba=require("elements/VisualElement")local ca=aa.getElement("Container")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"items",{default={},type="table",canTriggerRender=true})
_b.defineProperty(_b,"isOpen",{default=false,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"openSubmenu",{default=nil,type="table",allowNil=true})
_b.defineProperty(_b,"itemHeight",{default=1,type="number",canTriggerRender=true})_b.defineEvent(_b,"mouse_click")
function _b.new()
local ab=setmetatable({},_b):__init()ab.class=_b;ab.set("width",10)ab.set("height",10)
ab.set("visible",false)return ab end;function _b:init(ab,bb)ca.init(self,ab,bb)
self.set("type","ContextMenu")end
function _b:setItems(ab)
self.set("items",ab or{})self:calculateSize()return self end
function _b:calculateSize()local ab=self.getResolved("items")
local bb=self.getResolved("itemHeight")
if#ab==0 then self.set("width",10)self.set("height",2)return end;local cb=8
for _c,ac in ipairs(ab)do if ac.label then local bc=#ac.label;local cc=bc+3
if ac.submenu then cc=cc+1 end;if cc>cb then cb=cc end end end;local db=#ab*bb;self.set("width",cb)
self.set("height",db)end;function _b:open()self.set("isOpen",true)
self.set("visible",true)self:updateRender()self:dispatchEvent("opened")
return self end
function _b:close()
self.set("isOpen",false)self.set("visible",false)
local ab=self.getResolved("openSubmenu")if ab and ab.menu then ab.menu:close()end
self.set("openSubmenu",nil)self:updateRender()self:dispatchEvent("closed")
return self end;function _b:closeAll()local ab=self;while ab.parentMenu do ab=ab.parentMenu end
ab:close()return self end
function _b:getItemAt(ab)
local bb=self.getResolved("items")local cb=self.getResolved("itemHeight")local db=
math.floor((ab-1)/cb)+1
if db>=1 and db<=#bb then return db,bb[db]end;return nil,nil end
function _b:createSubmenu(ab,bb)local cb=self.parent:addContextMenu()
cb:setItems(ab)
cb.set("background",self.getResolved("background"))
cb.set("foreground",self.getResolved("foreground"))cb.parentMenu=self;local db=self.getResolved("x")
local _c=self.getResolved("y")local ac=self.getResolved("width")
local bc=self.getResolved("itemHeight")local cc=bb._index or 1;cb.set("x",db+ac)
cb.set("y",_c+ (cc-1)*bc)cb.set("z",self.getResolved("z")+1)return
cb end
function _b:mouse_click(ab,bb,cb)if not ba.mouse_click(self,ab,bb,cb)then self:close()
return false end
local db,_c=ba.getRelativePosition(self,bb,cb)local ac,bc=self:getItemAt(_c)
if bc then if bc.disabled then return true end
if bc.submenu then
local cc=self.getResolved("openSubmenu")
if cc and cc.index==ac then cc.menu:close()
self.set("openSubmenu",nil)else if cc and cc.menu then cc.menu:close()end;bc._index=ac
local dc=self:createSubmenu(bc.submenu,bc)dc:open()
self.set("openSubmenu",{index=ac,menu=dc})end;return true end;if bc.onClick then bc.onClick(bc)end;self:closeAll()
return true end;return true end
function _b:render()local ab=self.getResolved("items")
local bb=self.getResolved("width")local cb=self.getResolved("height")
local db=self.getResolved("itemHeight")local _c=self.getResolved("background")
local ac=self.getResolved("foreground")
for bc,cc in ipairs(ab)do local dc=(bc-1)*db+1;local _d=cc.background or _c;local ad=cc.foreground or
ac;local bd=da[_d]local cd=da[ad]
local dd=string.rep(" ",bb)local __a=string.rep(bd,bb)local a_a=string.rep(cd,bb)
self:blit(1,dc,dd,a_a,__a)local b_a=cc.label or""
if#b_a>bb-3 then b_a=b_a:sub(1,bb-3)end;self:textFg(2,dc,b_a,ad)if cc.submenu then
self:textFg(bb-1,dc,">",ad)end end;if not self.getResolved("childrenSorted")then
self:sortChildren()end
if
not self.getResolved("childrenEventsSorted")then for bc in pairs(self._values.childrenEvents or{})do
self:sortChildrenEvents(bc)end end
for bc,cc in
ipairs(self.getResolved("visibleChildren")or{})do
if cc==self then error("CIRCULAR REFERENCE DETECTED!")return end;cc:render()cc:postRender()end end;return _b end
project["elements/List.lua"] = function(...) local _a=require("elements/Collection")
local aa=require("libraries/colorHex")local ba=setmetatable({},_a)ba.__index=ba
ba.defineProperty(ba,"offset",{default=0,type="number",canTriggerRender=true,setter=function(da,_b)
local ab=math.max(0,#
da.getResolved("items")-da.getResolved("height"))return math.min(ab,math.max(0,_b))end})
ba.defineProperty(ba,"emptyText",{default="No items",type="string",canTriggerRender=true})
ba.defineProperty(ba,"showScrollBar",{default=true,type="boolean",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarSymbol",{default=" ",type="string",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarBackground",{default="\127",type="string",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarColor",{default=colors.lightGray,type="color",canTriggerRender=true})
ba.defineProperty(ba,"scrollBarBackgroundColor",{default=colors.gray,type="color",canTriggerRender=true})ba.defineEvent(ba,"mouse_click")
ba.defineEvent(ba,"mouse_up")ba.defineEvent(ba,"mouse_drag")
ba.defineEvent(ba,"mouse_scroll")ba.defineEvent(ba,"key")
local ca={text={type="string",default="Entry"},bg={type="number",default=nil},fg={type="number",default=
nil},selectedBg={type="number",default=nil},selectedFg={type="number",default=nil},callback={type="function",default=nil}}function ba.new()local da=setmetatable({},ba):__init()
da.class=ba;da.set("width",16)da.set("height",8)da.set("z",5)
return da end
function ba:init(da,_b)
_a.init(self,da,_b)self._entrySchema=ca;self.set("type","List")
self:observe("items",function()
local ab=math.max(0,#
self.getResolved("items")-self.getResolved("height"))
if self.getResolved("offset")>ab then self.set("offset",ab)end end)
self:observe("height",function()
local ab=math.max(0,#self.getResolved("items")-
self.getResolved("height"))
if self.getResolved("offset")>ab then self.set("offset",ab)end end)return self end
function ba:mouse_click(da,_b,ab)
if _a.mouse_click(self,da,_b,ab)then
local bb,cb=self:getRelativePosition(_b,ab)local db=self.getResolved("width")
local _c=self.getResolved("items")local ac=self.getResolved("height")
local bc=self.getResolved("showScrollBar")
if bc and#_c>ac and bb==db then local cc=#_c-ac
local dc=math.max(1,math.floor((ac/#_c)*ac))local _d=
cc>0 and(self.getResolved("offset")/cc*100)or 0;local ad=
math.floor((_d/100)* (ac-dc))+1
if cb>=ad and cb<ad+dc then
self._scrollBarDragging=true;self._scrollBarDragOffset=cb-ad else
local bd=( (cb-1)/ (ac-dc))*100;local cd=math.floor((bd/100)*cc+0.5)
self.set("offset",math.max(0,math.min(cc,cd)))end;return true end
if self.getResolved("selectable")then
local cc=cb+self.getResolved("offset")
if cc<=#_c then local dc=_c[cc]if not self.getResolved("multiSelection")then
for _d,ad in
ipairs(_c)do if type(ad)=="table"then ad.selected=false end end end;dc.selected=not
dc.selected;if dc.callback then dc.callback(self)end
self:fireEvent("select",cc,dc)self:updateRender()end end;return true end;return false end
function ba:mouse_drag(da,_b,ab)
if self._scrollBarDragging then local bb,cb=self:getRelativePosition(_b,ab)
local db=self.getResolved("items")local _c=self.getResolved("height")
local ac=math.max(1,math.floor((_c/#db)*_c))local bc=#db-_c;cb=math.max(1,math.min(_c,cb))local cc=cb- (
self._scrollBarDragOffset or 0)local dc=
( (cc-1)/ (_c-ac))*100
local _d=math.floor((dc/100)*bc+0.5)
self.set("offset",math.max(0,math.min(bc,_d)))return true end;return
_a.mouse_drag and _a.mouse_drag(self,da,_b,ab)or false end
function ba:mouse_up(da,_b,ab)if self._scrollBarDragging then self._scrollBarDragging=false
self._scrollBarDragOffset=nil;return true end
return _a.mouse_up and
_a.mouse_up(self,da,_b,ab)or false end
function ba:mouse_scroll(da,_b,ab)
if _a.mouse_scroll(self,da,_b,ab)then
local bb=self.getResolved("offset")
local cb=math.max(0,#self.getResolved("items")-self.getResolved("height"))bb=math.min(cb,math.max(0,bb+da))
self.set("offset",bb)return true end;return false end
function ba:onSelect(da)self:registerCallback("select",da)return self end
function ba:scrollToBottom()
local da=math.max(0,#self.getResolved("items")-
self.getResolved("height"))self.set("offset",da)return self end
function ba:scrollToTop()self.set("offset",0)return self end
function ba:scrollToItem(da)local _b=self.getResolved("height")
local ab=self.getResolved("offset")
if da<ab+1 then self.set("offset",math.max(0,da-1))elseif da>
ab+_b then self.set("offset",da-_b)end;return self end
function ba:key(da)
if _a.key(self,da)and self.getResolved("selectable")then
local _b=self.getResolved("items")local ab=self:getSelectedIndex()
if da==keys.up then
self:selectPrevious()if ab and ab>1 then self:scrollToItem(ab-1)end
return true elseif da==keys.down then self:selectNext()if ab and ab<#_b then
self:scrollToItem(ab+1)end;return true elseif da==keys.home then
self:clearItemSelection()self:selectItem(1)self:scrollToTop()return true elseif
da==keys["end"]then self:clearItemSelection()self:selectItem(#_b)
self:scrollToBottom()return true elseif da==keys.pageUp then local bb=self.getResolved("height")local cb=math.max(1,(
ab or 1)-bb)
self:clearItemSelection()self:selectItem(cb)self:scrollToItem(cb)return true elseif da==
keys.pageDown then local bb=self.getResolved("height")
local cb=math.min(#_b,(ab or 1)+bb)self:clearItemSelection()self:selectItem(cb)
self:scrollToItem(cb)return true end end;return false end
function ba:render(da)da=da or 0;_a.render(self)
local _b=self.getResolved("items")local ab=self.getResolved("height")
local bb=self.getResolved("offset")local cb=self.getResolved("width")
local db=self.getResolved("background")local _c=self.getResolved("foreground")
local ac=self.getResolved("showScrollBar")local bc=ac and#_b>ab;local cc=bc and cb-1 or cb
if#_b==0 then
local dc=self.getResolved("emptyText")local _d=math.floor(ab/2)+da;local ad=math.max(1,
math.floor((cb-#dc)/2)+1)for i=1,ab do
self:textBg(1,i,string.rep(" ",cb),db)end;if _d>=1 and _d<=ab then
self:textFg(ad,_d+da,dc,colors.gray)end;return end
for i=1,ab do local dc=i+bb;local _d=_b[dc]
if _d then
if _d.separator then
local ad=(
(_d.text or"-")~=""and _d.text or"-"):sub(1,1)local bd=string.rep(ad,cc)local cd=_d.fg or _c;local dd=_d.bg or db;self:textBg(1,
i+da,string.rep(" ",cc),dd)self:textFg(1,i+
da,bd,cd)else local ad=_d.text or""local bd=_d.selected
local cd=
bd and(
_d.selectedBg or self.getResolved("selectedBackground"))or(_d.bg or db)
local dd=bd and
(_d.selectedFg or self.getResolved("selectedForeground"))or(_d.fg or _c)local __a=ad
if#__a>cc then __a=__a:sub(1,cc-3).."..."else __a=__a..string.rep(" ",cc-
#__a)end;self:textBg(1,i+da,string.rep(" ",cc),cd)self:textFg(1,
i+da,__a,dd)end else self:textBg(1,i+da,string.rep(" ",cc),db)end end
if bc then
local dc=math.max(1,math.floor((ab/#_b)*ab))local _d=#_b-ab;local ad=_d>0 and(bb/_d*100)or 0;local bd=math.floor((ad/
100)* (ab-dc))+1
local cd=self.getResolved("scrollBarSymbol")local dd=self.getResolved("scrollBarBackground")
local __a=self.getResolved("scrollBarColor")local a_a=self.getResolved("scrollBarBackgroundColor")
for i=1,ab do self:blit(cb,
i+da,dd,aa[_c],aa[a_a])end;for i=bd,math.min(ab,bd+dc-1)do
self:blit(cb,i+da,cd,aa[__a],aa[a_a])end end end;return ba end
project["elements/Collection.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/collectionentry")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"items",{default={},type="table",canTriggerRender=true})
aa.defineProperty(aa,"selectable",{default=true,type="boolean"})
aa.defineProperty(aa,"multiSelection",{default=false,type="boolean"})
aa.defineProperty(aa,"selectedBackground",{default=colors.blue,type="color",canTriggerRender=true})
aa.defineProperty(aa,"selectedForeground",{default=colors.white,type="color",canTriggerRender=true})
aa.combineProperties(aa,"selectionColor","selectedForeground","selectedBackground")function aa.new()local ba=setmetatable({},aa):__init()
ba.class=aa;return ba end
function aa:init(ba,ca)
d.init(self,ba,ca)self._entrySchema={}self.set("type","Collection")return self end
function aa:addItem(ba)if type(ba)=="string"then ba={text=ba}end;if ba.selected==nil then
ba.selected=false end
local ca=_a.new(self,ba,self._entrySchema)
table.insert(self.getResolved("items"),ca)self:updateRender()return ca end
function aa:removeItem(ba)local ca=self.getResolved("items")if type(ba)=="number"then
table.remove(ca,ba)else
for da,_b in pairs(ca)do if _b==ba then table.remove(ca,da)break end end end
self:updateRender()return self end
function aa:clear()self.set("items",{})self:updateRender()return self end
function aa:getSelectedItems()local ba={}for ca,da in ipairs(self.getResolved("items"))do
if
type(da)=="table"and da.selected then local _b=da;_b.index=ca;table.insert(ba,_b)end end
return ba end
function aa:getSelectedItem()local ba=self.getResolved("items")
for ca,da in ipairs(ba)do if
type(da)=="table"and da.selected then return da end end;return nil end
function aa:selectItem(ba)local ca=self.getResolved("items")
if type(ba)=="number"then
if
ca[ba]and type(ca[ba])=="table"then ca[ba].selected=true end else for da,_b in pairs(ca)do
if _b==ba then if type(_b)=="table"then _b.selected=true end;break end end end;self:updateRender()return self end
function aa:unselectItem(ba)local ca=self.getResolved("items")
if type(ba)=="number"then
if
ca[ba]and type(ca[ba])=="table"then ca[ba].selected=false end else
for da,_b in pairs(ca)do if _b==ba then
if type(ca[da])=="table"then ca[da].selected=false end;break end end end;self:updateRender()return self end
function aa:clearItemSelection()local ba=self.getResolved("items")for ca,da in ipairs(ba)do
da.selected=false end;self:updateRender()return self end
function aa:getSelectedIndex()local ba=self.getResolved("items")
for ca,da in ipairs(ba)do if
type(da)=="table"and da.selected then return ca end end;return nil end
function aa:selectNext()local ba=self.getResolved("items")
local ca=self:getSelectedIndex()
if not ca then if#ba>0 then self:selectItem(1)end elseif ca<#ba then
if not
self.getResolved("multiSelection")then self:clearItemSelection()end;self:selectItem(ca+1)end;self:updateRender()return self end
function aa:selectPrevious()local ba=self.getResolved("items")
local ca=self:getSelectedIndex()
if not ca then if#ba>0 then self:selectItem(#ba)end elseif ca>1 then
if not
self.getResolved("multiSelection")then self:clearItemSelection()end;self:selectItem(ca-1)end;self:updateRender()return self end
function aa:onSelect(ba)self:registerCallback("select",ba)return self end;return aa end
project["elements/Accordion.lua"] = function(...) local aa=require("elementManager")
local ba=require("elements/VisualElement")local ca=aa.getElement("Container")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"panels",{default={},type="table"})
_b.defineProperty(_b,"panelHeaderHeight",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"allowMultiple",{default=false,type="boolean"})
_b.defineProperty(_b,"headerBackground",{default=colors.gray,type="color",canTriggerRender=true})
_b.defineProperty(_b,"headerTextColor",{default=colors.white,type="color",canTriggerRender=true})
_b.defineProperty(_b,"expandedHeaderBackground",{default=colors.lightGray,type="color",canTriggerRender=true})
_b.defineProperty(_b,"expandedHeaderTextColor",{default=colors.black,type="color",canTriggerRender=true})_b.defineEvent(_b,"mouse_click")
_b.defineEvent(_b,"mouse_up")function _b.new()local ab=setmetatable({},_b):__init()
ab.class=_b;ab.set("width",20)ab.set("height",10)ab.set("z",10)return
ab end
function _b:init(ab,bb)
ca.init(self,ab,bb)self.set("type","Accordion")end
function _b:newPanel(ab,bb)local cb=self.getResolved("panels")or{}
local db=#cb+1;local _c=self:addContainer()_c.set("x",1)_c.set("y",1)
_c.set("width",self.getResolved("width"))
_c.set("height",self.getResolved("height"))_c.set("visible",bb or false)
_c.set("ignoreOffset",true)
table.insert(cb,{id=db,title=tostring(ab or("Panel "..db)),expanded=bb or false,container=_c})self.set("panels",cb)self:updatePanelLayout()return _c end;_b.addPanel=_b.newPanel
function _b:updatePanelLayout()
local ab=self.getResolved("panels")or{}
local bb=self.getResolved("panelHeaderHeight")or 1;local cb=1;local db=self.getResolved("width")
local _c=self.getResolved("height")
for dc,_d in ipairs(ab)do local ad=cb+bb;_d.container.set("x",1)
_d.container.set("y",ad)_d.container.set("width",db)
_d.container.set("visible",_d.expanded)_d.container.set("ignoreOffset",false)cb=cb+bb
if
_d.expanded then local bd=0
for dd,__a in
ipairs(_d.container._values.children or{})do
if not __a._destroyed then local a_a=__a.get("y")local b_a=__a.get("height")local c_a=
a_a+b_a-1;if c_a>bd then bd=c_a end end end;local cd=math.max(1,bd)_d.container.set("height",cd)cb=
cb+cd end end;local ac=cb-1;local bc=math.max(0,ac-_c)
local cc=self.getResolved("offsetY")if cc>bc then self.set("offsetY",bc)end
self:updateRender()end
function _b:togglePanel(ab)local bb=self.getResolved("panels")or{}
local cb=self.getResolved("allowMultiple")
for db,_c in ipairs(bb)do
if _c.id==ab then _c.expanded=not _c.expanded
if not cb and _c.expanded then for ac,bc in
ipairs(bb)do if ac~=db then bc.expanded=false end end end;self:updatePanelLayout()
self:dispatchEvent("panelToggled",ab,_c.expanded)break end end;return self end
function _b:expandPanel(ab)local bb=self.getResolved("panels")or{}
local cb=self.getResolved("allowMultiple")
for db,_c in ipairs(bb)do
if _c.id==ab then
if not _c.expanded then _c.expanded=true
if not cb then for ac,bc in ipairs(bb)do if ac~=db then
bc.expanded=false end end end;self:updatePanelLayout()
self:dispatchEvent("panelToggled",ab,true)end;break end end;return self end
function _b:collapsePanel(ab)local bb=self.getResolved("panels")or{}
for cb,db in
ipairs(bb)do
if db.id==ab then if db.expanded then db.expanded=false;self:updatePanelLayout()
self:dispatchEvent("panelToggled",ab,false)end;break end end;return self end
function _b:getPanel(ab)local bb=self.getResolved("panels")or{}
for cb,db in
ipairs(bb)do if db.id==ab then return db.container end end;return nil end
function _b:_getPanelMetrics()local ab=self.getResolved("panels")or{}local bb=
self.getResolved("panelHeaderHeight")or 1;local cb={}local db=1
for _c,ac in ipairs(ab)do
table.insert(cb,{id=ac.id,title=ac.title,expanded=ac.expanded,headerY=db,headerHeight=bb})db=db+bb;if ac.expanded then
db=db+ac.container.get("height")end end;return{positions=cb,totalHeight=db-1}end
function _b:mouse_click(ab,bb,cb)
if not ba.mouse_click(self,ab,bb,cb)then return false end;local db,_c=ba.getRelativePosition(self,bb,cb)
local ac=self.getResolved("offsetY")local bc=_c+ac;local cc=self:_getPanelMetrics()
for dc,_d in ipairs(cc.positions)do local ad=
_d.headerY+_d.headerHeight-1;if
bc>=_d.headerY and bc<=ad then self:togglePanel(_d.id)
self.set("focusedChild",nil)return true end end;return ca.mouse_click(self,ab,bb,cb)end
function _b:mouse_scroll(ab,bb,cb)
if ba.mouse_scroll(self,ab,bb,cb)then
local db=self:_getPanelMetrics()local _c=self.getResolved("height")local ac=db.totalHeight
local bc=math.max(0,ac-_c)
if bc>0 then local cc=self.getResolved("offsetY")local dc=cc+ab
dc=math.max(0,math.min(bc,dc))self.set("offsetY",dc)return true end;return ca.mouse_scroll(self,ab,bb,cb)end;return false end
function _b:render()ba.render(self)local ab=self.getResolved("width")
local bb=self.getResolved("offsetY")local cb=self:_getPanelMetrics()
for db,_c in ipairs(cb.positions)do
local ac=_c.expanded and
self.getResolved("expandedHeaderBackground")or self.getResolved("headerBackground")
local bc=
_c.expanded and self.getResolved("expandedHeaderTextColor")or self.getResolved("headerTextColor")local cc=_c.headerY-bb
if
cc>=1 and cc<=self.getResolved("height")then
ba.multiBlit(self,1,cc,ab,_c.headerHeight," ",da[bc],da[ac])local dc=_c.expanded and"v"or">"
local _d=dc.." ".._c.title;ba.textFg(self,1,cc,_d,bc)end end;if not self.getResolved("childrenSorted")then
self:sortChildren()end
if
not self.getResolved("childrenEventsSorted")then for db in pairs(self._values.childrenEvents or{})do
self:sortChildrenEvents(db)end end
for db,_c in
ipairs(self.getResolved("visibleChildren")or{})do
if _c==self then error("CIRCULAR REFERENCE DETECTED!")return end;_c:render()_c:postRender()end end;return _b end
project["plugins/store.lua"] = function(...) local _a=require("propertySystem")
local aa=require("errorManager")local ba={}function ba.setup(da)
da.defineProperty(da,"stores",{default={},type="table"})
da.defineProperty(da,"storeObserver",{default={},type="table"})end
function ba:initializeStore(da,_b,ab,bb)
local cb=self.get("stores")if cb[da]then
aa.error("Store '"..da.."' already exists")return self end;local db=bb or"stores/"..
self.get("name")..".store"local _c={}
if ab and
fs.exists(db)then local ac=fs.open(db,"r")_c=
textutils.unserialize(ac.readAll())or{}ac.close()end;cb[da]={value=ab and _c[da]or _b,persist=ab}
return self end;local ca={}
function ca:setStore(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("stores")local cb=ab.get("storeObserver")
if not bb[da]then aa.error("Store '"..
da.."' not initialized")end
if bb[da].persist then
local db="stores/"..ab.get("name")..".store"local _c={}
if fs.exists(db)then local cc=fs.open(db,"r")_c=
textutils.unserialize(cc.readAll())or{}cc.close()end;_c[da]=_b;local ac=fs.getDir(db)if not fs.exists(ac)then
fs.makeDir(ac)end;local bc=fs.open(db,"w")
bc.write(textutils.serialize(_c))bc.close()end;bb[da].value=_b
if cb[da]then for db,_c in ipairs(cb[da])do _c(da,_b)end end;for db,_c in pairs(bb)do
if _c.computed then _c.value=_c.computeFn(self)if cb[db]then for ac,bc in ipairs(cb[db])do
bc(db,_c.value)end end end end
return self end
function ca:getStore(da)local _b=self:getBaseFrame()local ab=_b.get("stores")if
not ab[da]then
aa.error("Store '"..da.."' not initialized")end;if ab[da].computed then
return ab[da].computeFn(self)end;return ab[da].value end
function ca:onStoreChange(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("stores")[da]if not bb then
aa.error("Cannot observe store '"..da.."': Store not initialized")return self end
local cb=ab.get("storeObserver")if not cb[da]then cb[da]={}end;table.insert(cb[da],_b)
return self end
function ca:removeStoreChange(da,_b)local ab=self:getBaseFrame()
local bb=ab.get("storeObserver")
if bb[da]then for cb,db in ipairs(bb[da])do
if db==_b then table.remove(bb[da],cb)break end end end;return self end
function ca:computed(da,_b)local ab=self:getBaseFrame()local bb=ab.get("stores")if bb[da]then
aa.error(
"Computed store '"..da.."' already exists")return self end
bb[da]={computeFn=_b,value=_b(self),computed=true}return self end
function ca:bind(da,_b)_b=_b or da;local ab=self:getBaseFrame()local bb=false
if
self.get(da)~=nil then self.set(da,ab:getStore(_b))end
self:onChange(da,function(cb,db)if bb then return end;bb=true;cb:setStore(_b,db)bb=false end)
self:onStoreChange(_b,function(cb,db)if bb then return end;bb=true;if self.get(da)~=nil then
self.set(da,db)end;bb=false end)return self end;return{BaseElement=ca,BaseFrame=ba} end
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
project["plugins/theme.lua"] = function(...) local _b=require("errorManager")
local ab={default={background=colors.cyan,foreground=colors.black},BaseFrame={background=colors.white,foreground=colors.black,Container={default={background=colors.cyan,foreground=colors.black},background=colors.black,Button={background=colors.cyan,foreground=colors.black,states={clicked={background=colors.white,foreground=colors.black}}},Input={background=colors.cyan,foreground=colors.black},Label={foreground=colors.white}},Button={background=colors.cyan,foreground=colors.black,states={clicked={background=colors.black,foreground=colors.cyan}}},Label={foreground=colors.black},names={basaltDebugLog={background=colors.red,foreground=colors.white}}}}local bb={default=ab}local cb="default"
local db={hooks={postInit={pre=function(dc)if dc._postInitialized then return dc end
dc:applyTheme()end}}}
function db.____getElementPath(dc,_d)if _d then table.insert(_d,1,dc._values.type)else
_d={dc._values.type}end;local ad=dc.parent;if ad then return
ad.____getElementPath(ad,_d)else return _d end end
local function _c(dc,_d)local ad=dc
for i=1,#_d do local bd=false;local cd=_d[i]for dd,__a in ipairs(cd)do
if ad[__a]then ad=ad[__a]bd=true;break end end;if not bd then return nil end end;return ad end
local function ac(dc,_d,ad,bd,cd)
if
_d.default and _d.default.names and _d.default.names[bd]then for dd,__a in pairs(_d.default.names[bd])do
if type(__a)~="table"then dc[dd]=__a end end end
if

_d.default and _d.default[ad]and _d.default[ad].names and _d.default[ad].names[bd]then
for dd,__a in pairs(_d.default[ad].names[bd])do if
type(__a)~="table"then dc[dd]=__a end end end;if cd and cd.names and cd.names[bd]then
for dd,__a in pairs(cd.names[bd])do if type(__a)~=
"table"then dc[dd]=__a end end end end
local function bc(dc,_d,ad,bd)local cd={}
if dc.default then for a_a,b_a in pairs(dc.default)do
if type(b_a)~="table"then cd[a_a]=b_a end end end;local dd=dc
for i=1,#_d do local a_a=_d[i]local b_a=false
for c_a,d_a in ipairs(a_a)do
if dd[d_a]then dd=dd[d_a]b_a=true;if dd.default then
for _aa,aaa in
pairs(dd.default)do if type(aaa)~="table"then cd[_aa]=aaa end end end;break end end;if not b_a then dd=nil;break end end;local __a=_c(dc,_d)if __a then
for a_a,b_a in pairs(__a)do if
type(b_a)~="table"or a_a=="states"then cd[a_a]=b_a end end end
ac(cd,dc,ad,bd,__a)return cd end
function db:applyTheme(dc)local _d={}if self._modifiedProperties then
for bd,cd in pairs(self._modifiedProperties)do _d[bd]=true end end
local ad=self:getTheme()
if(ad~=nil)then
for bd,cd in pairs(ad)do
if bd~="states"and not _d[bd]then
local dd=self._properties[bd]
if(dd)then
if( (dd.type)=="color")then if(type(cd)=="string")then
if(colors[cd])then cd=colors[cd]end end end;self.set(bd,cd)end end end
if ad.states then
for bd,cd in pairs(ad.states)do
for dd,__a in pairs(cd)do
if dd~="priority"then
local a_a=self._properties[dd]local b_a=dd:sub(1,1):upper()..dd:sub(2)
if(a_a)then
if(
(a_a.type)=="color")then if(type(__a)=="string")then
if(colors[__a])then __a=colors[__a]end end end
self["set"..b_a.."State"](self,bd,__a)end end end end end end;self._modifiedProperties=_d
if(dc~=false)then if(self:isType("Container"))then
local bd=self.get("children")
for cd,dd in ipairs(bd)do if(dd and dd.applyTheme)then dd:applyTheme()end end end end;return self end
function db:getTheme()local dc=self:____getElementPath()
local _d=self.get("type")local ad=self.get("name")return bc(bb[cb],dc,_d,ad)end;local cc={}function cc.setTheme(dc)bb.default=dc end
function cc.getTheme()return bb.default end
function cc.loadTheme(dc)local _d=fs.open(dc,"r")
if _d then local ad=_d.readAll()_d.close()
bb.default=textutils.unserializeJSON(ad)if not bb.default then
_b.error("Failed to load theme from "..dc)end else
_b.error("Could not open theme file: "..dc)end end;return{BaseElement=db,API=cc} end
project["plugins/reactive.lua"] = function(...) local cb=require("errorManager")
local db=require("propertySystem")local _c={colors=true,math=true,clamp=true,round=true}
local ac={clamp=function(__a,a_a,b_a)return
math.min(math.max(__a,a_a),b_a)end,round=function(__a)
return math.floor(__a+0.5)end,floor=math.floor,ceil=math.ceil,abs=math.abs}
local function bc(__a)return
{parent=__a:find("parent%."),self=__a:find("self%."),other=__a:find("[^(parent)][^(self)]%.")}end
local function cc(__a,a_a,b_a)local c_a=bc(__a)
if c_a.parent and not a_a.parent then
cb.header="Reactive evaluation error"
cb.error("Expression uses parent but no parent available")return function()return nil end end;__a=__a:gsub("^{(.+)}$","%1")
__a=__a:gsub("([%w_]+)%$([%w_]+)",function(baa,caa)
if baa=="self"then return
string.format('__getState("%s")',caa)elseif baa=="parent"then return
string.format('__getParentState("%s")',caa)else return
string.format('__getElementState("%s", "%s")',baa,caa)end end)
__a=__a:gsub("([%w_]+)%.([%w_]+)",function(baa,caa)if _c[baa]then return baa.."."..caa end;if
tonumber(baa)then return baa.."."..caa end;return
string.format('__getProperty("%s", "%s")',baa,caa)end)
local d_a=setmetatable({colors=colors,math=math,tostring=tostring,tonumber=tonumber,__getState=function(baa)return a_a:getState(baa)end,__getParentState=function(baa)return
a_a.parent:getState(baa)end,__getElementState=function(baa,caa)if tonumber(baa)then return nil end
local daa=a_a:getBaseFrame():getChild(baa)if not daa then cb.header="Reactive evaluation error"
cb.error("Could not find element: "..baa)return nil end;return
daa:getState(caa).value end,__getProperty=function(baa,caa)if
tonumber(baa)then return nil end
if baa=="self"then if a_a._properties[caa]then
return a_a.getResolved(caa)end;if
a_a._registeredStates and a_a._registeredStates[caa]then return a_a:hasState(caa)end
local daa=a_a.get("states")if daa and daa[caa]~=nil then return true end
cb.header="Reactive evaluation error"
cb.error("Property or state '"..caa..
"' not found in element '"..a_a:getType().."'")return nil elseif baa=="parent"then if a_a.parent._properties[caa]then return
a_a.parent.getResolved(caa)end;if a_a.parent._registeredStates and
a_a.parent._registeredStates[caa]then
return a_a.parent:hasState(caa)end
local daa=a_a.parent.get("states")if daa and daa[caa]~=nil then return true end
cb.header="Reactive evaluation error"
cb.error("Property or state '"..caa.."' not found in parent element")return nil else local daa=a_a.parent:getChild(baa)if not daa then
cb.header="Reactive evaluation error"
cb.error("Could not find element: "..baa)return nil end;if
daa._properties[caa]then return daa.getResolved(caa)end
if daa._registeredStates and
daa._registeredStates[caa]then return daa:hasState(caa)end;local _ba=daa.get("states")
if _ba and _ba[caa]~=nil then return true end;cb.header="Reactive evaluation error"
cb.error("Property or state '"..caa..
"' not found in element '"..baa.."'")return nil end end},{__index=ac})if(a_a._properties[b_a].type=="string")then
__a="tostring("..__a..")"elseif(a_a._properties[b_a].type=="number")then
__a="tonumber("..__a..")"end;local _aa,aaa=load(
"return "..__a,"reactive","t",d_a)
if not _aa then
cb.header="Reactive evaluation error"cb.error("Invalid expression: "..aaa)return
function()return nil end end;return _aa end
local function dc(__a,a_a)
for b_a in __a:gmatch("([%w_]+)%.")do
if not _c[b_a]then
if b_a=="self"then elseif b_a=="parent"then
if not a_a.parent then
cb.header="Reactive evaluation error"cb.error("No parent element available")return false end else
if(tonumber(b_a)==nil)then local c_a=a_a.parent:getChild(b_a)if not c_a then
cb.header="Reactive evaluation error"
cb.error("Referenced element not found: "..b_a)return false end end end end end;return true end;local _d=setmetatable({},{__mode="k"})
local ad=setmetatable({},{__mode="k",__index=function(__a,a_a)__a[a_a]={}return
__a[a_a]end})
local bd=setmetatable({},{__mode="k",__index=function(__a,a_a)__a[a_a]={}return __a[a_a]end})
local function cd(__a,a_a,b_a)local c_a=bc(a_a)
if ad[__a][b_a]then for _aa,aaa in ipairs(ad[__a][b_a])do
aaa.target:removeObserver(aaa.property,aaa.callback)end end;local d_a={}
for _aa,aaa in a_a:gmatch("([%w_]+)%.([%w_]+)")do
if not _c[_aa]then local baa
if
_aa=="self"and c_a.self then baa=__a elseif _aa=="parent"and c_a.parent then baa=__a.parent elseif c_a.other then
baa=__a:getBaseFrame():getChild(_aa)end
if baa then local caa=false
if baa._properties[aaa]then caa=false elseif baa._registeredStates and
baa._registeredStates[aaa]then caa=true else local _ba=baa.get("states")if _ba and
_ba[aaa]~=nil then caa=true end end
local daa={target=baa,property=caa and"states"or aaa,callback=function()local _ba=bd[__a][b_a]local aba=__a.get(b_a)
if
_ba~=aba then bd[__a][b_a]=aba
if
__a._observers and __a._observers[b_a]then for bba,cba in ipairs(__a._observers[b_a])do cba()end end;__a:updateRender()end end}baa:observe(daa.property,daa.callback)
table.insert(d_a,daa)end end end;ad[__a][b_a]=d_a end
db.addSetterHook(function(__a,a_a,b_a,c_a)
if type(b_a)=="string"and b_a:match("^{.+}$")then
local d_a=b_a:gsub("^{(.+)}$","%1")local _aa=bc(d_a)
if _aa.parent and not __a.parent then return c_a.default end;if not dc(d_a,__a)then return c_a.default end
cd(__a,d_a,a_a)if not _d[__a]then _d[__a]={}end;if not _d[__a][b_a]then
local aaa=cc(b_a,__a,a_a)_d[__a][b_a]=aaa end
return
function(aaa)
if __a._destroyed or(_aa.parent and not
__a.parent)then return c_a.default end;local baa,caa=pcall(_d[__a][b_a])
if not baa then
if caa and
caa:match("attempt to index.-nil value")then return c_a.default end;cb.header="Reactive evaluation error"if type(caa)=="string"then cb.error(
"Error evaluating expression: "..caa)else
cb.error("Error evaluating expression")end
return c_a.default end;bd[__a][a_a]=caa;return caa end end end)local dd={}
dd.hooks={destroy=function(__a)
if ad[__a]then
for a_a,b_a in pairs(ad[__a])do for c_a,d_a in ipairs(b_a)do
d_a.target:removeObserver(d_a.property,d_a.callback)end end;ad[__a]=nil;bd[__a]=nil;_d[__a]=nil end end}return{BaseElement=dd} end
project["plugins/xml.lua"] = function(...) local bb=require("errorManager")local cb=require("log")
local db={new=function(cd)
return
{tag=cd,value=nil,attributes={},children={},addChild=function(dd,__a)
table.insert(dd.children,__a)end,addAttribute=function(dd,__a,a_a)dd.attributes[__a]=a_a end}end}
local _c=function(cd,dd)
local __a,a_a=string.gsub(dd,"([%w:]+)=([\"'])(.-)%2",function(d_a,_aa,aaa)
cd:addAttribute(d_a,"\""..aaa.."\"")end)
local b_a,c_a=string.gsub(dd,"([%w:]+)={(.-)}",function(d_a,_aa)cd:addAttribute(d_a,_aa)end)end;local ac={}
ac={_customTagHandlers={},registerTagHandler=function(cd,dd)ac._customTagHandlers[cd]=dd
cb.info(
"XMLParser: Registered custom tag handler for '"..cd.."'")end,unregisterTagHandler=function(cd)ac._customTagHandlers[cd]=
nil
cb.info("XMLParser: Unregistered custom tag handler for '"..cd.."'")end,getTagHandler=function(cd)return
ac._customTagHandlers[cd]end,parseText=function(cd)local dd={}local __a=db.new()
table.insert(dd,__a)local a_a,b_a,c_a,d_a,_aa;local aaa,baa=1,1
while true do
a_a,baa,b_a,c_a,d_a,_aa=string.find(cd,"<(%/?)([%w_:]+)(.-)(%/?)>",aaa)if not a_a then break end;local caa=string.sub(cd,aaa,a_a-1)if not
string.find(caa,"^%s*$")then local daa=(__a.value or"")..caa
dd[#dd].value=daa end
if _aa=="/"then local daa=db.new(c_a)
_c(daa,d_a)__a:addChild(daa)elseif b_a==""then local daa=db.new(c_a)_c(daa,d_a)
table.insert(dd,daa)__a=daa else local daa=table.remove(dd)__a=dd[#dd]
if#dd<1 then bb.error(
"XMLParser: nothing to close with "..c_a)end;if daa.tag~=c_a then
bb.error("XMLParser: trying to close "..daa.tag.." with "..c_a)end;__a:addChild(daa)end;aaa=baa+1 end;if#dd>1 then
error("XMLParser: unclosed "..dd[#dd].tag)end;return __a.children end}
local function bc(cd)local dd={}local __a=1
while true do local a_a,b_a,c_a=cd:find("%${([^}]+)}",__a)
if not a_a then break end
table.insert(dd,{start=a_a,ending=b_a,expression=c_a,raw=cd:sub(a_a,b_a)})__a=b_a+1 end;return dd end
local function cc(cd,dd)if not cd then return cd end;if
cd:sub(1,1)=="\""and cd:sub(-1)=="\""then cd=cd:sub(2,-2)end;local __a=bc(cd)
for a_a,b_a in ipairs(__a)do
local c_a=b_a.expression;local d_a=b_a.start-1;local _aa=b_a.ending+1;if dd[c_a]then cd=cd:sub(1,d_a)..
tostring(dd[c_a])..cd:sub(_aa)else
bb.error(
"XMLParser: variable '"..c_a.."' not found in scope")end end
if cd:match("^%s*<!%[CDATA%[.*%]%]>%s*$")then
local a_a=cd:match("<!%[CDATA%[(.*)%]%]>")local b_a=_ENV;for baa,caa in pairs(dd)do b_a[baa]=caa end
local c_a,d_a=load("return "..a_a,nil,"bt",b_a)if not c_a then
bb.error("XMLParser: CDATA syntax error: "..tostring(d_a))end;local _aa,aaa=pcall(c_a)if not _aa then
bb.error(
"XMLParser: CDATA execution error: "..tostring(aaa))end;return aaa end
if cd=="true"then return true elseif cd=="false"then return false elseif colors[cd]then return colors[cd]elseif tonumber(cd)then return
tonumber(cd)else return cd end end
local function dc(cd,dd)local __a={}
for a_a,b_a in pairs(cd.children)do
if b_a.tag=="item"or b_a.tag=="entry"then
local c_a={}
for d_a,_aa in pairs(b_a.attributes)do c_a[d_a]=cc(_aa,dd)end;for d_a,_aa in pairs(b_a.children)do
if _aa.value then c_a[_aa.tag]=cc(_aa.value,dd)elseif#
_aa.children>0 then c_a[_aa.tag]=dc(_aa)end end
table.insert(__a,c_a)else if b_a.value then __a[b_a.tag]=cc(b_a.value,dd)elseif#b_a.children>0 then
__a[b_a.tag]=dc(b_a)end end end;return __a end
local function _d(cd,dd,__a,a_a)local b_a,c_a=dd:match("^(.+)State:(.+)$")
if b_a and c_a then
c_a=c_a:gsub("^\"",""):gsub("\"$","")
local d_a=b_a:sub(1,1):upper()..b_a:sub(2)local _aa="set"..d_a.."State"
if cd[_aa]then
cd[_aa](cd,c_a,cc(__a,a_a))return true else
cb.warn("XMLParser: State method '".._aa..
"' not found for element '"..cd:getType().."'")return true end end;return false end;local ad={}function ad.setup(cd)
cd.defineProperty(cd,"customXML",{default={attributes={},children={}},type="table"})end
function ad:fromXML(cd,dd)
if(cd.attributes)then
for __a,a_a in
pairs(cd.attributes)do
if not _d(self,__a,a_a,dd)then
if(self._properties[__a])then
self.set(__a,cc(a_a,dd))elseif self[__a]then
if(__a:sub(1,2)=="on")then local b_a=a_a:gsub("\"","")
if(dd[b_a])then if(
type(dd[b_a])~="function")then
bb.error("XMLParser: variable '"..
b_a.."' is not a function for element '"..self:getType()..
"' "..__a)end
self[__a](self,dd[b_a])else
bb.error("XMLParser: variable '"..b_a.."' not found in scope")end else
bb.error("XMLParser: property '"..__a..
"' not found in element '"..self:getType().."'")end else local b_a=self.get("customXML")
b_a.attributes[__a]=cc(a_a,dd)end end end end
if(cd.children)then
for __a,a_a in pairs(cd.children)do
if a_a.tag=="state"then
local b_a=a_a.attributes and a_a.attributes.name;if not b_a then
bb.error("XMLParser: <state> tag requires 'name' attribute")end
b_a=b_a:gsub("^\"",""):gsub("\"$","")
if a_a.children then
for c_a,d_a in ipairs(a_a.children)do local _aa=d_a.tag;local aaa
if
d_a.attributes and d_a.attributes.value then aaa=cc(d_a.attributes.value,dd)elseif d_a.value then
aaa=cc(d_a.value,dd)else
cb.warn("XMLParser: State property '".._aa.."' has no value")aaa=nil end
if aaa~=nil then
local baa=_aa:sub(1,1):upper().._aa:sub(2)local caa="set"..baa.."State"if self[caa]then
self[caa](self,b_a,aaa)else
cb.warn("XMLParser: State method '"..caa..
"' not found for element '"..self:getType().."'")end end end end elseif(self._properties[a_a.tag])then if
(self._properties[a_a.tag].type=="table")then self.set(a_a.tag,dc(a_a,dd))else
self.set(a_a.tag,cc(a_a.value,dd))end else local b_a={}
if(a_a.children)then
for c_a,d_a in
pairs(a_a.children)do
if(d_a.tag=="param")then
table.insert(b_a,cc(d_a.value,dd))elseif(d_a.tag=="table")then table.insert(b_a,dc(d_a,dd))end end end
if(self[a_a.tag])then if(#b_a>0)then
self[a_a.tag](self,table.unpack(b_a))elseif(a_a.value)then self[a_a.tag](self,cc(a_a.value,dd))else
self[a_a.tag](self)end else
local c_a=self.get("customXML")a_a.value=cc(a_a.value,dd)c_a.children[a_a.tag]=a_a end end end end;return self end;local bd={}
function bd:loadXML(cd,dd)dd=dd or{}local __a=ac.parseText(cd)
self:fromXML(__a,dd)
if(__a)then
for a_a,b_a in ipairs(__a)do
local c_a=b_a.tag:sub(1,1):upper()..b_a.tag:sub(2)if self["add"..c_a]then local d_a=self["add"..c_a](self)
d_a:fromXML(b_a,dd)end end end;return self end
function bd:fromXML(cd,dd)ad.fromXML(self,cd,dd)
if(cd.children)then
for __a,a_a in ipairs(cd.children)do local b_a=
a_a.tag:sub(1,1):upper()..a_a.tag:sub(2)
local c_a=ac.getTagHandler(a_a.tag)
if c_a then local d_a=c_a(a_a,self,dd)elseif self["add"..b_a]then
local d_a=self["add"..b_a](self)d_a:fromXML(a_a,dd)else
cb.warn("XMLParser: Unknown tag '"..
a_a.tag.."' - no handler or element found")end end end;return self end;return{API=ac,Container=bd,BaseElement=ad} end
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
project["plugins/animation.lua"] = function(...) local aa={}local ba={}
ba={linear=function(ab)return ab end,easeInQuad=function(ab)return ab*ab end,easeOutQuad=function(ab)return
1 - (1 -ab)* (1 -ab)end,easeInOutQuad=function(ab)if ab<0.5 then return 2 *ab*ab end;return 1 - (
-2 *ab+2)^2 /2 end,easeInCubic=function(ab)return
ab*ab*ab end,easeOutCubic=function(ab)return 1 - (1 -ab)^3 end,easeInOutCubic=function(ab)if
ab<0.5 then return 4 *ab*ab*ab end;return
1 - (-2 *ab+2)^3 /2 end,easeInQuart=function(ab)
return ab*ab*ab*ab end,easeOutQuart=function(ab)return 1 - (1 -ab)^4 end,easeInOutQuart=function(ab)if ab<0.5 then return
8 *ab*ab*ab*ab end;return
1 - (-2 *ab+2)^4 /2 end,easeInQuint=function(ab)return
ab*ab*ab*ab*ab end,easeOutQuint=function(ab)return 1 - (1 -ab)^5 end,easeInOutQuint=function(ab)if ab<
0.5 then return 16 *ab*ab*ab*ab*ab end;return 1 - (-
2 *ab+2)^5 /2 end,easeInSine=function(ab)return
1 -math.cos(ab*math.pi/2)end,easeOutSine=function(ab)return math.sin(
ab*math.pi/2)end,easeInOutSine=function(ab)
return- (math.cos(
math.pi*ab)-1)/2 end,easeInExpo=function(ab)if ab==0 then return 0 end
return 2 ^ (10 *ab-10)end,easeOutExpo=function(ab)if ab==1 then return 1 end;return
1 -2 ^ (-10 *ab)end,easeInOutExpo=function(ab)if ab==0 then return 0 end
if ab==1 then return 1 end;if ab<0.5 then return 2 ^ (20 *ab-10)/2 end;return(2 -2 ^ (
-20 *ab+10))/2 end,easeInCirc=function(ab)return
1 -math.sqrt(1 -ab*ab)end,easeOutCirc=function(ab)return math.sqrt(
1 - (ab-1)* (ab-1))end,easeInOutCirc=function(ab)if
ab<0.5 then
return(1 -math.sqrt(1 - (2 *ab)^2))/2 end;return
(math.sqrt(1 - (-2 *ab+2)^2)+1)/2 end,easeInBack=function(ab)
local bb=1.70158;local cb=bb+1;return cb*ab*ab*ab-bb*ab*ab end,easeOutBack=function(ab)
local bb=1.70158;local cb=bb+1
return 1 +cb* (ab-1)^3 +bb* (ab-1)^2 end,easeInOutBack=function(ab)local bb=1.70158;local cb=bb*1.525;if ab<0.5 then
return( (
2 *ab)^2 * ( (cb+1)*2 *ab-cb))/2 end
return( (2 *ab-2)^2 *
( (cb+1)* (ab*2 -2)+cb)+2)/2 end,easeInElastic=function(ab)local bb=(
2 *math.pi)/3;if ab==0 then return 0 end;if ab==1 then return 1 end;return
- (
2 ^ (10 *ab-10))*math.sin((ab*10 -10.75)*bb)end,easeOutElastic=function(ab)local bb=(
2 *math.pi)/3;if ab==0 then return 0 end;if ab==1 then return 1 end;return

2 ^ (-10 *ab)*math.sin((ab*10 -0.75)*bb)+1 end,easeInOutElastic=function(ab)local bb=(
2 *math.pi)/4.5;if ab==0 then return 0 end
if ab==1 then return 1 end;if ab<0.5 then
return-
(2 ^ (20 *ab-10)*math.sin((20 *ab-11.125)*bb))/2 end;return
(2 ^ (-20 *ab+10)*math.sin(
(20 *ab-11.125)*bb))/2 +1 end,easeInBounce=function(ab)return
1 -ba.easeOutBounce(1 -ab)end,easeOutBounce=function(ab)
local bb=7.5625;local cb=2.75
if ab<1 /cb then return bb*ab*ab elseif ab<2 /cb then ab=ab-1.5 /cb;return
bb*ab*ab+0.75 elseif ab<2.5 /cb then ab=ab-2.25 /cb;return bb*ab*ab+0.9375 else ab=
ab-2.625 /cb;return bb*ab*ab+0.984375 end end,easeInOutBounce=function(ab)if
ab<0.5 then
return(1 -ba.easeOutBounce(1 -2 *ab))/2 end;return
(1 +ba.easeOutBounce(2 *ab-1))/2 end}local ca={}ca.__index=ca
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
end})
da.registerAnimation("custom",{start=function(ab)ab.callback=ab.args[1]if
type(ab.callback)~="function"then
error("custom animation requires a function as first argument")end end,update=function(ab,bb)local cb=
os.epoch("local")/1000 -ab.startTime
ab.callback(ab.element,bb,cb)return bb>=1 end,complete=function(ab)if ab.callback then
ab.callback(ab.element,1,ab.duration)end end})local _b={hooks={}}
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
project["plugins/responsive.lua"] = function(...) local c=require("errorManager")local d={}
function d:responsive()
local _a={_element=self,_rules={},_currentStateName=nil,_currentCondition=nil,_stateCounter=0}
function _a:when(aa)
if self._currentCondition then c.header="Responsive Builder Error"
c.error("Previous when() must be followed by apply() before starting a new when()")end;self._stateCounter=self._stateCounter+1;self._currentStateName="__responsive_"..
self._stateCounter;self._currentCondition=aa;return
self end
function _a:apply(aa)if not self._currentCondition then c.header="Responsive Builder Error"
c.error("apply() must follow a when() call")end;if
type(aa)~="table"then c.header="Responsive Builder Error"
c.error("apply() requires a table of properties")end
self._element:registerResponsiveState(self._currentStateName,self._currentCondition,100)
for ba,ca in pairs(aa)do
local da=ba:sub(1,1):upper()..ba:sub(2)local _b="set"..da.."State"
if self._element[_b]then
self._element[_b](self._element,self._currentStateName,ca)else c.header="Responsive Builder Error"
c.error("Unknown property: "..ba)end end
table.insert(self._rules,{stateName=self._currentStateName,condition=self._currentCondition,properties=aa})self._currentCondition=nil;self._currentStateName=nil;return self end
function _a:otherwise(aa)if self._currentCondition then c.header="Responsive Builder Error"
c.error("otherwise() cannot be used after when() without apply()")end;if type(aa)~=
"table"then c.header="Responsive Builder Error"
c.error("otherwise() requires a table of properties")end;self._stateCounter=
self._stateCounter+1
local ba="__responsive_otherwise_"..self._stateCounter;local ca={}
for _b,ab in ipairs(self._rules)do table.insert(ca,ab.condition)end;local da
if type(ca[1])=="string"then local _b={}for ab,bb in ipairs(ca)do
table.insert(_b,"not ("..bb..")")end;da=table.concat(_b," and ")else
da=function(_b)for ab,bb in
ipairs(ca)do if bb(_b)then return false end end;return true end end
self._element:registerResponsiveState(ba,da,50)
for _b,ab in pairs(aa)do
local bb=_b:sub(1,1):upper().._b:sub(2)local cb="set"..bb.."State"if self._element[cb]then
self._element[cb](self._element,ba,ab)else c.header="Responsive Builder Error"
c.error("Unknown property: ".._b)end end;return self end
function _a:done()if self._currentCondition then c.header="Responsive Builder Error"
c.error("Unfinished when() without apply()")end
return self._element end;return _a end;return{BaseElement=d} end
project["elementManager.lua"] = function(...) local _c=table.pack(...)
local ac=fs.getDir(_c[2]or"basalt")local bc=_c[1]if(ac==nil)then
error("Unable to find directory "..
_c[2].." please report this bug to our discord.")end
local cc=require("log")local dc=package.path;local _d="path;/path/?.lua;/path/?/init.lua;"
local ad=_d:gsub("path",ac)local bd={}bd._elements={}bd._plugins={}bd._APIs={}
bd._config={autoLoadMissing=false,allowRemoteLoading=false,allowDiskLoading=true,remoteSources={},diskMounts={},useGlobalCache=false,globalCacheName="_BASALT_ELEMENT_CACHE"}local cd=fs.combine(ac,"elements")
local dd=fs.combine(ac,"plugins")cc.info("Loading elements from "..cd)
if
fs.exists(cd)then
for d_a,_aa in ipairs(fs.list(cd))do local aaa=_aa:match("(.+).lua")if aaa then cc.debug(
"Found element: "..aaa)
bd._elements[aaa]={class=nil,plugins={},loaded=false,source="local",path=nil}end end end;cc.info("Loading plugins from "..dd)
if
fs.exists(dd)then
for d_a,_aa in ipairs(fs.list(dd))do local aaa=_aa:match("(.+).lua")
if aaa then cc.debug("Found plugin: "..
aaa)
local baa=require(fs.combine("plugins",aaa))
if type(baa)=="table"then
for caa,daa in pairs(baa)do
if(caa~="API")then if(bd._plugins[caa]==nil)then
bd._plugins[caa]={}end
table.insert(bd._plugins[caa],daa)else bd._APIs[aaa]=daa end end end end end end
if(minified)then if(minified_elementDirectory==nil)then
error("Unable to find minified_elementDirectory please report this bug to our discord.")end;for d_a,_aa in
pairs(minified_elementDirectory)do
bd._elements[d_a:gsub(".lua","")]={class=nil,plugins={},loaded=false,source="local",path=nil}end;if(
minified_pluginDirectory==nil)then
error("Unable to find minified_pluginDirectory please report this bug to our discord.")end
for d_a,_aa in
pairs(minified_pluginDirectory)do local aaa=d_a:gsub(".lua","")
local baa=require(fs.combine("plugins",aaa))
if type(baa)=="table"then
for caa,daa in pairs(baa)do
if(caa~="API")then if(bd._plugins[caa]==nil)then
bd._plugins[caa]={}end
table.insert(bd._plugins[caa],daa)else bd._APIs[aaa]=daa end end end end end
local function __a(d_a,_aa)if not bd._config.useGlobalCache then return end
if not
_G[bd._config.globalCacheName]then _G[bd._config.globalCacheName]={}end;_G[bd._config.globalCacheName][d_a]=_aa;cc.debug(
"Cached element in _G: "..d_a)end
local function a_a(d_a)if not bd._config.useGlobalCache then return nil end
if

_G[bd._config.globalCacheName]and _G[bd._config.globalCacheName][d_a]then
cc.debug("Loaded element from _G cache: "..d_a)return _G[bd._config.globalCacheName][d_a]end;return nil end
function bd.configure(d_a)for _aa,aaa in pairs(d_a)do
if bd._config[_aa]~=nil then bd._config[_aa]=aaa end end end
function bd.registerDiskMount(d_a)if not fs.exists(d_a)then
error("Disk mount path does not exist: "..d_a)end
table.insert(bd._config.diskMounts,d_a)cc.info("Registered disk mount: "..d_a)
local _aa=fs.combine(d_a,"elements")
if fs.exists(_aa)then
for aaa,baa in ipairs(fs.list(_aa))do
local caa=baa:match("(.+).lua")
if caa then
if not bd._elements[caa]then
cc.debug("Found element on disk: "..caa)
bd._elements[caa]={class=nil,plugins={},loaded=false,source="disk",path=fs.combine(_aa,baa)}end end end end end
function bd.registerRemoteSource(d_a,_aa)if not bd._config.allowRemoteLoading then
error("Remote loading is disabled. Enable with ElementManager.configure({allowRemoteLoading = true})")end
bd._config.remoteSources[d_a]=_aa
if not bd._elements[d_a]then
bd._elements[d_a]={class=nil,plugins={},loaded=false,source="remote",path=_aa}else bd._elements[d_a].source="remote"
bd._elements[d_a].path=_aa end
cc.info("Registered remote source for "..d_a..": ".._aa)end
local function b_a(d_a)if not http then
error("HTTP API is not available. Enable it in your CC:Tweaked config.")end
cc.info("Loading element from remote: "..d_a)local _aa=http.get(d_a)if not _aa then
error("Failed to download from: "..d_a)end;local aaa=_aa.readAll()_aa.close()if
not aaa or aaa==""then
error("Empty response from: "..d_a)end;local baa,caa=load(aaa,d_a,"t",_ENV)if not baa then
error(
"Failed to load element from "..d_a..": "..tostring(caa))end;local daa=baa()return daa end
local function c_a(d_a)if not fs.exists(d_a)then
error("Element file does not exist: "..d_a)end
cc.info("Loading element from disk: "..d_a)local _aa,aaa=loadfile(d_a)if not _aa then
error("Failed to load element from "..
d_a..": "..tostring(aaa))end;local baa=_aa()return baa end
function bd.tryAutoLoad(d_a)
if bd._config.allowDiskLoading then
for _aa,aaa in ipairs(bd._config.diskMounts)do
local baa=fs.combine(aaa,"elements")local caa=fs.combine(baa,d_a..".lua")
if fs.exists(caa)then
bd._elements[d_a]={class=
nil,plugins={},loaded=false,source="disk",path=caa}bd.loadElement(d_a)return true end end end
if
bd._config.allowRemoteLoading and bd._config.remoteSources[d_a]then bd.loadElement(d_a)return true end;return false end
function bd.loadElement(d_a)
if not bd._elements[d_a]then
if bd._config.autoLoadMissing then
local _aa=bd.tryAutoLoad(d_a)if not _aa then
error("Element '"..d_a.."' not found and could not be auto-loaded")end else
error("Element '"..d_a.."' not found")end end
if not bd._elements[d_a].loaded then local _aa=bd._elements[d_a].source or
"local"local aaa;local baa=false;aaa=a_a(d_a)
if aaa then
baa=true
cc.info("Loaded element from _G cache: "..d_a)elseif _aa=="local"then package.path=ad.."rom/?"
aaa=require(fs.combine("elements",d_a))package.path=dc elseif _aa=="disk"then if not bd._config.allowDiskLoading then
error(
"Disk loading is disabled for element: "..d_a)end
aaa=c_a(bd._elements[d_a].path)__a(d_a,aaa)elseif _aa=="remote"then if not bd._config.allowRemoteLoading then
error(
"Remote loading is disabled for element: "..d_a)end
aaa=b_a(bd._elements[d_a].path)__a(d_a,aaa)else
error("Unknown source type: ".._aa)end
bd._elements[d_a]={class=aaa,plugins=aaa.plugins,loaded=true,source=baa and"cache"or _aa,path=bd._elements[d_a].path}if not baa then
cc.debug("Loaded element: "..d_a.." from ".._aa)end
if(bd._plugins[d_a]~=nil)then
for caa,daa in
pairs(bd._plugins[d_a])do if(daa.setup)then daa.setup(aaa)end
if(daa.hooks)then
for _ba,aba in pairs(daa.hooks)do
local bba=aaa[_ba]if(type(bba)~="function")then
error("Element "..
d_a.." does not have a method ".._ba)end
if(type(aba)=="function")then
aaa[_ba]=function(cba,...)
local dba=bba(cba,...)local _ca=aba(cba,...)return _ca==nil and dba or _ca end elseif(type(aba)=="table")then
aaa[_ba]=function(cba,...)if aba.pre then aba.pre(cba,...)end
local dba=bba(cba,...)if aba.post then aba.post(cba,...)end;return dba end end end end;for _ba,aba in pairs(daa)do
if _ba~="setup"and _ba~="hooks"then aaa[_ba]=aba end end end end end end
function bd.getElement(d_a)
if not bd._elements[d_a]then
if bd._config.autoLoadMissing then
local _aa=bd.tryAutoLoad(d_a)if not _aa then
error("Element '"..d_a.."' not found")end else
error("Element '"..d_a.."' not found")end end
if not bd._elements[d_a].loaded then bd.loadElement(d_a)end;return bd._elements[d_a].class end;function bd.getElementList()return bd._elements end;function bd.getAPI(d_a)
return bd._APIs[d_a]end
function bd.hasElement(d_a)return bd._elements[d_a]~=nil end
function bd.isElementLoaded(d_a)return
bd._elements[d_a]and bd._elements[d_a].loaded or false end
function bd.clearGlobalCache()if _G[bd._config.globalCacheName]then _G[bd._config.globalCacheName]=
nil
cc.info("Cleared global element cache")end end
function bd.getCacheStats()if not _G[bd._config.globalCacheName]then
return{size=0,elements={}}end;local d_a={}for _aa,aaa in
pairs(_G[bd._config.globalCacheName])do table.insert(d_a,_aa)end;return
{size=#d_a,elements=d_a}end
function bd.preloadElements(d_a)for _aa,aaa in ipairs(d_a)do
if bd._elements[aaa]and
not bd._elements[aaa].loaded then bd.loadElement(aaa)end end end;return bd end
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
bc:_updateProperty(db,cc)return bc end
cb["get"..ac.."State"]=function(bc,cc,...)ca(1,bc,"element")return
bc.getPropertyState(db,cc,...)end
cb["set"..ac.."State"]=function(bc,cc,dc,...)ca(1,bc,"element")
bc.setPropertyState(db,cc,dc,...)return bc end end
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
function _b:__init()self._values={}self._observers={}self._states={}
self._modifiedProperties={}
self.set=function(bc,cc,...)local dc=self._values[bc]local _d=self._properties[bc]
if
(_d~=nil)then if(_d.setter)then cc=_d.setter(self,cc,...)end;if _d.canTriggerRender then
self:updateRender()end;self._values[bc]=bb(self,bc,cc,_d)
self._modifiedProperties[bc]=true
if dc~=cc and self._observers[bc]then for ad,bd in
ipairs(self._observers[bc])do bd(self,cc,dc)end end end end
self.get=function(bc,...)local cc=self._values[bc]local dc=self._properties[bc]
if
(dc==nil)then da.error("Property not found: "..bc)return end;if type(cc)=="function"and dc.type~="function"then
cc=cc(self)end;return
dc.getter and dc.getter(self,cc,...)or cc end
self.setPropertyState=function(bc,cc,dc,...)local _d=self._properties[bc]
if(_d~=nil)then if(_d.setter)then
dc=_d.setter(self,dc,...)end;dc=bb(self,bc,dc,_d)if
not self._states[cc]then self._states[cc]={}end
self._states[cc][bc]=dc;local ad=self._values.currentState
if ad==cc then if _d.canTriggerRender then
self:updateRender()end
if self._observers[bc]then for bd,cd in
ipairs(self._observers[bc])do cd(self,dc,nil)end end end end end
self.getPropertyState=function(bc,cc,...)local dc=self._states and self._states[cc]and
self._states[cc][bc]local _d=
dc~=nil and dc or self._values[bc]
local ad=self._properties[bc]if(ad==nil)then da.error("Property not found: "..bc)
return end;if
type(_d)=="function"and ad.type~="function"then _d=_d(self)end;return
ad.getter and ad.getter(self,_d,...)or _d end
self.getResolved=function(bc,...)local cc=self:getActiveStates()local dc=nil;for ad,bd in ipairs(cc)do
if
self._states and
self._states[bd.name]and self._states[bd.name][bc]~=nil then dc=self._states[bd.name][bc]break end end;if dc==
nil then dc=self._values[bc]end
local _d=self._properties[bc]if(_d==nil)then da.error("Property not found: "..bc)
return end;if
type(dc)=="function"and _d.type~="function"then dc=dc(self)end;return
_d.getter and _d.getter(self,dc,...)or dc end;local cb={}local db=getmetatable(self).__index
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
if type(_c)=="function"then _c=_c(self)end;self._modifiedProperties[cb]=true;self._values[cb]=db
local ac=
type(db)=="function"and db(self)or db
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
local db=cb:sub(1,1):upper()..cb:sub(2)self["get"..db]=nil;self["set"..db]=nil;self["get"..db.."State"]=
nil;self["set"..db.."State"]=nil;return self end
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
"Error in event callback for '"..aca.."': "..tostring(_da))end end end end
function __a.requireElements(aca,bca)if type(aca)=="string"then aca={aca}end
dd(1,aca,"table")if bca~=nil then dd(2,bca,"boolean")end;local cca={}local dca={}for _da,ada in
ipairs(aca)do
if not ad.hasElement(ada)then table.insert(cca,ada)elseif not
ad.isElementLoaded(ada)then table.insert(dca,ada)end end
if
#dca>0 then
for _da,ada in ipairs(dca)do local bda,cda=pcall(ad.loadElement,ada)
if not bda then
__a.LOGGER.warn(
"Failed to load element "..ada..": "..tostring(cda))table.insert(cca,ada)end end end
if#cca>0 then
if bca then local _da={}for ada,bda in ipairs(cca)do local cda=ad.tryAutoLoad(bda)if not cda then
table.insert(_da,bda)end end
if
#_da>0 then
local ada="Missing required elements: "..table.concat(_da,", ")
ada=ada.."\n\nThese elements could not be auto-loaded."
ada=ada.."\nPlease install them or register remote sources."bd.error(ada)end else
local _da="Missing required elements: "..table.concat(cca,", ")_da=_da.."\n\nSuggestions:"
_da=_da.."\n  • Use basalt.requireElements({...}, true) to auto-load"
_da=_da.."\n  • Register remote sources with elementManager.registerRemoteSource()"
_da=_da.."\n  • Register disk mounts with elementManager.registerDiskMount()"bd.error(_da)end end
__a.LOGGER.info("All required elements are available: "..table.concat(aca,", "))return true end
function __a.loadManifest(aca)dd(1,aca,"string")
if not fs.exists(aca)then bd.error(
"Manifest file not found: "..aca)end;local bca;local cca,dca=pcall(dofile,aca)if not cca then
bd.error("Failed to load manifest: "..tostring(dca))end;bca=dca;if type(bca)~="table"then
bd.error("Manifest must return a table")end
if bca.config then
ad.configure(bca.config)__a.LOGGER.debug("Applied manifest config")end;if bca.diskMounts then
for _da,ada in ipairs(bca.diskMounts)do ad.registerDiskMount(ada)end end;if bca.remoteSources then
for _da,ada in
pairs(bca.remoteSources)do ad.registerRemoteSource(_da,ada)end end;if bca.requiredElements then local _da=
bca.autoLoadMissing~=false
__a.requireElements(bca.requiredElements,_da)end
if bca.optionalElements then for _da,ada in
ipairs(bca.optionalElements)do pcall(ad.loadElement,ada)end end
if bca.preloadElements then ad.preloadElements(bca.preloadElements)end
__a.LOGGER.info("Manifest loaded successfully: ".. (bca.name or aca))return bca end
function __a.install(aca,bca)dd(1,aca,"string")
if bca~=nil then dd(2,bca,"string")end
if ad.hasElement(aca)and ad.isElementLoaded(aca)then return true end
if bca then
if bca:match("^https?://")then ad.registerRemoteSource(aca,bca)else if not
fs.exists(bca)then
bd.error("Source file not found: "..bca)end end end;local cca=ad.tryAutoLoad(aca)if cca then return true else return false end end
function __a.configure(aca)dd(1,aca,"table")ad.configure(aca)end;return __a end
project["layoutManager.lua"] = function(...) local b={}b._cache={}
function b.load(c)if b._cache[c]then return b._cache[c]end
local d,_a=pcall(require,c)if not d then
error("Failed to load layout: "..c.."\n".._a)end;if type(_a)~="table"then
error("Layout must return a table: "..c)end;if type(_a.calculate)~="function"then
error(
"Layout must have a calculate() function: "..c)end;b._cache[c]=_a;return _a end
function b.apply(c,d)local _a=b.load(d)local aa={layout=_a,container=c,options={}}
_a.calculate(aa)b._applyPositions(aa)return aa end
function b._applyPositions(c)if not c._positions then return end
for d,_a in pairs(c._positions)do
if
not d._destroyed then d.set("x",_a.x)d.set("y",_a.y)
d.set("width",_a.width)d.set("height",_a.height)
d._layoutValues={x=_a.x,y=_a.y,width=_a.width,height=_a.height}end end end
function b._wasChangedByUser(c)if not c._layoutValues then return false end
local d=c.get("x")local _a=c.get("y")local aa=c.get("width")local ba=c.get("height")
return d~=
c._layoutValues.x or _a~=c._layoutValues.y or aa~=
c._layoutValues.width or
ba~=c._layoutValues.height end
function b.update(c)
if c and c.layout and c.layout.calculate then
if c._positions then for d,_a in pairs(c._positions)do
if not
d._destroyed then d._userModified=b._wasChangedByUser(d)end end end;c.layout.calculate(c)b._applyPositions(c)end end
function b.destroy(c)if c and c.layout and c.layout.destroy then
c.layout.destroy(c)end;if c then c._positions=nil end end;return b end
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
project["libraries/collectionentry.lua"] = function(...) local b={}
b.__index=function(c,d)local _a=rawget(b,d)if _a then return _a end;if c._data[d]~=nil then return
c._data[d]end;local aa=c._parent[d]if aa then return aa end
return nil end
function b.new(c,d)local _a={_parent=c,_data=d}return setmetatable(_a,b)end
function b:_findIndex()for c,d in ipairs(self._parent:getItems())do
if d==self then return c end end;return nil end;function b:setText(c)self._data.text=c
self._parent:updateRender()return self end;function b:getText()
return self._data.text end
function b:moveUp(c)local d=self._parent:getItems()
local _a=self:_findIndex()if not _a then return self end;c=c or 1;local aa=math.max(1,_a-c)if _a~=aa then
table.remove(d,_a)table.insert(d,aa,self)
self._parent:updateRender()end;return self end
function b:moveDown(c)local d=self._parent:getItems()
local _a=self:_findIndex()if not _a then return self end;c=c or 1;local aa=math.min(#d,_a+c)if _a~=aa then
table.remove(d,_a)table.insert(d,aa,self)
self._parent:updateRender()end;return self end
function b:moveToTop()local c=self._parent:getItems()
local d=self:_findIndex()if not d or d==1 then return self end;table.remove(c,d)
table.insert(c,1,self)self._parent:updateRender()return self end
function b:moveToBottom()local c=self._parent:getItems()
local d=self:_findIndex()if not d or d==#c then return self end;table.remove(c,d)
table.insert(c,self)self._parent:updateRender()return self end;function b:getIndex()return self:_findIndex()end
function b:swapWith(c)
local d=self._parent:getItems()local _a=self:getIndex()local aa=c:getIndex()
if _a and aa and _a~=aa then
d[_a],d[aa]=d[aa],d[_a]self._parent:updateRender()end;return self end
function b:remove()if self._parent and self._parent.removeItem then
self._parent:removeItem(self)return true end;return false end
function b:select()if self._parent and self._parent.selectItem then
self._parent:selectItem(self)end;return self end
function b:unselect()if self._parent and self._parent.unselectItem then
self._parent:unselectItem(self)end end
function b:isSelected()
if self._parent and self._parent.getSelectedItem then return
self._parent:getSelectedItem()==self end;return false end;return b end
project["libraries/expect.lua"] = function(...) local c=require("errorManager")
local function d(_a,aa,ba)local ca=type(aa)
if ba=="element"then if ca=="table"and
aa.get("type")~=nil then return true end end
if ba=="color"then if ca=="number"then return true end;if
ca=="string"and colors[aa]then return true end end;if ca~=ba then c.header="Basalt Type Error"
c.error(string.format("Bad argument #%d: expected %s, got %s",_a,ba,ca))end;return true end;return d end
return project["main.lua"]()