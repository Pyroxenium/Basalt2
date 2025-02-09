local minified = true
local project = {}
local baseRequire = require
require = function(path) return project[path] or baseRequire(path) end
project["render.lua"] = function(...) local d={}d.__index=d;local _a=require("libraries/colorHex")
local aa=require("log")
function d.new(ba)local ca=setmetatable({},d)ca.terminal=ba
ca.width,ca.height=ba.getSize()ca.buffer={text={},fg={},bg={},changed={}}
for y=1,ca.height do
ca.buffer.text[y]=string.rep(" ",ca.width)ca.buffer.fg[y]=string.rep("0",ca.width)
ca.buffer.bg[y]=string.rep("f",ca.width)ca.buffer.changed[y]=false end;return ca end
function d:blit(ba,ca,da,_b,ab)if ca<1 or ca>self.height then return self end;if(#da~=#_b or
#da~=#ab)then
error("Text, fg, and bg must be the same length")end
self.buffer.text[ca]=self.buffer.text[ca]:sub(1,
ba-1)..da..
self.buffer.text[ca]:sub(ba+#da)
self.buffer.fg[ca]=
self.buffer.fg[ca]:sub(1,ba-1).._b..self.buffer.fg[ca]:sub(ba+#_b)
self.buffer.bg[ca]=
self.buffer.bg[ca]:sub(1,ba-1)..ab..self.buffer.bg[ca]:sub(ba+#ab)self.buffer.changed[ca]=true;return self end
function d:multiBlit(ba,ca,da,_b,ab,bb,cb)if ca<1 or ca>self.height then return self end;if(
#ab~=#bb or#ab~=#cb)then
error("Text, fg, and bg must be the same length")end;ab=ab:rep(da)
bb=bb:rep(da)cb=cb:rep(da)
for dy=0,_b-1 do local db=ca+dy
if db>=1 and db<=self.height then
self.buffer.text[db]=self.buffer.text[db]:sub(1,
ba-1)..ab..
self.buffer.text[db]:sub(ba+#ab)
self.buffer.fg[db]=
self.buffer.fg[db]:sub(1,ba-1)..bb..self.buffer.fg[db]:sub(ba+#bb)
self.buffer.bg[db]=
self.buffer.bg[db]:sub(1,ba-1)..cb..self.buffer.bg[db]:sub(ba+#cb)self.buffer.changed[db]=true end end;return self end
function d:textFg(ba,ca,da,_b)if ca<1 or ca>self.height then return self end
_b=_a[_b]or"0"
self.buffer.text[ca]=
self.buffer.text[ca]:sub(1,ba-1)..
da..self.buffer.text[ca]:sub(ba+#da)
self.buffer.fg[ca]=
self.buffer.fg[ca]:sub(1,ba-1)..
_b:rep(#da)..self.buffer.fg[ca]:sub(ba+#da)self.buffer.changed[ca]=true;return self end
function d:text(ba,ca,da)if ca<1 or ca>self.height then return self end
self.buffer.text[ca]=self.buffer.text[ca]:sub(1,
ba-1)..da..
self.buffer.text[ca]:sub(ba+#da)self.buffer.changed[ca]=true;return self end
function d:fg(ba,ca,da)if ca<1 or ca>self.height then return self end
self.buffer.fg[ca]=self.buffer.fg[ca]:sub(1,
ba-1)..da..
self.buffer.fg[ca]:sub(ba+#da)self.buffer.changed[ca]=true;return self end
function d:bg(ba,ca,da)if ca<1 or ca>self.height then return self end
self.buffer.bg[ca]=self.buffer.bg[ca]:sub(1,
ba-1)..da..
self.buffer.bg[ca]:sub(ba+#da)self.buffer.changed[ca]=true;return self end
function d:clear(ba)local ca=_a[ba]or"f"
for y=1,self.height do
self.buffer.text[y]=string.rep(" ",self.width)self.buffer.fg[y]=string.rep("0",self.width)
self.buffer.bg[y]=string.rep(ca,self.width)self.buffer.changed[y]=true end;return self end
function d:render()
for y=1,self.height do
if self.buffer.changed[y]then
self.terminal.setCursorPos(1,y)
self.terminal.blit(self.buffer.text[y],self.buffer.fg[y],self.buffer.bg[y])self.buffer.changed[y]=false end end;return self end
function d:clearArea(ba,ca,da,_b,ab)local bb=_a[ab]or"f"
for dy=0,_b-1 do local cb=ca+dy;if
cb>=1 and cb<=self.height then local db=string.rep(" ",da)local _c=string.rep(bb,da)
self:blit(ba,cb,db,"0",bb)end end;return self end;function d:getSize()return self.width,self.height end;return d end
project["elementManager.lua"] = function(...) local ba=table.pack(...)
local ca=fs.getDir(ba[2]or"basalt")if(ca==nil)then
error("Unable to find directory "..ba[2].." please report this bug to our discord.")end
local da=require("log")local _b={}_b._elements={}_b._plugins={}
local ab=fs.combine(ca,"elements")local bb=fs.combine(ca,"plugins")
da.info("Loading elements from "..ab)
if fs.exists(ab)then
for cb,db in ipairs(fs.list(ab))do local _c=db:match("(.+).lua")if _c then da.debug(
"Found element: ".._c)
_b._elements[_c]={class=nil,plugins={},loaded=false}end end end
function _b.extendMethod(cb,db,_c,ac)if not ac then cb[db]=_c;return end
cb[db]=function(bc,...)if _c.before then
_c.before(bc,...)end;local cc;if _c.override then
cc={_c.override(bc,ac,...)}else cc={ac(bc,...)}end;if _c.after then
_c.after(bc,...)end;return table.unpack(cc)end end
function _b.loadPlugin(cb)local db=require("plugins/"..cb)
for _c,ac in pairs(db)do
local bc=_b._elements[_c]
if bc then if ac.properties then bc.class.initialize(_c.."Plugin")
for cc,dc in
pairs(ac.properties)do bc.class.registerProperty(cc,dc)end end;if ac.methods then
for cc,dc in
pairs(ac.methods)do _b.extendMethod(bc.class,cc,dc,bc.class[cc])end end end end end
function _b.loadElement(cb)
if not _b._elements[cb].loaded then
local db=require("elements/"..cb)_b._elements[cb]={class=db,plugins=db.plugins,loaded=true}da.debug(
"Loaded element: "..cb)if db.requires then
for _c,ac in pairs(db.requires)do end end end end
function _b.registerPlugin(cb,db)if not db.provides then
error("Plugin must specify what it provides")end;_b._plugins[cb]=db end
function _b.getElement(cb)if not _b._elements[cb].loaded then
_b.loadElement(cb)end;return _b._elements[cb].class end;function _b.getElementList()return _b._elements end
function _b.generateId()
return
string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff),
math.random(0,0x0fff)+0x4000,math.random(0,0x3fff)+0x8000,math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff))end;return _b end
project["init.lua"] = function(...) local da={...}local _b=da[1]or"basalt"local ab=package.path
local bb="path;/path/?.lua;/path/?/init.lua;"local cb=bb:gsub("path",_b)package.path=cb.."rom/?"
local function db(bc)
local cc=require("errorManager")cc.header="Basalt Loading Error"cc.error(bc)end;local _c,ac=pcall(require,"main")if not _c then db(ac)else return ac end end
project["elements/BaseFrame.lua"] = function(...) local d=require("elements/Container")
local _a=require("render")local aa=setmetatable({},d)aa.__index=aa
function aa.new(ba,ca)
local da=setmetatable({},aa):__init()da:init(ba,ca)da.terminal=term.current()
da._render=_a.new(da.terminal)da._renderUpdate=true;local _b,ab=da.terminal.getSize()
da.set("width",_b)da.set("height",ab)
da.set("background",colors.red)da.set("type","BaseFrame")return da end;function aa:multiBlit(ba,ca,da,_b,ab,bb,cb)
self._render:multiBlit(ba,ca,da,_b,ab,bb,cb)end;function aa:textFg(ba,ca,da,_b)
self._render:textFg(ba,ca,da,_b)end
function aa:render()if(self._renderUpdate)then d.render(self)
self._render:render()self._renderUpdate=false end end;return aa end
project["elements/Button.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/utils").getCenteredPosition;local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"text",{default="Button",type="string"})aa.listenTo(aa,"mouse_click")
function aa.new(ba,ca)
local da=setmetatable({},aa):__init()da:init(ba,ca)da.set("type","Button")
da.set("width",10)da.set("height",3)da.set("z",5)return da end
function aa:render()d.render(self)local ba=self.get("text")
local ca,da=_a(ba,self.get("width"),self.get("height"))
self:textFg(ca,da,ba,self.get("foreground"))end;return aa end
project["elements/VisualElement.lua"] = function(...) local d=require("elements/BaseElement")
local _a=setmetatable({},d)_a.__index=_a;local aa=require("libraries/colorHex")
d.defineProperty(_a,"x",{default=1,type="number",canTriggerRender=true})
d.defineProperty(_a,"y",{default=1,type="number",canTriggerRender=true})
d.defineProperty(_a,"z",{default=1,type="number",canTriggerRender=true,setter=function(ba,ca)
ba.basalt.LOGGER.debug("Setting z to "..ca)if ba.parent then ba.parent:sortChildren()end;return ca end})
d.defineProperty(_a,"width",{default=1,type="number",canTriggerRender=true})
d.defineProperty(_a,"height",{default=1,type="number",canTriggerRender=true})
d.defineProperty(_a,"background",{default=colors.black,type="number",canTriggerRender=true})
d.defineProperty(_a,"foreground",{default=colors.white,type="number",canTriggerRender=true})
d.defineProperty(_a,"clicked",{default=false,type="boolean"})
function _a.new(ba,ca)local da=setmetatable({},_a):__init()
da:init(ba,ca)da.set("type","VisualElement")return da end;function _a:multiBlit(ba,ca,da,_b,ab,bb,cb)ba=ba+self.get("x")-1;ca=ca+self.get("y")-
1
self.parent:multiBlit(ba,ca,da,_b,ab,bb,cb)end;function _a:textFg(ba,ca,da,_b)ba=ba+
self.get("x")-1;ca=ca+self.get("y")-1
self.parent:textFg(ba,ca,da,_b)end
function _a:isInBounds(ba,ca)
local da,_b=self.get("x"),self.get("y")local ab,bb=self.get("width"),self.get("height")return
ba>=da and ba<=
da+ab-1 and ca>=_b and ca<=_b+bb-1 end
function _a:mouse_click(ba,ca,da)if self:isInBounds(ca,da)then self.set("clicked",true)
self:fireEvent("mouse_click",ba,ca,da)return true end end
function _a:mouse_up(ba,ca,da)if self:isInBounds(ca,da)then self.set("clicked",false)
self:fireEvent("mouse_up",ba,ca,da)return true end
self:fireEvent("mouse_release",ba,ca,da)end;function _a:mouse_release()self.set("clicked",false)end
function _a:handleEvent(ba,...)if
(self[ba])then return self[ba](self,...)end end
function _a:getAbsolutePosition(ba,ca)if(ba==nil)or(ca==nil)then
ba,ca=self.get("x"),self.get("y")end;local da=self.parent
while da do
local _b,ab=da.get("x"),da.get("y")ba=ba+_b-1;ca=ca+ab-1;da=da.parent end;return ba,ca end
function _a:getRelativePosition(ba,ca)if(ba==nil)or(ca==nil)then
ba,ca=self.get("x"),self.get("y")end;local da,_b=1,1;if self.parent then
da,_b=self.parent:getRelativePosition()end;local ab=self.get("x")
local bb=self.get("y")return ba- (ab-1)- (da-1),ca- (bb-1)- (_b-1)end
function _a:render()local ba,ca=self.get("width"),self.get("height")
self:multiBlit(1,1,ba,ca," ",aa[self.get("foreground")],aa[self.get("background")])end;return _a end
project["elements/BaseElement.lua"] = function(...) local c=require("propertySystem")local d=setmetatable({},c)
d.__index=d;d._events={}
d.defineProperty(d,"type",{default="BaseElement",type="string"})
d.defineProperty(d,"eventCallbacks",{default={},type="table"})
function d.new(_a,aa)local ba=setmetatable({},d):__init()
ba:init(_a,aa)ba.set("type","BaseElement")return ba end
function d:init(_a,aa)self.id=_a;self.basalt=aa;self._registeredEvents={}
if d._events then
for ba in
pairs(d._events)do self._registeredEvents[ba]=true
local ca="on"..
ba:gsub("_(%l)",function(da)return da:upper()end):gsub("^%l",string.upper)
self[ca]=function(da,...)da:registerCallback(ba,...)end end end;return self end;function d.listenTo(_a,aa)if not _a._events then _a._events={}end
_a._events[aa]=true end
function d:listenEvent(_a,aa)aa=aa~=false
if aa~= (
self._registeredEvents[_a]or false)then
if aa then
self._registeredEvents[_a]=true
if self.parent then self.parent:registerChildEvent(self,_a)end else self._registeredEvents[_a]=nil;if self.parent then
self.parent:unregisterChildEvent(self,_a)end end end;return self end
function d:registerCallback(_a,aa)if not self._registeredEvents[_a]then
self:listenEvent(_a,true)end
if
not self._values.eventCallbacks[_a]then self._values.eventCallbacks[_a]={}end
table.insert(self._values.eventCallbacks[_a],aa)return self end
function d:fireEvent(_a,...)
if self._values.eventCallbacks[_a]then for aa,ba in
ipairs(self._values.eventCallbacks[_a])do local ca=ba(self,...)return ca end end;return self end
function d:updateRender()if(self.parent)then self.parent:updateRender()else
self._renderUpdate=true end end;return d end
project["elements/Container.lua"] = function(...) local aa=require("elements/VisualElement")
local ba=require("elementManager")local ca=require("libraries/expect")local da=math.max
local _b=setmetatable({},aa)_b.__index=_b
_b.defineProperty(_b,"children",{default={},type="table"})
_b.defineProperty(_b,"childrenEvents",{default={},type="table"})
_b.defineProperty(_b,"eventListenerCount",{default={},type="table"})
for ab,bb in pairs(ba:getElementList())do
local cb=ab:sub(1,1):upper()..ab:sub(2)
_b["add"..cb]=function(db,...)ca(1,db,"table")
local _c=db.basalt.create(ab,...)
db.basalt.LOGGER.debug(cb.." created with ID: ".._c.id)db:addChild(_c)return _c end end
function _b.new(ab,bb)local cb=setmetatable({},_b):__init()
cb:init(ab,bb)cb.set("type","Container")return cb end
function _b:addChild(ab)
if ab==self then error("Cannot add container to itself")end;local bb=ab.get("z")local cb=1;for db,_c in ipairs(self._values.children)do if
_c.get("z")>bb then break end;cb=db+1 end
table.insert(self._values.children,cb,ab)ab.parent=self;self:registerChildrenEvents(ab)return self end;function _b:sortChildren()
table.sort(self._values.children,function(ab,bb)
return ab.get("z")<bb.get("z")end)end
function _b:sortChildrenEvents(ab)if
self._values.childrenEvents[ab]then
table.sort(self._values.childrenEvents[ab],function(bb,cb)return
bb.get("z")>cb.get("z")end)end end
function _b:registerChildrenEvents(ab)for bb in pairs(ab._registeredEvents)do
self:registerChildEvent(ab,bb)end end
function _b:registerChildEvent(ab,bb)
if not self._values.childrenEvents[bb]then
self._values.childrenEvents[bb]={}self._values.eventListenerCount[bb]=0;if self.parent then
self.parent:registerChildEvent(self,bb)end end;for _c,ac in ipairs(self._values.childrenEvents[bb])do
if ac==ab then return end end;local cb=ab.get("z")local db=1
for _c,ac in
ipairs(self._values.childrenEvents[bb])do if ac.get("z")<cb then break end;db=_c+1 end
table.insert(self._values.childrenEvents[bb],db,ab)self._values.eventListenerCount[bb]=
self._values.eventListenerCount[bb]+1 end
function _b:removeChildrenEvents(ab)for bb in pairs(ab._registeredEvents)do
self:unregisterChildEvent(ab,bb)end end
function _b:unregisterChildEvent(ab,bb)
if self._values.childrenEvents[bb]then
for cb,db in
ipairs(self._values.childrenEvents[bb])do
if db==ab then
table.remove(self._values.childrenEvents[bb],cb)self._values.eventListenerCount[bb]=
self._values.eventListenerCount[bb]-1
if
self._values.eventListenerCount[bb]<=0 then
self._values.childrenEvents[bb]=nil;self._values.eventListenerCount[bb]=nil;if self.parent then
self.parent:unregisterChildEvent(self,bb)end end;break end end end end
function _b:removeChild(ab)
for bb,cb in ipairs(self.children)do if cb==ab then
table.remove(self._values.children,bb)ab.parent=nil;break end end;return self end
function _b:handleEvent(ab,...)
if(aa.handleEvent(self,ab,...))then local bb={...}if ab:find("mouse_")then local cb,db,_c=...
local ac,bc=self:getRelativePosition(db,_c)bb={cb,ac,bc}end
if
self._values.childrenEvents[ab]then
for cb,db in ipairs(self._values.childrenEvents[ab])do if
(db:handleEvent(ab,table.unpack(bb)))then return true end end end end end
function _b:multiBlit(ab,bb,cb,db,_c,ac,bc)local cc,dc=self.get("width"),self.get("height")cb=ab<1 and math.min(
cb+ab-1,cc)or
math.min(cb,math.max(0,cc-ab+1))db=bb<1 and math.min(
db+bb-1,dc)or
math.min(db,math.max(0,dc-bb+1))if
cb<=0 or db<=0 then return end
aa.multiBlit(self,math.max(1,ab),math.max(1,bb),cb,db,_c,ac,bc)end
function _b:textFg(ab,bb,cb,db)local _c,ac=self.get("width"),self.get("height")if
bb<1 or bb>ac then return end;local bc=ab<1 and(2 -ab)or 1
local cc=math.min(#cb-bc+1,
_c-math.max(1,ab)+1)if cc<=0 then return end
aa.textFg(self,math.max(1,ab),math.max(1,bb),cb:sub(bc,bc+cc-1),db)end
function _b:render()aa.render(self)
for ab,bb in ipairs(self._values.children)do if bb==self then
self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")return end;bb:render()end end;return _b end
project["elements/Frame.lua"] = function(...) local c=require("elements/Container")
local d=setmetatable({},c)d.__index=d
function d.new(_a,aa)local ba=setmetatable({},d):__init()
ba:init(_a,aa)ba.set("width",12)ba.set("height",6)
ba.set("background",colors.blue)ba.set("type","Frame")ba.set("z",10)return ba end;return d end
project["errorManager.lua"] = function(...) local d=require("log")
local _a={tracebackEnabled=true,header="Basalt Error"}local function aa(ba,ca)term.setTextColor(ca)print(ba)
term.setTextColor(colors.white)end
function _a.error(ba)
term.setBackgroundColor(colors.black)term.clear()term.setCursorPos(1,1)
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
d.error(ba)error()end;return _a end
project["libraries/utils.lua"] = function(...) local d,_a=math.floor,string.len;local aa={}
function aa.getCenteredPosition(ba,ca,da)local _b=_a(ba)local ab=d(
(ca-_b+1)/2 +0.5)local bb=d(da/2 +0.5)return ab,bb end
function aa.deepCopy(ba)if type(ba)~="table"then return ba end;local ca={}for da,_b in pairs(ba)do
ca[aa.deepCopy(da)]=aa.deepCopy(_b)end;return ca end;return aa end
project["libraries/expect.lua"] = function(...) local c=require("errorManager")
local function d(_a,aa,ba)local ca=type(aa)
if ba=="element"then if ca=="table"and
aa.get("type")~=nil then return true end end
if ba=="color"then
if ca=="number"and aa>=1 and aa<=32768 then return true end;if ca=="string"and colors[aa]then return true end end;if ca~=ba then c.header="Basalt Type Error"
c.error(string.format("Bad argument #%d: expected %s, got %s",_a,ba,ca))end;return true end;return d end
project["libraries/colorHex.lua"] = function(...) local b={}for i=0,15 do b[2 ^i]=("%x"):format(i)
b[("%x"):format(i)]=2 ^i end;return b end
project["log.lua"] = function(...) local aa={}aa._logs={}aa._enabled=true;aa._logToFile=true
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
function aa.warn(...)_b(aa.LEVEL.WARN,...)end;function aa.error(...)_b(aa.LEVEL.ERROR,...)end
aa.info("Logger initialized")return aa end
project["main.lua"] = function(...) local da=require("elementManager")
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
ab.error(_d)end end end;bb.autoUpdate=bb.run;return bb end
project["propertySystem.lua"] = function(...) local d=require("libraries/utils").deepCopy
local _a=require("libraries/expect")local aa={}aa.__index=aa;aa._properties={}
function aa.defineProperty(ba,ca,da)if
not rawget(ba,'_properties')then ba._properties={}end
ba._properties[ca]={type=da.type,default=da.default,canTriggerRender=da.canTriggerRender,getter=da.getter,setter=da.setter}local _b=ca:sub(1,1):upper()..ca:sub(2)
ba[
"get".._b]=function(ab)_a(1,ab,"element")local bb=ab._values[ca]return da.getter and
da.getter(bb)or bb end
ba["set".._b]=function(ab,bb)_a(1,ab,"element")_a(2,bb,da.type)if da.setter then
bb=da.setter(ab,bb)end;ab:_updateProperty(ca,bb)return ab end end
function aa:__init()self._values={}self._observers={}
self.set=function(ab,bb)
local cb=self._values[ab]self._values[ab]=bb;if(self._properties[ab].setter)then
bb=self._properties[ab].setter(self,bb)end;if
cb~=bb and self._observers[ab]then
for db,_c in ipairs(self._observers[ab])do _c(self,bb,cb)end end end
self.get=function(ab)return self._values[ab]end;local ba={}local ca=getmetatable(self).__index
while ca do if
rawget(ca,'_properties')then
for ab,bb in pairs(ca._properties)do if not ba[ab]then ba[ab]=bb end end end;ca=getmetatable(ca)and
rawget(getmetatable(ca),'__index')end;self._properties=ba;local da=getmetatable(self)local _b=da.__index
setmetatable(self,{__index=function(ab,bb)if
self._properties[bb]then return self._values[bb]end;if
type(_b)=="function"then return _b(ab,bb)else return _b[bb]end end,__newindex=function(ab,bb,cb)
if
self._properties[bb]then if self._properties[bb].setter then
cb=self._properties[bb].setter(self,cb)end
self:_updateProperty(bb,cb)else rawset(ab,bb,cb)end end,__tostring=function(ab)return
string.format("Object: %s (id: %s)",ab._values.type,ab.id)end})
for ab,bb in pairs(ba)do if self._values[ab]==nil then
if type(bb.default)=="table"then
self._values[ab]=d(bb.default)else self._values[ab]=bb.default end end end;return self end
function aa:_updateProperty(ba,ca)local da=self._values[ba]
if da~=ca then self._values[ba]=ca;if
self._properties[ba].canTriggerRender then self:updateRender()end;if
self._observers[ba]then
for _b,ab in ipairs(self._observers[ba])do ab(self,ca,da)end end end end
function aa:observe(ba,ca)
self._observers[ba]=self._observers[ba]or{}table.insert(self._observers[ba],ca)return self end;return aa end
return project["main.lua"]