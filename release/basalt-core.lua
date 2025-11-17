local minified = true
local minified_elementDirectory = {}
local minified_pluginDirectory = {}
local project = {}
local loadedProject = {}
local baseRequire = require
require = function(path) if(project[path..".lua"])then if(loadedProject[path]==nil)then loadedProject[path] = project[path..".lua"]() end return loadedProject[path] end return baseRequire(path) end
minified_elementDirectory["BaseFrame"] = {}
minified_elementDirectory["Image"] = {}
minified_elementDirectory["BarChart"] = {}
minified_elementDirectory["Button"] = {}
minified_elementDirectory["Label"] = {}
minified_elementDirectory["Input"] = {}
minified_elementDirectory["Frame"] = {}
minified_elementDirectory["Container"] = {}
minified_elementDirectory["LineChart"] = {}
minified_elementDirectory["Menu"] = {}
minified_elementDirectory["VisualElement"] = {}
minified_elementDirectory["ProgressBar"] = {}
minified_elementDirectory["CheckBox"] = {}
minified_elementDirectory["BaseElement"] = {}
minified_elementDirectory["List"] = {}
minified_elementDirectory["Collection"] = {}
minified_pluginDirectory["store"] = {}
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