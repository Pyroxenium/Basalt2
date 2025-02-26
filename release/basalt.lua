local minified = true
local minified_elementDirectory = {}
local minified_pluginDirectory = {}
local project = {}
local loadedProject = {}
local baseRequire = require
require = function(path) if(project[path..".lua"])then if(loadedProject[path]==nil)then loadedProject[path] = project[path..".lua"]() end return loadedProject[path] end baseRequire(path) end
minified_elementDirectory["BigFont"] = {}
minified_elementDirectory["TextBox"] = {}
minified_elementDirectory["Container"] = {}
minified_elementDirectory["Image"] = {}
minified_elementDirectory["Flexbox"] = {}
minified_elementDirectory["VisualElement"] = {}
minified_elementDirectory["Scrollbar"] = {}
minified_elementDirectory["Tree"] = {}
minified_elementDirectory["Label"] = {}
minified_elementDirectory["Button"] = {}
minified_elementDirectory["Input"] = {}
minified_elementDirectory["BaseFrame"] = {}
minified_elementDirectory["BaseElement"] = {}
minified_elementDirectory["Frame"] = {}
minified_elementDirectory["Checkbox"] = {}
minified_elementDirectory["Program"] = {}
minified_elementDirectory["Table"] = {}
minified_elementDirectory["Slider"] = {}
minified_elementDirectory["ProgressBar"] = {}
minified_elementDirectory["List"] = {}
minified_elementDirectory["Dropdown"] = {}
minified_elementDirectory["Menu"] = {}
minified_pluginDirectory["xml"] = {}
minified_pluginDirectory["state"] = {}
minified_pluginDirectory["reactive"] = {}
minified_pluginDirectory["animation"] = {}
minified_pluginDirectory["debug"] = {}
minified_pluginDirectory["benchmark"] = {}
minified_pluginDirectory["theme"] = {}
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
project["propertySystem.lua"] = function(...) local ba=require("libraries/utils").deepCopy
local ca=require("libraries/expect")local da=require("errorManager")local _b={}_b.__index=_b
_b._properties={}local ab={}_b._setterHooks={}function _b.addSetterHook(cb)
table.insert(_b._setterHooks,cb)end
local function bb(cb,db,_c,ac)for bc,cc in ipairs(_b._setterHooks)do
local dc=cc(cb,db,_c,ac)if dc~=nil then _c=dc end end;return _c end
function _b.defineProperty(cb,db,_c)
if not rawget(cb,'_properties')then cb._properties={}end
cb._properties[db]={type=_c.type,default=_c.default,canTriggerRender=_c.canTriggerRender,getter=_c.getter,setter=_c.setter}local ac=db:sub(1,1):upper()..db:sub(2)
cb[
"get"..ac]=function(bc,...)ca(1,bc,"element")local cc=bc._values[db]
if type(cc)==
"function"and _c.type~="function"then cc=cc(bc)end
return _c.getter and _c.getter(bc,cc,...)or cc end
cb["set"..ac]=function(bc,cc,...)ca(1,bc,"element")cc=bb(bc,db,cc,_c)if
type(cc)~="function"then ca(2,cc,_c.type)end;if _c.setter then
cc=_c.setter(bc,cc,...)end;bc:_updateProperty(db,cc)return bc end end
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
local db=math.max(da.y+da.height,_b.y+_b.height)da.x=ab;da.y=bb;da.width=cb-ab;da.height=db-bb end
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
dc.bigfontText=_c(_d,dc.get("text"),dc.get("foreground"),dc.get("background"))return _d end})
function cc.new()local dc=setmetatable({},cc):__init()
dc.set("width",16)dc.set("height",3)dc.set("z",5)return dc end
function cc:init(dc,_d)bc.init(self,dc,_d)self.set("type","BigFont")end
function cc:render()bc.render(self)
if(self.bigfontText)then
local dc,_d=self.get("x"),self.get("y")
for i=1,#self.bigfontText[1]do
local ad=self.bigfontText[1][i]:sub(1,self.get("width"))
local bd=self.bigfontText[2][i]:sub(1,self.get("width"))
local cd=self.bigfontText[3][i]:sub(1,self.get("width"))self:blit(dc,_d+i-1,ad,bd,cd)end end end;return cc end
project["elements/TextBox.lua"] = function(...) local ca=require("elements/VisualElement")
local da=require("libraries/colorHex")local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"lines",{default={""},type="table",canTriggerRender=true})
_b.defineProperty(_b,"cursorX",{default=1,type="number"})
_b.defineProperty(_b,"cursorY",{default=1,type="number"})
_b.defineProperty(_b,"scrollX",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"scrollY",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"editable",{default=true,type="boolean"})
_b.defineProperty(_b,"syntaxPatterns",{default={},type="table"})
_b.defineProperty(_b,"cursorColor",{default=nil,type="number"})_b.defineEvent(_b,"mouse_click")
_b.defineEvent(_b,"key")_b.defineEvent(_b,"char")
_b.defineEvent(_b,"mouse_scroll")
function _b.new()local _c=setmetatable({},_b):__init()
_c.set("width",20)_c.set("height",10)return _c end;function _b:init(_c,ac)ca.init(self,_c,ac)self.set("type","TextBox")
return self end;function _b:addSyntaxPattern(_c,ac)
table.insert(self.get("syntaxPatterns"),{pattern=_c,color=ac})return self end
local function ab(_c,ac)
local bc=_c.get("lines")local cc=_c.get("cursorX")local dc=_c.get("cursorY")local _d=bc[dc]bc[dc]=_d:sub(1,
cc-1)..ac.._d:sub(cc)
_c.set("cursorX",cc+1)_c:updateViewport()_c:updateRender()end
local function bb(_c)local ac=_c.get("lines")local bc=_c.get("cursorX")
local cc=_c.get("cursorY")local dc=ac[cc]local _d=dc:sub(bc)ac[cc]=dc:sub(1,bc-1)
table.insert(ac,cc+1,_d)_c.set("cursorX",1)_c.set("cursorY",cc+1)
_c:updateViewport()_c:updateRender()end
local function cb(_c)local ac=_c.get("lines")local bc=_c.get("cursorX")
local cc=_c.get("cursorY")local dc=ac[cc]
if bc>1 then
ac[cc]=dc:sub(1,bc-2)..dc:sub(bc)_c.set("cursorX",bc-1)elseif cc>1 then local _d=ac[cc-1]
_c.set("cursorX",#_d+1)_c.set("cursorY",cc-1)ac[cc-1]=_d..dc
table.remove(ac,cc)end;_c:updateViewport()_c:updateRender()end
function _b:updateViewport()local _c=self.get("cursorX")
local ac=self.get("cursorY")local bc=self.get("scrollX")local cc=self.get("scrollY")
local dc=self.get("width")local _d=self.get("height")
if _c-bc>dc then
self.set("scrollX",_c-dc)elseif _c-bc<1 then self.set("scrollX",_c-1)end;if ac-cc>_d then self.set("scrollY",ac-_d)elseif ac-cc<1 then
self.set("scrollY",ac-1)end;return self end
function _b:char(_c)if
not self.get("editable")or not self.get("focused")then return false end;ab(self,_c)return true end
function _b:key(_c)if
not self.get("editable")or not self.get("focused")then return false end
local ac=self.get("lines")local bc=self.get("cursorX")local cc=self.get("cursorY")
if _c==
keys.enter then bb(self)elseif _c==keys.backspace then cb(self)elseif _c==keys.left then
if bc>1 then self.set("cursorX",
bc-1)elseif cc>1 then self.set("cursorY",cc-1)self.set("cursorX",
#ac[cc-1]+1)end elseif _c==keys.right then
if bc<=#ac[cc]then self.set("cursorX",bc+1)elseif cc<#ac then self.set("cursorY",
cc+1)self.set("cursorX",1)end elseif _c==keys.up and cc>1 then self.set("cursorY",cc-1)
self.set("cursorX",math.min(bc,
#ac[cc-1]+1))elseif _c==keys.down and cc<#ac then self.set("cursorY",cc+1)
self.set("cursorX",math.min(bc,
#ac[cc+1]+1))end;self:updateRender()self:updateViewport()return true end
function _b:mouse_scroll(_c,ac,bc)
if self:isInBounds(ac,bc)then local cc=self.get("scrollY")
local dc=self.get("height")local _d=self.get("lines")local ad=math.max(0,#_d-dc+2)local bd=math.max(0,math.min(ad,
cc+_c))
self.set("scrollY",bd)self:updateRender()return true end;return false end
function _b:mouse_click(_c,ac,bc)
if ca.mouse_click(self,_c,ac,bc)then
local cc,dc=self:getRelativePosition(ac,bc)local _d=self.get("scrollX")local ad=self.get("scrollY")
local bd=dc+ad;local cd=self.get("lines")if bd<=#cd then self.set("cursorY",bd)
self.set("cursorX",math.min(
cc+_d,#cd[bd]+1))end;self:updateRender()return
true end;return false end
function _b:setText(_c)local ac={}
if _c==""then ac={""}else for bc in(_c.."\n"):gmatch("([^\n]*)\n")do
table.insert(ac,bc)end end;self.set("lines",ac)return self end
function _b:getText()return table.concat(self.get("lines"),"\n")end
local function db(_c,ac)local bc=ac
local cc=string.rep(da[_c.get("foreground")],#bc)local dc=_c.get("syntaxPatterns")
for _d,ad in ipairs(dc)do local bd=1
while true do
local cd,dd=bc:find(ad.pattern,bd)if not cd then break end
cc=cc:sub(1,cd-1)..
string.rep(da[ad.color],dd-cd+1)..cc:sub(dd+1)bd=dd+1 end end;return bc,cc end
function _b:render()ca.render(self)local _c=self.get("lines")
local ac=self.get("scrollX")local bc=self.get("scrollY")local cc=self.get("width")
local dc=self.get("height")local _d=da[self.get("foreground")]
local ad=da[self.get("background")]
for y=1,dc do local bd=y+bc;local cd=_c[bd]or""local dd=cd:sub(ac+1,ac+cc)if#dd<cc then dd=dd..string.rep(" ",
cc-#dd)end
local __a,a_a=db(self,dd)self:blit(1,y,__a,a_a,string.rep(ad,#dd))end
if self.get("focused")then local bd=self.get("cursorX")-ac;local cd=
self.get("cursorY")-bc;if
bd>=1 and bd<=cc and cd>=1 and cd<=dc then
self:setCursor(bd,cd,true,self.get("cursorColor")or self.get("foreground"))end end end;return _b end
project["elements/Container.lua"] = function(...) local ca=require("elementManager")
local da=ca.getElement("VisualElement")local _b=require("libraries/expect")
local ab=require("libraries/utils").split;local bb=setmetatable({},da)bb.__index=bb
bb.defineProperty(bb,"children",{default={},type="table"})
bb.defineProperty(bb,"childrenSorted",{default=true,type="boolean"})
bb.defineProperty(bb,"childrenEventsSorted",{default=true,type="boolean"})
bb.defineProperty(bb,"childrenEvents",{default={},type="table"})
bb.defineProperty(bb,"eventListenerCount",{default={},type="table"})
bb.defineProperty(bb,"focusedChild",{default=nil,type="table",setter=function(_c,ac,bc)local cc=_c._values.focusedChild
if ac==cc then return ac end
if cc then
if cc:isType("Container")then cc.set("focusedChild",nil,true)end;cc.set("focused",false,true)end
if ac and not bc then ac.set("focused",true,true)if _c.parent then
_c.parent:setFocusedChild(_c)end end;return ac end})
bb.defineProperty(bb,"visibleChildren",{default={},type="table"})
bb.defineProperty(bb,"visibleChildrenEvents",{default={},type="table"})
bb.defineProperty(bb,"offsetX",{default=0,type="number",canTriggerRender=true,setter=function(_c,ac)_c.set("childrenSorted",false)
_c.set("childrenEventsSorted",false)return ac end})
bb.defineProperty(bb,"offsetY",{default=0,type="number",canTriggerRender=true,setter=function(_c,ac)_c.set("childrenSorted",false)
_c.set("childrenEventsSorted",false)return ac end})
for _c,ac in pairs(ca:getElementList())do
local bc=_c:sub(1,1):upper().._c:sub(2)
if bc~="BaseFrame"then
bb["add"..bc]=function(cc,...)_b(1,cc,"table")
local dc=cc.basalt.create(_c,...)cc:addChild(dc)dc:postInit()return dc end
bb["addDelayed"..bc]=function(cc,dc)_b(1,cc,"table")
local _d=cc.basalt.create(_c,dc,true,cc)return _d end end end
function bb.new()local _c=setmetatable({},bb):__init()return _c end
function bb:init(_c,ac)da.init(self,_c,ac)self.set("type","Container")end
function bb:isChildVisible(_c)if(_c.get("visible")==false)then return false end
local ac,bc=self.get("width"),self.get("height")local cc,dc=self.get("offsetX"),self.get("offsetY")
local _d,ad=_c.get("x"),_c.get("y")local bd,cd=_c.get("width"),_c.get("height")local dd;local __a;if
(_c.get("ignoreOffset"))then dd=_d;__a=ad else dd=_d-cc;__a=ad-dc end
return
(dd+bd>0)and(dd<=ac)and(__a+cd>0)and(__a<=bc)end
function bb:addChild(_c)
if _c==self then error("Cannot add container to itself")end;table.insert(self._values.children,_c)
_c.parent=self;self.set("childrenSorted",false)
self:registerChildrenEvents(_c)return self end
local function cb(_c,ac)local bc={}
for cc,dc in ipairs(ac)do if _c:isChildVisible(dc)and dc.get("visible")then
table.insert(bc,dc)end end
for i=2,#bc do local cc=bc[i]local dc=cc.get("z")local _d=i-1
while _d>0 do
local ad=bc[_d].get("z")if ad>dc then bc[_d+1]=bc[_d]_d=_d-1 else break end end;bc[_d+1]=cc end;return bc end
function bb:clear()self.set("children",{})
self.set("childrenEvents",{})self.set("visibleChildren",{})
self.set("visibleChildrenEvents",{})self.set("childrenSorted",true)
self.set("childrenEventsSorted",true)return self end
function bb:sortChildren()
self.set("visibleChildren",cb(self,self._values.children))self.set("childrenSorted",true)return self end
function bb:sortChildrenEvents(_c)if self._values.childrenEvents[_c]then
self._values.visibleChildrenEvents[_c]=cb(self,self._values.childrenEvents[_c])end
self.set("childrenEventsSorted",true)return self end
function bb:registerChildrenEvents(_c)if(_c._registeredEvents==nil)then return end
for ac in
pairs(_c._registeredEvents)do self:registerChildEvent(_c,ac)end;return self end
function bb:registerChildEvent(_c,ac)
if not self._values.childrenEvents[ac]then
self._values.childrenEvents[ac]={}self._values.eventListenerCount[ac]=0;if self.parent then
self.parent:registerChildEvent(self,ac)end end;for bc,cc in ipairs(self._values.childrenEvents[ac])do
if cc==_c then return self end end
self.set("childrenEventsSorted",false)
table.insert(self._values.childrenEvents[ac],_c)self._values.eventListenerCount[ac]=
self._values.eventListenerCount[ac]+1;return self end
function bb:removeChildrenEvents(_c)if(_c._registeredEvents==nil)then return self end
for ac in
pairs(_c._registeredEvents)do self:unregisterChildEvent(_c,ac)end;return self end
function bb:unregisterChildEvent(_c,ac)
if self._values.childrenEvents[ac]then
for bc,cc in
ipairs(self._values.childrenEvents[ac])do
if cc==_c then
table.remove(self._values.childrenEvents[ac],bc)self._values.eventListenerCount[ac]=
self._values.eventListenerCount[ac]-1
if
self._values.eventListenerCount[ac]<=0 then
self._values.childrenEvents[ac]=nil;self._values.eventListenerCount[ac]=nil;if self.parent then
self.parent:unregisterChildEvent(self,ac)end end;break end end end;return self end
function bb:removeChild(_c)
for ac,bc in ipairs(self._values.children)do if bc==_c then
table.remove(self._values.children,ac)_c.parent=nil;break end end;self:removeChildrenEvents(_c)return self end
function bb:getChild(_c)
if type(_c)=="string"then local ac=ab(_c,"/")
for bc,cc in
pairs(self._values.children)do if cc.get("name")==ac[1]then
if#ac==1 then return cc else if(cc:isType("Container"))then return
cc:find(table.concat(ac,"/",2))end end end end end;return nil end
local function db(_c,ac,...)local bc={...}
if ac:find("mouse_")then local cc,dc,_d=...
local ad,bd=_c.get("offsetX"),_c.get("offsetY")local cd,dd=_c:getRelativePosition(dc+ad,_d+bd)
bc={cc,cd,dd}end;return bc end
function bb:callChildrenEvent(_c,ac,...)local bc=_c and self.get("visibleChildrenEvents")or
self.get("childrenEvents")
if
bc[ac]then local cc=bc[ac]for i=#cc,1,-1 do local dc=cc[i]
if(dc:dispatchEvent(ac,...))then return true,dc end end end
if(bc["*"])then local cc=bc["*"]for i=#cc,1,-1 do local dc=cc[i]
if(dc:dispatchEvent(ac,...))then return true,dc end end end;return false end
function bb:handleEvent(_c,...)da.handleEvent(self,_c,...)local ac=db(self,_c,...)return
self:callChildrenEvent(false,_c,table.unpack(ac))end
function bb:mouse_click(_c,ac,bc)
if da.mouse_click(self,_c,ac,bc)then
local cc=db(self,"mouse_click",_c,ac,bc)
local dc,_d=self:callChildrenEvent(true,"mouse_click",table.unpack(cc))
if(dc)then self.set("focusedChild",_d)return true end;self.set("focusedChild",nil)return true end;return false end
function bb:mouse_up(_c,ac,bc)
if da.mouse_up(self,_c,ac,bc)then local cc=db(self,"mouse_up",_c,ac,bc)
local dc,_d=self:callChildrenEvent(true,"mouse_up",table.unpack(cc))if(dc)then return true end end;return false end
function bb:mouse_release(_c,ac,bc)da.mouse_release(self,_c,ac,bc)
local cc=db(self,"mouse_release",_c,ac,bc)
self:callChildrenEvent(false,"mouse_release",table.unpack(cc))end
function bb:mouse_move(_c,ac,bc)
if da.mouse_move(self,_c,ac,bc)then
local cc=db(self,"mouse_move",_c,ac,bc)
local dc,_d=self:callChildrenEvent(true,"mouse_move",table.unpack(cc))if(dc)then return true end end;return false end
function bb:mouse_drag(_c,ac,bc)
if da.mouse_drag(self,_c,ac,bc)then
local cc=db(self,"mouse_drag",_c,ac,bc)
local dc,_d=self:callChildrenEvent(true,"mouse_drag",table.unpack(cc))if(dc)then return true end end;return false end
function bb:mouse_scroll(_c,ac,bc)local cc=db(self,"mouse_scroll",_c,ac,bc)
local dc,_d=self:callChildrenEvent(true,"mouse_scroll",table.unpack(cc))if(dc)then return true end
if(da.mouse_scroll(self,_c,ac,bc))then return true end;return false end;function bb:key(_c)if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key",_c)end
return true end
function bb:char(_c)if
self.get("focusedChild")then
return self.get("focusedChild"):dispatchEvent("char",_c)end;return true end;function bb:key_up(_c)
if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key_up",_c)end;return true end
function bb:multiBlit(_c,ac,bc,cc,dc,_d,ad)
local bd,cd=self.get("width"),self.get("height")bc=_c<1 and math.min(bc+_c-1,bd)or
math.min(bc,math.max(0,bd-_c+1))cc=ac<1 and math.min(
cc+ac-1,cd)or
math.min(cc,math.max(0,cd-ac+1))if
bc<=0 or cc<=0 then return self end
da.multiBlit(self,math.max(1,_c),math.max(1,ac),bc,cc,dc,_d,ad)return self end
function bb:textFg(_c,ac,bc,cc)local dc,_d=self.get("width"),self.get("height")if
ac<1 or ac>_d then return self end;local ad=_c<1 and(2 -_c)or 1
local bd=math.min(#bc-
ad+1,dc-math.max(1,_c)+1)if bd<=0 then return self end
da.textFg(self,math.max(1,_c),math.max(1,ac),bc:sub(ad,ad+bd-1),cc)return self end
function bb:textBg(_c,ac,bc,cc)local dc,_d=self.get("width"),self.get("height")if
ac<1 or ac>_d then return self end;local ad=_c<1 and(2 -_c)or 1
local bd=math.min(#bc-
ad+1,dc-math.max(1,_c)+1)if bd<=0 then return self end
da.textBg(self,math.max(1,_c),math.max(1,ac),bc:sub(ad,ad+bd-1),cc)return self end
function bb:blit(_c,ac,bc,cc,dc)local _d,ad=self.get("width"),self.get("height")if
ac<1 or ac>ad then return self end;local bd=_c<1 and(2 -_c)or 1
local cd=math.min(#bc-
bd+1,_d-math.max(1,_c)+1)
local dd=math.min(#cc-bd+1,_d-math.max(1,_c)+1)
local __a=math.min(#dc-bd+1,_d-math.max(1,_c)+1)if cd<=0 then return self end;local a_a=bc:sub(bd,bd+cd-1)
local b_a=cc:sub(bd,bd+dd-1)local c_a=dc:sub(bd,bd+__a-1)
da.blit(self,math.max(1,_c),math.max(1,ac),a_a,b_a,c_a)return self end
function bb:render()da.render(self)if not self.get("childrenSorted")then
self:sortChildren()end
if
not self.get("childrenEventsSorted")then for _c in pairs(self._values.childrenEvents)do
self:sortChildrenEvents(_c)end end
for _c,ac in ipairs(self.get("visibleChildren"))do if ac==self then
self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")return end;ac:render()end end
function bb:destroy()
for _c,ac in ipairs(self._values.children)do ac:destroy()end;da.destroy(self)return self end;return bb end
project["elements/Image.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=require("libraries/colorHex")
local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"bimg",{default={{}},type="table",canTriggerRender=true})
_b.defineProperty(_b,"currentFrame",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"metadata",{default={},type="table"})
_b.defineProperty(_b,"autoResize",{default=false,type="boolean"})
_b.defineProperty(_b,"offsetX",{default=0,type="number",canTriggerRender=true})
_b.defineProperty(_b,"offsetY",{default=0,type="number",canTriggerRender=true})
_b.combineProperties(_b,"offset","offsetX","offsetY")
function _b.new()local cb=setmetatable({},_b):__init()
cb.set("width",12)cb.set("height",6)
cb.set("background",colors.black)cb.set("z",5)return cb end;function _b:init(cb,db)ca.init(self,cb,db)self.set("type","Image")
return self end
function _b:loadBimg(cb)
if type(cb)~="table"then return self end;local db={}local _c={}for ac,bc in pairs(cb)do
if type(ac)=="number"then db[ac]=bc else _c[ac]=bc end end;self.set("bimg",db)
self.set("metadata",_c)
if db[1]and db[1][1]then
self.set("width",#db[1][1][2])self.set("height",#db[1])end;return self end
function _b:resizeImage(cb,db)local _c=self.get("bimg")
for ac,bc in ipairs(_c)do local cc={}
for y=1,db do
local dc=string.rep(" ",cb)local _d=string.rep("f",cb)local ad=string.rep("0",cb)
if bc[y]and
bc[y][1]then local bd=bc[y][1]local cd=bc[y][2]local dd=bc[y][3]dc=(bd..
string.rep(" ",cb)):sub(1,cb)_d=(cd..
string.rep("f",cb)):sub(1,cb)ad=(dd..
string.rep("0",cb)):sub(1,cb)end;cc[y]={dc,_d,ad}end;_c[ac]=cc end;self:updateRender()return self end
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
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end;local ac=ab(self,db)
if
self.get("autoResize")then bb(self,cb+#_c-1,db)else local cc=#ac[db][1]
if cb>cc then return self end;_c=_c:sub(1,cc-cb+1)end;local bc=ac[db][1]
ac[db][1]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:setFg(cb,db,_c)if
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end;local ac=ab(self,db)
if
self.get("autoResize")then bb(self,cb+#_c-1,db)else local cc=#ac[db][2]
if cb>cc then return self end;_c=_c:sub(1,cc-cb+1)end;local bc=ac[db][2]
ac[db][2]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:setBg(cb,db,_c)if
type(_c)~="string"or#_c<1 or cb<1 or db<1 then return self end;local ac=ab(self,db)
if
self.get("autoResize")then bb(self,cb+#_c-1,db)else local cc=#ac[db][3]
if cb>cc then return self end;_c=_c:sub(1,cc-cb+1)end;local bc=ac[db][3]
ac[db][3]=bc:sub(1,cb-1).._c..bc:sub(cb+#_c)self:updateRender()return self end
function _b:setPixel(cb,db,_c,ac,bc)if _c then self:setText(cb,db,_c)end;if ac then
self:setFg(cb,db,ac)end;if bc then self:setBg(cb,db,bc)end;return self end
function _b:nextFrame()
if not self.get("metadata").animation then return self end;local cb=self.get("bimg")local db=self.get("currentFrame")
local _c=db+1;if _c>#cb then _c=1 end;self.set("currentFrame",_c)return self end
function _b:addFrame()local cb=self.get("bimg")local db={}
local _c=string.rep(" ",self.get("width"))local ac=string.rep("f",self.get("width"))
local bc=string.rep("0",self.get("width"))for y=1,self.get("height")do db[y]={_c,ac,bc}end
table.insert(cb,db)return self end
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
project["elements/Flexbox.lua"] = function(...) local da=require("elementManager")
local _b=da.getElement("Container")local ab=setmetatable({},_b)ab.__index=ab
ab.defineProperty(ab,"flexDirection",{default="row",type="string"})
ab.defineProperty(ab,"flexSpacing",{default=1,type="number"})
ab.defineProperty(ab,"flexJustifyContent",{default="flex-start",type="string",setter=function(bc,cc)if not cc:match("^flex%-")then
cc="flex-"..cc end;return cc end})
ab.defineProperty(ab,"flexWrap",{default=false,type="boolean"})
ab.defineProperty(ab,"flexUpdateLayout",{default=false,type="boolean"})
local bb={getHeight=function(bc)return 0 end,getWidth=function(bc)return 0 end,getZ=function(bc)return 1 end,getPosition=function(bc)return 0,0 end,getSize=function(bc)return 0,0 end,isType=function(bc)return
false end,getType=function(bc)return"lineBreak"end,getName=function(bc)return"lineBreak"end,setPosition=function(bc)
end,setParent=function(bc)end,setSize=function(bc)end,getFlexGrow=function(bc)return 0 end,getFlexShrink=function(bc)return 0 end,getFlexBasis=function(bc)return 0 end,init=function(bc)end,getVisible=function(bc)return
true end}
local function cb(bc,cc,dc,_d)local ad=bc.get("children")local bd={}
if not(_d)then local cd=1;local dd=1;local __a=1
for a_a,b_a in pairs(ad)do if
(bd[cd]==nil)then bd[cd]={offset=1}end;local c_a=
cc=="row"and b_a.get("height")or b_a.get("width")if
c_a>dd then dd=c_a end
if(b_a==bb)then __a=__a+dd+dc;dd=1;cd=cd+1
bd[cd]={offset=__a}else table.insert(bd[cd],b_a)end end elseif(_d)then local cd=1;local dd=1
local __a=cc=="row"and bc.get("width")or bc.get("height")local a_a=0;local b_a=1
for c_a,d_a in pairs(ad)do
if(bd[b_a]==nil)then bd[b_a]={offset=1}end
if d_a:getType()=="lineBreak"then dd=dd+cd+dc;a_a=0;cd=1;b_a=b_a+1
bd[b_a]={offset=dd}else
local _aa=cc=="row"and d_a.get("width")or d_a.get("height")
if(_aa+a_a<=__a)then table.insert(bd[b_a],d_a)
a_a=a_a+_aa+dc else dd=dd+cd+dc
cd=cc=="row"and d_a.get("height")or d_a.get("width")b_a=b_a+1;a_a=_aa+dc;bd[b_a]={offset=dd,d_a}end
local aaa=cc=="row"and d_a.get("height")or d_a.get("width")if aaa>cd then cd=aaa end end end end;return bd end
local function db(bc,cc,dc,_d)local ad=bc.get("width")local bd=dc* (#cc-1)local cd=0;for c_a,d_a in ipairs(cc)do
if d_a~=bb then bd=bd+
d_a.get("width")cd=cd+d_a.get("flexGrow")end end;local dd=ad-bd;local __a=
cd>0 and(dd/cd)or 0;local a_a=0;local b_a=1
for c_a,d_a in ipairs(cc)do
if d_a~=bb then
local _aa=d_a.get("width")
if d_a.get("flexGrow")>0 then if c_a==#cc then local aaa=dd-a_a;_aa=_aa+aaa else local aaa=math.floor(__a*
d_a.get("flexGrow"))_aa=_aa+aaa
a_a=a_a+aaa end end;d_a.set("x",b_a)d_a.set("y",cc.offset or 1)
d_a.set("width",_aa)b_a=b_a+_aa+dc end end
if _d=="flex-end"then local c_a=ad- (b_a-dc-1)for d_a,_aa in ipairs(cc)do
_aa.set("x",_aa.get("x")+c_a)end elseif _d=="flex-center"or _d=="center"then local c_a=math.floor((
ad- (b_a-dc-1))/2)for d_a,_aa in ipairs(cc)do _aa.set("x",
_aa.get("x")+c_a)end end end
local function _c(bc,cc,dc,_d)local ad=bc.get("height")local bd=dc* (#cc-1)local cd=0;for c_a,d_a in ipairs(cc)do
if d_a~=bb then bd=bd+
d_a.get("height")cd=cd+d_a.get("flexGrow")end end;local dd=ad-bd;local __a=
cd>0 and(dd/cd)or 0;local a_a=0;local b_a=1
for c_a,d_a in ipairs(cc)do
if d_a~=bb then
local _aa=d_a.get("height")
if d_a.get("flexGrow")>0 then if c_a==#cc then local aaa=dd-a_a;_aa=_aa+aaa else local aaa=math.floor(__a*
d_a.get("flexGrow"))_aa=_aa+aaa
a_a=a_a+aaa end end;d_a.set("x",cc.offset or 1)d_a.set("y",b_a)
d_a.set("height",_aa)b_a=b_a+_aa+dc end end
if _d=="flex-end"then local c_a=ad- (b_a-dc-1)for d_a,_aa in ipairs(cc)do
_aa.set("y",_aa.get("y")+c_a)end elseif _d=="flex-center"or _d=="center"then local c_a=math.floor((
ad- (b_a-dc-1))/2)for d_a,_aa in ipairs(cc)do _aa.set("y",
_aa.get("y")+c_a)end end end
local function ac(bc,cc,dc,_d,ad)local bd=cb(bc,cc,dc,ad)
if cc=="row"then
for cd,dd in pairs(bd)do db(bc,dd,dc,_d)end else for cd,dd in pairs(bd)do _c(bc,dd,dc,_d)end end;bc.set("flexUpdateLayout",false)end
function ab.new()local bc=setmetatable({},ab):__init()
bc.set("width",12)bc.set("height",6)
bc.set("background",colors.blue)bc.set("z",10)
bc:observe("width",function()
bc.set("flexUpdateLayout",true)end)
bc:observe("height",function()bc.set("flexUpdateLayout",true)end)return bc end;function ab:init(bc,cc)_b.init(self,bc,cc)self.set("type","Flexbox")
return self end
function ab:addChild(bc)
_b.addChild(self,bc)
if(bc~=bb)then
bc:instanceProperty("flexGrow",{default=0,type="number"})
bc:instanceProperty("flexShrink",{default=0,type="number"})
bc:instanceProperty("flexBasis",{default=0,type="number"})end;self.set("flexUpdateLayout",true)return self end
function ab:removeChild(bc)_b.removeChild(self,bc)
if(bc~=bb)then bc.setFlexGrow=nil;bc.setFlexShrink=
nil;bc.setFlexBasis=nil;bc.getFlexGrow=nil;bc.getFlexShrink=nil;bc.getFlexBasis=
nil;bc.set("flexGrow",nil)
bc.set("flexShrink",nil)bc.set("flexBasis",nil)end;self.set("flexUpdateLayout",true)return self end;function ab:addLineBreak()self:addChild(bb)return self end
function ab:render()
if
(self.get("flexUpdateLayout"))then
ac(self,self.get("flexDirection"),self.get("flexSpacing"),self.get("flexJustifyContent"),self.get("flexWrap"))end;_b.render(self)end;return ab end
project["elements/VisualElement.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("BaseElement")local da=require("libraries/colorHex")
local _b=setmetatable({},ca)_b.__index=_b
_b.defineProperty(_b,"x",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"y",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"z",{default=1,type="number",canTriggerRender=true,setter=function(cb,db)
if cb.parent then cb.parent:sortChildren()end;return db end})
_b.defineProperty(_b,"width",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"height",{default=1,type="number",canTriggerRender=true})
_b.defineProperty(_b,"background",{default=colors.black,type="number",canTriggerRender=true})
_b.defineProperty(_b,"foreground",{default=colors.white,type="number",canTriggerRender=true})
_b.defineProperty(_b,"clicked",{default=false,type="boolean"})
_b.defineProperty(_b,"hover",{default=false,type="boolean"})
_b.defineProperty(_b,"backgroundEnabled",{default=true,type="boolean",canTriggerRender=true})
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
local ab,bb=math.max,math.min
function _b.new()local cb=setmetatable({},_b):__init()return cb end;function _b:init(cb,db)ca.init(self,cb,db)
self.set("type","VisualElement")end;function _b:multiBlit(cb,db,_c,ac,bc,cc,dc)
local _d,ad=self:calculatePosition()cb=cb+_d-1;db=db+ad-1
self.parent:multiBlit(cb,db,_c,ac,bc,cc,dc)end;function _b:textFg(cb,db,_c,ac)
local bc,cc=self:calculatePosition()cb=cb+bc-1;db=db+cc-1
self.parent:textFg(cb,db,_c,ac)end;function _b:textBg(cb,db,_c,ac)
local bc,cc=self:calculatePosition()cb=cb+bc-1;db=db+cc-1
self.parent:textBg(cb,db,_c,ac)end;function _b:blit(cb,db,_c,ac,bc)
local cc,dc=self:calculatePosition()cb=cb+cc-1;db=db+dc-1
self.parent:blit(cb,db,_c,ac,bc)end
function _b:isInBounds(cb,db)
local _c,ac=self.get("x"),self.get("y")local bc,cc=self.get("width"),self.get("height")if
(self.get("ignoreOffset"))then
if(self.parent)then cb=cb-self.parent.get("offsetX")db=
db-self.parent.get("offsetY")end end;return
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
function _b:mouse_move(cb,db,_c)if(db==nil)or(_c==nil)then return end
local ac=self.get("hover")
if(self:isInBounds(db,_c))then if(not ac)then self.set("hover",true)
self:fireEvent("mouse_enter",self:getRelativePosition(db,_c))end;return true else if(ac)then
self.set("hover",false)
self:fireEvent("mouse_leave",self:getRelativePosition(db,_c))end end;return false end
function _b:mouse_scroll(cb,db,_c)if(self:isInBounds(db,_c))then
self:fireEvent("mouse_scroll",cb,self:getRelativePosition(db,_c))return true end;return false end
function _b:mouse_drag(cb,db,_c)if(self.get("clicked"))then
self:fireEvent("mouse_drag",cb,self:getRelativePosition(db,_c))return true end;return false end;function _b:focus()self:fireEvent("focus")end;function _b:blur()
self:fireEvent("blur")self:setCursor(1,1,false)end
function _b:key(cb)if
(self.get("focused"))then self:fireEvent("key",cb)end end;function _b:key_up(cb)
if(self.get("focused"))then self:fireEvent("key_up",cb)end end;function _b:char(cb)if(self.get("focused"))then
self:fireEvent("char",cb)end end
function _b:calculatePosition()
local cb,db=self.get("x"),self.get("y")
if not self.get("ignoreOffset")then if self.parent~=nil then
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
if self.parent then local bc,cc=self:calculatePosition()return self.parent:setCursor(
cb+bc-1,db+cc-1,_c,ac)end;return self end
function _b:prioritize()
if(self.parent)then local cb=self.parent;cb:removeChild(self)
cb:addChild(self)self:updateRender()end;return self end
function _b:render()
if(not self.get("backgroundEnabled"))then return end;local cb,db=self.get("width"),self.get("height")
self:multiBlit(1,1,cb,db," ",da[self.get("foreground")],da[self.get("background")])end;return _b end
project["elements/Scrollbar.lua"] = function(...) local aa=require("elements/VisualElement")
local ba=require("libraries/colorHex")local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"value",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"min",{default=0,type="number",canTriggerRender=true})
ca.defineProperty(ca,"max",{default=100,type="number",canTriggerRender=true})
ca.defineProperty(ca,"step",{default=10,type="number"})
ca.defineProperty(ca,"dragMultiplier",{default=1,type="number"})
ca.defineProperty(ca,"symbol",{default=" ",type="string",canTriggerRender=true})
ca.defineProperty(ca,"symbolColor",{default=colors.gray,type="number",canTriggerRender=true})
ca.defineProperty(ca,"symbolBackgroundColor",{default=colors.black,type="number",canTriggerRender=true})
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
ab.set("width",1)ab.set("height",10)return ab end;function ca:init(ab,bb)aa.init(self,ab,bb)self.set("type","Scrollbar")return
self end
function ca:attach(ab,bb)
self.set("attachedElement",ab)self.set("attachedProperty",bb.property)self.set("minValue",
bb.min or 0)
self.set("maxValue",bb.max or 100)return self end
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
project["elements/Tree.lua"] = function(...) local _a=require("elements/VisualElement")local aa=string.sub
local ba=setmetatable({},_a)ba.__index=ba
ba.defineProperty(ba,"nodes",{default={},type="table",canTriggerRender=true,setter=function(da,_b)if#_b>0 then
da.get("expandedNodes")[_b[1]]=true end;return _b end})
ba.defineProperty(ba,"selectedNode",{default=nil,type="table",canTriggerRender=true})
ba.defineProperty(ba,"expandedNodes",{default={},type="table",canTriggerRender=true})
ba.defineProperty(ba,"scrollOffset",{default=0,type="number",canTriggerRender=true})
ba.defineProperty(ba,"horizontalOffset",{default=0,type="number",canTriggerRender=true})
ba.defineProperty(ba,"nodeColor",{default=colors.white,type="number"})
ba.defineProperty(ba,"selectedColor",{default=colors.lightBlue,type="number"})ba.defineEvent(ba,"mouse_click")
ba.defineEvent(ba,"mouse_scroll")
function ba.new()local da=setmetatable({},ba):__init()
da.set("width",30)da.set("height",10)da.set("z",5)return da end
function ba:init(da,_b)_a.init(self,da,_b)self.set("type","Tree")return self end;function ba:expandNode(da)self.get("expandedNodes")[da]=true
self:updateRender()return self end
function ba:collapseNode(da)self.get("expandedNodes")[da]=
nil;self:updateRender()return self end;function ba:toggleNode(da)if self.get("expandedNodes")[da]then
self:collapseNode(da)else self:expandNode(da)end
return self end
local function ca(da,_b,ab,bb)bb=bb or{}ab=
ab or 0;for cb,db in ipairs(da)do table.insert(bb,{node=db,level=ab})
if
_b[db]and db.children then ca(db.children,_b,ab+1,bb)end end;return bb end
function ba:mouse_click(da,_b,ab)
if _a.mouse_click(self,da,_b,ab)then
local bb,cb=self:getRelativePosition(_b,ab)
local db=ca(self.get("nodes"),self.get("expandedNodes"))local _c=cb+self.get("scrollOffset")
if db[_c]then local ac=db[_c]
local bc=ac.node
if bb<=ac.level*2 +2 then self:toggleNode(bc)end;self.set("selectedNode",bc)
self:fireEvent("node_select",bc)end;return true end end
function ba:onSelect(da)self:registerCallback("node_select",da)return self end
function ba:mouse_scroll(da,_b,ab)
if _a.mouse_scroll(self,da,_b,ab)then
local bb=ca(self.get("nodes"),self.get("expandedNodes"))
local cb=math.max(0,#bb-self.get("height"))
local db=math.min(cb,math.max(0,self.get("scrollOffset")+da))self.set("scrollOffset",db)return true end end
function ba:getNodeSize()local da,_b=0,0
local ab=ca(self.get("nodes"),self.get("expandedNodes"))for bb,cb in ipairs(ab)do
da=math.max(da,cb.level+#cb.node.text)end;_b=#ab;return da,_b end
function ba:render()_a.render(self)
local da=ca(self.get("nodes"),self.get("expandedNodes"))local _b=self.get("height")local ab=self.get("selectedNode")
local bb=self.get("expandedNodes")local cb=self.get("scrollOffset")
local db=self.get("horizontalOffset")
for y=1,_b do local _c=da[y+cb]
if _c then local ac=_c.node;local bc=_c.level
local cc=string.rep("  ",bc)local dc=" "if ac.children and#ac.children>0 then
dc=bb[ac]and"\31"or"\16"end
local _d=
ac==ab and self.get("selectedColor")or self.get("background")
local ad=cc..dc.." ".. (ac.text or"Node")local bd=aa(ad,db+1,db+self.get("width"))
self:textFg(1,y,
bd..string.rep(" ",self.get("width")-#bd),self.get("foreground"))else
self:textFg(1,y,string.rep(" ",self.get("width")),self.get("foreground"),self.get("background"))end end end;return ba end
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
da.set("z",3)da.set("foreground",colors.black)
da.set("backgroundEnabled",false)return da end;function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Label")
return self end
function ca:getWrappedText()
local da=self.get("text")local _b=ba(da,self.get("width"))return _b end
function ca:render()aa.render(self)local da=self.get("text")
if
(self.get("autoSize"))then self:textFg(1,1,da,self.get("foreground"))else
local _b=ba(da,self.get("width"))for ab,bb in ipairs(_b)do
self:textFg(1,ab,bb,self.get("foreground"))end end end;return ca end
project["elements/Button.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")
local ba=require("libraries/utils").getCenteredPosition;local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"text",{default="Button",type="string",canTriggerRender=true})ca.defineEvent(ca,"mouse_click")
ca.defineEvent(ca,"mouse_up")
function ca.new()local da=setmetatable({},ca):__init()
da.set("width",10)da.set("height",3)da.set("z",5)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Button")end
function ca:render()aa.render(self)local da=self.get("text")
da=da:sub(1,self.get("width"))
local _b,ab=ba(da,self.get("width"),self.get("height"))
self:textFg(_b,ab,da,self.get("foreground"))end;return ca end
project["elements/Input.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"text",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"cursorPos",{default=1,type="number"})
aa.defineProperty(aa,"viewOffset",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"maxLength",{default=nil,type="number"})
aa.defineProperty(aa,"placeholder",{default="...",type="string"})
aa.defineProperty(aa,"placeholderColor",{default=colors.gray,type="number"})
aa.defineProperty(aa,"focusedBackground",{default=colors.blue,type="number"})
aa.defineProperty(aa,"focusedForeground",{default=colors.white,type="number"})
aa.defineProperty(aa,"pattern",{default=nil,type="string"})
aa.defineProperty(aa,"cursorColor",{default=nil,type="number"})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"key")aa.defineEvent(aa,"char")
function aa.new()
local ba=setmetatable({},aa):__init()ba.set("width",8)ba.set("z",3)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Input")return self end
function aa:setCursor(ba,ca,da,_b)
ba=math.min(self.get("width"),math.max(1,ba))return d.setCursor(self,ba,ca,da,_b)end
function aa:char(ba)if not self.get("focused")then return false end
local ca=self.get("text")local da=self.get("cursorPos")local _b=self.get("maxLength")
local ab=self.get("pattern")if _b and#ca>=_b then return end
if ab and not ba:match(ab)then return end
self.set("text",ca:sub(1,da-1)..ba..ca:sub(da))self.set("cursorPos",da+1)self:updateViewport()local bb=
self.get("cursorPos")-self.get("viewOffset")
self:setCursor(bb,1,true,
self.get("cursorColor")or self.get("foreground"))return true end
function aa:key(ba)if not self.get("focused")then return false end
local ca=self.get("cursorPos")local da=self.get("text")local _b=self.get("viewOffset")
local ab=self.get("width")
if ba==keys.left then if ca>1 then self.set("cursorPos",ca-1)
if ca-1 <=_b then self.set("viewOffset",math.max(0,
ca-2))end end elseif ba==keys.right then if ca<=#da then self.set("cursorPos",
ca+1)if ca-_b>=ab then
self.set("viewOffset",ca-ab+1)end end elseif
ba==keys.backspace then if ca>1 then
self.set("text",da:sub(1,ca-2)..da:sub(ca))self.set("cursorPos",ca-1)self:updateRender()
self:updateViewport()end end
local bb=self.get("cursorPos")-self.get("viewOffset")
self:setCursor(bb,1,true,self.get("cursorColor")or self.get("foreground"))return true end
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
function aa:render()local ba=self.get("text")local ca=self.get("viewOffset")
local da=self.get("width")local _b=self.get("placeholder")
local ab=self.get("focusedBackground")local bb=self.get("focusedForeground")
local cb=self.get("focused")local db,_c=self.get("width"),self.get("height")
self:multiBlit(1,1,db,_c," ",_a[
cb and bb or self.get("foreground")],_a[cb and ab or
self.get("background")])if
#ba==0 and#_b~=0 and self.get("focused")==false then
self:textFg(1,1,_b:sub(1,db),self.get("placeholderColor"))return end
local ac=ba:sub(ca+1,ca+db)self:textFg(1,1,ac,self.get("foreground"))end;return aa end
project["elements/BaseFrame.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("Container")local ba=require("render")local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"term",{default=
nil,type="table",setter=function(da,_b)
if _b==nil or _b.setCursorPos==nil then return _b end;da._render=ba.new(_b)da._renderUpdate=true;local ab,bb=_b.getSize()
da.set("width",ab)da.set("height",bb)return _b end})
function ca.new()local da=setmetatable({},ca):__init()
da.set("term",term.current())da.set("background",colors.lightGray)return da end;function ca:init(da,_b)aa.init(self,da,_b)self.set("type","BaseFrame")return
self end
function ca:multiBlit(da,_b,ab,bb,cb,db,_c)if(da<1)then ab=ab+da-1
da=1 end;if(_b<1)then bb=bb+_b-1;_b=1 end
self._render:multiBlit(da,_b,ab,bb,cb,db,_c)end;function ca:textFg(da,_b,ab,bb)if da<1 then ab=string.sub(ab,1 -da)da=1 end
self._render:textFg(da,_b,ab,bb)end;function ca:textBg(da,_b,ab,bb)if da<1 then ab=string.sub(ab,1 -
da)da=1 end
self._render:textBg(da,_b,ab,bb)end
function ca:blit(da,_b,ab,bb,cb)if da<1 then ab=string.sub(ab,1 -
da)bb=string.sub(bb,1 -da)
cb=string.sub(cb,1 -da)da=1 end
self._render:blit(da,_b,ab,bb,cb)end;function ca:setCursor(da,_b,ab,bb)local cb=self.get("term")
self._render:setCursor(da,_b,ab,bb)end
function ca:mouse_up(da,_b,ab)
aa.mouse_up(self,da,_b,ab)aa.mouse_release(self,da,_b,ab)end
function ca:term_resize()local da,_b=self.get("term").getSize()
if(da==
self.get("width")and _b==self.get("height"))then return end;self.set("width",da)self.set("height",_b)
self._render:setSize(da,_b)self._renderUpdate=true end
function ca:key(da)self:fireEvent("key",da)aa.key(self,da)end
function ca:key_up(da)self:fireEvent("key_up",da)aa.key_up(self,da)end
function ca:char(da)self:fireEvent("char",da)aa.char(self,da)end;function ca:render()
if(self._renderUpdate)then if self._render~=nil then aa.render(self)
self._render:render()self._renderUpdate=false end end end
return ca end
project["elements/BaseElement.lua"] = function(...) local d=require("propertySystem")
local _a=require("libraries/utils").uuid;local aa=setmetatable({},d)aa.__index=aa;aa._events={}
aa.defineProperty(aa,"type",{default={"BaseElement"},type="string",setter=function(ba,ca)if
type(ca)=="string"then table.insert(ba._values.type,1,ca)return
ba._values.type end;return ca end,getter=function(ba,ca,da)if
da~=nil and da<1 then return ba._values.type end;return ba._values.type[
da or 1]end})
aa.defineProperty(aa,"id",{default="",type="string",readonly=true})
aa.defineProperty(aa,"name",{default="",type="string"})
aa.defineProperty(aa,"eventCallbacks",{default={},type="table"})
function aa.defineEvent(ba,ca,da)
if not rawget(ba,'_eventConfigs')then ba._eventConfigs={}end;ba._eventConfigs[ca]={requires=da and da or ca}end
function aa.registerEventCallback(ba,ca,...)
local da=ca:match("^on")and ca or"on"..ca;local _b={...}local ab=_b[1]
ba[da]=function(bb,...)
for cb,db in ipairs(_b)do if not bb._registeredEvents[db]then
bb:listenEvent(db,true)end end;bb:registerCallback(ab,...)return bb end end
function aa.new()local ba=setmetatable({},aa):__init()return ba end
function aa:init(ba,ca)self._props=ba;self._values.id=_a()self.basalt=ca
self._registeredEvents={}local da=getmetatable(self).__index;local _b={}da=self
while da do
if
type(da)=="table"and da._eventConfigs then for ab,bb in pairs(da._eventConfigs)do
if not _b[ab]then _b[ab]=bb end end end
da=getmetatable(da)and getmetatable(da).__index end
for ab,bb in pairs(_b)do self._registeredEvents[bb.requires]=true end;if self._callbacks then
for ab,bb in pairs(self._callbacks)do self[bb]=function(cb,...)
cb:registerCallback(ab,...)return cb end end end
return self end
function aa:postInit()if(self._props)then
for ba,ca in pairs(self._props)do self.set(ba,ca)end end;self._props=nil;return self end;function aa:isType(ba)
for ca,da in ipairs(self._values.type)do if da==ba then return true end end;return false end
function aa:listenEvent(ba,ca)ca=
ca~=false
if
ca~= (self._registeredEvents[ba]or false)then
if ca then self._registeredEvents[ba]=true;if self.parent then
self.parent:registerChildEvent(self,ba)end else self._registeredEvents[ba]=nil
if
self.parent then self.parent:unregisterChildEvent(self,ba)end end end;return self end
function aa:registerCallback(ba,ca)if not self._registeredEvents[ba]then
self:listenEvent(ba,true)end
if
not self._values.eventCallbacks[ba]then self._values.eventCallbacks[ba]={}end
table.insert(self._values.eventCallbacks[ba],ca)return self end
function aa:fireEvent(ba,...)
if self.get("eventCallbacks")[ba]then for ca,da in
ipairs(self.get("eventCallbacks")[ba])do local _b=da(self,...)return _b end end;return self end;function aa:dispatchEvent(ba,...)if self[ba]then return self[ba](self,...)end;return
self:handleEvent(ba,...)end;function aa:handleEvent(ba,...)return
false end
function aa:onChange(ba,ca)self:observe(ba,ca)return self end;function aa:getBaseFrame()
if self.parent then return self.parent:getBaseFrame()end;return self end
function aa:destroy()if self.parent then
self.parent:removeChild(self)end;for ba in pairs(self._registeredEvents)do
self:listenEvent(ba,false)end;self._values.eventCallbacks={}self._props=
nil;self._values=nil;self.basalt=nil;self.parent=nil
self.__index=nil;setmetatable(self,nil)end
function aa:updateRender()if(self.parent)then self.parent:updateRender()else
self._renderUpdate=true end end;return aa end
project["elements/Frame.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")local ba=_a.getElement("Container")local ca=setmetatable({},ba)
ca.__index=ca
ca.defineProperty(ca,"draggable",{default=false,type="boolean",setter=function(da,_b)
if _b then da:listenEvent("mouse_click",true)
da:listenEvent("mouse_up",true)da:listenEvent("mouse_drag",true)end;return _b end})
ca.defineProperty(ca,"draggingMap",{default={{x=1,y=1,width="width",height=1}},type="table"})
function ca.new()local da=setmetatable({},ca):__init()
da.set("width",12)da.set("height",6)
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
function ca:mouse_up(da,_b,ab)self.dragging=false;self.dragStartX=nil;self.dragStartY=nil;return
ba.mouse_up(self,da,_b,ab)end
function ca:mouse_drag(da,_b,ab)
if self.get("clicked")and self.dragging then
local bb=_b-self.dragStartX;local cb=ab-self.dragStartY;self.set("x",bb)
self.set("y",cb)return true end
if not self.dragging then return ba.mouse_drag(self,da,_b,ab)end;return false end;return ca end
project["elements/Checkbox.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"checked",{default=false,type="boolean",canTriggerRender=true})
d.defineProperty(d,"text",{default=" ",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.get("checkedText")
local ca=math.max(#aa,#ba)if(_a.get("autoSize"))then _a.set("width",ca)end;return aa end})
d.defineProperty(d,"checkedText",{default="x",type="string",canTriggerRender=true,setter=function(_a,aa)local ba=_a.get("text")
local ca=math.max(#aa,#ba)if(_a.get("autoSize"))then _a.set("width",ca)end;return aa end})
d.defineProperty(d,"autoSize",{default=true,type="boolean"})d.defineEvent(d,"mouse_click")function d.new()
local _a=setmetatable({},d):__init()return _a end;function d:init(_a,aa)c.init(self,_a,aa)
self.set("type","Checkbox")end
function d:mouse_click(_a,aa,ba)
if c.mouse_click(self,_a,aa,ba)then
self.set("checked",
not self.get("checked"))
self:fireEvent("change",self.get("checked"))return true end;return false end
function d:render()c.render(self)local _a=self.get("checked")
local aa=self.get("text")local ba=self.get("checkedText")
local ca=string.sub(_a and ba or aa,1,self.get("width"))self:textFg(1,1,ca,self.get("foreground"))end;return d end
project["elements/Program.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=require("errorManager")local _b=setmetatable({},ca)
_b.__index=_b
_b.defineProperty(_b,"program",{default=nil,type="table"})
_b.defineProperty(_b,"path",{default="",type="string"})
_b.defineProperty(_b,"running",{default=false,type="boolean"})_b.defineEvent(_b,"*")local ab={}ab.__index=ab
local bb=dofile("rom/modules/main/cc/require.lua").make
function ab.new()local cb=setmetatable({},ab)cb.env={}cb.args={}return cb end
function ab:run(cb,db,_c)
self.window=window.create(term.current(),1,1,db,_c,false)local ac=shell.resolveProgram(cb)
if(ac~=nil)then
if(fs.exists(ac))then
local bc=fs.open(ac,"r")local cc=bc.readAll()bc.close()
local dc=setmetatable(self.env,{__index=_ENV})dc.shell=shell;dc.term=self.window
dc.require,dc.package=bb(dc,fs.getDir(ac))dc.term.current=term.current;dc.term.redirect=term.redirect
dc.term.native=term.native
self.coroutine=coroutine.create(function()local cd=load(cc,cb,"bt",dc)
if cd then
local dd=term.current()term.redirect(self.window)
local __a=cd(cb,table.unpack(self.args))term.redirect(dd)return __a end end)local _d=term.current()term.redirect(self.window)
local ad,bd=coroutine.resume(self.coroutine)term.redirect(_d)if not ad then
da.header="Basalt Program Error "..cb;da.error(bd)end else
da.header="Basalt Program Error "..cb;da.error("File not found")end else da.header="Basalt Program Error"
da.error("Program "..cb.." not found")end end
function ab:resize(cb,db)self.window.reposition(1,1,cb,db)end
function ab:resume(cb,...)if self.coroutine==nil or
coroutine.status(self.coroutine)=="dead"then return end
if(
self.filter~=nil)then if(cb~=self.filter)then return end;self.filter=nil end;local db=term.current()term.redirect(self.window)
local _c,ac=coroutine.resume(self.coroutine,cb,...)term.redirect(db)if _c then self.filter=ac else
da.header="Basalt Program Error"da.error(ac)end;return _c,ac end;function ab:stop()end;function _b.new()
local cb=setmetatable({},_b):__init()cb.set("z",5)cb.set("width",30)cb.set("height",12)
return cb end
function _b:init(cb,db)
ca.init(self,cb,db)self.set("type","Program")return self end
function _b:execute(cb)self.set("path",cb)self.set("running",true)
local db=ab.new()self.set("program",db)
db:run(cb,self.get("width"),self.get("height"))self:updateRender()return self end
function _b:dispatchEvent(cb,...)local db=self.get("program")
local _c=ca.dispatchEvent(self,cb,...)
if db then db:resume(cb,...)
if(self.get("focused"))then
local ac=db.window.getCursorBlink()local bc,cc=db.window.getCursorPos()
self:setCursor(bc,cc,ac,db.window.getTextColor())end;self:updateRender()end;return _c end
function _b:focus()
if(ca.focus(self))then local cb=self.get("program")if cb then
local db=cb.window.getCursorBlink()local _c,ac=cb.window.getCursorPos()
self:setCursor(_c,ac,db,cb.window.getTextColor())end end end
function _b:render()ca.render(self)local cb=self.get("program")
if cb then
local db,_c=cb.window.getSize()for y=1,_c do local ac,bc,cc=cb.window.getLine(y)if ac then
self:blit(1,y,ac,bc,cc)end end end end;return _b end
project["elements/Table.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"columns",{default={},type="table"})
aa.defineProperty(aa,"data",{default={},type="table",canTriggerRender=true})
aa.defineProperty(aa,"selectedRow",{default=nil,type="number",canTriggerRender=true})
aa.defineProperty(aa,"headerColor",{default=colors.blue,type="number"})
aa.defineProperty(aa,"selectedColor",{default=colors.lightBlue,type="number"})
aa.defineProperty(aa,"gridColor",{default=colors.gray,type="number"})
aa.defineProperty(aa,"sortColumn",{default=nil,type="number"})
aa.defineProperty(aa,"sortDirection",{default="asc",type="string"})
aa.defineProperty(aa,"scrollOffset",{default=0,type="number",canTriggerRender=true})aa.defineEvent(aa,"mouse_click")
aa.defineEvent(aa,"mouse_scroll")
function aa.new()local ba=setmetatable({},aa):__init()
ba.set("width",30)ba.set("height",10)ba.set("z",5)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Table")return self end
function aa:sortData(ba)local ca=self.get("data")
local da=self.get("sortDirection")
table.sort(ca,function(_b,ab)
if da=="asc"then return _b[ba]<ab[ba]else return _b[ba]>ab[ba]end end)self.set("data",ca)return self end
function aa:mouse_click(ba,ca,da)
if not d.mouse_click(self,ba,ca,da)then return false end;local _b,ab=self:getRelativePosition(ca,da)
if ab==1 then local bb=1
for cb,db in
ipairs(self.get("columns"))do
if _b>=bb and _b<bb+db.width then
if self.get("sortColumn")==cb then
self.set("sortDirection",
self.get("sortDirection")=="asc"and"desc"or"asc")else self.set("sortColumn",cb)
self.set("sortDirection","asc")end;self:sortData(cb)break end;bb=bb+db.width end end
if ab>1 then local bb=ab-2 +self.get("scrollOffset")if bb>=0 and bb<#
self.get("data")then
self.set("selectedRow",bb+1)end end;return true end
function aa:mouse_scroll(ba,ca,da)local _b=self.get("data")local ab=self.get("height")
local bb=ab-2;local cb=math.max(0,#_b-bb+1)
local db=math.min(cb,math.max(0,
self.get("scrollOffset")+ba))self.set("scrollOffset",db)return true end
function aa:render()d.render(self)local ba=self.get("columns")
local ca=self.get("data")local da=self.get("selectedRow")
local _b=self.get("sortColumn")local ab=self.get("scrollOffset")local bb=self.get("height")
local cb=1
for _c,ac in ipairs(ba)do local bc=ac.name;if _c==_b then
bc=bc.. (self.get("sortDirection")=="asc"and
"\30"or"\31")end
self:textFg(cb,1,bc:sub(1,ac.width),self.get("headerColor"))cb=cb+ac.width end;local db=bb-2
for y=2,bb do local _c=y-2 +ab;local ac=ca[_c+1]
if ac and(_c+1)<=#ca then cb=1
local bc=
(_c+1)==da and self.get("selectedColor")or self.get("background")
for cc,dc in ipairs(ba)do local _d=ac[cc]or""
local ad=_d..string.rep(" ",dc.width-#_d)
self:blit(cb,y,ad,string.rep(_a[self.get("foreground")],dc.width),string.rep(_a[bc],dc.width))cb=cb+dc.width end else
self:blit(1,y,string.rep(" ",self.get("width")),string.rep(_a[self.get("foreground")],self.get("width")),string.rep(_a[self.get("background")],self.get("width")))end end
if#ca>bb-2 then local _c=bb-2
local ac=math.max(1,math.floor(_c* (bb-2)/#ca))local bc=#ca- (bb-2)+1;local cc=ab/bc
local dc=2 +math.floor(cc* (_c-ac))if ab>=bc then dc=bb-ac end;for y=2,bb do
self:blit(self.get("width"),y,"\127",_a[colors.gray],_a[colors.gray])end;for y=dc,math.min(bb,dc+ac-1)do
self:blit(self.get("width"),y,"\127",_a[colors.white],_a[colors.white])end end end;return aa end
project["elements/Slider.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"step",{default=1,type="number",canTriggerRender=true})
d.defineProperty(d,"max",{default=100,type="number"})
d.defineProperty(d,"horizontal",{default=true,type="boolean",canTriggerRender=true})
d.defineProperty(d,"barColor",{default=colors.gray,type="number",canTriggerRender=true})
d.defineProperty(d,"sliderColor",{default=colors.blue,type="number",canTriggerRender=true})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_drag")d.defineEvent(d,"mouse_up")function d.new()
local _a=setmetatable({},d):__init()_a.set("width",8)_a.set("height",1)
_a.set("backgroundEnabled",false)return _a end;function d:init(_a,aa)
c.init(self,_a,aa)self.set("type","Slider")end
function d:getValue()
local _a=self.get("step")local aa=self.get("max")
local ba=
self.get("horizontal")and self.get("width")or self.get("height")return math.floor((_a-1)* (aa/ (ba-1)))end
function d:mouse_click(_a,aa,ba)
if _a==1 and self:isInBounds(aa,ba)then
local ca,da=self:getRelativePosition(aa,ba)
local _b=self.get("horizontal")and ca or da;local ab=self.get("horizontal")and self.get("width")or
self.get("height")
self.set("step",math.min(ab,math.max(1,_b)))self:updateRender()return true end end;d.mouse_drag=d.mouse_click
function d:mouse_scroll(_a,aa,ba)
if self:isInBounds(aa,ba)then
local ca=self.get("step")local da=self.get("horizontal")and self.get("width")or
self.get("height")
self.set("step",math.min(da,math.max(1,
ca+_a)))self:updateRender()return true end end
function d:render()c.render(self)local _a=self.get("width")
local aa=self.get("height")local ba=self.get("horizontal")local ca=self.get("step")local da=
ba and"\140"or"│"
local _b=string.rep(da,ba and _a or aa)
if ba then self:textFg(1,1,_b,self.get("barColor"))
self:textBg(ca,1," ",self.get("sliderColor"))else
for y=1,aa do self:textFg(1,y,da,self.get("barColor"))end
self:textFg(1,ca,"\140",self.get("sliderColor"))end end;return d end
project["elements/ProgressBar.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"progress",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"showPercentage",{default=false,type="boolean"})
d.defineProperty(d,"progressColor",{default=colors.black,type="number"})
function d.new()local _a=setmetatable({},d):__init()
_a.set("width",10)_a.set("height",1)return _a end
function d:init(_a,aa)c.init(self,_a,aa)self.set("type","ProgressBar")end
function d:render()c.render(self)local _a=self.get("width")
local aa=math.min(100,math.max(0,self.get("progress")))local ba=math.floor((_a*aa)/100)for i=1,self.get("height")do
self:textBg(1,i,string.rep(" ",ba),self.get("progressColor"))end;if self.get("showPercentage")then local ca=
tostring(aa).."%"
local da=math.floor((_a-#ca)/2)+1
self:textFg(da,1,ca,self.get("foreground"))end end;return d end
project["elements/List.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"items",{default={},type="table",canTriggerRender=true})
d.defineProperty(d,"selectable",{default=true,type="boolean"})
d.defineProperty(d,"multiSelection",{default=false,type="boolean"})
d.defineProperty(d,"offset",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"selectedBackground",{default=colors.blue,type="number"})
d.defineProperty(d,"selectedForeground",{default=colors.white,type="number"})d.defineEvent(d,"mouse_click")
d.defineEvent(d,"mouse_scroll")
function d.new()local _a=setmetatable({},d):__init()
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
function d:mouse_click(_a,aa,ba)
if
_a==1 and self:isInBounds(aa,ba)and self.get("selectable")then local ca,da=self:getRelativePosition(aa,ba)
local _b=da+self.get("offset")local ab=self.get("items")
if _b<=#ab then local bb=ab[_b]if type(bb)=="string"then
bb={text=bb}ab[_b]=bb end;if
not self.get("multiSelection")then
for cb,db in ipairs(ab)do if type(db)=="table"then db.selected=false end end end
bb.selected=not bb.selected;if bb.callback then bb.callback(self)end
self:fireEvent("select",_b,bb)self:updateRender()return true end end;return false end
function d:mouse_scroll(_a,aa,ba)
if self:isInBounds(aa,ba)then local ca=self.get("offset")
local da=math.max(0,#
self.get("items")-self.get("height"))ca=math.min(da,math.max(0,ca+_a))
self.set("offset",ca)return true end;return false end
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
project["elements/Dropdown.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"isOpen",{default=false,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"dropdownHeight",{default=5,type="number"})
ca.defineProperty(ca,"selectedText",{default="",type="string"})
ca.defineProperty(ca,"dropSymbol",{default="\31",type="string"})
function ca.new()local da=setmetatable({},ca):__init()
da.set("width",16)da.set("height",1)da.set("z",8)return da end;function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Dropdown")
return self end
function ca:mouse_click(da,_b,ab)if not
_a.mouse_click(self,da,_b,ab)then return false end
local bb,cb=self:getRelativePosition(_b,ab)
if cb==1 then
self.set("isOpen",not self.get("isOpen"))if not self.get("isOpen")then self.set("height",1)else
self.set("height",1 +math.min(self.get("dropdownHeight"),
#self.get("items")))end
return true elseif
self.get("isOpen")and cb>1 and self.get("selectable")then local db=(cb-1)+self.get("offset")
local _c=self.get("items")
if db<=#_c then local ac=_c[db]
if type(ac)=="string"then ac={text=ac}_c[db]=ac end
if not self.get("multiSelection")then for bc,cc in ipairs(_c)do if type(cc)=="table"then
cc.selected=false end end end;ac.selected=not ac.selected
if ac.callback then ac.callback(self)end;self:fireEvent("select",db,ac)
self.set("isOpen",false)self.set("height",1)self:updateRender()return true end end;return false end
function ca:render()_a.render(self)local da=self.get("selectedText")if
#da==0 then local _b=self:getSelectedItems()if#_b>0 then local ab=_b[1]
da=ab.text or""end end
self:blit(1,1,
da..
string.rep(" ",self.get("width")-#da-1).. (
self.get("isOpen")and"\31"or"\17"),string.rep(ba[self.get("foreground")],self.get("width")),string.rep(ba[self.get("background")],self.get("width")))
if self.get("isOpen")then local _b=self.get("items")
local ab=self.get("height")-1;local bb=self.get("offset")local cb=self.get("width")
for i=1,ab do local db=i+bb
local _c=_b[db]
if _c then if type(_c)=="string"then _c={text=_c}_b[db]=_c end
if
_c.separator then local ac=(_c.text or"-"):sub(1,1)
local bc=string.rep(ac,cb)local cc=_c.foreground or self.get("foreground")local dc=
_c.background or self.get("background")self:textBg(1,
i+1,string.rep(" ",cb),dc)
self:textFg(1,i+1,bc,cc)else local ac=_c.text;local bc=_c.selected
local cc=bc and
(_c.selectedBackground or self.get("selectedBackground"))or
(_c.background or self.get("background"))
local dc=
bc and(_c.selectedForeground or self.get("selectedForeground"))or(_c.foreground or self.get("foreground"))self:textBg(1,i+1,string.rep(" ",cb),cc)self:textFg(1,
i+1,ac,dc)end end end end end;return ca end
project["elements/Menu.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"separatorColor",{default=colors.gray,type="number"})function ca.new()local da=setmetatable({},ca):__init()
da.set("width",30)da.set("height",1)
da.set("background",colors.gray)return da end
function ca:init(da,_b)
aa.init(self,da,_b)self.set("type","Menu")return self end
function ca:setItems(da)local _b={}local ab=0
for bb,cb in ipairs(da)do
if cb.separator then
table.insert(_b,{text=cb.text or"|",selectable=false})ab=ab+1 else local db=" "..cb.text.." "cb.text=db
table.insert(_b,cb)ab=ab+#db end end;self.set("width",ab)return aa.setItems(self,_b)end
function ca:render()_a.render(self)local da=1
for _b,ab in ipairs(self.get("items"))do if type(ab)==
"string"then ab={text=" "..ab.." "}
self.get("items")[i]=ab end;local bb=ab.selected
local cb=ab.selectable==false and
self.get("separatorColor")or(bb and
(ab.selectedForeground or self.get("selectedForeground"))or
(ab.foreground or self.get("foreground")))
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
project["main.lua"] = function(...) local cc=require("elementManager")
local dc=require("errorManager")local _d=require("propertySystem")
local ad=require("libraries/expect")local bd={}bd.traceback=true;bd._events={}bd._schedule={}bd._plugins={}
bd.LOGGER=require("log")
if(minified)then
bd.path=fs.getDir(shell.getRunningProgram())else bd.path=fs.getDir(select(2,...))end;local cd=nil;local dd=false;local __a=type;local a_a={}local b_a=10;local c_a=0;local d_a=false;local function _aa()if(d_a)then return end
c_a=os.startTimer(0.2)d_a=true end;local function aaa(_ba)
for _=1,_ba do local aba=a_a[1]if(aba)then
aba:create()end;table.remove(a_a,1)end end
local function baa(_ba,aba)if(_ba=="timer")then
if(aba==c_a)then
aaa(b_a)d_a=false;c_a=0;if(#a_a>0)then _aa()end;return true end end end
function bd.create(_ba,aba,bba,cba)if(__a(aba)=="string")then aba={name=aba}end;if(aba==nil)then
aba={name=_ba}end;local dba=cc.getElement(_ba)
if(bba)then
local _ca=_d.blueprint(dba,aba,bd,cba)table.insert(a_a,_ca)_aa()return _ca else local _ca=dba.new()
_ca:init(aba,bd)return _ca end end
function bd.createFrame()local _ba=bd.create("BaseFrame")_ba:postInit()if(cd==nil)then
cd=_ba end;return _ba end;function bd.getElementManager()return cc end;function bd.getMainFrame()if(cd==nil)then
cd=bd.createFrame()end;return cd end;function bd.setActiveFrame(_ba)
cd=_ba;cd:updateRender()end
function bd.schedule(_ba)
ad(1,_ba,"function")local aba=coroutine.create(_ba)
local bba,cba=coroutine.resume(aba)
if(bba)then
table.insert(bd._schedule,{coroutine=aba,filter=cba})else dc.header="Basalt Schedule Error"dc.error(cba)end;return aba end
function bd.removeSchedule(_ba)
for aba,bba in ipairs(bd._schedule)do if(bba.coroutine==_ba)then
table.remove(bd._schedule,aba)return true end end;return false end
local function caa(_ba,...)if(_ba=="terminate")then bd.stop()end
if baa(_ba,...)then return end;if(cd)then cd:dispatchEvent(_ba,...)end
for aba,bba in
ipairs(bd._schedule)do
if(_ba==bba.filter)or(bba.filter==nil)then
local cba,dba=coroutine.resume(bba.coroutine,_ba,...)
if(not cba)then dc.header="Basalt Schedule Error"dc.error(dba)end;bba.filter=dba end;if(coroutine.status(bba.coroutine)=="dead")then
bd.removeSchedule(bba.coroutine)end end;if bd._events[_ba]then
for aba,bba in ipairs(bd._events[_ba])do bba(...)end end end;local function daa()if(cd)then cd:render()end end;function bd.update(...)caa(...)
daa()end;function bd.stop()dd=false;term.clear()
term.setCursorPos(1,1)end
function bd.run(_ba)dd=_ba;if(_ba==nil)then dd=true end;local function aba()
daa()
while dd do caa(os.pullEventRaw())if(dd)then daa()end end end
while dd do local bba,cba=pcall(aba)if not(bba)then
dc.header="Basalt Runtime Error"dc.error(cba)end end end;function bd.getAPI(_ba)return cc.getAPI(_ba)end;return bd end
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
if ba=="color"then
if ca=="number"and aa>=1 and aa<=32768 then return true end;if ca=="string"and colors[aa]then return true end end;if ca~=ba then c.header="Basalt Type Error"
c.error(string.format("Bad argument #%d: expected %s, got %s",_a,ba,ca))end;return true end;return d end
project["plugins/xml.lua"] = function(...) local da=require("errorManager")
local function _b(bc)local cc={attributes={}}
cc.name=bc:match("<(%w+)")
for dc,_d in bc:gmatch('%s(%w+)="([^"]-)"')do cc.attributes[dc]=_d end;return cc end
local function ab(bc,cc)local dc={}local _d={children={}}local ad=_d;local bd=false;local cd=""
for dd in cc:gmatch("[^\r\n]+")do
dd=dd:match("^%s*(.-)%s*$")
if dd:match("^<!%[CDATA%[")then bd=true;cd=""elseif dd:match("%]%]>$")and bd then bd=false
ad.content=cd elseif bd then cd=cd..dd.."\n"elseif dd:match("^<[^/]")then local __a=_b(dd)__a.children={}
__a.content=""table.insert(ad.children,__a)if not dd:match("/>$")then
table.insert(dc,ad)ad=__a end elseif dd:match("^</")then
ad=table.remove(dc)end end;return _d end
local function bb(bc,cc)
if not bc:match("^%${.*}$")then
return
bc:gsub("%${(.-)}",function(bd)
local cd=setmetatable({},{__index=function(a_a,b_a)return
cc and cc[b_a]or _ENV[b_a]end})local dd,__a=load("return "..bd,"expression","t",cd)
if not dd then da.error(
"Failed to parse expression: "..__a)end;return tostring(dd())end)end;bc=bc:match("^%${(.*)}$")
local dc=setmetatable({},{__index=function(bd,cd)
return cc and cc[cd]or _ENV[cd]end})local _d,ad=load("return "..bc,"expression","t",dc)
if not _d then da.error(
"Failed to parse expression: "..ad)end;return _d()end
local function cb(bc,cc,dc)if cc=="string"and type(bc)=="string"then if bc:find("${")then
return bb(bc,dc)end end
if
type(bc)=="string"and bc:match("^%${.*}$")then return bb(bc,dc)end
if cc=="number"then if(tonumber(bc)==nil)then return bc end
return tonumber(bc)elseif cc=="boolean"then return bc=="true"elseif cc=="color"then return colors[bc]elseif cc=="table"then
local _d=setmetatable({},{__index=_ENV})local ad=load("return "..bc,nil,"t",_d)if ad then return ad()end end;return bc end
local function db(bc,cc,dc)
for _d,ad in pairs(bc.attributes)do
if _d:match("^on%u")then
local bd=_d:sub(3,3):lower().._d:sub(4)if dc[ad]then
cc["on"..bd:sub(1,1):upper()..bd:sub(2)](cc,dc[ad])end end end
for _d,ad in ipairs(bc.children or{})do
if
ad.name and ad.name:match("^on%u")then
local bd=ad.name:sub(3,3):lower()..ad.name:sub(4)
if ad.content then
local cd=ad.content:gsub("^%s+",""):gsub("%s+$","")
local dd,__a=load(string.format([[
                    return %s
                ]],cd),"event","t",dc)if __a then
da.error("Failed to parse event: "..__a)elseif dd then
cc["on"..bd:sub(1,1):upper()..bd:sub(2)](cc,dd())end end end end end;local _c={}
function _c:fromXML(bc)
for cc,dc in pairs(bc.attributes)do
local _d=self:getPropertyConfig(cc)if _d then local ad=cb(dc,_d.type)self.set(cc,ad)end end;return self end;local ac={}
function ac:loadXML(bc,cc)local dc=ab(self,bc)
local function _d(ad,bd,cd)
for dd,__a in ipairs(ad.children)do
if not
__a.name:match("^on")then local a_a=__a.name:sub(1,1):upper()..
__a.name:sub(2)
local b_a=bd["add"..a_a](bd,__a.attributes.name)
for c_a,d_a in pairs(__a.attributes)do local _aa=b_a:getPropertyConfig(c_a)if _aa then
local aaa=cb(d_a,_aa.type,cd)b_a.set(c_a,aaa)end end;db(__a,b_a,cd)
if#__a.children>0 then _d(__a,b_a,cd)end end end end;_d(dc,self,cc)return self end;return{BaseElement=_c,Container=ac} end
project["plugins/state.lua"] = function(...) local d=require("propertySystem")
local _a=require("errorManager")local aa={}
function aa.setup(ba)
ba.defineProperty(ba,"states",{default={},type="table"})
ba.defineProperty(ba,"computedStates",{default={},type="table"})
ba.defineProperty(ba,"stateUpdate",{default={key="",value=nil,oldValue=nil},type="table"})end
function aa:initializeState(ba,ca,da,_b,ab)local bb=self.get("states")
if bb[ba]then _a.error("State '"..
ba.."' already exists")return self end
if _b then local cb=ab or
("states/"..self.get("name").."_"..ba..".state")
if fs.exists(cb)then
local db=fs.open(cb,"r")
bb[ba]={value=textutils.unserialize(db.readAll()),persist=true,file=cb}db.close()else
bb[ba]={value=ca,persist=true,file=cb,canTriggerRender=da}end else bb[ba]={value=ca,canTriggerRender=da}end;return self end
function aa:setState(ba,ca)local da=self.get("states")
if not da[ba]then error("State '"..
ba.."' not initialized")end;local _b=da[ba].value;da[ba].value=ca
if da[ba].persist then
local ab=fs.getDir(da[ba].file)if not fs.exists(ab)then fs.makeDir(ab)end
local bb=fs.open(da[ba].file,"w")bb.write(textutils.serialize(ca))
bb.close()end;if da[ba].canTriggerRender then self:updateRender()end
self.set("stateUpdate",{key=ba,value=ca,oldValue=_b})return self end
function aa:getState(ba)local ca=self.get("states")
if not ca[ba]then _a.error("State '"..
ba.."' not initialized")end;return ca[ba].value end
function aa:computed(ba,ca)local da=self.get("computedStates")
da[ba]=setmetatable({},{__call=function()
return ca(self)end})return self end
function aa:shareState(ba,...)local ca=self:getState(ba)
for da,_b in ipairs({...})do if
_b.get("states")[ba]then
_a.error("Cannot share state '"..ba.."': Target element already has this state")return self end
_b:initializeState(ba,ca)
self:observe("stateUpdate",function(ab,bb)
if bb.key==ba then _b:setState(ba,bb.value)end end)end;return self end
function aa:onStateChange(ba,ca)if not self.get("states")[ba]then
_a.error("Cannot observe state '"..ba..
"': State not initialized")return self end
self:observe("stateUpdate",function(da,_b)if
_b.key==ba then ca(da,_b.value,_b.oldValue)end end)return self end;return{BaseElement=aa} end
project["plugins/reactive.lua"] = function(...) local ab=require("errorManager")
local bb=require("propertySystem")local cb={colors=true,math=true,clamp=true,round=true}
local db={clamp=function(ad,bd,cd)return
math.min(math.max(ad,bd),cd)end,round=function(ad)
return math.floor(ad+0.5)end}
local function _c(ad,bd,cd)ad=ad:gsub("^{(.+)}$","%1")
ad=ad:gsub("([%w_]+)%$([%w_]+)",function(b_a,c_a)
if b_a=="self"then return
string.format('__getState("%s")',c_a)elseif b_a=="parent"then return
string.format('__getParentState("%s")',c_a)else return
string.format('__getElementState("%s", "%s")',b_a,c_a)end end)
ad=ad:gsub("([%w_]+)%.([%w_]+)",function(b_a,c_a)if cb[b_a]then return b_a.."."..c_a end;return
string.format('__getProperty("%s", "%s")',b_a,c_a)end)
local dd=setmetatable({colors=colors,math=math,tostring=tostring,tonumber=tonumber,__getState=function(b_a)return bd:getState(b_a)end,__getParentState=function(b_a)return
bd.parent:getState(b_a)end,__getElementState=function(b_a,c_a)
local d_a=bd:getBaseFrame():getChild(b_a)if not d_a then ab.header="Reactive evaluation error"
ab.error("Could not find element: "..b_a)return nil end;return
d_a:getState(c_a).value end,__getProperty=function(b_a,c_a)
if
b_a=="self"then return bd.get(c_a)elseif b_a=="parent"then
return bd.parent.get(c_a)else local d_a=bd.parent:getChild(b_a)if not d_a then
ab.header="Reactive evaluation error"
ab.error("Could not find element: "..b_a)return nil end
return d_a.get(c_a)end end},{__index=db})if(bd._properties[cd].type=="string")then
ad="tostring("..ad..")"elseif(bd._properties[cd].type=="number")then
ad="tonumber("..ad..")"end;local __a,a_a=load("return "..
ad,"reactive","t",dd)
if not __a then
ab.header="Reactive evaluation error"ab.error("Invalid expression: "..a_a)return
function()return nil end end;return __a end
local function ac(ad,bd)
for cd in ad:gmatch("([%w_]+)%.")do
if not cb[cd]then
if cd=="self"then elseif cd=="parent"then
if not bd.parent then
ab.header="Reactive evaluation error"ab.error("No parent element available")return false end else local dd=bd.parent:getChild(cd)if not dd then
ab.header="Reactive evaluation error"
ab.error("Referenced element not found: "..cd)return false end end end end;return true end;local bc=setmetatable({},{__mode="k"})
local cc=setmetatable({},{__mode="k",__index=function(ad,bd)ad[bd]={}
return ad[bd]end})
local function dc(ad,bd,cd)
if cc[ad][cd]then for __a,a_a in ipairs(cc[ad][cd])do
a_a.target:removeObserver(a_a.property,a_a.callback)end end;local dd={}
for __a,a_a in bd:gmatch("([%w_]+)%.([%w_]+)")do
if not cb[__a]then local b_a;if __a=="self"then b_a=ad elseif
__a=="parent"then b_a=ad.parent else
b_a=ad:getBaseFrame():getChild(__a)end;if b_a then
local c_a={target=b_a,property=a_a,callback=function()
ad:updateRender()end}b_a:observe(a_a,c_a.callback)
table.insert(dd,c_a)end end end;cc[ad][cd]=dd end
bb.addSetterHook(function(ad,bd,cd,dd)
if type(cd)=="string"and cd:match("^{.+}$")then
local __a=cd:gsub("^{(.+)}$","%1")if not ac(__a,ad)then return dd.default end;dc(ad,__a,bd)if
not bc[ad]then bc[ad]={}end;if not bc[ad][cd]then local a_a=_c(cd,ad,bd)
bc[ad][cd]=a_a end
return
function(a_a)local b_a,c_a=pcall(bc[ad][cd])
if not b_a then
ab.header="Reactive evaluation error"
if type(c_a)=="string"then
ab.error("Error evaluating expression: "..c_a)else ab.error("Error evaluating expression")end;return dd.default end;return c_a end end end)local _d={}
_d.hooks={destroy=function(ad)
if cc[ad]then
for bd,cd in pairs(cc[ad])do for dd,__a in ipairs(cd)do
__a.target:removeObserver(__a.property,__a.callback)end end;cc[ad]=nil end end}return{BaseElement=_d} end
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
function da:start()self.currentSequence=1
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
ipairs(self.sequences[self.currentSequence])do dc:start()table.insert(_c,dc)end end end;if#_c>0 then self.timer=os.startTimer(0.05)end end end
da.registerAnimation("move",{start=function(ab)ab.startX=ab.element.get("x")
ab.startY=ab.element.get("y")end,update=function(ab,bb)local cb=ab.startX+
(ab.args[1]-ab.startX)*bb;local db=ab.startY+
(ab.args[2]-ab.startY)*bb
ab.element.set("x",math.floor(cb))ab.element.set("y",math.floor(db))return bb>=1 end,complete=function(ab)
ab.element.set("x",ab.args[1])ab.element.set("y",ab.args[2])end})
da.registerAnimation("moveOffset",{start=function(ab)ab.startX=ab.element.get("offsetX")
ab.startY=ab.element.get("offsetY")end,update=function(ab,bb)local cb=ab.startX+ (ab.args[1]-ab.startX)*
bb;local db=ab.startY+ (ab.args[2]-
ab.startY)*bb
ab.element.set("offsetX",math.floor(cb))ab.element.set("offsetY",math.floor(db))return
bb>=1 end,complete=function(ab)
ab.element.set("offsetX",ab.args[1])ab.element.set("offsetY",ab.args[2])end})
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
da.registerAnimation("scrollText",{start=function(ab)ab.width=ab.element.get("width")
ab.targetText=ab.args[2]ab.element.set(ab.args[1],"")end,update=function(ab,bb)local cb=math.floor(
ab.width* (1 -bb))
local db=string.rep(" ",cb)
ab.element.set(ab.args[1],db..ab.targetText)return bb>=1 end})local _b={hooks={}}function _b.hooks.dispatchEvent(ab,bb,...)
if bb=="timer"then local cb=ab.get("animation")if
cb then cb:event(bb,...)end;return true end end
function _b.setup(ab)
ab.defineProperty(ab,"animation",{default=
nil,type="table"})ab.defineEvent(ab,"timer")end
function _b:animate()local ab=da.new(self)self.set("animation",ab)return ab end;return{VisualElement=_b} end
project["plugins/debug.lua"] = function(...) local da=require("log")local _b=require("libraries/colorHex")
local ab=10;local bb=false
local function cb(bc)
local cc={renderCount=0,eventCount={},lastRender=os.epoch("utc"),properties={},children={}}
return
{trackProperty=function(dc,_d)cc.properties[dc]=_d end,trackRender=function()
cc.renderCount=cc.renderCount+1;cc.lastRender=os.epoch("utc")end,trackEvent=function(dc)cc.eventCount[dc]=(
cc.eventCount[dc]or 0)+1 end,dump=function()return
{type=bc.get("type"),id=bc.get("id"),stats=cc}end}end;local db={}function db.debug(bc,cc)bc._debugger=cb(bc)
bc._debugLevel=cc or DEBUG_LEVELS.INFO;return bc end
function db.dumpDebug(bc)if
not bc._debugger then return end;return bc._debugger.dump()end;local _c={}
function _c.showDebugLog(bc)
if not bc._debugFrame then local cc=bc.get("width")
local dc=bc.get("height")
bc._debugFrame=bc:addFrame("basaltDebugLog"):setWidth(cc):setHeight(dc):setZ(999):listenEvent("mouse_scroll",true)
bc.basalt.LOGGER.debug("Created debug log frame "..bc._debugFrame.get("name"))
bc._debugFrame:addButton("basaltDebugLogClose"):setWidth(9):setHeight(1):setX(
cc-8):setY(dc):setText("Close"):onMouseClick(function()
bc:hideDebugLog()end)bc._debugFrame._scrollOffset=0
bc._debugFrame._processedLogs={}
local function _d(__a,a_a)local b_a={}while#__a>0 do local c_a=__a:sub(1,a_a)table.insert(b_a,c_a)__a=__a:sub(
a_a+1)end;return b_a end
local function ad()local __a={}local a_a=bc._debugFrame.get("width")
for b_a,c_a in
ipairs(da._logs)do local d_a=_d(c_a.message,a_a)for _aa,aaa in ipairs(d_a)do
table.insert(__a,{text=aaa,level=c_a.level})end end;return __a end;local bd=#ad()-bc.get("height")bc._scrollOffset=bd
local cd=bc._debugFrame.render
bc._debugFrame.render=function(__a)cd(__a)__a._processedLogs=ad()
local a_a=__a.get("height")-2;local b_a=#__a._processedLogs;local c_a=math.max(0,b_a-a_a)
__a._scrollOffset=math.min(__a._scrollOffset,c_a)
for i=1,a_a-2 do local d_a=i+__a._scrollOffset
local _aa=__a._processedLogs[d_a]
if _aa then
local aaa=

_aa.level==da.LEVEL.ERROR and colors.red or _aa.level==
da.LEVEL.WARN and colors.yellow or _aa.level==da.LEVEL.DEBUG and colors.lightGray or colors.white;__a:textFg(2,i,_aa.text,aaa)end end end;local dd=bc._debugFrame.dispatchEvent
bc._debugFrame.dispatchEvent=function(__a,a_a,b_a,...)
if
(a_a=="mouse_scroll")then
__a._scrollOffset=math.max(0,__a._scrollOffset+b_a)__a:updateRender()return true else dd(__a,a_a,b_a,...)end end end;bc._debugFrame.set("visible",true)return bc end
function _c.hideDebugLog(bc)if bc._debugFrame then
bc._debugFrame.set("visible",false)end;return bc end;function _c.toggleDebugLog(bc)if bc._debugFrame and bc._debugFrame:isVisible()then
bc:hideDebugLog()else bc:showDebugLog()end
return bc end
local ac={}
function ac.debugChildren(bc,cc)bc:debug(cc)for dc,_d in pairs(bc.get("children"))do if _d.debug then
_d:debug(cc)end end;return bc end;return{BaseElement=db,Container=ac,BaseFrame=_c} end
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
project["plugins/theme.lua"] = function(...) 
local _b={default={background=colors.lightGray,foreground=colors.black},BaseFrame={background=colors.white,foreground=colors.black,Frame={background=colors.black,names={basaltDebugLogClose={background=colors.blue,foreground=colors.white}}},Button={background="{self.clicked and colors.black or colors.cyan}",foreground="{self.clicked and colors.cyan or colors.black}"},names={basaltDebugLog={background=colors.red,foreground=colors.white},test={background="{self.clicked and colors.black or colors.green}",foreground="{self.clicked and colors.green or colors.black}"}}}}local ab={default=_b}local bb="default"
local cb={hooks={postInit={pre=function(dc)dc:applyTheme()end}}}
function cb.____getElementPath(dc,_d)if _d then table.insert(_d,1,dc._values.type)else
_d={dc._values.type}end;local ad=dc.parent;if ad then return
ad.____getElementPath(ad,_d)else return _d end end
local function db(dc,_d)local ad=dc
for i=1,#_d do local bd=false;local cd=_d[i]for dd,__a in ipairs(cd)do
if ad[__a]then ad=ad[__a]bd=true;break end end;if not bd then return nil end end;return ad end
local function _c(dc,_d)local ad={}
if dc.default then for bd,cd in pairs(dc.default)do
if type(cd)~="table"then ad[bd]=cd end end;if dc.default[_d]then
for bd,cd in
pairs(dc.default[_d])do if type(cd)~="table"then ad[bd]=cd end end end end;return ad end
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
local function bc(dc,_d,ad,bd)local cd={}local dd=db(dc,_d)
if dd then for __a,a_a in pairs(dd)do
if type(a_a)~="table"then cd[__a]=a_a end end end;if next(cd)==nil then cd=_c(dc,ad)end;ac(cd,dc,ad,bd,dd)
return cd end
function cb:applyTheme()local dc=self:getTheme()if(dc~=nil)then
for _d,ad in pairs(dc)do self.set(_d,ad)end end end
function cb:getTheme()local dc=self:____getElementPath()
local _d=self.get("type")local ad=self.get("name")return bc(ab[bb],dc,_d,ad)end;local cc={}function cc.setTheme(dc)ab.default=dc end
function cc.getTheme()return ab.default end
function cc.loadTheme(dc)local _d=fs.open(dc,"r")if _d then local ad=_d.readAll()_d.close()
ab.default=textutils.unserializeJSON(ad)end end;return{BaseElement=cb,API=cc} end
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
project["init.lua"] = function(...) local da={...}local _b=fs.getDir(da[2])local ab=package.path
local bb="path;/path/?.lua;/path/?/init.lua;"local cb=bb:gsub("path",_b)package.path=cb.."rom/?"
local function db(bc)
local cc=require("errorManager")cc.header="Basalt Loading Error"cc.error(bc)end;local _c,ac=pcall(require,"main")package.path=ab
if not _c then db(ac)else return ac end end
return project["main.lua"]()