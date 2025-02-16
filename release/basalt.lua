local minified = true
local project = {}
local baseRequire = require
require = function(path) return project[path] or baseRequire(path) end
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
project["propertySystem.lua"] = function(...) local ca=require("libraries/utils").deepCopy
local da=require("libraries/expect")local _b=require("errorManager")local ab=require("log")local bb={}
bb.__index=bb;bb._properties={}local cb={}bb._setterHooks={}function bb.addSetterHook(_c)
table.insert(bb._setterHooks,_c)end
local function db(_c,ac,bc,cc)for dc,_d in ipairs(bb._setterHooks)do
local ad=_d(_c,ac,bc,cc)if ad~=nil then bc=ad end end;return bc end
function bb.defineProperty(_c,ac,bc)
if not rawget(_c,'_properties')then _c._properties={}end
_c._properties[ac]={type=bc.type,default=bc.default,canTriggerRender=bc.canTriggerRender,getter=bc.getter,setter=bc.setter}local cc=ac:sub(1,1):upper()..ac:sub(2)
_c[
"get"..cc]=function(dc,...)da(1,dc,"element")local _d=dc._values[ac]
if type(_d)==
"function"and bc.type~="function"then _d=_d(dc)end
return bc.getter and bc.getter(dc,_d,...)or _d end
_c["set"..cc]=function(dc,_d,...)da(1,dc,"element")_d=db(dc,ac,_d,bc)if
type(_d)~="function"then da(2,_d,bc.type)end;if bc.setter then
_d=bc.setter(dc,_d,...)end;dc:_updateProperty(ac,_d)return dc end end
function bb.combineProperties(_c,ac,...)local bc={...}for dc,_d in pairs(bc)do
if not _c._properties[_d]then _b.error("Property not found: "..
_d)end end;local cc=
ac:sub(1,1):upper()..ac:sub(2)
_c["get"..cc]=function(dc,...)
da(1,dc,"element")local _d={}for ad,bd in pairs(bc)do _d[bd]=dc.get(bd)end;return
table.unpack(_d)end
_c["set"..cc]=function(dc,...)da(1,dc,"element")local _d={...}for ad,bd in pairs(bc)do
dc.set(bd,_d[ad])end;return dc end end
function bb.blueprint(_c,ac,bc,cc)
if not cb[_c]then
local _d={basalt=bc,__isBlueprint=true,_values=ac or{},_events={},render=function()end,dispatchEvent=function()end,init=function()end}
_d.loaded=function(bd,cd)bd.loadedCallback=cd;return _d end
_d.create=function(bd)local cd=_c.new()cd:init({},bd.basalt)for dd,__a in pairs(bd._values)do
cd._values[dd]=__a end;for dd,__a in pairs(bd._events)do for a_a,b_a in ipairs(__a)do
cd[dd](cd,b_a)end end;if(cc~=nil)then
cc:addChild(cd)end;cd:updateRender()bd.loadedCallback(cd)
cd:postInit()return cd end;local ad=_c
while ad do
if rawget(ad,'_properties')then for bd,cd in pairs(ad._properties)do
if
type(cd.default)=="table"then _d._values[bd]=ca(cd.default)else _d._values[bd]=cd.default end end end
ad=getmetatable(ad)and rawget(getmetatable(ad),'__index')end;cb[_c]=_d end;local dc={_values={},_events={},loadedCallback=function()end}
dc.get=function(_d)
local ad=dc._values[_d]local bd=_c._properties[_d]if
type(ad)=="function"and bd.type~="function"then ad=ad(dc)end;return ad end
dc.set=function(_d,ad)dc._values[_d]=ad;return dc end
setmetatable(dc,{__index=function(_d,ad)
if ad:match("^on%u")then return
function(bd,cd)
_d._events[ad]=_d._events[ad]or{}table.insert(_d._events[ad],cd)return _d end end
if ad:match("^get%u")then
local bd=ad:sub(4,4):lower()..ad:sub(5)return function()return _d._values[bd]end end;if ad:match("^set%u")then
local bd=ad:sub(4,4):lower()..ad:sub(5)
return function(cd,dd)_d._values[bd]=dd;return _d end end
return cb[_c][ad]end})return dc end
function bb.createFromBlueprint(_c,ac,bc)local cc=_c.new({},bc)
for dc,_d in pairs(ac._values)do if type(_d)=="table"then
cc._values[dc]=ca(_d)else cc._values[dc]=_d end end;return cc end
function bb:__init()self._values={}self._observers={}
self.set=function(dc,_d,...)
local ad=self._values[dc]local bd=self._properties[dc]
if(bd~=nil)then if(bd.setter)then
_d=bd.setter(self,_d,...)end
if bd.canTriggerRender then self:updateRender()end;self._values[dc]=db(self,dc,_d,bd)if
ad~=_d and self._observers[dc]then
for cd,dd in ipairs(self._observers[dc])do dd(self,_d,ad)end end end end
self.get=function(dc,...)local _d=self._values[dc]local ad=self._properties[dc]
if
(ad==nil)then _b.error("Property not found: "..dc)return end;if type(_d)=="function"and ad.type~="function"then
_d=_d(self)end;return
ad.getter and ad.getter(self,_d,...)or _d end;local _c={}local ac=getmetatable(self).__index
while ac do if
rawget(ac,'_properties')then
for dc,_d in pairs(ac._properties)do if not _c[dc]then _c[dc]=_d end end end;ac=getmetatable(ac)and
rawget(getmetatable(ac),'__index')end;self._properties=_c;local bc=getmetatable(self)local cc=bc.__index
setmetatable(self,{__index=function(dc,_d)
local ad=self._properties[_d]
if ad then local bd=self._values[_d]if
type(bd)=="function"and ad.type~="function"then bd=bd(self)end;return bd end
if type(cc)=="function"then return cc(dc,_d)else return cc[_d]end end,__newindex=function(dc,_d,ad)
local bd=self._properties[_d]
if bd then if bd.setter then ad=bd.setter(self,ad)end
ad=db(self,_d,ad,bd)self:_updateProperty(_d,ad)else rawset(dc,_d,ad)end end,__tostring=function(dc)return
string.format("Object: %s (id: %s)",dc._values.type,dc.id)end})
for dc,_d in pairs(_c)do if self._values[dc]==nil then
if type(_d.default)=="table"then
self._values[dc]=ca(_d.default)else self._values[dc]=_d.default end end end;return self end
function bb:_updateProperty(_c,ac)local bc=self._values[_c]
if type(bc)=="function"then bc=bc(self)end;self._values[_c]=ac
local cc=type(ac)=="function"and ac(self)or ac
if bc~=cc then
if self._properties[_c].canTriggerRender then self:updateRender()end
if self._observers[_c]then for dc,_d in ipairs(self._observers[_c])do
_d(self,cc,bc)end end end end
function bb:observe(_c,ac)
self._observers[_c]=self._observers[_c]or{}table.insert(self._observers[_c],ac)return self end
function bb:removeObserver(_c,ac)
if self._observers[_c]then
for bc,cc in ipairs(self._observers[_c])do if cc==ac then
table.remove(self._observers[_c],bc)
if#self._observers[_c]==0 then self._observers[_c]=nil end;break end end end;return self end;function bb:removeAllObservers(_c)
if _c then self._observers[_c]=nil else self._observers={}end;return self end
function bb:instanceProperty(_c,ac)
bb.defineProperty(self,_c,ac)self._values[_c]=ac.default;return self end
function bb:removeProperty(_c)self._values[_c]=nil;self._properties[_c]=nil;self._observers[_c]=
nil
local ac=_c:sub(1,1):upper().._c:sub(2)self["get"..ac]=nil;self["set"..ac]=nil;return self end
function bb:getPropertyConfig(_c)return self._properties[_c]end;return bb end
project["main.lua"] = function(...) local bc=require("elementManager")
local cc=require("errorManager")local dc=require("propertySystem")local _d={}_d.traceback=true
_d._events={}_d._schedule={}_d._plugins={}_d.LOGGER=require("log")
_d.path=fs.getDir(select(2,...))local ad=nil;local bd=false;local cd=type;local dd={}local __a=10;local a_a=0;local b_a=false;local function c_a()if(b_a)then return end
a_a=os.startTimer(0.2)b_a=true end;local function d_a(caa)
for _=1,caa do local daa=dd[1]if(daa)then
daa:create()end;table.remove(dd,1)end end
local function _aa(caa,daa)if(caa=="timer")then
if(daa==a_a)then
d_a(__a)b_a=false;a_a=0;if(#dd>0)then c_a()end;return true end end end
function _d.create(caa,daa,_ba,aba)if(cd(daa)=="string")then daa={name=daa}end;if(daa==nil)then
daa={name=caa}end;local bba=bc.getElement(caa)
if(_ba)then
local cba=dc.blueprint(bba,daa,_d,aba)table.insert(dd,cba)c_a()return cba else local cba=bba.new()
cba:init(daa,_d)return cba end end;function _d.createFrame()local caa=_d.create("BaseFrame")caa:postInit()ad=caa
return caa end
function _d.getElementManager()return bc end
function _d.getMainFrame()if(ad==nil)then ad=_d.createFrame()end;return ad end;function _d.setActiveFrame(caa)ad=caa end;function _d.scheduleUpdate(caa)
table.insert(_d._schedule,caa)return#_d._schedule end;function _d.removeSchedule(caa)_d._schedule[caa]=
nil end
local function aaa(caa,...)
if(caa=="terminate")then _d.stop()end;if _aa(caa,...)then return end;if(ad)then
if(ad:dispatchEvent(caa,...))then return end end;if _d._events[caa]then for daa,_ba in ipairs(_d._events[caa])do
_ba(...)end end end;local function baa()if(ad)then ad:render()end end;function _d.update()
for caa,daa in
pairs(_d._schedule)do if type(daa)=="function"then daa()end end end;function _d.stop()term.clear()
term.setCursorPos(1,1)bd=false end
function _d.run(caa)bd=caa
if(caa==nil)then bd=true end;local function daa()baa()
while bd do aaa(os.pullEventRaw())baa()end end
while bd do local _ba,aba=pcall(daa)if not(_ba)then
cc.header="Basalt Runtime Error"cc.error(aba)end end end;function _d.getAPI(caa)return bc.getAPI(caa)end;return _d end
project["init.lua"] = function(...) local da={...}local _b=fs.getDir(da[2])local ab=package.path
local bb="path;/path/?.lua;/path/?/init.lua;"local cb=bb:gsub("path",_b)package.path=cb.."rom/?"
local function db(bc)
local cc=require("errorManager")cc.header="Basalt Loading Error"cc.error(bc)end;local _c,ac=pcall(require,"main")package.path=ab
if not _c then db(ac)else return ac end end
project["libraries/expect.lua"] = function(...) local c=require("errorManager")
local function d(_a,aa,ba)local ca=type(aa)
if ba=="element"then if ca=="table"and
aa.get("type")~=nil then return true end end
if ba=="color"then
if ca=="number"and aa>=1 and aa<=32768 then return true end;if ca=="string"and colors[aa]then return true end end;if ca~=ba then c.header="Basalt Type Error"
c.error(string.format("Bad argument #%d: expected %s, got %s",_a,ba,ca))end;return true end;return d end
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
function aa.split(ba,ca)local da={}local _b=1;local ab=_a(ba)local bb=1
while true do local cb=ba:find(ca,_b,true)if not cb then
da[bb]=ba:sub(_b,ab)break end;da[bb]=ba:sub(_b,cb-1)_b=cb+1;bb=bb+1 end;return da end;return aa end
project["plugins/debug.lua"] = function(...) local da=require("log")local _b=require("libraries/colorHex")
local ab=10;local bb=false
local function cb(bc)
local cc={renderCount=0,eventCount={},lastRender=os.epoch("utc"),properties={},children={}}
return
{trackProperty=function(dc,_d)cc.properties[dc]=_d end,trackRender=function()
cc.renderCount=cc.renderCount+1;cc.lastRender=os.epoch("utc")end,trackEvent=function(dc)cc.eventCount[dc]=(
cc.eventCount[dc]or 0)+1 end,dump=function()return
{type=bc.get("type"),id=bc.get("id"),stats=cc}end}end
local db={debug=function(bc,cc)bc._debugger=cb(bc)
bc._debugLevel=cc or DEBUG_LEVELS.INFO;return bc end,dumpDebug=function(bc)
if not bc._debugger then return end;return bc._debugger.dump()end}
local _c={showDebugLog=function(bc)
if not bc._debugFrame then local cc=bc.get("width")local dc=bc.get("height")
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
__a._scrollOffset=math.max(0,__a._scrollOffset+b_a)__a:updateRender()return true else dd(__a,a_a,b_a,...)end end end;bc._debugFrame.set("visible",true)return bc end,hideDebugLog=function(bc)
if
bc._debugFrame then bc._debugFrame.set("visible",false)end;return bc end,toggleDebugLog=function(bc)
if bc._debugFrame and
bc._debugFrame:isVisible()then bc:hideDebugLog()else bc:showDebugLog()end;return bc end}
local ac={debugChildren=function(bc,cc)bc:debug(cc)for dc,_d in pairs(bc.get("children"))do
if _d.debug then _d:debug(cc)end end;return bc end}return{BaseElement=db,Container=ac,BaseFrame=_c} end
project["plugins/theme.lua"] = function(...) 
local ab={default={background=colors.lightGray,foreground=colors.black},BaseFrame={background=colors.white,foreground=colors.black,Frame={background=colors.black,names={basaltDebugLogClose={background=colors.blue,foreground=colors.white}}},Button={background="{self.clicked and colors.black or colors.cyan}",foreground="{self.clicked and colors.cyan or colors.black}"},names={basaltDebugLog={background=colors.red,foreground=colors.white},test={background="{self.clicked and colors.black or colors.green}",foreground="{self.clicked and colors.green or colors.black}"}}}}local bb={default=ab}local cb="default"
local db={hooks={postInit={pre=function(ad)ad:applyTheme()end}}}
function db.____getElementPath(ad,bd)if bd then table.insert(bd,1,ad._values.type)else
bd={ad._values.type}end;local cd=ad.parent;if cd then return
cd.____getElementPath(cd,bd)else return bd end end
local function _c(ad,bd)local cd=ad
for i=1,#bd do local dd=false;local __a=bd[i]for a_a,b_a in ipairs(__a)do
if cd[b_a]then cd=cd[b_a]dd=true;break end end;if not dd then return nil end end;return cd end
local function ac(ad,bd)local cd={}
if ad.default then for dd,__a in pairs(ad.default)do
if type(__a)~="table"then cd[dd]=__a end end;if ad.default[bd]then
for dd,__a in
pairs(ad.default[bd])do if type(__a)~="table"then cd[dd]=__a end end end end;return cd end
local function bc(ad,bd,cd,dd,__a)
if
bd.default and bd.default.names and bd.default.names[dd]then for a_a,b_a in pairs(bd.default.names[dd])do
if type(b_a)~="table"then ad[a_a]=b_a end end end
if

bd.default and bd.default[cd]and bd.default[cd].names and bd.default[cd].names[dd]then
for a_a,b_a in pairs(bd.default[cd].names[dd])do if
type(b_a)~="table"then ad[a_a]=b_a end end end;if __a and __a.names and __a.names[dd]then
for a_a,b_a in pairs(__a.names[dd])do if
type(b_a)~="table"then ad[a_a]=b_a end end end end
local function cc(ad,bd,cd,dd)local __a={}local a_a=_c(ad,bd)
if a_a then for b_a,c_a in pairs(a_a)do
if type(c_a)~="table"then __a[b_a]=c_a end end end;if next(__a)==nil then __a=ac(ad,cd)end
bc(__a,ad,cd,dd,a_a)return __a end
function db:applyTheme()local ad=self:getTheme()if(ad~=nil)then
for bd,cd in pairs(ad)do self.set(bd,cd)end end end
function db:getTheme()local ad=self:____getElementPath()
local bd=self.get("type")local cd=self.get("name")return cc(bb[cb],ad,bd,cd)end
local dc={setTheme=function(ad)ab=ad end,getTheme=function()return ab end,loadTheme=function(ad)local bd=fs.open(ad,"r")
if bd then
local cd=bd.readAll()bd.close()ab=textutils.unserializeJSON(cd)end end}local _d={BaseElement=db,API=dc}return _d end
project["plugins/reactive.lua"] = function(...) local bb=require("errorManager")
local cb=require("propertySystem")local db=require("log")
local _c={colors=true,math=true,clamp=true,round=true}
local ac={clamp=function(cd,dd,__a)return math.min(math.max(cd,dd),__a)end,round=function(cd)return math.floor(
cd+0.5)end}
local function bc(cd,dd,__a)cd=cd:gsub("^{(.+)}$","%1")
cd=cd:gsub("([%w_]+)%$([%w_]+)",function(d_a,_aa)
if d_a=="self"then return
string.format('__getState("%s")',_aa)elseif d_a=="parent"then return
string.format('__getParentState("%s")',_aa)else return
string.format('__getElementState("%s", "%s")',d_a,_aa)end end)
cd=cd:gsub("([%w_]+)%.([%w_]+)",function(d_a,_aa)if _c[d_a]then return d_a..".".._aa end;return
string.format('__getProperty("%s", "%s")',d_a,_aa)end)
local a_a=setmetatable({colors=colors,math=math,tostring=tostring,tonumber=tonumber,__getState=function(d_a)return dd:getState(d_a)end,__getParentState=function(d_a)return
dd.parent:getState(d_a)end,__getElementState=function(d_a,_aa)
local aaa=dd:getBaseFrame():getChild(d_a)if not aaa then bb.header="Reactive evaluation error"
bb.error("Could not find element: "..d_a)return nil end;return
aaa:getState(_aa).value end,__getProperty=function(d_a,_aa)
if
d_a=="self"then return dd.get(_aa)elseif d_a=="parent"then
return dd.parent.get(_aa)else local aaa=dd:getBaseFrame():getChild(d_a)if not aaa then
bb.header="Reactive evaluation error"
bb.error("Could not find element: "..d_a)return nil end
return aaa.get(_aa)end end},{__index=ac})if(dd._properties[__a].type=="string")then
cd="tostring("..cd..")"elseif(dd._properties[__a].type=="number")then
cd="tonumber("..cd..")"end;local b_a,c_a=load(
"return "..cd,"reactive","t",a_a)
if not b_a then
bb.header="Reactive evaluation error"bb.error("Invalid expression: "..c_a)return
function()return nil end end;return b_a end
local function cc(cd,dd)
for __a in cd:gmatch("([%w_]+)%.")do
if not _c[__a]then
if __a=="self"then elseif __a=="parent"then
if not dd.parent then
bb.header="Reactive evaluation error"bb.error("No parent element available")return false end else local a_a=dd:getBaseFrame():getChild(__a)if not a_a then
bb.header="Reactive evaluation error"
bb.error("Referenced element not found: "..__a)return false end end end end;return true end;local dc=setmetatable({},{__mode="k"})
local _d=setmetatable({},{__mode="k",__index=function(cd,dd)cd[dd]={}
return cd[dd]end})
local function ad(cd,dd,__a)
if _d[cd][__a]then for b_a,c_a in ipairs(_d[cd][__a])do
c_a.target:removeObserver(c_a.property,c_a.callback)end end;local a_a={}
for b_a,c_a in dd:gmatch("([%w_]+)%.([%w_]+)")do
if not _c[b_a]then local d_a;if b_a=="self"then d_a=cd elseif
b_a=="parent"then d_a=cd.parent else
d_a=cd:getBaseFrame():getChild(b_a)end;if d_a then
local _aa={target=d_a,property=c_a,callback=function()
cd:updateRender()end}d_a:observe(c_a,_aa.callback)
table.insert(a_a,_aa)end end end;_d[cd][__a]=a_a end
cb.addSetterHook(function(cd,dd,__a,a_a)
if type(__a)=="string"and __a:match("^{.+}$")then
local b_a=__a:gsub("^{(.+)}$","%1")if not cc(b_a,cd)then return a_a.default end;ad(cd,b_a,dd)if not
dc[cd]then dc[cd]={}end;if not dc[cd][__a]then local c_a=bc(__a,cd,dd)
dc[cd][__a]=c_a end
return
function(c_a)local d_a,_aa=pcall(dc[cd][__a])
if
not d_a then bb.header="Reactive evaluation error"if type(_aa)=="string"then bb.error(
"Error evaluating expression: ".._aa)else
bb.error("Error evaluating expression")end
return a_a.default end;return _aa end end end)local bd={}
bd.hooks={destroy=function(cd)
if _d[cd]then
for dd,__a in pairs(_d[cd])do for a_a,b_a in ipairs(__a)do
b_a.target:removeObserver(b_a.property,b_a.callback)end end;_d[cd]=nil end end}return{BaseElement=bd} end
project["plugins/xml.lua"] = function(...) local da=require("errorManager")
local function _b(bc)local cc={attributes={}}
cc.name=bc:match("<(%w+)")
for dc,_d in bc:gmatch('%s(%w+)="([^"]-)"')do cc.attributes[dc]=_d end;return cc end
local function ab(bc,cc)local dc={}local _d={children={}}local ad=_d;local bd=false;local cd=""
for dd in cc:gmatch("[^\r\n]+")do
dd=dd:match("^%s*(.-)%s*$")
bc.basalt.LOGGER.debug("Parsing line: "..dd)
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
if cc=="number"then return tonumber(bc)elseif cc=="boolean"then return bc=="true"elseif cc=="color"then return
colors[bc]elseif cc=="table"then local _d=setmetatable({},{__index=_ENV})local ad=load(
"return "..bc,nil,"t",_d)if ad then return ad()end end;return bc end
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
project["plugins/animation.lua"] = function(...) local aa={}aa.__index=aa;local ba={}
function aa.registerAnimation(ab,bb)ba[ab]=bb
aa[ab]=function(cb,...)local db={...}
local _c="linear"
if(type(db[#db])=="string")then _c=table.remove(db,#db)end;local ac=table.remove(db,#db)
return cb:addAnimation(ab,db,ac,_c)end end
local ca={linear=function(ab)return ab end,easeInQuad=function(ab)return ab*ab end,easeOutQuad=function(ab)
return 1 - (1 -ab)* (1 -ab)end,easeInOutQuad=function(ab)if ab<0.5 then return 2 *ab*ab end;return 1 -
(-2 *ab+2)^2 /2 end}function aa.registerEasing(ab,bb)ca[ab]=bb end;local da={}da.__index=da
function da.new(ab,bb,cb,db,_c)
local ac=setmetatable({},da)ac.element=ab;ac.type=bb;ac.args=cb;ac.duration=db;ac.startTime=0
ac.isPaused=false;ac.handlers=ba[bb]ac.easing=_c;return ac end
function da:start()self.startTime=os.epoch("local")/1000;if
self.handlers.start then self.handlers.start(self)end end
function da:update(ab)local bb=math.min(1,ab/self.duration)
local cb=ca[self.easing](bb)return self.handlers.update(self,cb)end;function da:complete()if self.handlers.complete then
self.handlers.complete(self)end end
function aa.new(ab)
local bb={}bb.element=ab;bb.sequences={{}}bb.sequenceCallbacks={}
bb.currentSequence=1;bb.timer=nil;setmetatable(bb,aa)return bb end
function aa:sequence()table.insert(self.sequences,{})self.currentSequence=#
self.sequences;self.sequenceCallbacks[self.currentSequence]={start=nil,update=nil,complete=
nil}return self end
function aa:onStart(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].start=ab;return self end
function aa:onUpdate(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].update=ab;return self end
function aa:onComplete(ab)
if
not self.sequenceCallbacks[self.currentSequence]then self.sequenceCallbacks[self.currentSequence]={}end
self.sequenceCallbacks[self.currentSequence].complete=ab;return self end
function aa:addAnimation(ab,bb,cb,db)local _c=da.new(self.element,ab,bb,cb,db)
table.insert(self.sequences[self.currentSequence],_c)return self end
function aa:start()self.currentSequence=1
if
(self.sequenceCallbacks[self.currentSequence])then if(self.sequenceCallbacks[self.currentSequence].start)then
self.sequenceCallbacks[self.currentSequence].start(self.element)end end
if
#self.sequences[self.currentSequence]>0 then self.timer=os.startTimer(0.05)for ab,bb in
ipairs(self.sequences[self.currentSequence])do bb:start()end end;return self end
function aa:event(ab,bb)
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
aa.registerAnimation("move",{start=function(ab)ab.startX=ab.element.get("x")
ab.startY=ab.element.get("y")end,update=function(ab,bb)local cb=ab.startX+
(ab.args[1]-ab.startX)*bb;local db=ab.startY+
(ab.args[2]-ab.startY)*bb
ab.element.set("x",math.floor(cb))ab.element.set("y",math.floor(db))return bb>=1 end,complete=function(ab)
ab.element.set("x",ab.args[1])ab.element.set("y",ab.args[2])end})
aa.registerAnimation("morphText",{start=function(ab)local bb=ab.element.get(ab.args[1])
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
aa.registerAnimation("typewrite",{start=function(ab)ab.targetText=ab.args[2]
ab.element.set(ab.args[1],"")end,update=function(ab,bb)
local cb=math.floor(#ab.targetText*bb)
ab.element.set(ab.args[1],ab.targetText:sub(1,cb))return bb>=1 end})
aa.registerAnimation("fadeText",{start=function(ab)ab.chars={}for i=1,#ab.args[2]do
ab.chars[i]={char=ab.args[2]:sub(i,i),visible=false}end end,update=function(ab,bb)
local cb=""for db,_c in ipairs(ab.chars)do
if math.random()<bb then _c.visible=true end
cb=cb.. (_c.visible and _c.char or" ")end
ab.element.set(ab.args[1],cb)return bb>=1 end})
aa.registerAnimation("scrollText",{start=function(ab)ab.width=ab.element.get("width")
ab.targetText=ab.args[2]ab.element.set(ab.args[1],"")end,update=function(ab,bb)local cb=math.floor(
ab.width* (1 -bb))
local db=string.rep(" ",cb)
ab.element.set(ab.args[1],db..ab.targetText)return bb>=1 end})local _b={hooks={}}function _b.hooks.dispatchEvent(ab,bb,...)
if bb=="timer"then local cb=ab.get("animation")if
cb then cb:event(bb,...)end end end
function _b.setup(ab)
VisualElementBaseDispatchEvent=ab.dispatchEvent
ab.defineProperty(ab,"animation",{default=nil,type="table"})ab.listenTo(ab,"timer")end
function _b:animate()local ab=aa.new(self)self.set("animation",ab)return ab end;return{VisualElement=_b} end
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
bc:stopContainerBenchmark(_c)else bc:stopBenchmark(_c)end end;self:stopBenchmark(_c)return self end
local db={start=function(_c,ac)ac=ac or{}local bc=_b()bc.name=_c;bc.startTime=os.clock()*1000
bc.custom=true;da[_c]=bc end,stop=function(_c)
local ac=da[_c]if not ac or not ac.custom then return end
local bc=os.clock()*1000;local cc=bc-ac.startTime;ac.calls=ac.calls+1
ac.totalTime=ac.totalTime+cc;ac.minTime=math.min(ac.minTime,cc)
ac.maxTime=math.max(ac.maxTime,cc)ac.lastTime=cc
ca.info(string.format("Custom Benchmark '%s': "..
"Calls: %d ".."Average time: %.2fms "..
"Min time: %.2fms "..
"Max time: %.2fms ".."Last time: %.2fms ".."Total time: %.2fms",_c,ac.calls,
ac.totalTime/ac.calls,ac.minTime,ac.maxTime,ac.lastTime,ac.totalTime))end,getStats=function(_c)
local ac=da[_c]if not ac then return nil end;return
{averageTime=ac.totalTime/ac.calls,totalTime=ac.totalTime,calls=ac.calls,minTime=ac.minTime,maxTime=ac.maxTime,lastTime=ac.lastTime}end,clear=function(_c)da[_c]=
nil end,clearAll=function()
for _c,ac in pairs(da)do if ac.custom then da[_c]=nil end end end}return{BaseElement=bb,Container=cb,API=db} end
project["plugins/pluginTemplate.lua"] = function(...) local b={hooks={init={}}}function b.setup(c)
c.defineProperty(c,"testProp",{default=5,type="number"})end;function b.hooks.init(c)end
function b:testFunc()end;return{VisualElement=b} end
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
aa.defineProperty(aa,"scrollOffset",{default=0,type="number",canTriggerRender=true})aa.listenTo(aa,"mouse_click")
aa.listenTo(aa,"mouse_scroll")
function aa.new()local ba=setmetatable({},aa):__init()
ba.set("width",30)ba.set("height",10)ba.set("z",5)return ba end
function aa:init(ba,ca)d.init(self,ba,ca)self.set("type","Table")return self end
function aa:setColumns(ba)self.set("columns",ba)return self end;function aa:setData(ba)self.set("data",ba)return self end
function aa:sortData(ba)
local ca=self.get("data")local da=self.get("sortDirection")
table.sort(ca,function(_b,ab)if da=="asc"then return
_b[ba]<ab[ba]else return _b[ba]>ab[ba]end end)self.set("data",ca)return self end
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
project["elements/BaseFrame.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("Container")local ba=require("render")local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"term",{default=
nil,type="table",setter=function(da,_b)
if _b==nil or _b.setCursorPos==nil then return _b end;da._render=ba.new(_b)da._renderUpdate=true;local ab,bb=_b.getSize()
da.set("width",ab)da.set("height",bb)return _b end})
function ca.new()local da=setmetatable({},ca):__init()
da.set("term",term.current())da.set("background",colors.lightGray)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","BaseFrame")end;function ca:multiBlit(da,_b,ab,bb,cb,db,_c)
self._render:multiBlit(da,_b,ab,bb,cb,db,_c)end;function ca:textFg(da,_b,ab,bb)
self._render:textFg(da,_b,ab,bb)end;function ca:textBg(da,_b,ab,bb)
self._render:textBg(da,_b,ab,bb)end;function ca:blit(da,_b,ab,bb,cb)
self._render:blit(da,_b,ab,bb,cb)end;function ca:setCursor(da,_b,ab)local bb=self.get("term")
self._render:setCursor(da,_b,ab)end;function ca:render()
if(self._renderUpdate)then if
self._render~=nil then aa.render(self)self._render:render()
self._renderUpdate=false end end end
return ca end
project["elements/ProgressBar.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"progress",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"showPercentage",{default=false,type="boolean"})
d.defineProperty(d,"progressColor",{default=colors.lime,type="number"})
function d.new()local _a=setmetatable({},d):__init()
_a.set("width",10)_a.set("height",1)return _a end
function d:init(_a,aa)c.init(self,_a,aa)self.set("type","ProgressBar")end
function d:render()c.render(self)local _a=self.get("width")
local aa=math.min(100,math.max(0,self.get("progress")))local ba=math.floor((_a*aa)/100)
self:textBg(1,1,string.rep(" ",ba),self.get("progressColor"))if self.get("showPercentage")then local ca=tostring(aa).."%"local da=math.floor(
(_a-#ca)/2)+1
self:textFg(da,1,ca,self.get("foreground"))end end;return d end
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
for _b,ab in ipairs(self.get("items"))do local bb=_b==
self.get("selectedIndex")
local cb=ab.selectable==false and
self.get("separatorColor")or(bb and
(ab.selectedForeground or self.get("foreground"))or
(ab.foreground or self.get("foreground")))
local db=
bb and(ab.selectedBackground or self.get("selectedColor"))or(ab.background or self.get("background"))
self:blit(da,1,ab.text,string.rep(ba[cb],#ab.text),string.rep(ba[db],#ab.text))da=da+#ab.text end end
function ca:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end
if(self.get("selectable")==false)then return false end
local bb=select(1,self:getRelativePosition(_b,ab))local cb=1
for db,_c in ipairs(self.get("items"))do
if
bb>=cb and bb<cb+#_c.text then
if _c.selectable~=false then self.set("selectedIndex",db)
if
type(_c)=="table"then if _c.callback then _c.callback(self)end end;self:fireEvent("select",db,_c)end;return true end;cb=cb+#_c.text end;return false end;return ca end
project["elements/Frame.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("Container")local aa=setmetatable({},_a)aa.__index=aa
function aa.new()
local ba=setmetatable({},aa):__init()ba.set("width",12)ba.set("height",6)
ba.set("background",colors.gray)ba.set("z",10)return ba end
function aa:init(ba,ca)_a.init(self,ba,ca)self.set("type","Frame")end;return aa end
project["elements/Button.lua"] = function(...) local _a=require("elementManager")
local aa=_a.getElement("VisualElement")
local ba=require("libraries/utils").getCenteredPosition;local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"text",{default="Button",type="string",canTriggerRender=true})ca.listenTo(ca,"mouse_click")
ca.listenTo(ca,"mouse_up")
function ca.new()local da=setmetatable({},ca):__init()
da.set("width",10)da.set("height",3)da.set("z",5)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Button")end
function ca:render()aa.render(self)local da=self.get("text")
local _b,ab=ba(da,self.get("width"),self.get("height"))
self:textFg(_b,ab,da,self.get("foreground"))end;return ca end
project["elements/Program.lua"] = function(...) local ba=require("elementManager")
local ca=ba.getElement("VisualElement")local da=require("errorManager")local _b=setmetatable({},ca)
_b.__index=_b
_b.defineProperty(_b,"program",{default=nil,type="table"})
_b.defineProperty(_b,"path",{default="",type="string"})
_b.defineProperty(_b,"running",{default=false,type="boolean"})_b.listenTo(_b,"key")_b.listenTo(_b,"char")
_b.listenTo(_b,"key_up")_b.listenTo(_b,"paste")
_b.listenTo(_b,"mouse_click")_b.listenTo(_b,"mouse_drag")
_b.listenTo(_b,"mouse_scroll")_b.listenTo(_b,"mouse_up")local ab={}ab.__index=ab
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
ca.init(self,cb,db)self.set("type","Program")end
function _b:execute(cb)self.set("path",cb)self.set("running",true)
local db=ab.new()self.set("program",db)
db:run(cb,self.get("width"),self.get("height"))self:updateRender()return self end
function _b:dispatchEvent(cb,...)local db=self.get("program")
local _c=ca.dispatchEvent(self,cb,...)
if db then db:resume(cb,...)if(self.get("focused"))then
local ac=db.window.getCursorBlink()local bc,cc=db.window.getCursorPos()
self:setCursor(bc,cc,ac)end
self:updateRender()end;return _c end
function _b:focus()
if(ca.focus(self))then local cb=self.get("program")if cb then
local db=cb.window.getCursorBlink()local _c,ac=cb.window.getCursorPos()
self:setCursor(_c,ac,db)end end end
function _b:render()ca.render(self)local cb=self.get("program")
if cb then
local db,_c=cb.window.getSize()for y=1,_c do local ac,bc,cc=cb.window.getLine(y)if ac then
self:blit(1,y,ac,bc,cc)end end end end;return _b end
project["elements/Label.lua"] = function(...) local d=require("elementManager")
local _a=d.getElement("VisualElement")local aa=setmetatable({},_a)aa.__index=aa
aa.defineProperty(aa,"text",{default="Label",type="string",setter=function(ba,ca)if(type(ca)==
"function")then ca=ca()end;ba.set("width",#ca)return ca end})
function aa.new()local ba=setmetatable({},aa):__init()
ba.set("z",3)ba.set("foreground",colors.black)
ba.set("backgroundEnabled",false)return ba end
function aa:init(ba,ca)_a.init(self,ba,ca)self.set("type","Label")end;function aa:render()_a.render(self)local ba=self.get("text")
self:textFg(1,1,ba,self.get("foreground"))end;return aa end
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
bc:observe("height",function()bc.set("flexUpdateLayout",true)end)return bc end
function ab:init(bc,cc)_b.init(self,bc,cc)self.set("type","Flexbox")end
function ab:addChild(bc)_b.addChild(self,bc)
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
project["elements/Container.lua"] = function(...) local _b=require("elementManager")
local ab=_b.getElement("VisualElement")local bb=require("libraries/expect")
local cb=require("libraries/utils").split;local db=math.max;local _c=setmetatable({},ab)_c.__index=_c
_c.defineProperty(_c,"children",{default={},type="table"})
_c.defineProperty(_c,"childrenSorted",{default=true,type="boolean"})
_c.defineProperty(_c,"childrenEventsSorted",{default=true,type="boolean"})
_c.defineProperty(_c,"childrenEvents",{default={},type="table"})
_c.defineProperty(_c,"eventListenerCount",{default={},type="table"})
_c.defineProperty(_c,"focusedChild",{default=nil,type="table",setter=function(dc,_d,ad)local bd=dc._values.focusedChild
if _d==bd then return _d end
if bd then
if bd:isType("Container")then bd.set("focusedChild",nil,true)end;bd.set("focused",false,true)end
if _d and not ad then _d.set("focused",true,true)if dc.parent then
dc.parent:setFocusedChild(dc)end end;return _d end})
_c.defineProperty(_c,"visibleChildren",{default={},type="table"})
_c.defineProperty(_c,"visibleChildrenEvents",{default={},type="table"})
for dc,_d in pairs(_b:getElementList())do
local ad=dc:sub(1,1):upper()..dc:sub(2)
if ad~="BaseFrame"then
_c["add"..ad]=function(bd,...)bb(1,bd,"table")
local cd=bd.basalt.create(dc,...)bd:addChild(cd)cd:postInit()return cd end
_c["addDelayed"..ad]=function(bd,cd)bb(1,bd,"table")
local dd=bd.basalt.create(dc,cd,true,bd)return dd end end end
function _c.new()local dc=setmetatable({},_c):__init()return dc end
function _c:init(dc,_d)ab.init(self,dc,_d)self.set("type","Container")end
function _c:isChildVisible(dc)local _d,ad=dc.get("x"),dc.get("y")
local bd,cd=dc.get("width"),dc.get("height")local dd,__a=self.get("width"),self.get("height")
return
_d<=dd and ad<=__a and _d+bd>0 and ad+cd>0 end
function _c:addChild(dc)
if dc==self then error("Cannot add container to itself")end;table.insert(self._values.children,dc)
dc.parent=self;self.set("childrenSorted",false)
self:registerChildrenEvents(dc)return self end
local function ac(dc,_d)local ad={}
for bd,cd in ipairs(_d)do if dc:isChildVisible(cd)and cd.get("visible")then
table.insert(ad,cd)end end
for i=2,#ad do local bd=ad[i]local cd=bd.get("z")local dd=i-1
while dd>0 do
local __a=ad[dd].get("z")if __a>cd then ad[dd+1]=ad[dd]dd=dd-1 else break end end;ad[dd+1]=bd end;return ad end
function _c:clear()self.set("children",{})
self.set("childrenEvents",{})self.set("visibleChildren",{})
self.set("visibleChildrenEvents",{})self.set("childrenSorted",true)
self.set("childrenEventsSorted",true)return self end
function _c:sortChildren()
self.set("visibleChildren",ac(self,self._values.children))self.set("childrenSorted",true)return self end
function _c:sortChildrenEvents(dc)if self._values.childrenEvents[dc]then
self._values.visibleChildrenEvents[dc]=ac(self,self._values.childrenEvents[dc])end
self.set("childrenEventsSorted",true)return self end
function _c:registerChildrenEvents(dc)if(dc._registeredEvents==nil)then return end
for _d in
pairs(dc._registeredEvents)do self:registerChildEvent(dc,_d)end;return self end
function _c:registerChildEvent(dc,_d)
if not self._values.childrenEvents[_d]then
self._values.childrenEvents[_d]={}self._values.eventListenerCount[_d]=0;if self.parent then
self.parent:registerChildEvent(self,_d)end end;for ad,bd in ipairs(self._values.childrenEvents[_d])do
if bd==dc then return self end end
self.set("childrenEventsSorted",false)
table.insert(self._values.childrenEvents[_d],dc)self._values.eventListenerCount[_d]=
self._values.eventListenerCount[_d]+1;return self end
function _c:removeChildrenEvents(dc)if(dc._registeredEvents==nil)then return self end
for _d in
pairs(dc._registeredEvents)do self:unregisterChildEvent(dc,_d)end;return self end
function _c:unregisterChildEvent(dc,_d)
if self._values.childrenEvents[_d]then
for ad,bd in
ipairs(self._values.childrenEvents[_d])do
if bd==dc then
table.remove(self._values.childrenEvents[_d],ad)self._values.eventListenerCount[_d]=
self._values.eventListenerCount[_d]-1
if
self._values.eventListenerCount[_d]<=0 then
self._values.childrenEvents[_d]=nil;self._values.eventListenerCount[_d]=nil;if self.parent then
self.parent:unregisterChildEvent(self,_d)end end;break end end end;return self end
function _c:removeChild(dc)
for _d,ad in ipairs(self._values.children)do if ad==dc then
table.remove(self._values.children,_d)dc.parent=nil;break end end;self:removeChildrenEvents(dc)return self end
function _c:getChild(dc)
if type(dc)=="string"then local _d=cb(dc,"/")
for ad,bd in
pairs(self._values.children)do if bd.get("name")==_d[1]then
if#_d==1 then return bd else if(bd:isType("Container"))then return
bd:find(table.concat(_d,"/",2))end end end end end;return nil end
local function bc(dc,_d,...)local ad={...}if _d:find("mouse_")then local bd,cd,dd=...
local __a,a_a=dc:getRelativePosition(cd,dd)ad={bd,__a,a_a}end
return ad end
local function cc(dc,_d,ad,...)
local bd=_d and dc.get("visibleChildrenEvents")or dc.get("childrenEvents")
if bd[ad]then local cd=bd[ad]for i=#cd,1,-1 do local dd=cd[i]
if(dd:dispatchEvent(ad,...))then return true,dd end end end;return false end
function _c:handleEvent(dc,...)ab.handleEvent(self,dc,...)local _d=bc(self,dc,...)return
cc(self,false,dc,table.unpack(_d))end
function _c:mouse_click(dc,_d,ad)
if ab.mouse_click(self,dc,_d,ad)then
local bd=bc(self,"mouse_click",dc,_d,ad)
local cd,dd=cc(self,true,"mouse_click",table.unpack(bd))
if(cd)then self.set("focusedChild",dd)return true end;self.set("focusedChild",nil)return true end;return false end
function _c:mouse_up(dc,_d,ad)
if ab.mouse_up(self,dc,_d,ad)then local bd=bc(self,"mouse_up",dc,_d,ad)
local cd,dd=cc(self,true,"mouse_up",table.unpack(bd))if(cd)then return true end end;return false end;function _c:key(dc)if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key",dc)end
return true end
function _c:char(dc)if
self.get("focusedChild")then
return self.get("focusedChild"):dispatchEvent("char",dc)end;return true end;function _c:key_up(dc)
if self.get("focusedChild")then return
self.get("focusedChild"):dispatchEvent("key_up",dc)end;return true end
function _c:multiBlit(dc,_d,ad,bd,cd,dd,__a)
local a_a,b_a=self.get("width"),self.get("height")ad=dc<1 and math.min(ad+dc-1,a_a)or
math.min(ad,math.max(0,a_a-dc+1))bd=_d<1 and math.min(
bd+_d-1,b_a)or
math.min(bd,math.max(0,b_a-_d+1))if ad<=0 or
bd<=0 then return self end
ab.multiBlit(self,math.max(1,dc),math.max(1,_d),ad,bd,cd,dd,__a)return self end
function _c:textFg(dc,_d,ad,bd)local cd,dd=self.get("width"),self.get("height")if
_d<1 or _d>dd then return self end;local __a=dc<1 and(2 -dc)or 1
local a_a=math.min(#ad-
__a+1,cd-math.max(1,dc)+1)if a_a<=0 then return self end
ab.textFg(self,math.max(1,dc),math.max(1,_d),ad:sub(__a,
__a+a_a-1),bd)end
function _c:blit(dc,_d,ad,bd,cd)local dd,__a=self.get("width"),self.get("height")if
_d<1 or _d>__a then return self end;local a_a=dc<1 and(2 -dc)or 1
local b_a=math.min(
#ad-a_a+1,dd-math.max(1,dc)+1)
local c_a=math.min(#bd-a_a+1,dd-math.max(1,dc)+1)
local d_a=math.min(#cd-a_a+1,dd-math.max(1,dc)+1)if b_a<=0 then return self end;local _aa=ad:sub(a_a,a_a+b_a-1)local aaa=bd:sub(a_a,
a_a+c_a-1)
local baa=cd:sub(a_a,a_a+d_a-1)
ab.blit(self,math.max(1,dc),math.max(1,_d),_aa,aaa,baa)return self end
function _c:render()ab.render(self)if not self.get("childrenSorted")then
self:sortChildren()end
if
not self.get("childrenEventsSorted")then for dc in pairs(self._values.childrenEvents)do
self:sortChildrenEvents(dc)end end
for dc,_d in ipairs(self.get("visibleChildren"))do if _d==self then
self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")return end;_d:render()end end;return _c end
project["elements/Slider.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"step",{default=1,type="number",canTriggerRender=true})
d.defineProperty(d,"max",{default=100,type="number"})
d.defineProperty(d,"horizontal",{default=true,type="boolean",canTriggerRender=true})
d.defineProperty(d,"barColor",{default=colors.gray,type="number",canTriggerRender=true})
d.defineProperty(d,"sliderColor",{default=colors.blue,type="number",canTriggerRender=true})d.listenTo(d,"mouse_click")
d.listenTo(d,"mouse_drag")d.listenTo(d,"mouse_up")function d.new()
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
project["elements/BaseElement.lua"] = function(...) local d=require("propertySystem")
local _a=require("/libraries/utils").uuid;local aa=setmetatable({},d)aa.__index=aa;aa._events={}
aa.defineProperty(aa,"type",{default={"BaseElement"},type="string",setter=function(ba,ca)if
type(ca)=="string"then table.insert(ba._values.type,1,ca)return
ba._values.type end;return ca end,getter=function(ba,ca,da)if
da~=nil and da<1 then return ba._values.type end;return ba._values.type[
da or 1]end})
aa.defineProperty(aa,"id",{default="",type="string",readonly=true})
aa.defineProperty(aa,"name",{default="",type="string"})
aa.defineProperty(aa,"eventCallbacks",{default={},type="table"})function aa.listenTo(ba,ca)if not ba._events then ba._events={}end
ba._events[ca]=true end;function aa.new()
local ba=setmetatable({},aa):__init()return ba end
function aa:init(ba,ca)self._props=ba
self._values.id=_a()self.basalt=ca;self._registeredEvents={}
if aa._events then
for da in pairs(aa._events)do
self._registeredEvents[da]=true
local _b="on"..
da:gsub("_(%l)",function(ab)return ab:upper()end):gsub("^%l",string.upper)
self[_b]=function(ab,...)ab:registerCallback(da,...)return ab end end end;return self end
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
if self._values.eventCallbacks[ba]then for ca,da in
ipairs(self._values.eventCallbacks[ba])do local _b=da(self,...)return _b end end;return self end;function aa:dispatchEvent(ba,...)if self[ba]then return self[ba](self,...)end;return
self:handleEvent(ba,...)end;function aa:handleEvent(ba,...)return
false end
function aa:getBaseFrame()if self.parent then return
self.parent:getBaseFrame()end;return self end;function aa:destroy()end
function aa:updateRender()if(self.parent)then
self.parent:updateRender()else self._renderUpdate=true end end;return aa end
project["elements/Checkbox.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"checked",{default=false,type="boolean",canTriggerRender=true})
d.defineProperty(d,"text",{default="",type="string",canTriggerRender=true})
d.defineProperty(d,"symbol",{default="x",type="string"})d.listenTo(d,"mouse_click")
function d.new()
local _a=setmetatable({},d):__init()_a.set("width",1)_a.set("height",1)return _a end
function d:init(_a,aa)c.init(self,_a,aa)self.set("type","Checkbox")end
function d:mouse_click(_a,aa,ba)
if c.mouse_click(self,_a,aa,ba)then
self.set("checked",not self.get("checked"))
self:fireEvent("change",self.get("checked"))return true end;return false end
function d:render()c.render(self)local _a=
self.get("checked")and self.get("symbol")or" "
self:textFg(1,1,"[".._a.."]",self.get("foreground"))local aa=self.get("text")if#aa>0 then
self:textFg(4,1,aa,self.get("foreground"))end end;return d end
project["elements/Input.lua"] = function(...) local d=require("elements/VisualElement")
local _a=require("libraries/colorHex")local aa=setmetatable({},d)aa.__index=aa
aa.defineProperty(aa,"text",{default="",type="string",canTriggerRender=true})
aa.defineProperty(aa,"cursorPos",{default=1,type="number"})
aa.defineProperty(aa,"viewOffset",{default=0,type="number",canTriggerRender=true})
aa.defineProperty(aa,"maxLength",{default=nil,type="number"})
aa.defineProperty(aa,"placeholder",{default="asd",type="string"})
aa.defineProperty(aa,"placeholderColor",{default=colors.gray,type="number"})
aa.defineProperty(aa,"focusedColor",{default=colors.blue,type="number"})
aa.defineProperty(aa,"pattern",{default=nil,type="string"})aa.listenTo(aa,"mouse_click")aa.listenTo(aa,"key")
aa.listenTo(aa,"char")function aa.new()local ba=setmetatable({},aa):__init()
ba.set("width",8)ba.set("z",3)return ba end;function aa:init(ba,ca)
d.init(self,ba,ca)self.set("type","Input")end
function aa:char(ba)if
not self.get("focused")then return end
local ca=self.get("text")local da=self.get("cursorPos")local _b=self.get("maxLength")
local ab=self.get("pattern")if _b and#ca>=_b then return end
if ab and not ba:match(ab)then return end
self.set("text",ca:sub(1,da-1)..ba..ca:sub(da))self.set("cursorPos",da+1)self:updateRender()
self:updateViewport()end
function aa:key(ba)if not self.get("focused")then return end
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
local bb=self.get("cursorPos")-self.get("viewOffset")self:setCursor(bb,1,true)end
function aa:focus()d.focus(self)self:updateRender()end
function aa:blur()d.blur(self)self:updateRender()end
function aa:mouse_click(ba,ca,da)
if d.mouse_click(self,ba,ca,da)then
local _b,ab=self:getRelativePosition(ca,da)local bb=self.get("text")
self:setCursor(math.min(_b,#bb+1),ab,true)
self:set("cursorPos",_b+self.get("viewOffset"))return true end end
function aa:updateViewport()local ba=self.get("width")
local ca=self.get("cursorPos")local da=self.get("viewOffset")
local _b=#self.get("text")
if ca-da>ba then self.set("viewOffset",ca-ba)elseif ca<=da then self.set("viewOffset",math.max(0,
ca-1))end;if da>_b-ba then
self.set("viewOffset",math.max(0,_b-ba))end end
function aa:render()local ba=self.get("text")local ca=self.get("viewOffset")
local da=self.get("width")local _b=self.get("placeholder")
local ab=self.get("focusedColor")local bb=self.get("focused")
local cb,db=self.get("width"),self.get("height")
self:multiBlit(1,1,cb,db," ",_a[self.get("foreground")],_a[bb and ab or
self.get("background")])if
#ba==0 and#_b~=0 and self.get("focused")==false then
self:textFg(1,1,_b:sub(1,cb),self.get("placeholderColor"))return end
local _c=ba:sub(ca+1,ca+cb)self:textFg(1,1,_c,self.get("foreground"))end;return aa end
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
_b.defineProperty(_b,"backgroundEnabled",{default=true,type="boolean",canTriggerRender=true})
_b.defineProperty(_b,"focused",{default=false,type="boolean",setter=function(cb,db,_c)local ac=cb.get("focused")
if db==ac then return db end;if db then cb:focus()else cb:blur()end;if not _c and cb.parent then
if db then
cb.parent:setFocusedChild(cb)else cb.parent:setFocusedChild(nil)end end;return db end})
_b.defineProperty(_b,"visible",{default=true,type="boolean",canTriggerRender=true,setter=function(cb,db)
if(cb.parent~=nil)then
cb.parent.set("childrenSorted",false)cb.parent.set("childrenEventsSorted",false)end;return db end})_b.combineProperties(_b,"position","x","y")
_b.combineProperties(_b,"size","width","height")
_b.combineProperties(_b,"color","foreground","background")_b.listenTo(_b,"focus")_b.listenTo(_b,"blur")
local ab,bb=math.max,math.min
function _b.new()local cb=setmetatable({},_b):__init()return cb end;function _b:init(cb,db)ca.init(self,cb,db)
self.set("type","VisualElement")end;function _b:multiBlit(cb,db,_c,ac,bc,cc,dc)
cb=cb+self.get("x")-1;db=db+self.get("y")-1
self.parent:multiBlit(cb,db,_c,ac,bc,cc,dc)end;function _b:textFg(cb,db,_c,ac)cb=cb+
self.get("x")-1;db=db+self.get("y")-1
self.parent:textFg(cb,db,_c,ac)end;function _b:textBg(cb,db,_c,ac)cb=cb+
self.get("x")-1;db=db+self.get("y")-1
self.parent:textBg(cb,db,_c,ac)end;function _b:blit(cb,db,_c,ac,bc)cb=cb+
self.get("x")-1;db=db+self.get("y")-1
self.parent:blit(cb,db,_c,ac,bc)end
function _b:isInBounds(cb,db)
local _c,ac=self.get("x"),self.get("y")local bc,cc=self.get("width"),self.get("height")return
cb>=_c and cb<=
_c+bc-1 and db>=ac and db<=ac+cc-1 end
function _b:mouse_click(cb,db,_c)if self:isInBounds(db,_c)then self.set("clicked",true)
self:fireEvent("mouse_click",cb,self:getRelativePosition(db,_c))return true end;return
false end
function _b:mouse_up(cb,db,_c)self.set("clicked",false)if self:isInBounds(db,_c)then
self:fireEvent("mouse_up",cb,db,_c)return true end
self:fireEvent("mouse_release",cb,self:getRelativePosition(db,_c))end;function _b:mouse_release()self.set("clicked",false)end;function _b:focus()
self:fireEvent("focus")end;function _b:blur()self:fireEvent("blur")
self:setCursor(1,1,false)end
function _b:getAbsolutePosition(cb,db)
local _c,ac=self.get("x"),self.get("y")if(cb~=nil)then _c=_c+cb-1 end;if(db~=nil)then ac=ac+db-1 end
local bc=self.parent;while bc do local cc,dc=bc.get("x"),bc.get("y")_c=_c+cc-1;ac=ac+dc-1
bc=bc.parent end;return _c,ac end
function _b:getRelativePosition(cb,db)if(cb==nil)or(db==nil)then
cb,db=self.get("x"),self.get("y")end;local _c,ac=1,1;if self.parent then
_c,ac=self.parent:getRelativePosition()end;local bc=self.get("x")
local cc=self.get("y")return cb- (bc-1)- (_c-1),db- (cc-1)- (ac-1)end
function _b:setCursor(cb,db,_c)
if self.parent then local ac,bc=self:getAbsolutePosition(cb,db)
ac=ab(self.get("x"),bb(ac,
self.get("width")+self.get("x")-1))return self.parent:setCursor(ac,bc,_c)end end
function _b:render()
if(not self.get("backgroundEnabled"))then return end;local cb,db=self.get("width"),self.get("height")
self:multiBlit(1,1,cb,db," ",da[self.get("foreground")],da[self.get("background")])end;return _b end
project["elements/List.lua"] = function(...) local c=require("elements/VisualElement")
local d=setmetatable({},c)d.__index=d
d.defineProperty(d,"items",{default={},type="table",canTriggerRender=true})
d.defineProperty(d,"selectedIndex",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"selectable",{default=true,type="boolean"})
d.defineProperty(d,"offset",{default=0,type="number",canTriggerRender=true})
d.defineProperty(d,"selectedColor",{default=colors.blue,type="number"})d.listenTo(d,"mouse_click")
d.listenTo(d,"mouse_scroll")function d.new()local _a=setmetatable({},d):__init()
_a.set("width",16)_a.set("height",8)
_a.set("background",colors.gray)return _a end;function d:init(_a,aa)
c.init(self,_a,aa)self.set("type","List")end
function d:addItem(_a)
local aa=self.get("items")table.insert(aa,_a)self:updateRender()return self end;function d:removeItem(_a)local aa=self.get("items")table.remove(aa,_a)
self:updateRender()return self end;function d:clear()
self.set("items",{})self.set("selectedIndex",0)self:updateRender()
return self end
function d:mouse_click(_a,aa,ba)
if _a==1 and
self:isInBounds(aa,ba)and self.get("selectable")then
local ca,da=self:getRelativePosition(aa,ba)local _b=da+self.get("offset")
local ab=self.get("items")
if _b<=#ab then local bb=ab[_b]self.set("selectedIndex",_b)
if
type(bb)=="table"and bb.callback then bb.callback(self)end;self:fireEvent("select",_b,bb)self:updateRender()return
true end end;return false end
function d:mouse_scroll(_a,aa,ba)
if self:isInBounds(aa,ba)then local ca=self.get("offset")
local da=math.max(0,#
self.get("items")-self.get("height"))ca=math.min(da,math.max(0,ca+_a))
self.set("offset",ca)return true end end
function d:onSelect(_a)self:registerCallback("select",_a)return self end
function d:render()c.render(self)local _a=self.get("items")
local aa=self.get("height")local ba=self.get("offset")
local ca=self.get("selectedIndex")local da=self.get("width")
for i=1,aa do local _b=i+ba;local ab=_a[_b]
if ab then
if type(ab)=="table"and
ab.separator then local bb=(ab.text or"-"):sub(1,1)
local cb=string.rep(bb,da)local db=ab.foreground or self.get("foreground")local _c=
ab.background or self.get("background")
self:textBg(1,i,string.rep(" ",da),_c)self:textFg(1,i,cb,db)else
local bb=type(ab)=="table"and ab.text or ab;local cb=_b==ca
local db=cb and
(ab.selectedBackground or self.get("selectedColor"))or
(ab.background or self.get("background"))
local _c=cb and(ab.selectedForeground or colors.white)or(ab.foreground or
self.get("foreground"))self:textBg(1,i,string.rep(" ",da),db)
self:textFg(1,i,bb,_c)end end end end;return d end
project["elements/Tree.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("libraries/colorHex")local ba=setmetatable({},_a)ba.__index=ba
ba.defineProperty(ba,"nodes",{default={},type="table",canTriggerRender=true})
ba.defineProperty(ba,"selectedNode",{default=nil,type="table",canTriggerRender=true})
ba.defineProperty(ba,"expandedNodes",{default={},type="table",canTriggerRender=true})
ba.defineProperty(ba,"scrollOffset",{default=0,type="number",canTriggerRender=true})
ba.defineProperty(ba,"nodeColor",{default=colors.white,type="number"})
ba.defineProperty(ba,"selectedColor",{default=colors.lightBlue,type="number"})ba.listenTo(ba,"mouse_click")
ba.listenTo(ba,"mouse_scroll")
function ba.new()local da=setmetatable({},ba):__init()
da.set("width",30)da.set("height",10)da.set("z",5)return da end
function ba:init(da,_b)_a.init(self,da,_b)self.set("type","Tree")return self end
function ba:setNodes(da)self.set("nodes",da)if#da>0 then
self.get("expandedNodes")[da[1]]=true end;return self end;function ba:expandNode(da)self.get("expandedNodes")[da]=true
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
if not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
local db=ca(self.get("nodes"),self.get("expandedNodes"))local _c=cb+self.get("scrollOffset")
if db[_c]then local ac=db[_c]
local bc=ac.node
if bb<=ac.level*2 +2 then self:toggleNode(bc)end;self.set("selectedNode",bc)
self:fireEvent("node_select",bc)end;return true end
function ba:onSelect(da)self:registerCallback("node_select",da)return self end
function ba:mouse_scroll(da)
local _b=ca(self.get("nodes"),self.get("expandedNodes"))
local ab=math.max(0,#_b-self.get("height"))
local bb=math.min(ab,math.max(0,self.get("scrollOffset")+da))self.set("scrollOffset",bb)return true end
function ba:render()_a.render(self)
local da=ca(self.get("nodes"),self.get("expandedNodes"))local _b=self.get("height")local ab=self.get("selectedNode")
local bb=self.get("expandedNodes")local cb=self.get("scrollOffset")
for y=1,_b do local db=da[y+cb]
if db then local _c=db.node
local ac=db.level;local bc=string.rep("  ",ac)local cc=" "if
_c.children and#_c.children>0 then cc=bb[_c]and"\31"or"\16"end
local dc=
_c==ab and self.get("selectedColor")or self.get("background")
local _d=bc..cc.." ".. (_c.text or"Node")
self:blit(1,y,_d..string.rep(" ",self.get("width")-#_d),string.rep(aa[self.get("nodeColor")],self.get("width")),string.rep(aa[dc],self.get("width")))else
self:blit(1,y,string.rep(" ",self.get("width")),string.rep(aa[self.get("foreground")],self.get("width")),string.rep(aa[self.get("background")],self.get("width")))end end end;return ba end
project["elements/Dropdown.lua"] = function(...) local _a=require("elements/VisualElement")
local aa=require("elements/List")local ba=require("libraries/colorHex")
local ca=setmetatable({},aa)ca.__index=ca
ca.defineProperty(ca,"isOpen",{default=false,type="boolean",canTriggerRender=true})
ca.defineProperty(ca,"dropdownHeight",{default=5,type="number"})
ca.defineProperty(ca,"selectedText",{default="",type="string"})
ca.defineProperty(ca,"dropSymbol",{default="\31",type="string"})
function ca.new()local da=setmetatable({},ca):__init()
da.set("width",16)da.set("height",1)da.set("z",8)return da end
function ca:init(da,_b)aa.init(self,da,_b)self.set("type","Dropdown")end
function ca:mouse_click(da,_b,ab)
if not _a.mouse_click(self,da,_b,ab)then return false end;local bb,cb=self:getRelativePosition(_b,ab)
if cb==1 then self.set("isOpen",not
self.get("isOpen"))if
not self.get("isOpen")then self.set("height",1)else
self.set("height",1 +math.min(self.get("dropdownHeight"),#
self.get("items")))end
return true elseif self.get("isOpen")and cb>1 then
local db=cb-1 +self.get("offset")local _c=self.get("items")
if db<=#_c then local ac=_c[db]if type(ac)=="table"and
ac.separator then return false end
self.set("selectedIndex",db)self.set("isOpen",false)self.set("height",1)
if type(ac)==
"table"and ac.callback then ac.callback(self)end;self:fireEvent("select",db,ac)return true end end;return false end
function ca:render()_a.render(self)local da=self.get("selectedText")
if
#da==0 and self.get("selectedIndex")>0 then
local _b=self.get("items")[self.get("selectedIndex")]
da=type(_b)=="table"and _b.text or tostring(_b)end
self:blit(1,1,da..

string.rep(" ",self.get("width")-#da-1).. (self.get("isOpen")and"\31"or"\17"),string.rep(ba[self.get("foreground")],self.get("width")),string.rep(ba[self.get("background")],self.get("width")))
if self.get("isOpen")then local _b=self.get("items")
local ab=self.get("offset")local bb=self.get("selectedIndex")local cb=self.get("width")
for i=2,self.get("height")
do local db=i-1 +ab;local _c=_b[db]
if _c then
if type(_c)=="table"and _c.separator then local ac=(
_c.text or"-"):sub(1,1)
local bc=string.rep(ac,cb)local cc=_c.foreground or self.get("foreground")local dc=
_c.background or self.get("background")
self:textBg(1,i,string.rep(" ",cb),dc)self:textFg(1,i,bc,cc)else local ac=type(_c)=="table"and _c.text or
tostring(_c)local bc=db==bb
local cc=bc and(_c.selectedBackground or
self.get("selectedColor"))or(_c.background or
self.get("background"))
local dc=bc and(_c.selectedForeground or colors.white)or(_c.foreground or
self.get("foreground"))self:textBg(1,i,string.rep(" ",cb),cc)
self:textFg(1,i,ac,dc)end end end end end;return ca end
project["render.lua"] = function(...) local c={}c.__index=c;local d=require("libraries/colorHex")
function c.new(_a)
local aa=setmetatable({},c)aa.terminal=_a;aa.width,aa.height=_a.getSize()
aa.buffer={text={},fg={},bg={},dirtyRects={}}
for y=1,aa.height do aa.buffer.text[y]=string.rep(" ",aa.width)
aa.buffer.fg[y]=string.rep("0",aa.width)aa.buffer.bg[y]=string.rep("f",aa.width)end;return aa end;function c:addDirtyRect(_a,aa,ba,ca)
table.insert(self.buffer.dirtyRects,{x=_a,y=aa,width=ba,height=ca})end
function c:blit(_a,aa,ba,ca,da)if aa<1 or
aa>self.height then return self end;if(#ba~=#ca or#ba~=#da)then
error("Text, fg, and bg must be the same length")end
self.buffer.text[aa]=self.buffer.text[aa]:sub(1,
_a-1)..ba..
self.buffer.text[aa]:sub(_a+#ba)
self.buffer.fg[aa]=
self.buffer.fg[aa]:sub(1,_a-1)..ca..self.buffer.fg[aa]:sub(_a+#ca)
self.buffer.bg[aa]=
self.buffer.bg[aa]:sub(1,_a-1)..da..self.buffer.bg[aa]:sub(_a+#da)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:multiBlit(_a,aa,ba,ca,da,_b,ab)if aa<1 or aa>self.height then return self end;if(
#da~=#_b or#da~=#ab)then
error("Text, fg, and bg must be the same length")end;da=da:rep(ba)
_b=_b:rep(ba)ab=ab:rep(ba)
for dy=0,ca-1 do local bb=aa+dy
if bb>=1 and bb<=self.height then
self.buffer.text[bb]=self.buffer.text[bb]:sub(1,
_a-1)..da..
self.buffer.text[bb]:sub(_a+#da)
self.buffer.fg[bb]=
self.buffer.fg[bb]:sub(1,_a-1).._b..self.buffer.fg[bb]:sub(_a+#_b)
self.buffer.bg[bb]=
self.buffer.bg[bb]:sub(1,_a-1)..ab..self.buffer.bg[bb]:sub(_a+#ab)end end;self:addDirtyRect(_a,aa,ba,ca)return self end
function c:textFg(_a,aa,ba,ca)if aa<1 or aa>self.height then return self end
ca=d[ca]or"0"
self.buffer.text[aa]=
self.buffer.text[aa]:sub(1,_a-1)..
ba..self.buffer.text[aa]:sub(_a+#ba)
self.buffer.fg[aa]=
self.buffer.fg[aa]:sub(1,_a-1)..
ca:rep(#ba)..self.buffer.fg[aa]:sub(_a+#ba)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:textBg(_a,aa,ba,ca)if aa<1 or aa>self.height then return self end
ca=d[ca]or"f"
self.buffer.text[aa]=
self.buffer.text[aa]:sub(1,_a-1)..
ba..self.buffer.text[aa]:sub(_a+#ba)
self.buffer.bg[aa]=
self.buffer.bg[aa]:sub(1,_a-1)..
ca:rep(#ba)..self.buffer.bg[aa]:sub(_a+#ba)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:text(_a,aa,ba)if aa<1 or aa>self.height then return self end
self.buffer.text[aa]=self.buffer.text[aa]:sub(1,
_a-1)..ba..
self.buffer.text[aa]:sub(_a+#ba)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:fg(_a,aa,ba)if aa<1 or aa>self.height then return self end
self.buffer.fg[aa]=self.buffer.fg[aa]:sub(1,
_a-1)..ba..
self.buffer.fg[aa]:sub(_a+#ba)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:bg(_a,aa,ba)if aa<1 or aa>self.height then return self end
self.buffer.bg[aa]=self.buffer.bg[aa]:sub(1,
_a-1)..ba..
self.buffer.bg[aa]:sub(_a+#ba)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:blit(_a,aa,ba,ca,da)if aa<1 or aa>self.height then return self end;if(#ba~=#ca or
#ba~=#da)then
error("Text, fg, and bg must be the same length")end
self.buffer.text[aa]=self.buffer.text[aa]:sub(1,
_a-1)..ba..
self.buffer.text[aa]:sub(_a+#ba)
self.buffer.fg[aa]=
self.buffer.fg[aa]:sub(1,_a-1)..ca..self.buffer.fg[aa]:sub(_a+#ca)
self.buffer.bg[aa]=
self.buffer.bg[aa]:sub(1,_a-1)..da..self.buffer.bg[aa]:sub(_a+#da)self:addDirtyRect(_a,aa,#ba,1)return self end
function c:clear(_a)local aa=d[_a]or"f"
for y=1,self.height do
self.buffer.text[y]=string.rep(" ",self.width)self.buffer.fg[y]=string.rep("0",self.width)
self.buffer.bg[y]=string.rep(aa,self.width)self:addDirtyRect(1,y,self.width,1)end;return self end
function c:render()local _a={}
for aa,ba in ipairs(self.buffer.dirtyRects)do local ca=false;for da,_b in ipairs(_a)do
if
self:rectOverlaps(ba,_b)then self:mergeRects(_b,ba)ca=true;break end end;if not ca then
table.insert(_a,ba)end end
for aa,ba in ipairs(_a)do
for y=ba.y,ba.y+ba.height-1 do
if y>=1 and y<=self.height then
self.terminal.setCursorPos(ba.x,y)
self.terminal.blit(self.buffer.text[y]:sub(ba.x,ba.x+ba.width-1),self.buffer.fg[y]:sub(ba.x,
ba.x+ba.width-1),self.buffer.bg[y]:sub(ba.x,
ba.x+ba.width-1))end end end;self.buffer.dirtyRects={}if self.blink then
self.terminal.setCursorPos(self.xCursor,self.yCursor)self.terminal.setCursorBlink(true)else
self.terminal.setCursorBlink(false)end;return
self end
function c:rectOverlaps(_a,aa)return
not(
_a.x+_a.width<=aa.x or aa.x+aa.width<=_a.x or _a.y+_a.height<=aa.y or
aa.y+aa.height<=_a.y)end
function c:mergeRects(_a,aa)local ba=math.min(_a.x,aa.x)
local ca=math.min(_a.y,aa.y)
local da=math.max(_a.x+_a.width,aa.x+aa.width)
local _b=math.max(_a.y+_a.height,aa.y+aa.height)_a.x=ba;_a.y=ca;_a.width=da-ba;_a.height=_b-ca end
function c:setCursor(_a,aa,ba)self.terminal.setCursorPos(_a,aa)
self.terminal.setCursorBlink(ba)self.xCursor=_a;self.yCursor=aa;self.blink=ba;return self end
function c:clearArea(_a,aa,ba,ca,da)local _b=d[da]or"f"
for dy=0,ca-1 do local ab=aa+dy
if ab>=1 and ab<=self.height then
local bb=string.rep(" ",ba)local cb=string.rep(_b,ba)self:blit(_a,ab,bb,"0",_b)end end;return self end;function c:getSize()return self.width,self.height end;return c end
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
return project["main.lua"]