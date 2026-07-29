local sources = {}
sources["main"] = [=[
local dc=...
if type(dc)~="function"then local bba,cba=...
local dba=fs.combine(fs.getDir(cba or"basalt/main.lua"),"init.lua")
return assert(loadfile(dba,nil,_ENV))(bba,dba)end;local _d=dc("core/errors")local ad=dc("core/palette")
local bd=dc("core/state")local cd=dc("core/layout")local dd=dc("core/container")
local __a=dc("core/baseframe")dd.register("Label",dc("elements/Label"))
dd.register("Canvas",dc("elements/Canvas"))dd.register("Button",dc("elements/Button"))
dd.register("Frame",dc("elements/Frame"))dd.register("Input",dc("elements/Input"))
dd.register("Checkbox",dc("elements/Checkbox"))dd.register("Switch",dc("elements/Switch"))
dd.register("ProgressBar",dc("elements/ProgressBar"))dd.register("Slider",dc("elements/Slider"))
dd.register("Collection",dc("elements/Collection"))dd.register("List",dc("elements/List"))
dd.register("Dropdown",dc("elements/Dropdown"))dd.register("Flex",dc("elements/Flex"))
dd.register("Row",dc("elements/Row"))dd.register("Column",dc("elements/Column"))
dd.register("TextBox",dc("elements/TextBox"))dd.register("Menu",dc("elements/Menu"))
dd.register("TabControl",dc("elements/TabControl"))dd.register("Tree",dc("elements/Tree"))
dd.register("Table",dc("elements/Table"))
dd.register("Program",dc("elements/Program"))
dd.register("ComboBox",dc("elements/ComboBox"))
dd.register("ContextMenu",dc("elements/ContextMenu"))dd.register("Dialog",dc("elements/Dialog"))
dd.register("Toast",dc("elements/Toast"))local a_a={}a_a.VERSION="2.5.0-dev"a_a.traceback=true;a_a.errors=_d
a_a.rgb=ad.rgb;a_a.state=bd.create;a_a.signal=bd.create;a_a.computed=bd.computed
a_a.isState=bd.is;a_a.auto=cd.auto;a_a.fill=cd.fill;a_a.percent=cd.percent;function a_a.use(bba)return
dc("modules/"..bba)end;local b_a={}local c_a=nil;local d_a=false;local _aa={}
function a_a.createFrame(bba,cba)bba=
bba or term.current()local dba=__a.new()
dba:setTerm(bba)
if cba==nil and bba.setTextScale and peripheral then
local _ca,aca=pcall(peripheral.getName,bba)if _ca then cba=aca end end;rawset(dba,"monitor",cba)b_a[#b_a+1]=dba
if not c_a then c_a=dba end;return dba end
function a_a.getMainFrame()return c_a or a_a.createFrame()end
function a_a.schedule(bba)local cba=coroutine.create(bba)
local dba,_ca=coroutine.resume(cba)if not dba then
error(_d.wrap(_ca,debug.traceback(cba)),0)end;_aa[#_aa+1]={co=cba,filter=_ca}
return cba end
local function aaa(bba,...)
for i=#_aa,1,-1 do local cba=_aa[i]
if
coroutine.status(cba.co)=="suspended"and(
cba.filter==nil or cba.filter==bba)then local dba,_ca=coroutine.resume(cba.co,bba,...)if not dba then
error(_d.wrap(_ca,debug.traceback(cba.co)),0)end;cba.filter=_ca end;if coroutine.status(cba.co)=="dead"then
table.remove(_aa,i)end end end
local baa={mouse_click=true,mouse_up=true,mouse_drag=true,mouse_scroll=true,mouse_move=true}local caa={key=true,key_up=true,char=true,paste=true}
local function daa(bba,cba,dba,_ca,...)
if bba=="mouse_move"and
type(cba)=="string"then
for i=1,#b_a do local aca=b_a[i]if
rawget(aca,"monitor")==cba then aca:handleEvent(bba,dba,_ca)end end elseif baa[bba]or caa[bba]then if c_a then
c_a:handleEvent(bba,cba,dba,_ca,...)end elseif
bba=="monitor_touch"or bba=="monitor_resize"then
for i=1,#b_a do local aca=b_a[i]
if rawget(aca,"monitor")==cba then if bba=="monitor_touch"then
aca:handleEvent("mouse_click",1,dba,_ca)aca:handleEvent("mouse_up",1,dba,_ca)else
aca:handleEvent("term_resize")end end end else
for i=1,#b_a do b_a[i]:handleEvent(bba,cba,dba,_ca,...)end end;aaa(bba,cba,dba,_ca,...)end;local function _ba()for i=1,#b_a do b_a[i]:draw()end end;function a_a.update(bba,...)if
bba then daa(bba,...)end;_ba()end;function a_a.stop()
d_a=false end
local function aba()for i=1,#b_a do b_a[i]:cleanup()end end
function a_a.run()
if d_a then error("Basalt is already running",2)end;d_a=true
local bba,cba=xpcall(function()_ba()
while d_a do
local dba=table.pack(os.pullEventRaw())if dba[1]=="terminate"then d_a=false else
daa(table.unpack(dba,1,dba.n))_ba()end end end,function(dba)
if
type(dba)=="table"and dba.__basaltError then return dba end;return _d.wrap(dba,debug.traceback(nil,2))end)d_a=false;aba()if not bba then
_d.show(cba.err,cba.trace,a_a.traceback)end end;return a_a
]=]
sources["core/baseframe"] = [=[
local ca=...local da=ca("core/class")local _b=ca("core/container")
local ab=ca("core/render")local bb=ca("core/state")local cb=da.create("BaseFrame",_b)
da.property(cb,"background",colors.black)
function cb:setup()_b.setup(self)rawset(self,"_keysDown",{})end;function cb:isKeyDown(_c)
return rawget(self,"_keysDown")[_c]==true end
function cb:setTerm(_c)rawset(self,"term",_c)
rawset(self,"_render",ab.new(_c))local ac,bc=_c.getSize()self._p.width,self._p.height=ac,bc
self:markDirty()return self end
function cb:draw()if not rawget(self,"_dirty")then return end
self._render:setCursor(1,1,false)
for _=1,2 do rawset(self,"_dirty",false)bb.clearWatcher(self)
self:render(self._render)if not rawget(self,"_dirty")then break end end;self._render:flush()end
function cb:setFocused(_c)local ac=rawget(self,"_focused")if ac==_c then return end
rawset(self,"_focused",_c)local bc=rawget(self,"_render")
if bc then bc:setCursor(1,1,false)end;if ac and ac~=self then ac:fire("blur")end;if _c and _c~=self then
_c:fire("focus")end;self:markDirty()end
function cb:setCursor(_c,ac,bc,cc)local dc=rawget(self,"_render")if dc then
dc:setCursor(_c,ac,bc,cc)end;return self end;function cb:getFocused()return rawget(self,"_focused")end
function cb:_updateHovered(_c,ac)
local bc=self:findAt(_c,ac)if bc==self then bc=nil end;local cc=rawget(self,"_hovered")
if cc==bc then return end;rawset(self,"_hovered",bc)if cc then
cc:setState("hover",false)cc:fire("mouseLeave")end;if bc then
bc:setState("hover",true)bc:fire("mouseEnter")end end;local function db(_c,ac)
while _c do if _c==ac then return true end;_c=rawget(_c,"parent")end;return false end
function cb:_releaseSubtree(_c,ac)
local bc=rawget(self,"_focused")if bc and db(bc,_c)then self:setFocused(nil)end
local cc=rawget(self,"_clicked")if cc and db(cc,_c)then cc:setState("pressed",false)
rawset(self,"_clicked",false)end
local dc=rawget(self,"_hovered")
if not ac and dc and db(dc,_c)then dc:setState("hover",false)
dc:fire("mouseLeave")rawset(self,"_hovered",nil)end end
function cb:handleEvent(_c,ac,bc,cc)
if _c=="key"then rawget(self,"_keysDown")[ac]=true elseif _c==
"key_up"then rawget(self,"_keysDown")[ac]=nil end
if _c=="mouse_click"then self:_updateHovered(bc,cc)
rawset(self,"_clicked",self:handleMouse(_c,ac,bc,cc))elseif _c=="mouse_move"then local dc,_d=ac,bc;if cc~=nil then dc,_d=bc,cc end;if
type(dc)=="number"and type(_d)=="number"then
self:_updateHovered(dc,_d)end elseif
_c=="mouse_up"or _c=="mouse_drag"then self:_updateHovered(bc,cc)
local dc=rawget(self,"_clicked")
if dc then local _d,ad=dc:getAbsolutePosition()
if _c=="mouse_up"then
dc:setState("pressed",false)dc:fire("clickUp",ac,bc-_d+1,cc-ad+1)
rawset(self,"_clicked",false)else dc:fire("drag",ac,bc-_d+1,cc-ad+1)end end elseif _c=="mouse_scroll"then self:handleMouse(_c,ac,bc,cc)
self:_updateHovered(bc,cc)elseif
_c=="key"or _c=="key_up"or _c=="char"or _c=="paste"then local dc=rawget(self,"_focused")if dc and dc~=self then
dc:handleKey(_c,ac,bc)end elseif _c=="term_resize"then
local dc,_d=self.term.getSize()self._p.width,self._p.height=dc,_d
self._render:resize(dc,_d)self:markDirty()end end
function cb:cleanup()local _c=rawget(self,"_render")if _c then
_c.mapper:restore()end;local ac=rawget(self,"term")
if ac then
ac.setBackgroundColor(colors.black)ac.setTextColor(colors.white)ac.clear()
ac.setCursorPos(1,1)ac.setCursorBlink(false)end end;return cb
]=]
sources["core/class"] = [=[
local _b=...local ab=_b("core/reactive")local bb=_b("core/state")
local cb=_b("core/layout")local db={}local _c=table.unpack or unpack
local function ac(dc,_d,ad)
if _d.state and dc.setState then
local bd=_d.stateWhen and
_d.stateWhen(ad,dc)or not not ad;dc:setState(_d.state,bd)end end
local function bc(dc,_d,ad)
if bb.is(ad)then ad=bb.read(ad,dc)elseif
type(ad)=="function"and not _d.rawFunction then ad=bb.withWatcher(dc,ad,dc)end;ac(dc,_d,ad)return ad end
local function cc(dc)return dc:sub(1,1):upper()..dc:sub(2)end
function db.create(dc,_d)local ad={}ad.__name=dc;ad.__parent=_d;ad.__props=setmetatable({},
_d and{__index=_d.__props}or nil)
ad.__defaults=setmetatable({},
_d and{__index=_d.__defaults}or nil)ad.__stateStyles={}ad.__pmeta={__index=ad.__defaults}if _d then
setmetatable(ad,{__index=_d})end
ad.__getPropertySpec=function(bd,cd)local dd=ad.__props[cd]
if not dd then return false end;local __a=ad.__stateResolver
if dd.styleable and __a then local b_a,c_a=__a(bd,cd,ad)if b_a then return true,
bc(bd,dd,c_a),dd end end;local a_a=rawget(bd,"_p")[cd]
if a_a~=nil then return true,bc(bd,dd,a_a),dd end;return false end
ad.__meta={__index=function(bd,cd)local dd=rawget(bd,"_layoutBox")if dd and dd[cd]~=nil then
return dd[cd]end;local __a,a_a=ad.__getPropertySpec(bd,cd)
if __a then if
cb.is(a_a)then return cb.resolveToken(a_a,bd,cd)end;return a_a end;return ad[cd]end,__newindex=function(bd,cd,dd)
local __a=ad.__props[cd]
if __a then
if
type(dd)=="string"and not __a.rawString and
dd:sub(1,1)=="{"and dd:sub(-1)=="}"then dd=ab.compile(dd,bd)end;local a_a=rawget(bd,"_p")local b_a=a_a[cd]
if b_a~=dd then a_a[cd]=dd
if
(
type(dd)=="function"and not __a.rawFunction)or bb.is(dd)then if __a.visual then
if bd.invalidateLayout then bd:invalidateLayout(cd)end
if bd.markRenderDirty then bd:markRenderDirty()else bd:markDirty()end end else if
__a.onChange then __a.onChange(bd,dd,b_a)end;ac(bd,__a,dd)if
__a.visual then if bd.invalidateLayout then bd:invalidateLayout(cd)end
if
bd.markRenderDirty then bd:markRenderDirty()else bd:markDirty()end end end end else rawset(bd,cd,dd)end end,__tostring=function(bd)return
dc end}
ad.new=function(bd)
local cd=setmetatable({_p=setmetatable({},ad.__pmeta),_handlers={},_class=ad},ad.__meta)cd:setup()if bd then cd:apply(bd)end;return cd end;return ad end
function db.property(dc,_d,ad,bd)bd=bd or{}
dc.__props[_d]={visual=bd.visual~=false,onChange=bd.onChange,rawFunction=bd.rawFunction,rawString=bd.rawString,state=bd.state,stateWhen=bd.stateWhen,styleable=
bd.styleable~=false}dc.__defaults[_d]=ad;local cd=cc(_d)
dc["set"..cd]=function(dd,__a)dd[_d]=__a;return dd end;dc["get"..cd]=function(dd)return dd[_d]end end
function db.combinedProperty(dc,_d,ad)if type(_d)~="string"or _d==""then
error("Basalt class: combined property name must be a non-empty string",2)end;if type(ad)~="table"or#
ad==0 then
error("Basalt class: combined property list must not be empty",2)end;local bd={}
for i=1,#ad do local a_a=ad[i]if
type(a_a)~="string"or dc.__props[a_a]==nil then
error(
"Basalt class: unknown property '"..tostring(a_a).."' in combined property ".._d,2)end
bd[i]=a_a end;local cd="set".._d;local dd="get".._d;local __a="getRaw".._d
dc[cd]=function(a_a,...)
local b_a=table.pack(...)if b_a.n~=#bd then
error("Basalt: "..cd..
" expects "..#bd.." values, got "..b_a.n,2)end
for i=1,#bd do a_a[bd[i]]=b_a[i]end;return a_a end
dc[dd]=function(a_a)local b_a={n=#bd}for i=1,#bd do b_a[i]=a_a[bd[i]]end;return
_c(b_a,1,b_a.n)end
dc[__a]=function(a_a)local b_a={n=#bd}for i=1,#bd do b_a[i]=a_a:raw(bd[i])end;return
_c(b_a,1,b_a.n)end end;function db.event(dc,_d)
dc["on"..cc(_d)]=function(ad,bd)return ad:on(_d,bd)end end;return db
]=]
sources["core/collection"] = [=[
local db=...local _c=db("core/class")
local ac=db("core/collectionentry")local bc={}local cc={methods=bc}
local function dc(b_a,c_a)
if type(c_a)=="number"then local d_a=math.floor(c_a)return
b_a.items[d_a]and d_a or nil end
for d_a,_aa in ipairs(b_a.items)do if _aa==c_a then return d_a end end end;local function _d(b_a)
return
b_a and b_a.selectable~=false and b_a.disabled~=true and b_a.separator~=true end
local function ad(b_a)
local c_a=b_a:getSelectedIndex()return c_a,c_a and b_a.items[c_a]or nil end
local function bd(b_a)local c_a=b_a:getSelectedIndex()or false
rawget(b_a,"_p").selected=c_a;b_a:setState("selected",c_a~=false)end
local function cd(b_a,c_a,d_a)bd(b_a)local _aa,aaa=ad(b_a)
local baa=rawget(b_a,"_collectionChangeEvent")if baa then
b_a:fire(baa,_aa or false,aaa,c_a or false,d_a)end;b_a:markDirty()end
local function dd(b_a,c_a)if ac.is(c_a)then if rawget(c_a,"_parent")==b_a then return c_a end
c_a=c_a:getData()end;return ac.new(b_a,c_a)end
local function __a(b_a,c_a,d_a)if type(c_a)~="table"then
error("Basalt Collection: items must be a table",3)end;local _aa,aaa
local baa=rawget(b_a,"_collectionSelection")if type(d_a)=="table"then
for _ba,aba in ipairs(d_a)do if baa[aba]then _aa,aaa=_ba,aba;break end end end;if type(d_a)=="table"then
for _ba,aba in
ipairs(d_a)do if ac.is(aba)then rawset(aba,"_parent",nil)end end end;local caa={}local daa={}
for _ba,aba in
ipairs(c_a)do
local bba=type(aba)=="table"and not ac.is(aba)and aba.selected==true;caa[_ba]=dd(b_a,aba)local cba=caa[_ba]:getData()
cba.selected=nil;if bba and(b_a.multiSelection or next(daa)==nil)then
daa[caa[_ba]]=true end end;rawget(b_a,"_p").items=caa
rawset(b_a,"_collectionSelection",daa)
if aaa or next(daa)then cd(b_a,_aa,aaa)else bd(b_a)b_a:markDirty()end;if b_a.setOffset and b_a.offset~=nil then
b_a:setOffset(b_a.offset)end end;local function a_a(b_a,c_a,d_a,_aa)
if b_a.__props[c_a]==nil then _c.property(b_a,c_a,d_a,_aa)end end
function cc.install(b_a,c_a)c_a=c_a or{}
a_a(b_a,"items",false,{onChange=function(_aa,aaa,baa)if
rawget(_aa,"_collectionSelection")then __a(_aa,aaa,baa)end end})a_a(b_a,"selectable",true)
a_a(b_a,"multiSelection",false,{onChange=function(_aa,aaa)
if aaa or not
rawget(_aa,"_collectionSelection")then return end;local baa=_aa:getSelectedItem()
local caa=rawget(_aa,"_collectionSelection")for daa in pairs(caa)do caa[daa]=daa==baa or nil end
bd(_aa)end})
a_a(b_a,"selected",false,{styleable=false,onChange=function(_aa,aaa)
if not rawget(_aa,"_collectionSelection")then return end;if aaa==false or aaa==nil then _aa:clearItemSelection()else
_aa:selectItem(aaa)end end})a_a(b_a,"selectionBackground",colors.blue)
a_a(b_a,"selectionForeground",colors.white)_c.event(b_a,"select")local d_a;if c_a.changeEvent~=false then
d_a=c_a.changeEvent or"change"end;if d_a then _c.event(b_a,d_a)end
b_a.setSelectedBackground=function(_aa,aaa)
_aa.selectionBackground=aaa;return _aa end
b_a.getSelectedBackground=function(_aa)return _aa.selectionBackground end
b_a.setSelectedForeground=function(_aa,aaa)_aa.selectionForeground=aaa;return _aa end
b_a.getSelectedForeground=function(_aa)return _aa.selectionForeground end
b_a.setSelectionColor=function(_aa,aaa,baa)_aa.selectionForeground=aaa;_aa.selectionBackground=baa;return _aa end
b_a.getSelectionColor=function(_aa)return _aa.selectionForeground,_aa.selectionBackground end;b_a._collectionChangeEventName=d_a
for _aa,aaa in pairs(cc.methods)do b_a[_aa]=aaa end end
function cc.setup(b_a)rawset(b_a,"_collectionSelection",{})
rawset(b_a,"_collectionChangeEvent",b_a._class._collectionChangeEventName)local c_a=rawget(b_a,"_p").items;local d_a={}
if type(c_a)=="table"then for _aa,aaa in
ipairs(c_a)do d_a[_aa]=dd(b_a,aaa)end end;rawget(b_a,"_p").items=d_a;bd(b_a)end;function bc:indexOfItem(b_a)return dc(self,b_a)end;function bc:getItem(b_a)
return self.items[b_a]end
function bc:getItemCount()return#self.items end
function bc:addItem(b_a)local c_a=type(b_a)=="table"and not ac.is(b_a)and
b_a.selected==true
local d_a=dd(self,b_a)d_a:getData().selected=nil
self.items[#self.items+1]=d_a;if c_a then self:selectItem(d_a)end;self:markDirty()return
d_a end
function bc:insertItem(b_a,c_a)
b_a=math.max(1,math.min(#self.items+1,math.floor(b_a)))local d_a=dd(self,c_a)
local _aa=d_a:getData().selected==true;d_a:getData().selected=nil
table.insert(self.items,b_a,d_a)if _aa then self:selectItem(d_a)end;bd(self)
self:markDirty()return d_a end
function bc:removeItem(b_a)local c_a=dc(self,b_a)if not c_a then return self end;local d_a,_aa=ad(self)
local aaa=table.remove(self.items,c_a)local baa=rawget(self,"_collectionSelection")
local caa=baa[aaa]==true;baa[aaa]=nil;rawset(aaa,"_parent",nil)if caa then cd(self,d_a,_aa)else
bd(self)end;self:markDirty()return self end
function bc:clear()local b_a,c_a=ad(self)for d_a,_aa in ipairs(self.items)do
rawset(_aa,"_parent",nil)end;rawget(self,"_p").items={}
rawset(self,"_collectionSelection",{})if c_a then cd(self,b_a,c_a)else bd(self)end
self:markDirty()return self end;function bc:clearItems()return self:clear()end;function bc:isItemSelected(b_a)
local c_a=dc(self,b_a)
return c_a~=nil and
rawget(self,"_collectionSelection")[self.items[c_a]]==true end;function bc:isSelected(b_a)return
self:isItemSelected(b_a)end
function bc:getSelectedItems()local b_a={}
local c_a=rawget(self,"_collectionSelection")
for d_a,_aa in ipairs(self.items)do if c_a[_aa]then b_a[#b_a+1]=_aa end end;return b_a end
function bc:getSelectedItem()local b_a=rawget(self,"_collectionSelection")for c_a,d_a in
ipairs(self.items)do if b_a[d_a]then return d_a end end end
function bc:getSelectedIndex()local b_a=rawget(self,"_collectionSelection")for c_a,d_a in
ipairs(self.items)do if b_a[d_a]then return c_a end end end
function bc:getSelection()local b_a={}local c_a=rawget(self,"_collectionSelection")
for d_a,_aa in
ipairs(self.items)do if c_a[_aa]then b_a[#b_a+1]=d_a end end;return b_a end
function bc:selectItem(b_a,c_a)if not self.selectable then return self end
local d_a=dc(self,b_a)local _aa=d_a and self.items[d_a]
if not _d(_aa)then return self end;local aaa=rawget(self,"_collectionSelection")local baa,caa=ad(self)local daa=not
aaa[_aa]
if not self.multiSelection then for _ba in pairs(aaa)do if _ba~=_aa then
aaa[_ba],daa=nil,true end end end;aaa[_aa]=true;if daa then
if c_a==false then bd(self)else cd(self,baa,caa)end end;return self end
function bc:unselectItem(b_a,c_a)local d_a=dc(self,b_a)
local _aa=d_a and self.items[d_a]local aaa=rawget(self,"_collectionSelection")if
not _aa or not aaa[_aa]then return self end;local baa,caa=ad(self)aaa[_aa]=nil;if c_a==false then
bd(self)else cd(self,baa,caa)end;return self end
function bc:toggleItem(b_a,c_a)if self:isItemSelected(b_a)then
return self:unselectItem(b_a,c_a)end;return self:selectItem(b_a,c_a)end
function bc:clearItemSelection(b_a)local c_a,d_a=ad(self)if not d_a then return self end
rawset(self,"_collectionSelection",{})if b_a==false then bd(self)else cd(self,c_a,d_a)end;return self end
function bc:clearSelection(b_a)return self:clearItemSelection(b_a)end
function bc:selectNext(b_a)local c_a=self:getSelectedIndex()or 0
for index=c_a+1,#
self.items do if _d(self.items[index])then
return self:selectItem(index,b_a)end end;return self end
function bc:selectPrevious(b_a)
local c_a=self:getSelectedIndex()or(#self.items+1)
for index=c_a-1,1,-1 do if _d(self.items[index])then
return self:selectItem(index,b_a)end end;return self end
function bc:scrollToTop()if self.setOffset then self:setOffset(0)end;return self end;function bc:scrollToBottom()
if self.setOffset then self:setOffset(math.huge)end;return self end
function bc:activateItem(b_a,c_a,d_a)
local _aa=dc(self,b_a)local aaa=_aa and self.items[_aa]if not self.selectable or
not _d(aaa)then return self end;if d_a then
self:toggleItem(aaa)else self:selectItem(aaa)end
_aa=dc(self,aaa)
if c_a~=false then if type(aaa.callback)=="function"then
aaa.callback(self,aaa)end;self:fire("select",_aa,aaa)end;return self end;function bc:select(b_a,c_a)
return self:activateItem(b_a,c_a,self.multiSelection)end
function bc:_moveCollectionEntry(b_a,c_a)
local d_a=dc(self,b_a)
if d_a then self:_moveCollectionEntryTo(b_a,d_a+c_a)end;return self end
function bc:_moveCollectionEntryTo(b_a,c_a)local d_a=dc(self,b_a)if not d_a then return self end
c_a=math.max(1,math.min(
#self.items,math.floor(c_a)))
if c_a~=d_a then table.remove(self.items,d_a)
table.insert(self.items,c_a,b_a)bd(self)self:markDirty()end;return self end
function bc:_swapCollectionEntries(b_a,c_a)local d_a,_aa=dc(self,b_a),dc(self,c_a)
if
d_a and _aa and d_a~=_aa then
self.items[d_a],self.items[_aa]=self.items[_aa],self.items[d_a]bd(self)self:markDirty()end;return self end;return cc
]=]
sources["core/collectionentry"] = [=[
local c={}local d={}
d.__index=function(_a,aa)local ba=c[aa]if ba then return ba end;if aa=="selected"then
local ab=rawget(_a,"_parent")
return ab and ab:isItemSelected(_a)or false end
local ca=rawget(_a,"_data")if ca and ca[aa]~=nil then return ca[aa]end
local da=rawget(_a,"_parent")local _b=da and da[aa]if type(_b)=="function"then return
function(ab,...)return _b(da,...)end end end
d.__newindex=function(_a,aa,ba)if type(aa)=="string"and aa:sub(1,1)=="_"then
rawset(_a,aa,ba)return end
if aa=="selected"then
local da=rawget(_a,"_parent")if da then
if ba then da:selectItem(_a)else da:unselectItem(_a)end end;return end;local ca=rawget(_a,"_data")
if ca[aa]~=ba then ca[aa]=ba
local da=rawget(_a,"_parent")if da then da:markDirty()end end end
d.__tostring=function(_a)local aa=rawget(_a,"_data")if aa.text~=nil then
return tostring(aa.text)end
if aa.label~=nil then return tostring(aa.label)end;if aa.value~=nil then return tostring(aa.value)end
return"Entry"end
function d.new(_a,aa)local ba
if type(aa)=="table"then ba=aa else ba={text=tostring(aa),value=aa}end;if
ba.text==nil and ba.label==nil and ba.value==nil then ba.text="Entry"end;return
setmetatable({_parent=_a,_data=ba},d)end;function d.is(_a)return getmetatable(_a)==d end;function c:getData()return
rawget(self,"_data")end;function c:getParent()
return rawget(self,"_parent")end
function c:setText(_a)self.text=_a;return self end;function c:getText()return self.text end
function c:getIndex()
local _a=rawget(self,"_parent")return _a and _a:indexOfItem(self)or nil end
function c:moveUp(_a)local aa=rawget(self,"_parent")if aa then
aa:_moveCollectionEntry(self,- (_a or 1))end;return self end
function c:moveDown(_a)local aa=rawget(self,"_parent")if aa then
aa:_moveCollectionEntry(self,_a or 1)end;return self end
function c:moveToTop()local _a=rawget(self,"_parent")if _a then
_a:_moveCollectionEntryTo(self,1)end;return self end
function c:moveToBottom()local _a=rawget(self,"_parent")if _a then
_a:_moveCollectionEntryTo(self,#_a.items)end;return self end
function c:swapWith(_a)local aa=rawget(self,"_parent")
if
aa and rawget(_a,"_parent")==aa then aa:_swapCollectionEntries(self,_a)end;return self end;function c:remove()local _a=rawget(self,"_parent")if not _a then return false end
_a:removeItem(self)return true end
function c:select()
local _a=rawget(self,"_parent")if _a then _a:selectItem(self)end;return self end;function c:unselect()local _a=rawget(self,"_parent")
if _a then _a:unselectItem(self)end;return self end;function c:isSelected()
local _a=rawget(self,"_parent")
return _a and _a:isItemSelected(self)or false end;return d
]=]
sources["core/container"] = [=[
local ab=...local bb=ab("core/class")local cb=ab("core/element")
local db=ab("core/state")local _c=ab("core/layout")local ac=ab("core/scroll")
local bc=bb.create("Container",cb)
bb.property(bc,"scrollable",false,{onChange=function(ad,bd)if not bd then ac.disable(ad)end end})bb.property(bc,"scrollbar","auto")
bb.property(bc,"scrollXEnabled",true)bb.property(bc,"scrollYEnabled",true)
bb.property(bc,"scrollStep",3)bb.property(bc,"scrollbarColor",colors.gray)
bb.property(bc,"scrollbarThumbColor",colors.lightGray)bb.event(bc,"scrollChange")
function bc:setup()cb.setup(self)
rawset(self,"_children",{})rawset(self,"_addIndex",0)
rawset(self,"_sortDirty",false)rawset(self,"_layoutDirty",true)
rawset(self,"_viewportDirty",true)rawset(self,"_visibleChildren",{})ac.setup(self)end
function bc:getScroll()return rawget(self,"_scrollX")or 0,
rawget(self,"_scrollY")or 0 end
function bc:getContentSize()return rawget(self,"_contentWidth")or 0,
rawget(self,"_contentHeight")or 0 end
function bc:getScrollInfo()local ad=ac.geometry(self)ad.x,ad.y=self:getScroll()
ad.contentWidth,ad.contentHeight=self:getContentSize()return ad end
function bc:scrollTo(ad,bd)ac.set(self,ad or 0,bd or 0)return self end;function bc:scrollBy(ad,bd)local cd,dd=self:getScroll()
ac.set(self,cd+ (ad or 0),dd+ (bd or 0))return self end
local function cc(ad,bd)
local cd,dd=bd.x,bd.y;local __a=rawget(bd,"parent")while __a and __a~=ad do cd=cd+__a.x-1 - (
rawget(__a,"_scrollX")or 0)dd=dd+__a.y-1 - (
rawget(__a,"_scrollY")or 0)
__a=rawget(__a,"parent")end;if
__a~=ad then
error("Basalt scroll: element is not a descendant of this container",3)end;return cd,dd,bd.width,bd.height end
function bc:scrollToElement(ad)local bd,cd=cc(self,ad)return self:scrollTo(bd-1,cd-1)end
function bc:ensureVisible(ad)local bd,cd,dd,__a=cc(self,ad)local a_a,b_a=self:getScroll()if bd<a_a+1 then a_a=
bd-1 end;if cd<b_a+1 then b_a=cd-1 end
if bd+dd-1 >
a_a+self.width then a_a=bd+dd-1 -self.width end;if cd+__a-1 >b_a+self.height then
b_a=cd+__a-1 -self.height end;return self:scrollTo(a_a,b_a)end
function bc:addChild(ad)local bd=rawget(ad,"parent")
if bd then bd:removeChild(ad)end;rawset(ad,"parent",self)
self._addIndex=self._addIndex+1;rawset(ad,"_order",self._addIndex)local cd=self._children;cd[#cd+
1]=ad;self._sortDirty=true;self:markLayoutDirty()
return ad end
function bc:removeChild(ad)local bd=self._children
for i=1,#bd do
if bd[i]==ad then local cd=self:getRoot()if
cd._releaseSubtree then cd:_releaseSubtree(ad)end
table.remove(bd,i)rawset(ad,"parent",nil)self:markLayoutDirty()return true end end;return false end
function bc:destroy()local ad=rawget(self,"_children")
while ad and#ad>0 do local bd=ad[#ad]if
bd.destroy then bd:destroy()end;if ad[#ad]==bd then
self:removeChild(bd)end end;return cb.destroy(self)end;function bc:getChildren()return self._children end
function bc:find(ad)
local bd=self._children
for i=1,#bd do if bd[i].name==ad then return bd[i]end end;for i=1,#bd do local cd=bd[i]
if cd.find then local dd=cd:find(ad)if dd then return dd end end end;return nil end;local function dc(ad,bd)local cd,dd=ad.z,bd.z
if cd==dd then return ad._order<bd._order end;return cd<dd end
function bc:_sorted()if
self._sortDirty then table.sort(self._children,dc)self._sortDirty=false
self._viewportDirty=true end;return self._children end
local function _d(ad,bd,cd,dd,__a)local a_a=rawget(ad,"_layoutBox")
local b_a=a_a and a_a.x or ad.x;local c_a=a_a and a_a.y or ad.y
local d_a=a_a and a_a.width or ad.width;local _aa=a_a and a_a.height or ad.height;if
d_a<=0 or _aa<=0 then return false end;return
b_a<=bd+dd and c_a<=cd+__a and
b_a+d_a-1 >bd and c_a+_aa-1 >cd end
function bc:_visibleSorted()local ad=rawget(self,"_visibleChildren")if not
rawget(self,"_viewportDirty")and ad then return ad end
ad={}local bd,cd=self:getScroll()local dd=self:_sorted()
for i=1,#dd do local __a=dd[i]if
__a.visible and _d(__a,bd,cd,self.width,self.height)then
ad[#ad+1]=__a end end;rawset(self,"_visibleChildren",ad)
rawset(self,"_viewportDirty",false)return ad end
function bc:render(ad)cb.render(self,ad)local bd=self._children
if
rawget(self,"_layoutDirty")then for i=1,#bd do local a_a=bd[i]db.clearWatcher(a_a)local b_a=a_a:raw("z")
if
db.is(b_a)or type(b_a)=="function"then self._sortDirty=true end end
self:fire("layout",self.width,self.height)if self.layoutChildren then self:layoutChildren()else
_c.resolveFreeChildren(self)end;ac.update(self)
rawset(self,"_layoutDirty",false)rawset(self,"_viewportDirty",true)end;local cd,dd=self:getScroll()local __a=self:_visibleSorted()for i=1,#__a do
local a_a=__a[i]
if a_a.visible then
ad:push(a_a.x-cd,a_a.y-dd,a_a.width,a_a.height)a_a:render(ad)ad:pop()end end
ac.draw(self,ad)end
function bc:handleMouse(ad,bd,cd,dd)if ad=="mouse_click"and ac.pointerDown(self,cd,dd)then
return self end;local __a,a_a=self:getScroll()
local b_a,c_a=cd+__a,dd+a_a;local d_a=self:_visibleSorted()
for i=#d_a,1,-1 do local _aa=d_a[i]
if _aa.visible and
_aa:contains(b_a,c_a)then
local aaa=_aa:handleMouse(ad,bd,b_a-_aa.x+1,c_a-_aa.y+1)if aaa then return aaa end end end
if ad=="mouse_scroll"and ac.wheel(self,bd)then return self end;return cb.handleMouse(self,ad,bd,cd,dd)end
function bc:findAt(ad,bd)if ac.isBarPoint(self,ad,bd)then return self end
local cd,dd=self:getScroll()local __a,a_a=ad+cd,bd+dd;local b_a=self:_visibleSorted()
for i=#b_a,1,-1 do
local c_a=b_a[i]
if c_a.visible and c_a:contains(__a,a_a)then
local d_a,_aa=__a-c_a.x+1,a_a-c_a.y+1
if c_a.findAt then local aaa=c_a:findAt(d_a,_aa)if aaa then return aaa end end;return c_a end end;return self end;function bc.register(ad,bd)
bc["add"..ad]=function(cd,dd)local __a=bd.new(dd)cd:addChild(__a)return __a end end;return bc
]=]
sources["core/element"] = [=[
local _c=...local ac=_c("core/class")local bc=_c("core/state")
local cc=_c("core/layout")local dc=ac.create("Element")ac.property(dc,"x",1)
ac.property(dc,"y",1)
ac.property(dc,"z",0,{onChange=function(d_a)local _aa=rawget(d_a,"parent")
if _aa then _aa._sortDirty=true end end})ac.property(dc,"width",1)ac.property(dc,"height",1)
ac.property(dc,"minWidth",false)ac.property(dc,"maxWidth",false)
ac.property(dc,"minHeight",false)ac.property(dc,"maxHeight",false)
ac.property(dc,"position","flow")ac.property(dc,"alignSelf",false)
ac.property(dc,"shrink",false)
ac.property(dc,"visible",true,{onChange=function(d_a,_aa)
if not _aa then local aaa=d_a:getRoot()if aaa._releaseSubtree then
aaa:_releaseSubtree(d_a)end end end})ac.property(dc,"background",false)
ac.property(dc,"foreground",colors.white)ac.property(dc,"name","",{visual=false})
ac.property(dc,"disabled",false,{state="disabled",styleable=false,onChange=function(d_a,_aa)
if
_aa then local aaa=d_a:getRoot()if aaa._releaseSubtree then
aaa:_releaseSubtree(d_a,true)end end end})ac.combinedProperty(dc,"Position",{"x","y"})
ac.combinedProperty(dc,"Size",{"width","height"})
ac.combinedProperty(dc,"Bounds",{"x","y","width","height"})
ac.combinedProperty(dc,"Colors",{"foreground","background"})
ac.combinedProperty(dc,"MinSize",{"minWidth","minHeight"})
ac.combinedProperty(dc,"MaxSize",{"maxWidth","maxHeight"})ac.event(dc,"click")ac.event(dc,"clickUp")
ac.event(dc,"drag")ac.event(dc,"scroll")ac.event(dc,"focus")
ac.event(dc,"blur")ac.event(dc,"key")ac.event(dc,"keyUp")
ac.event(dc,"char")ac.event(dc,"paste")ac.event(dc,"stateChange")
ac.event(dc,"mouseEnter")ac.event(dc,"mouseLeave")ac.event(dc,"layout")
local _d={hover=10,focused=20,checked=30,selected=30,pressed=40,disabled=100}
local ad={disabled=true,checked=true,selected=true,active=true,progress=true,value=true,offset=true,horizontalOffset=true,replaceChar=true,sortable=true,sortColumn=true,sortDirection=true}
local function bd(d_a)if not d_a then return true end;if ad[d_a]then return false end
local _aa=d_a:lower()
if
_aa:find("color",1,true)or _aa:find("background",1,true)or _aa:find("foreground",1,true)or
_aa:find("symbol",1,true)then return false end;return true end;local function cd(d_a)if not d_a then return false end
for _aa in pairs(d_a)do if bd(_aa)then return true end end;return false end
local function dd(d_a,_aa)
local aaa=rawget(d_a,"_stateStyles")[_aa]if cd(aaa)then return true end;local baa=rawget(d_a,"_class")while baa do
local caa=rawget(baa,"__stateStyles")if caa and cd(caa[_aa])then return true end
baa=rawget(baa,"__parent")end;return false end
local function __a(d_a,_aa)local aaa=rawget(d_a,"_statePriorities")return
(aaa and aaa[_aa])or _d[_aa]or 50 end
local function a_a(d_a)local _aa=rawget(d_a,"_activeStates")if _aa then return _aa end
local aaa,baa=rawget(d_a,"_states"),rawget(d_a,"_stateSequence")_aa={}
for caa,daa in pairs(aaa)do if daa then _aa[#_aa+1]=caa end end
table.sort(_aa,function(caa,daa)local _ba,aba=__a(d_a,caa),__a(d_a,daa)
if _ba~=aba then return _ba>aba end;return(baa[caa]or 0)> (baa[daa]or 0)end)rawset(d_a,"_activeStates",_aa)return _aa end
local function b_a(d_a,_aa,aaa)
while d_a do local baa=rawget(d_a,"__stateStyles")local caa=baa and baa[_aa]if
caa and caa[aaa]~=nil then return true,caa[aaa]end
d_a=rawget(d_a,"__parent")end;return false end
dc.__stateResolver=function(d_a,_aa,aaa)local baa=rawget(d_a,"_stateStyles")local caa=a_a(d_a)
for i=1,#caa do
local daa=caa[i]local _ba=baa[daa]
if _ba and _ba[_aa]~=nil then return true,_ba[_aa]end;local aba,bba=b_a(aaa,daa,_aa)if aba then return true,bba end end;return false end
function dc:setup()rawset(self,"_states",{})
rawset(self,"_stateStyles",{})rawset(self,"_statePriorities",{})
rawset(self,"_stateSequence",{})rawset(self,"_stateSequenceN",0)
rawset(self,"_bindings",{})
self:on("focus",function(d_a)d_a:setState("focused",true)end)
self:on("blur",function(d_a)d_a:setState("focused",false)end)end
function dc:setState(d_a,_aa)if type(d_a)~="string"or d_a==""then
error("Basalt: state name must be a non-empty string",2)end
_aa=_aa~=false and _aa~=nil;local aaa=rawget(self,"_states")
if aaa[d_a]==_aa then return self end;aaa[d_a]=_aa;if _aa then
local baa=rawget(self,"_stateSequenceN")+1;rawset(self,"_stateSequenceN",baa)
rawget(self,"_stateSequence")[d_a]=baa end;rawset(self,"_activeStates",
nil)if dd(self,d_a)then
self:markLayoutDirty()else self:markRenderDirty()end
self:fire("stateChange",d_a,_aa)return self end;function dc:hasState(d_a)
return rawget(self,"_states")[d_a]==true end;function dc:toggleState(d_a)return
self:setState(d_a,not self:hasState(d_a))end
function dc:getStates()
local d_a={}for _aa,aaa in pairs(rawget(self,"_states"))do
if aaa then d_a[#d_a+1]=_aa end end;table.sort(d_a)return d_a end
function dc:setStateStyle(d_a,_aa,aaa)if type(_aa)~="table"then
error("Basalt: state style must be a table",2)end;local baa=rawget(self,"_class")
local caa={}
for daa,_ba in pairs(_aa)do local aba=baa.__props[daa]if not aba then
error("Basalt: unknown state style property '"..
tostring(daa).."'",2)end;if not aba.styleable then
error("Basalt: property '"..daa..
"' cannot be state-styled",2)end;caa[daa]=_ba end;rawget(self,"_stateStyles")[d_a]=caa;if aaa~=nil then
self:setStatePriority(d_a,aaa)end
if self:hasState(d_a)and cd(caa)then
self:markLayoutDirty()else self:markRenderDirty()end;return self end
function dc:setStatePriority(d_a,_aa)if type(_aa)~="number"then
error("Basalt: state priority must be a number",2)end
rawget(self,"_statePriorities")[d_a]=_aa;rawset(self,"_activeStates",nil)
self:markLayoutDirty()return self end
function dc:apply(d_a)
for _aa,aaa in pairs(d_a)do if
type(aaa)=="function"and _aa:find("^on%u")and self[_aa]then self[_aa](self,aaa)else
self[_aa]=aaa end end;return self end;function dc:raw(d_a)return rawget(self,"_p")[d_a]end;function dc:on(d_a,_aa)
local aaa=self._handlers[d_a]if not aaa then aaa={}self._handlers[d_a]=aaa end
aaa[#aaa+1]=_aa;return self end
function dc:off(d_a,_aa)
local aaa=self._handlers[d_a]if not aaa then return self end;for i=#aaa,1,-1 do if aaa[i]==_aa then table.remove(aaa,i)
break end end;return self end
local c_a={text="change",checked="change",value="change",selected="select"}
function dc:bind(d_a,_aa,aaa)local baa=rawget(self,"_class")if not baa.__props[d_a]then
error(
"Basalt: cannot bind unknown property '"..tostring(d_a).."'",2)end;if not bc.is(_aa)then
error("Basalt: bind expects a state or computed value",2)end;if type(aaa)=="function"then
aaa={fromState=aaa}else aaa=aaa or{}end;if type(aaa)~="table"then
error("Basalt: bind options must be a function or table",2)end;self:unbind(d_a)
local caa=_aa
if aaa.fromState then local cba=aaa.fromState;if type(cba)~="function"then
error("Basalt: fromState must be a function",2)end;local dba=self
caa=bc.computed(function()return
cba(_aa:get(),dba)end)end;local daa={source=_aa,value=caa}local _ba=aaa.event or c_a[d_a]
local aba=
aaa.twoWay~=false and bc.isWritable(_aa)and _ba~=nil
if aba then local cba=aaa.toState;if cba~=nil and type(cba)~="function"then
error("Basalt: toState must be a function",2)end;local dba=_aa;daa.event=_ba
daa.handler=function(_ca,aca,...)if
cba then aca=cba(aca,self,...)end;dba:set(aca)
self[d_a]=caa end;self:on(_ba,daa.handler)end;rawget(self,"_bindings")[d_a]=daa;self[d_a]=caa
local bba=self[d_a]return self end
function dc:unbind(d_a,_aa)local aaa=rawget(self,"_bindings")local baa=aaa and aaa[d_a]if not
baa then return self end;local caa=self[d_a]if baa.handler then
self:off(baa.event,baa.handler)end;aaa[d_a]=nil
if _aa==false then rawget(self,"_p")[d_a]=
nil;self:markDirty()else self[d_a]=caa end;return self end
function dc:fire(d_a,...)local _aa=self._handlers[d_a]if not _aa then return false end;for i=1,#_aa do
_aa[i](self,...)end;return true end;function dc:markDirty()return self:markLayoutDirty()end
function dc:markRenderDirty()
local d_a=self;local _aa=rawget(d_a,"parent")
while _aa do d_a=_aa;_aa=rawget(d_a,"parent")end;rawset(d_a,"_dirty",true)return self end
function dc:invalidateLayout(d_a)if d_a and not bd(d_a)then return self end;local _aa=self;while _aa do if
rawget(_aa,"_children")then rawset(_aa,"_layoutDirty",true)
rawset(_aa,"_viewportDirty",true)end
_aa=rawget(_aa,"parent")end
return self end;function dc:markLayoutDirty()self:invalidateLayout()
return self:markRenderDirty()end;function dc:contains(d_a,_aa)local aaa,baa=self.x,self.y
return d_a>=
aaa and _aa>=baa and d_a<aaa+self.width and _aa<baa+
self.height end;function dc:getRoot()
local d_a=self
while rawget(d_a,"parent")do d_a=rawget(d_a,"parent")end;return d_a end
function dc:getAbsolutePosition()
local d_a,_aa=self.x,self.y;local aaa=rawget(self,"parent")while aaa do d_a=d_a+aaa.x-1 -
(rawget(aaa,"_scrollX")or 0)_aa=_aa+aaa.y-1 - (
rawget(aaa,"_scrollY")or 0)
aaa=rawget(aaa,"parent")end
return d_a,_aa end
function dc:measure()
local d_a,_aa=cc.spec(self,"width"),cc.spec(self,"height")return type(d_a)=="number"and d_a or 1,
type(_aa)=="number"and _aa or 1 end
function dc:focus()if self.disabled then return self end;local d_a=self:getRoot()if d_a.setFocused then
d_a:setFocused(self)end;return self end
function dc:setCursor(d_a,_aa,aaa,baa)local caa=self:getRoot()
if
caa~=self and caa.setCursor and caa.getFocused and caa:getFocused()==self then
local daa,_ba=self:getAbsolutePosition()local aba,bba=daa+d_a-1,_ba+_aa-1
local cba=
d_a>=1 and _aa>=1 and d_a<=self.width and _aa<=self.height;local dba=rawget(self,"parent")
while cba and dba do
local _ca,aca=dba:getAbsolutePosition()
if aba<_ca or bba<aca or aba>=_ca+dba.width or bba>=aca+
dba.height then cba=false end;dba=rawget(dba,"parent")end;if cba then caa:setCursor(aba,bba,aaa,baa)else
caa:setCursor(1,1,false,baa)end end;return self end;function dc:destroy()local d_a=rawget(self,"parent")
if d_a then d_a:removeChild(self)end;return self end
function dc:render(d_a)
local _aa=self.background;if _aa then
d_a:fill(1,1,self.width,self.height," ",self.foreground,_aa)end end
function dc:handleMouse(d_a,_aa,aaa,baa)if self.disabled then return nil end
if d_a=="mouse_click"then
if self.background or
self._handlers.click then self:setState("pressed",true)
self:focus()self:fire("click",_aa,aaa,baa)return self end elseif d_a=="mouse_scroll"then if self._handlers.scroll then
self:fire("scroll",_aa,aaa,baa)return self end end;return nil end
function dc:handleKey(d_a,_aa,aaa)if self.disabled then return end
if d_a=="key"then
self:fire("key",_aa,aaa)elseif d_a=="key_up"then self:fire("keyUp",_aa)elseif d_a=="char"then
self:fire("char",_aa)elseif d_a=="paste"then self:fire("paste",_aa)end end;return dc
]=]
sources["core/errors"] = [=[
local ca,da=...local _b={}
local function ab(_c)return _c:match("^%s*(.-)%s*$")end
local function bb(_c)return

_c=="[C]"or _c:sub(1,1)=="("or _c:find("^reactive{")or(da~=""and _c:find(da,1,true)==1)end
function _b.parse(_c,ac)local bc=tostring(_c)
local cc,dc,_d=bc:match("^(.-):(%d+): (.*)$")local ad={}
if ac then
for dd in ac:gmatch("[^\n]+")do dd=ab(dd)if

dd~=""and dd~="stack traceback:"and not dd:find("in function 'xpcall'",1,true)then ad[#ad+1]=dd end end end;local bd,cd
for dd,__a in ipairs(ad)do local a_a,b_a=__a:match("^(.-):(%d+):")if
a_a and not bb(a_a)then bd,cd=a_a,tonumber(b_a)break end end
return{message=_d or bc,file=cc,line=dc and tonumber(dc),userFile=bd,userLine=cd,trace=ad}end;local function cb(_c,ac)term.setTextColor(ac)print(_c)end
local function db(_c,ac)if not
fs.exists(_c)or fs.isDir(_c)then return nil end
local bc=fs.open(_c,"r")if not bc then return nil end;local cc,dc=nil,0;repeat cc=bc.readLine()dc=dc+1 until dc==ac or
cc==nil;bc.close()return cc end
function _b.show(_c,ac,bc)local cc=_b.parse(_c,ac)
term.setBackgroundColor(colors.black)term.clear()term.setCursorPos(1,1)
cb("Basalt Error",colors.red)print()cb(cc.message,colors.white)print()
local dc=cc.userFile or cc.file;local _d=cc.userLine or cc.line
if dc and _d then local ad=db(dc,_d)cb("\26 "..
dc..":".._d,colors.cyan)if ad then
cb("  "..ab(ad),colors.lightGray)end;print()end
if bc~=false and#cc.trace>0 then
cb("Traceback:",colors.gray)
for i=1,math.min(#cc.trace,6)do local ad=cc.trace[i]
local bd=ad:match("^(.-):%d+:")
cb("  "..ad,(bd and not bb(bd))and colors.lightGray or colors.gray)end;if#cc.trace>6 then
cb("  ... (".. (#cc.trace-6).." more)",colors.gray)end;print()end;cb("Press any key to exit",colors.orange)while true do
local ad=os.pullEventRaw()
if
ad=="key"or ad=="mouse_click"or ad=="monitor_touch"or ad=="terminate"then break end end
term.setBackgroundColor(colors.black)term.setTextColor(colors.white)term.clear()
term.setCursorPos(1,1)end
function _b.wrap(_c,ac)return
setmetatable({__basaltError=true,err=_c,trace=ac},{__tostring=function(bc)return tostring(bc.err)end})end;return _b
]=]
sources["core/itemview"] = [=[
local b={}
function b.maxOffset(c,d)return math.max(0,c-math.max(0,d))end
function b.clampOffset(c,d,_a)return
math.max(0,math.min(math.floor(c or 0),b.maxOffset(d,_a)))end
function b.ensureVisible(c,d,_a,aa)c=b.clampOffset(c,_a,aa)if not d or d<1 then return c end;if
d<=c then c=d-1 end;if d>c+aa then c=d-aa end
return b.clampOffset(c,_a,aa)end
function b.geometry(c,d,_a,aa)if aa~="auto"and aa~="always"and aa~="hidden"then
error("Basalt item scrollbar: expected 'auto', 'always' or 'hidden'",3)end;d=math.max(0,math.floor(
d or 0))local ba=b.maxOffset(c,d)
_a=b.clampOffset(_a,c,d)
local ca=aa~="hidden"and d>0 and(aa=="always"or ba>0)local da=d;local _b=0
if ca and d>0 then
da=math.max(1,math.floor(d*d/math.max(c,d)))da=math.min(d,da)local ab=d-da;_b=
ba>0 and math.floor(ab*_a/ba+0.5)or 0 end;return{show=ca,rows=d,maximum=ba,offset=_a,thumbSize=da,thumbPos=_b}end
function b.draw(c,d,_a,aa,ba,ca,da)if not aa.show or aa.rows<=0 then return end
c:fill(d,_a,1,aa.rows," ",ba,ca)
c:fill(d,_a+aa.thumbPos,1,aa.thumbSize," ",ba,da)end
function b.pointerDown(c,d)if not d.show then return nil,nil end;local _a=d.thumbPos+1
if c>=_a and c<_a+
d.thumbSize then return d.offset,c-_a end;local aa=math.max(1,d.rows-d.thumbSize)
local ba=math.floor((c-1 -d.thumbSize/
2)/aa*d.maximum+0.5)
return b.clampOffset(ba,d.maximum+d.rows,d.rows),nil end
function b.drag(c,d,_a)local aa=math.max(1,_a.rows-_a.thumbSize)local ba=math.max(0,math.min(aa,
c-1 -d))local ca=math.floor(
ba/aa*_a.maximum+0.5)return
b.clampOffset(ca,_a.maximum+_a.rows,_a.rows)end;return b
]=]
sources["core/layout"] = [=[
local ca=...local da=ca("core/state")local _b={}local ab={}ab.__index=ab
ab.__basaltLayoutValue=true
local function bb(_c,ac)return setmetatable({kind=_c,value=ac},ab)end;function _b.auto()return bb("auto")end
function _b.fill(_c)_c=_c or 1;if
type(_c)~="number"or _c<=0 then
error("Basalt layout: fill weight must be greater than zero",2)end;return bb("fill",_c)end;function _b.percent(_c)if type(_c)~="number"or _c<0 then
error("Basalt layout: percent must be a non-negative number",2)end
return bb("percent",_c)end;function _b.is(_c)local ac=
type(_c)=="table"and getmetatable(_c)
return ac and
ac.__basaltLayoutValue==true or false end
function _b.spec(_c,ac)
local bc=rawget(_c,"_class")if bc and bc.__getPropertySpec then local cc,dc=bc.__getPropertySpec(_c,ac)if cc then
return dc end end
return _c:raw(ac)end;local function cb(_c)return math.floor(_c+0.5)end
local function db(_c,ac,bc)
if ac and _c<ac then _c=ac end;if bc and _c>bc then _c=bc end;return math.max(0,cb(_c))end
function _b.constrain(_c,ac,bc)
local cc=ac=="width"and"minWidth"or"minHeight"local dc=ac=="width"and"maxWidth"or"maxHeight"
local _d,ad=_c[cc],_c[dc]if _d==false then _d=nil end;if ad==false then ad=nil end;return db(bc,_d,ad)end
function _b.measure(_c,ac,bc)if _c.measure then return _c:measure(ac,bc)end;return 1,1 end
function _b.resolveSize(_c,ac,bc,cc,dc)local _d=ac=="width"and cc or dc;local ad,bd;local cd
if _b.is(bc)then
if
bc.kind=="percent"then cd=_d*bc.value elseif bc.kind=="fill"then cd=_d else
ad,bd=_b.measure(_c,cc,dc)cd=ac=="width"and ad or bd end else cd=tonumber(bc)or 1 end;return _b.constrain(_c,ac,cd)end
function _b.resolveToken(_c,ac,bc)local cc=rawget(ac,"parent")
local dc=cc and cc.width or 1;local _d=cc and cc.height or 1
if _c.kind=="fill"and cc then
if
bc=="width"then
dc=math.max(0,dc- (tonumber(_b.spec(ac,"x"))or 1)+1)elseif bc=="height"then _d=math.max(0,
_d- (tonumber(_b.spec(ac,"y"))or 1)+1)end end;return _b.resolveSize(ac,bc,_c,dc,_d)end
function _b.resolveFreeChild(_c,ac)local bc,cc=_b.spec(ac,"x"),_b.spec(ac,"y")
local dc,_d=_b.spec(ac,"width"),_b.spec(ac,"height")
local ad=_b.is(bc)or _b.is(cc)or _b.is(dc)or _b.is(_d)
if not ad then local aaa=rawget(ac,"_layoutBox")
rawset(ac,"_layoutBox",nil)
if aaa and rawget(ac,"_children")then
rawset(ac,"_layoutDirty",true)rawset(ac,"_viewportDirty",true)end;return end;local bd,cd=_c.width,_c.height;local dd=tonumber(bc)or 1
local __a=tonumber(cc)or 1
local a_a,b_a=math.max(0,bd-dd+1),math.max(0,cd-__a+1)local c_a=_b.resolveSize(ac,"width",dc,a_a,b_a)
local d_a=_b.resolveSize(ac,"height",_d,a_a,b_a)local _aa=rawget(ac,"_layoutBox")
rawset(ac,"_layoutBox",{x=cb(dd),y=cb(__a),width=c_a,height=d_a})
if rawget(ac,"_children")and
(not _aa or _aa.width~=c_a or _aa.height~=d_a)then
rawset(ac,"_layoutDirty",true)rawset(ac,"_viewportDirty",true)end end
function _b.resolveFreeChildren(_c)local ac=_c:getChildren()for i=1,#ac do
_b.resolveFreeChild(_c,ac[i])end end
function _b.setBox(_c,ac,bc,cc,dc)
local _d={x=cb(ac),y=cb(bc),width=math.max(0,cb(cc)),height=math.max(0,cb(dc))}local ad=rawget(_c,"_layoutBox")rawset(_c,"_layoutBox",_d)
if
rawget(_c,"_children")and
(not ad or ad.width~=_d.width or ad.height~=_d.height)then
rawset(_c,"_layoutDirty",true)rawset(_c,"_viewportDirty",true)end end;return _b
]=]
sources["core/palette"] = [=[
local bc={}local cc=math.floor;local dc=string.char
local _d={[0]=0xF0F0F0,0xF2B233,0xE57FD8,0x99B2F2,0xDEDE6C,0x7FCC19,0xF2B2CC,0x4C4C4C,0x999999,0x4C99B2,0xB266E5,0x3366CC,0x7F664C,0x57A64E,0xCC4C4C,0x111111}local ad={}local bd=16;local cd={}local dd={}
local function __a(caa)return cc(caa/65536)/255,cc(caa/256)%256 /
255, (caa%256)/255 end
for i=0,15 do ad[i]={__a(_d[i])}cd[2 ^i]=dc(i)dd[_d[i]]=2 ^i end;bc.charOf=cd
function bc.getRGB(caa)local daa;if type(caa)=="string"then daa=caa:byte()elseif cd[caa]then
daa=cd[caa]:byte()else daa=caa end;local _ba=ad[daa]if not _ba then
error(
"Basalt: unknown registry color "..tostring(caa),2)end;return _ba[1],_ba[2],_ba[3]end
local function a_a(caa)if caa<0 then return 0 end;if caa>1 then return 1 end;return caa end
local function b_a(caa,daa,_ba)
if type(caa)=="string"then local aba=caa:gsub("#","")
if aba:match("^%x%x%x$")then
aba=aba:gsub("%x","%0%0")elseif aba:match("^%x%x%x%x%x%x%x%x$")then aba=aba:sub(3)elseif not
aba:match("^%x%x%x%x%x%x$")then
error("Basalt: invalid color string '"..
caa.."' (expected #RGB, #RRGGBB or #AARRGGBB)",3)end;return __a(tonumber(aba,16))end
if daa==nil then if caa<0 or caa>0xFFFFFF or caa%1 ~=0 then
error(
"Basalt: invalid color number "..tostring(caa).." (expected 0x000000-0xFFFFFF)",3)end
return __a(caa)end
if caa>1 or daa>1 or _ba>1 then caa,daa,_ba=caa/255,daa/255,_ba/255 end;return a_a(caa),a_a(daa),a_a(_ba)end
function bc.rgb(caa,daa,_ba)local aba,bba,cba=b_a(caa,daa,_ba)local dba=cc(aba*255 +0.5)*65536 +cc(bba*
255 +0.5)*256 +
cc(cba*255 +0.5)
local _ca=dd[dba]if _ca then return _ca end
if bd>255 then local cca,dca=0,math.huge
for index=0,255 do local ada=ad[index]
local bda=
(aba-ada[1])^2 + (bba-ada[2])^2 + (cba-ada[3])^2;if bda<dca then cca,dca=index,bda end end;local _da=cca<16 and 2 ^cca or 0x10000 +cca
dd[dba]=_da;return _da end;local aca=bd;bd=bd+1;ad[aca]={aba,bba,cba}local bca=0x10000 +aca
cd[bca]=dc(aca)dd[dba]=bca;return bca end;function bc.hasVirtual()return bd>16 end;local c_a={}for i=0,15 do
c_a[i]=("%x"):format(i)end;local d_a={}for i=0,15 do d_a[dc(i)]=c_a[i]end
bc.identityMap=d_a;local _aa={}for i=0,15 do _aa[c_a[i]]=dc(i)
_aa[c_a[i]:upper()]=dc(i)end;bc.hexToByte=_aa
function bc.windowTranslation(caa)local daa=caa.getPaletteColour or
caa.getPaletteColor;if not daa then return nil end
local _ba
for i=0,15 do local aba,bba,cba,dba=pcall(daa,2 ^i)
if
aba and type(bba)=="number"and
type(cba)=="number"and type(dba)=="number"then local _ca,aca,bca=bc.getRGB(i)
if

math.abs(bba-_ca)+math.abs(cba-aca)+math.abs(dba-bca)>0.004 then
if not _ba then _ba={}for dca,_da in pairs(_aa)do _ba[dca]=_da end end;local cca=cd[bc.rgb(bba,cba,dba)]_ba[c_a[i]]=cca
_ba[c_a[i]:upper()]=cca end end end;return _ba end;local aaa={}aaa.__index=aaa
function bc.newMapper(caa)return
setmetatable({term=caa,overridden={},prevSlot={},prevMap={}},aaa)end
local function baa(caa,daa)
local _ba,aba,bba=caa[1]-daa[1],caa[2]-daa[2],caa[3]-daa[3]return _ba*_ba+aba*aba+bba*bba end
function aaa:build(caa)local daa=self.term
local _ba=daa.setPaletteColour or daa.setPaletteColor;local aba={}local bba={}
for i=0,15 do aba[dc(i)]=c_a[i]
if caa[i]then bba[i]=i;if
_ba and self.overridden[i]then local aca=ad[i]_ba(2 ^i,aca[1],aca[2],aca[3])self.overridden[i]=
nil end end end;local cba={}
for aca in pairs(caa)do if aca>15 then cba[#cba+1]=aca end end
if#cba>0 then table.sort(cba)local aca={}
if _ba then
local function bca(_da,ada)bba[ada]=_da
self.prevSlot[_da]=ada
if self.overridden[ada]~=_da then local bda=ad[_da]
_ba(2 ^ada,bda[1],bda[2],bda[3])self.overridden[ada]=_da end;aba[dc(_da)]=c_a[ada]end;local cca={}
for _da,ada in ipairs(cba)do local bda=self.prevSlot[ada]if
bda and bba[bda]==nil then bca(ada,bda)else cca[#cca+1]=ada end end;local dca=0
for _da,ada in ipairs(cca)do local bda;while dca<=15 do if bba[dca]==nil then bda=dca;break end
dca=dca+1 end;if bda then bca(ada,bda)else
aca[#aca+1]=ada end end else aca=cba end
for bca,cca in ipairs(aca)do local dca=ad[cca]local _da,ada=15,math.huge
for s=0,15 do local bda=bba[s]
local cda=bda and ad[bda]or(not
_ba and ad[s]or nil)
if cda then local dda=baa(dca,cda)if dda<ada then _da,ada=s,dda end end end;aba[dc(cca)]=c_a[_da]end end;local dba=false;local _ca=self.prevMap
for aca,bca in pairs(aba)do if
_ca[aca]~=nil and _ca[aca]~=bca then dba=true;break end end;self.prevMap=aba;return aba,dba end
function aaa:restore()local caa=self.term
local daa=caa.setPaletteColour or caa.setPaletteColor
if daa then for _ba in pairs(self.overridden)do local aba=ad[_ba]
daa(2 ^_ba,aba[1],aba[2],aba[3])end end;self.overridden,self.prevSlot,self.prevMap={},{},{}end;return bc
]=]
sources["core/reactive"] = [=[
local _a=...local aa=_a("core/palette")local ba={}
local ca={colors=colors,math=math,rgb=aa.rgb,tostring=tostring,tonumber=tonumber,clamp=function(da,_b,ab)return
math.min(math.max(da,_b),ab)end,round=function(da)
return math.floor(da+0.5)end,floor=math.floor,ceil=math.ceil,abs=math.abs,min=math.min,max=math.max}
function ba.compile(da,_b)local ab=da:sub(2,-2)
local bb=setmetatable({},{__index=function(_c,ac)if ac=="self"then return _b end;if
ac=="parent"then return rawget(_b,"parent")end;local bc=ca[ac]if bc~=nil then
return bc end;local cc=_b:getRoot()
if cc.find then return cc:find(ac)end;return nil end})
local cb,db=load("return "..ab,"reactive"..da,"t",bb)if not cb then
error("Basalt: invalid reactive expression "..da..": "..tostring(db),3)end;return cb end;return ba
]=]
sources["core/render"] = [=[
local bc=...local cc=bc("core/palette")local dc,_d=string.rep,string.sub
local ad=math.floor;local bd=cc.charOf;local cd={}local dd={}for mask=0,31 do
cd[mask]=string.char(128 +mask)end;local __a={}__a.__index=__a;function __a.new(caa)
local daa=setmetatable({},__a)daa.term=caa;daa.mapper=cc.newMapper(caa)
daa:resize(caa.getSize())return daa end
function __a:resize(caa,daa)
self.width,self.height=caa,daa;self.text,self.fg,self.bg={},{},{}
self.prevText,self.prevFg,self.prevBg={},{},{}local _ba=dc(" ",caa)local aba=dc("\0",caa)
local bba=dc(string.char(15),caa)
for y=1,daa do self.text[y],self.fg[y],self.bg[y]=_ba,aba,bba end;self.dirty=true;self.ox,self.oy=0,0
self.cx1,self.cy1,self.cx2,self.cy2=1,1,caa,daa;self.stack,self.stackN={},0;return self end
function __a:push(caa,daa,_ba,aba)local bba,cba=self.stackN,self.stack
cba[bba+1],cba[bba+2],cba[bba+3]=self.ox,self.oy,self.cx1
cba[bba+4],cba[bba+5],cba[bba+6]=self.cy1,self.cx2,self.cy2;self.stackN=bba+6
local dba,_ca=self.ox+caa-1,self.oy+daa-1;self.ox,self.oy=dba,_ca
if dba+1 >self.cx1 then self.cx1=dba+1 end;if _ca+1 >self.cy1 then self.cy1=_ca+1 end;if
dba+_ba<self.cx2 then self.cx2=dba+_ba end;if _ca+aba<self.cy2 then
self.cy2=_ca+aba end;return self end
function __a:pop()local caa,daa=self.stackN,self.stack;self.ox,self.oy,self.cx1=daa[caa-5],daa[caa-4],daa[
caa-3]
self.cy1,self.cx2,self.cy2=daa[caa-2],daa[caa-1],daa[caa]self.stackN=caa-6;return self end;local function a_a(caa,daa,_ba)
return _d(caa,1,daa-1).._ba.._d(caa,daa+#_ba)end
local function b_a(caa,daa,_ba)local aba={}
for i=1,#caa do local bba=_ba and _ba:byte(i)or
caa:byte(i)aba[i]=bba==0 and _d(daa,i,i)or
_d(caa,i,i)end;return table.concat(aba)end
local function c_a(caa,daa,_ba)local aba,bba,cba=cc.getRGB(caa)local dba,_ca,aca=cc.getRGB(daa)
local bca,cca,dca=cc.getRGB(_ba)
local _da=(aba-dba)^2 + (bba-_ca)^2 + (cba-aca)^2
local ada=(aba-bca)^2 + (bba-cca)^2 + (cba-dca)^2;return _da<=ada and 0 or 1 end
local function d_a(caa,daa,_ba,aba,bba,cba)local dba=caa..daa.._ba..aba..bba..cba
local _ca=dd[dba]if _ca then return _ca[1],_ca[2],_ca[3]end
local aca,bca,cca={caa,daa,_ba,aba,bba,cba},{},{}
for i=1,6 do local a_b=aca[i]if bca[a_b]then bca[a_b]=bca[a_b]+1 else
bca[a_b],cca[#cca+1]=1,a_b end end;local dca,_da;for a_b,b_b in ipairs(cca)do
if not dca or bca[b_b]>bca[dca]then _da,dca=dca,b_b elseif
not _da or bca[b_b]>bca[_da]then _da=b_b end end
if not _da then
_ca={" ",dca,dca}dd[dba]=_ca;return _ca[1],_ca[2],_ca[3]end;local ada={}
for i=1,6 do ada[i]=aca[i]==dca and 0 or
(aca[i]==_da and 1 or c_a(aca[i],dca,_da))end;local bda,cda=ada[6],0;if ada[1]~=bda then cda=cda+1 end;if ada[2]~=bda then
cda=cda+2 end;if ada[3]~=bda then cda=cda+4 end;if ada[4]~=bda then
cda=cda+8 end;if ada[5]~=bda then cda=cda+16 end;local dda,__b;if bda==0 then
dda,__b=_da,dca else dda,__b=dca,_da end;_ca={cd[cda],dda,__b}
dd[dba]=_ca;return _ca[1],_ca[2],_ca[3]end
function __a:write(caa,daa,_ba,aba,bba)local cba=daa+self.oy;if cba<self.cy1 or cba>self.cy2 then
return self end;local dba=caa+self.ox
local _ca,aca=dba,dba+#_ba-1;local bca,cca=self.cx1,self.cx2
if _ca<bca then _ba=_d(_ba,bca-_ca+1)_ca=bca end;if aca>cca then _ba=_d(_ba,1,cca-_ca+1)aca=cca end;if
_ca>aca then return self end
self.text[cba]=a_a(self.text[cba],_ca,_ba)if aba then
self.fg[cba]=a_a(self.fg[cba],_ca,dc(aba,aca-_ca+1))end;if bba then
self.bg[cba]=a_a(self.bg[cba],_ca,dc(bba,aca-_ca+1))end;self.dirty=true;return self end
local function _aa(caa)if not caa then return nil end;local daa=bd[caa]if not daa then
error("Basalt: unknown color value "..
tostring(caa).." (use colors.* or basalt.rgb)",3)end;return daa end;function __a:blit(caa,daa,_ba,aba,bba)
return self:write(caa,daa,_ba,_aa(aba),_aa(bba))end
function __a:colorBlit(caa,daa,_ba,aba,bba)local cba,dba={},{}for i=1,#_ba do
cba[i]=_aa(aba[i])dba[i]=_aa(bba[i])end;return
self:rawBlit(caa,daa,_ba,table.concat(cba),table.concat(dba))end
function __a:drawText(caa,daa,_ba)return self:write(caa,daa,_ba)end
function __a:rawBlit(caa,daa,_ba,aba,bba)local cba=daa+self.oy;if cba<self.cy1 or cba>self.cy2 then
return self end;local dba=caa+self.ox
local _ca,aca=dba,dba+#_ba-1;local bca,cca=self.cx1,self.cx2
local dca=_ca<bca and(bca-_ca)or 0;local _da=aca>cca and(aca-cca)or 0
if dca>0 or _da>0 then
_ca=_ca+dca;aca=aca-_da;if _ca>aca then return self end
_ba=_d(_ba,1 +dca,#_ba-_da)if aba then aba=_d(aba,1 +dca,#aba-_da)end;if bba then bba=_d(bba,1 +dca,
#bba-_da)end end;self.text[cba]=a_a(self.text[cba],_ca,_ba)if aba then
self.fg[cba]=a_a(self.fg[cba],_ca,aba)end;if bba then
self.bg[cba]=a_a(self.bg[cba],_ca,bba)end;self.dirty=true;return self end
function __a:maskedBlit(caa,daa,_ba,aba,bba,cba,dba,_ca)local aca,bca=daa+self.oy,caa+self.ox;if aca<self.cy1 or
aca>self.cy2 then return self end
local cca,dca=bca,bca+#_ba-1
local _da=cca<self.cx1 and self.cx1 -cca or 0
local ada=dca>self.cx2 and dca-self.cx2 or 0
if _da>0 or ada>0 then cca,dca=cca+_da,dca-ada;if cca>dca then return self end;_ba=_d(_ba,
1 +_da,#_ba-ada)
aba=aba and _d(aba,1 +_da,#aba-ada)bba=bba and _d(bba,1 +_da,#bba-ada)cba=cba and _d(cba,1 +_da,#
cba-ada)dba=dba and
_d(dba,1 +_da,#dba-ada)
_ca=_ca and _d(_ca,1 +_da,#_ca-ada)end;local bda=_d(self.text[aca],cca,dca)
self.text[aca]=a_a(self.text[aca],cca,b_a(_ba,bda,cba))if aba then local cda=_d(self.fg[aca],cca,dca)
self.fg[aca]=a_a(self.fg[aca],cca,b_a(aba,cda,dba))end;if bba then
local cda=_d(self.bg[aca],cca,dca)
self.bg[aca]=a_a(self.bg[aca],cca,b_a(bba,cda,_ca))end;self.dirty=true;return self end
function __a:drawPixels(caa,daa,_ba,aba,bba,cba)local dba,_ca=math.ceil(_ba/2),math.ceil(aba/3)
for cellY=1,_ca do
local aca,bca,cca,dca,_da={},{},{},{},false
for cellX=1,dba do
local ada,bda=caa+cellX-1 +self.ox,daa+cellY-1 +self.oy
local cda=
ada>=self.cx1 and ada<=self.cx2 and bda>=self.cy1 and bda<=self.cy2;local dda,__b={},false
if cda then local a_b,b_b={},_d(self.bg[bda],ada,ada)
local c_b=self.text[bda]:byte(ada)
if c_b and c_b>=128 and c_b<=159 then
local d_b,_ab=_d(self.fg[bda],ada,ada),c_b-128;local aab={1,2,4,8,16}
for slot=1,5 do a_b[slot]=
ad(_ab/aab[slot])%2 ==1 and d_b or b_b end;a_b[6]=b_b else for slot=1,6 do a_b[slot]=b_b end end
for py=1,3 do local d_b=(cellY-1)*3 +py
for px=1,2 do local _ab=(cellX-1)*2 +px;local aab=
(py-1)*2 +px;local bab=
d_b<=aba and _ab<=_ba and bba[d_b]:byte(_ab)or 0
if bab~=0 then
dda[aab],__b=cba[bab],true;if not dda[aab]then
error("Basalt: FLIMG palette index "..bab.." is missing",2)end else dda[aab]=a_b[aab]end end end end
if __b then
aca[cellX],bca[cellX],cca[cellX]=d_a(dda[1],dda[2],dda[3],dda[4],dda[5],dda[6])dca[cellX],_da="\1",true else
aca[cellX],bca[cellX],cca[cellX]="\0","\0","\0"dca[cellX]="\0"end end;if _da then local ada=table.concat(dca)
self:maskedBlit(caa,daa+cellY-1,table.concat(aca),table.concat(bca),table.concat(cca),ada,ada,ada)end end;return self end;local aaa={}for i=0,15 do aaa[("%x"):format(i)]=string.char(i)
aaa[("%X"):format(i)]=string.char(i)end
function __a:drawBlit(caa,daa,_ba,aba,bba)return
self:rawBlit(caa,daa,_ba,aba and
(aba:gsub(".",aaa)),bba and(bba:gsub(".",aaa)))end
function __a:fill(caa,daa,_ba,aba,bba,cba,dba)local _ca=dc(bba,_ba)local aca,bca=_aa(cba),_aa(dba)for dy=0,aba-1 do
self:write(caa,daa+dy,_ca,aca,bca)end;return self end
function __a:setCursor(caa,daa,_ba,aba)self.cursorX,self.cursorY,self.cursorBlink=caa,daa,_ba
self.cursorColor=aba;self.dirty=true;return self end
local function baa(caa,daa)for i=1,#caa do daa[caa:byte(i)]=true end end
function __a:flush()if not self.dirty then return self end;local caa=self.term;local daa,_ba
if
cc.hasVirtual()then local dba={}for y=1,self.height do baa(self.fg[y],dba)
baa(self.bg[y],dba)end
daa,_ba=self.mapper:build(dba)else daa,_ba=cc.identityMap,false end;local aba,bba,cba=self.prevText,self.prevFg,self.prevBg
for y=1,self.height do
local dba,_ca,aca=self.text[y],self.fg[y],self.bg[y]
if
_ba or dba~=aba[y]or _ca~=bba[y]or aca~=cba[y]then caa.setCursorPos(1,y)
caa.blit(dba,(_ca:gsub(".",daa)),(aca:gsub(".",daa)))aba[y],bba[y],cba[y]=dba,_ca,aca end end
if self.cursorBlink then
local dba=self.cursorColor and bd[self.cursorColor]local _ca=dba and daa[dba]if _ca then
caa.setTextColor(2 ^tonumber(_ca,16))end
caa.setCursorPos(self.cursorX,self.cursorY)caa.setCursorBlink(true)else caa.setCursorBlink(false)end;self.dirty=false;return self end;return __a
]=]
sources["core/scroll"] = [=[
local ba={}
local function ca(cb,db,_c)if cb<db then return db end;if cb>_c then return _c end;return cb end;local function da(cb)
return rawget(cb,"_scrollX")or 0,rawget(cb,"_scrollY")or 0 end;local function _b(cb)
return math.max(0,
(rawget(cb,"_contentWidth")or 0)-cb.width),math.max(0,(
rawget(cb,"_contentHeight")or 0)-cb.height)end
local function ab(cb)
local db=cb.scrollbar;if db~="auto"and db~="always"and db~="hidden"then
error("Basalt scroll: scrollbar must be 'auto', 'always' or 'hidden'",3)end;return db end
function ba.disable(cb)rawset(cb,"_scrollX",0)rawset(cb,"_scrollY",0)
rawset(cb,"_showScrollX",false)rawset(cb,"_showScrollY",false)
rawset(cb,"_scrollDrag",nil)rawset(cb,"_viewportDirty",true)end
function ba.setup(cb)rawset(cb,"_scrollX",0)rawset(cb,"_scrollY",0)
rawset(cb,"_contentWidth",0)rawset(cb,"_contentHeight",0)
cb:on("drag",function(db,_c,ac,bc)ba.drag(db,ac,bc)end)
cb:on("clickUp",function(db)rawset(db,"_scrollDrag",nil)end)end
function ba.update(cb)local db=cb:getChildren()local _c,ac=0,0
for i=1,#db do local dd=db[i]if dd.visible then _c=math.max(_c,dd.x+
dd.width-1)
ac=math.max(ac,dd.y+dd.height-1)end end;rawset(cb,"_contentWidth",_c)
rawset(cb,"_contentHeight",ac)if not cb.scrollable then ba.disable(cb)return end
local bc=ab(cb)local cc=cb.scrollXEnabled and _c>cb.width;local dc=cb.scrollYEnabled and
ac>cb.height
rawset(cb,"_showScrollX",
bc~="hidden"and cb.scrollXEnabled and(bc=="always"or cc))
rawset(cb,"_showScrollY",bc~="hidden"and cb.scrollYEnabled and(bc=="always"or dc))local _d,ad=_b(cb)local bd,cd=da(cb)
rawset(cb,"_scrollX",cb.scrollXEnabled and ca(bd,0,_d)or 0)
rawset(cb,"_scrollY",cb.scrollYEnabled and ca(cd,0,ad)or 0)rawset(cb,"_viewportDirty",true)end
local function bb(cb,db,_c,ac,bc)if cb<=0 then return 1,0 end
local cc=math.max(1,math.floor(cb*db/math.max(_c,db)))cc=math.min(cb,cc)local dc=cb-cc;local _d=bc>0 and
math.floor(dc*ac/bc+0.5)or 0;return cc,_d end
function ba.geometry(cb)local db=rawget(cb,"_showScrollX")==true;local _c=
rawget(cb,"_showScrollY")==true;local ac,bc=da(cb)local cc,dc=_b(cb)local _d=math.max(0,
cb.width- (_c and 1 or 0))local ad=math.max(0,
cb.height- (db and 1 or 0))
local bd,cd=bb(_d,cb.width,
rawget(cb,"_contentWidth")or 0,ac,cc)
local dd,__a=bb(ad,cb.height,rawget(cb,"_contentHeight")or 0,bc,dc)
return
{showX=db,showY=_c,horizontalLength=_d,verticalLength=ad,horizontalThumbSize=bd,horizontalThumbPos=cd,verticalThumbSize=dd,verticalThumbPos=__a,maxX=cc,maxY=dc}end
function ba.draw(cb,db)if not cb.scrollable then return end;local _c=ba.geometry(cb)
local ac,bc=cb.scrollbarColor,cb.scrollbarThumbColor
if _c.showY and _c.verticalLength>0 then
db:fill(cb.width,1,1,_c.verticalLength," ",cb.foreground,ac)
db:fill(cb.width,_c.verticalThumbPos+1,1,_c.verticalThumbSize," ",cb.foreground,bc)end
if _c.showX and _c.horizontalLength>0 then
db:fill(1,cb.height,_c.horizontalLength,1," ",cb.foreground,ac)
db:fill(_c.horizontalThumbPos+1,cb.height,_c.horizontalThumbSize,1," ",cb.foreground,bc)end;if _c.showX and _c.showY then
db:fill(cb.width,cb.height,1,1," ",cb.foreground,ac)end end
function ba.set(cb,db,_c,ac)if not cb.scrollable then return false end;local bc,cc=da(cb)
local dc,_d=_b(cb)db=
cb.scrollXEnabled and ca(math.floor(db or bc),0,dc)or 0
_c=cb.scrollYEnabled and ca(math.floor(
_c or cc),0,_d)or 0;if db==bc and _c==cc then return false end
rawset(cb,"_scrollX",db)rawset(cb,"_scrollY",_c)
rawset(cb,"_viewportDirty",true)cb:markRenderDirty()if ac~=false then
cb:fire("scrollChange",db,_c)end;return true end
function ba.wheel(cb,db)if not cb.scrollable then return false end;local _c,ac=da(cb)local bc=db*
math.max(1,math.floor(cb.scrollStep))
if
cb.scrollYEnabled and(
rawget(cb,"_contentHeight")or 0)>cb.height then return ba.set(cb,_c,ac+bc)elseif cb.scrollXEnabled then
return ba.set(cb,_c+bc,ac)end;return false end
function ba.isBarPoint(cb,db,_c)if not cb.scrollable then return false end
local ac=ba.geometry(cb)if
ac.showY and db==cb.width and _c<=ac.verticalLength then return"y",ac end
if
ac.showX and _c==cb.height and db<=ac.horizontalLength then return"x",ac end;if
ac.showX and ac.showY and db==cb.width and _c==cb.height then return"corner",ac end;return false,ac end
function ba.pointerDown(cb,db,_c)local ac,bc=ba.isBarPoint(cb,db,_c)if ac=="corner"or not ac then return ac==
"corner"end;local cc=ac=="y"
local dc=cc and _c or db
local _d=cc and bc.verticalThumbPos or bc.horizontalThumbPos
local ad=cc and bc.verticalThumbSize or bc.horizontalThumbSize
local bd=cc and bc.verticalLength or bc.horizontalLength;local cd=cc and bc.maxY or bc.maxX;local dd=_d+1
if
dc>=dd and dc<dd+ad then rawset(cb,"_scrollDrag",{axis=ac,grab=dc-dd})else local __a=math.max(1,
bd-ad)
local a_a=math.floor((dc-1 -ad/2)/__a*cd+0.5)local b_a,c_a=da(cb)
ba.set(cb,cc and b_a or a_a,cc and a_a or c_a)end;return true end
function ba.drag(cb,db,_c)local ac=rawget(cb,"_scrollDrag")if not ac then return false end
local bc=ba.geometry(cb)local cc=ac.axis=="y"local dc=cc and _c or db;local _d=cc and bc.verticalThumbSize or
bc.horizontalThumbSize;local ad=
cc and bc.verticalLength or bc.horizontalLength;local bd=
cc and bc.maxY or bc.maxX;local cd=math.max(1,ad-_d)local dd=ca(dc-1 -
ac.grab,0,cd)
local __a=math.floor(dd/cd*bd+0.5)local a_a,b_a=da(cb)return
ba.set(cb,cc and a_a or __a,cc and __a or b_a)end;return ba
]=]
sources["core/state"] = [=[
local ba={}local ca=table.unpack or unpack;local da=nil;local _b={}_b.__index=_b
_b.__basaltStateValue=true;local ab={}ab.__index=ab;ab.__basaltStateValue=true
local function bb(cb,db)db=db or da
if
db and db.markDirty then cb._watchers[db]=true
local _c=rawget(db,"_stateDependencies")if not _c then _c=setmetatable({},{__mode="k"})
rawset(db,"_stateDependencies",_c)end;_c[cb]=true end end
function ba.clearWatcher(cb)local db=rawget(cb,"_stateDependencies")
if not db then return end
for _c in pairs(db)do _c._watchers[cb]=nil;db[_c]=nil end end
function ba.withWatcher(cb,db,...)local _c=da;da=cb or _c
local ac=table.pack(pcall(db,...))da=_c;if not ac[1]then error(ac[2],0)end;return ca(ac,2,ac.n)end;function ba.is(cb)
local db=type(cb)=="table"and getmetatable(cb)
return db and db.__basaltStateValue==true or false end;function ba.read(cb,db)
return cb:get(db)end
function ba.isWritable(cb)return getmetatable(cb)==_b end;function _b:get(cb)bb(self,cb)return self._value end
function _b:set(cb)
local db=self._value;if db==cb then return self end;self._value=cb
for _c in pairs(self._watchers)do if _c.markLayoutDirty then
_c:markLayoutDirty()else _c:markDirty()end end;for _c in pairs(self._listeners)do _c(cb,db)end;return self end;function _b:update(cb)if type(cb)~="function"then
error("Basalt state: update expects a function",2)end
return self:set(cb(self._value))end
function _b:touch()for cb in
pairs(self._watchers)do
if cb.markLayoutDirty then cb:markLayoutDirty()else cb:markDirty()end end
for cb in
pairs(self._listeners)do cb(self._value,self._value)end;return self end
function _b:subscribe(cb,db)if type(cb)~="function"then
error("Basalt state: subscribe expects a function",2)end
self._listeners[cb]=true;if db then cb(self._value,nil)end;local _c=true;return
function()if _c then self._listeners[cb]=
nil;_c=false end end end
function _b:map(cb)if type(cb)~="function"then
error("Basalt state: map expects a function",2)end;local db=self;return ba.computed(function()
return cb(db:get())end)end;function _b:__tostring()return tostring(self._value)end;function ab:get(cb)return
ba.withWatcher(cb,self._compute)end
function ab:map(cb)
if
type(cb)~="function"then error("Basalt state: map expects a function",2)end;local db=self;return
ba.computed(function()return cb(db:get())end)end;function ab:__tostring()return tostring(self:get())end
function ba.create(cb)return
setmetatable({_value=cb,_watchers=setmetatable({},{__mode="k"}),_listeners={}},_b)end;function ba.computed(cb)if type(cb)~="function"then
error("Basalt computed: expected a function",2)end
return setmetatable({_compute=cb},ab)end
return ba
]=]
sources["core/text"] = [=[
local b={}
function b.wrap(c,d)d=math.max(1,d)local _a={}
for aa in
(tostring(c).."\n"):gmatch("(.-)\n")do local ba=""
for ca in aa:gmatch("%S+")do if#ba==0 then ba=ca elseif#ba+1 +#ca<=d then ba=ba.." "..ca else _a[#
_a+1]=ba;ba=ca end
while#ba>d do _a[
#_a+1]=ba:sub(1,d)ba=ba:sub(d+1)end end;_a[#_a+1]=ba end
if#_a>1 and _a[#_a]==""then table.remove(_a)end;if#_a==0 then _a={""}end;return _a end;return b
]=]
sources["elements/Button"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("Button",ba)aa.property(ca,"text","Button")
aa.property(ca,"width",10)aa.property(ca,"height",3)
aa.property(ca,"background",colors.gray)
function ca:render(da)local _b,ab=self.foreground,self.background;if
self:hasState("pressed")and ab then _b,ab=ab,_b end;local bb,cb=self.width,self.height;if ab then
da:fill(1,1,bb,cb," ",_b,ab)end;local db=tostring(self.text)
da:blit(
math.floor((bb-#db)/2)+1,math.floor((cb-1)/2)+1,db,_b,ab or nil)end;function ca:measure()
return math.max(3,#tostring(self.text)+2),3 end;return ca
]=]
sources["elements/Canvas"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("Canvas",ba)aa.property(ca,"draw",false,{rawFunction=true})
function ca:render(da)
ba.render(self,da)local _b=self.draw;if _b then _b(self,da)end end;return ca
]=]
sources["elements/Checkbox"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("Checkbox",ba)
aa.property(ca,"checked",false,{state="checked",styleable=false})aa.property(ca,"text","")
aa.property(ca,"checkedSymbol","x")aa.property(ca,"uncheckedSymbol"," ")
aa.property(ca,"width",function(da)return#
tostring(da.text)+4 end)aa.event(ca,"change")function ca:setup()ba.setup(self)
self:on("click",function(da)da.checked=not
da.checked;da:fire("change",da.checked)end)end
function ca:render(da)
ba.render(self,da)
local _b=self.checked and self.checkedSymbol or self.uncheckedSymbol
da:blit(1,1,"["..
tostring(_b):sub(1,1).."] "..tostring(self.text),self.foreground,nil)end;return ca
]=]
sources["elements/Collection"] = [=[
local aa=...local ba=aa("core/class")local ca=aa("core/element")
local da=aa("core/collection")local _b=ba.create("Collection",ca)da.install(_b)function _b:setup()
ca.setup(self)da.setup(self)end;return _b
]=]
sources["elements/Column"] = [=[
local aa=...local ba=aa("core/class")local ca=aa("core/layout")
local da=aa("elements/Flex")local _b=ba.create("Column",da)
ba.property(_b,"direction","column")ba.property(_b,"width",ca.fill())
ba.property(_b,"height",ca.auto())return _b
]=]
sources["elements/ComboBox"] = [=[
local da=...local _b=da("core/class")local ab=da("elements/Input")
local bb=da("core/itemview")local cb=da("core/collection")local db=_b.create("ComboBox",ab)
cb.install(db,{changeEvent="selectionChange"})_b.property(db,"dropHeight",6)
_b.property(db,"autoComplete",false)_b.property(db,"offset",0)
_b.property(db,"dropBackground",colors.black)_b.property(db,"dropForeground",colors.white)
_b.property(db,"scrollbar","auto")_b.property(db,"scrollbarColor",colors.gray)
_b.property(db,"scrollbarThumbColor",colors.lightGray)_b.property(db,"width",14)
_b.property(db,"height",function(bc)if bc.open then
return 1 +math.min(#
bc:getDisplayItems(),bc.dropHeight)end;return 1 end)
_b.property(db,"open",false,{onChange=function(bc,cc)
if cc then rawset(bc,"_zBefore",bc.z)bc.z=999
rawset(bc,"_highlighted",1)bc.offset=0 else bc.z=rawget(bc,"_zBefore")or bc.z end end})
function db:getDisplayItems()local bc=self.items;local cc={}local dc=
self.autoComplete and self.text:lower()or""
for i=1,#bc do
local _d=tostring(bc[i])if#dc==0 or _d:lower():sub(1,#dc)==dc then
cc[#cc+1]={index=i,text=_d,item=bc[i]}end end;return cc end;local function _c(bc,cc)
return math.min(#cc,math.max(0,bc.dropHeight))end;local function ac(bc,cc)return
bb.geometry(#cc,_c(bc,cc),bc.offset,bc.scrollbar)end
function db:selectDisplayed(bc)
local cc=self:getDisplayItems()local dc=cc[bc]if not dc then return self end
rawset(self,"_selecting",true)self.text=dc.text;rawset(self,"_selecting",nil)self:_moveCursor(#
dc.text+1)self.open=false
self:activateItem(dc.index)return self end;function db:clear()cb.methods.clear(self)self.open=false;self.offset=0
self:markDirty()return self end
function db:setup()
ab.setup(self)cb.setup(self)
self:on("click",function(bc,cc,dc,_d)if _d==1 then
if dc==bc.width then bc.open=not bc.open end;return end;local ad=bc:getDisplayItems()
local bd=ac(bc,ad)if bd.show and dc==bc.width then local cd,dd=bb.pointerDown(_d-1,bd)
bc.offset=cd
if dd~=nil then rawset(bc,"_itemScrollDrag",dd)end;return end;bc:selectDisplayed(
bc.offset+_d-1)end)
self:on("drag",function(bc,cc,dc,_d)local ad=rawget(bc,"_itemScrollDrag")if ad~=nil then
bc.offset=bb.drag(_d-1,ad,ac(bc,bc:getDisplayItems()))end end)
self:on("clickUp",function(bc)rawset(bc,"_itemScrollDrag",nil)end)
self:on("change",function(bc)
if
bc.autoComplete and not rawget(bc,"_selecting")then
bc.open=#bc:getDisplayItems()>0 and#bc.text>0;rawset(bc,"_highlighted",1)bc.offset=0 end end)
self:on("blur",function(bc)bc.open=false end)end
function db:handleMouse(bc,cc,dc,_d)
if bc=="mouse_scroll"and self.open then
if self.disabled then return nil end;local ad=self:getDisplayItems()
self.offset=bb.clampOffset(self.offset+cc,#ad,_c(self,ad))return self end;return ab.handleMouse(self,bc,cc,dc,_d)end
function db:handleKey(bc,cc,dc)
if bc=="key"then
if self.open then local _d=self:getDisplayItems()local ad=
rawget(self,"_highlighted")or 1
if cc==keys.escape then self.open=false;return elseif cc==
keys.enter then self:selectDisplayed(ad)return elseif
cc==keys.up or cc==keys.down then local bd=cc==keys.down and 1 or-1
ad=math.max(1,math.min(#_d,ad+bd))rawset(self,"_highlighted",ad)
self.offset=bb.ensureVisible(self.offset,ad,#_d,_c(self,_d))self:markDirty()return end elseif
cc==keys.down and#self:getDisplayItems()>0 then self.open=true;return end end;ab.handleKey(self,bc,cc,dc)end
function db:render(bc)ab.render(self,bc)local cc=self.width
bc:blit(cc,1,self.open and"\30"or"\31",self.foreground,self.background)
if self.open then local dc=self:getDisplayItems()local _d=ac(self,dc)
rawget(self,"_p").offset=_d.offset;local ad=rawget(self,"_highlighted")
local bd=math.max(0,cc- (_d.show and 1 or 0))
for row=1,self.height-1 do local cd=dc[_d.offset+row]if not cd then break end;local dd=(_d.offset+
row)==ad;local __a=dd and self.selectionForeground or
self.dropForeground;local a_a=
dd and self.selectionBackground or self.dropBackground;bc:fill(1,
1 +row,bd,1," ",__a,a_a)
bc:blit(1,1 +row,cd.text:sub(1,bd),__a,a_a)end
bb.draw(bc,cc,2,_d,self.foreground,self.scrollbarColor,self.scrollbarThumbColor)end end;return db
]=]
sources["elements/ContextMenu"] = [=[
local aa=...local ba=aa("core/class")
local ca=aa("elements/Collection")local da=ba.create("ContextMenu",ca)
ba.property(da,"background",colors.black)ba.property(da,"separatorColor",colors.gray)
ba.property(da,"visible",false)
ba.property(da,"width",function(ab)local bb=4
for cb,db in ipairs(ab.items)do if not
(type(db)=="table"and db.separator)then
bb=math.max(bb,#tostring(db)+2)end end;return bb end)
ba.property(da,"height",function(ab)return math.max(1,#ab.items)end)local function _b(ab)
return type(ab)=="table"and ab.separator==true end
function da:setup()ca.setup(self)self.z=1000
self:on("click",function(ab,bb,cb,db)
local _c=ab.items[db]if _c~=nil and not _b(_c)and not _c.disabled then
ab:activateItem(db)ab:close()end end)
self:on("blur",function(ab)ab:close()end)end
function da:openAt(ab,bb)local cb=rawget(self,"parent")if cb then
ab=math.max(1,math.min(ab,
cb.width-self.width+1))
bb=math.max(1,math.min(bb,cb.height-self.height+1))end
self.x,self.y=ab,bb;self.visible=true;self:focus()return self end;function da:close()self.visible=false;return self end
function da:handleKey(ab,bb,cb)
if ab=="key"then
if bb==
keys.escape then self:close()elseif bb==keys.enter then
local db=rawget(self,"_highlighted")local _c=db and self.items[db]
if
_c and not _b(_c)and not _c.disabled then self:activateItem(db)self:close()end elseif bb==keys.up or bb==keys.down then local db=#self.items;local _c=
rawget(self,"_highlighted")or 0
local ac=bb==keys.down and 1 or-1;for _=1,db do _c=_c+ac;if _c<1 then _c=db elseif _c>db then _c=1 end
if
not _b(self.items[_c])and not self.items[_c].disabled then break end end
rawset(self,"_highlighted",_c)self:markDirty()end end;ca.handleKey(self,ab,bb,cb)end
function da:render(ab)local bb=self.width;local cb,db=self.foreground,self.background
local _c=rawget(self,"_highlighted")
for ac,bc in ipairs(self.items)do
if _b(bc)then
ab:fill(1,ac,bb,1,"\140",self.separatorColor,db)elseif ac==_c and not bc.disabled then
ab:fill(1,ac,bb,1," ",self.selectionForeground,self.selectionBackground)
ab:blit(2,ac,tostring(bc):sub(1,bb-2),self.selectionForeground,self.selectionBackground)else local cc=bc.fg or cb;ab:fill(1,ac,bb,1," ",cb,db)ab:blit(2,ac,tostring(bc):sub(1,
bb-2),cc,db)end end end;return da
]=]
sources["elements/Dialog"] = [=[
local da=...local _b=da("core/class")local ab=da("core/container")
local bb=da("core/text")local cb=_b.create("Dialog",ab)_b.property(cb,"title","")
_b.property(cb,"titleBackground",colors.blue)_b.property(cb,"titleForeground",colors.white)
_b.property(cb,"boxBackground",colors.lightGray)_b.property(cb,"boxForeground",colors.black)
_b.property(cb,"boxWidth",26)_b.property(cb,"visible",false)
_b.property(cb,"background",false)
_b.property(cb,"width",function(bc)local cc=rawget(bc,"parent")
return cc and cc.width or 1 end)
_b.property(cb,"height",function(bc)local cc=rawget(bc,"parent")
return cc and cc.height or 1 end)_b.event(cb,"close")
function cb:setup()ab.setup(self)self.x,self.y=1,1
self.z=950;self:on("click",function()end)end;local function db(bc)local cc=bc:getChildren()
for i=#cc,1,-1 do bc:removeChild(cc[i])end end
function cb:close(bc)db(self)
self.visible=false;self:fire("close",bc)return self end
local function _c(bc,cc,dc,_d)db(bc)bc.title=tostring(cc or"")bc.visible=true;local ad=math.min(bc.boxWidth,math.max(10,
bc.width-2))local bd=bb.wrap(dc or"",
ad-2)
local cd=1 +1 +#bd+ (_d or 0)+2
local dd=bc:addFrame({x=math.max(1,math.floor((bc.width-ad)/2)+1),y=math.max(1,math.floor((
bc.height-cd)/2)+1),width=ad,height=cd,background=bc.boxBackground,foreground=bc.boxForeground})
dd:addLabel({x=1,y=1,width=ad,height=1,text=bc.title,background=bc.titleBackground,foreground=bc.titleForeground})for __a,a_a in ipairs(bd)do
dd:addLabel({x=2,y=2 +__a,text=a_a,foreground=bc.boxForeground})end;return dd,2 +#bd+1 end
local function ac(bc,cc,dc,_d)local ad=0;for cd,dd in ipairs(dc)do ad=ad+#dd[1]+2 +1 end
local bd=math.max(2,math.floor((
cc.width-ad+1)/2)+1)
for cd,dd in ipairs(dc)do local __a,a_a=dd[1],dd[2]
cc:addButton({x=bd,y=_d+1,width=#__a+2,height=1,text=__a}):onClick(function()
a_a()end)bd=bd+#__a+3 end end
function cb:alert(bc,cc,dc)local _d,ad=_c(self,bc,cc,0)
ac(self,_d,{{"OK",function()self:close(true)
if dc then dc()end end}},ad)return self end
function cb:confirm(bc,cc,dc)local _d,ad=_c(self,bc,cc,0)
ac(self,_d,{{"Yes",function()self:close(true)if dc then
dc(true)end end},{"No",function()
self:close(false)if dc then dc(false)end end}},ad)return self end
function cb:prompt(bc,cc,dc,_d)local ad,bd=_c(self,bc,cc,2)
local cd=ad:addInput({x=2,y=bd+1,width=ad.width-2,text=tostring(dc or"")})
local function dd()local __a=cd.text;self:close(__a)if _d then _d(__a)end end;cd:onEnter(dd)
ac(self,ad,{{"OK",dd},{"Cancel",function()self:close(nil)
if _d then _d(nil)end end}},
bd+2)cd:focus()return self end;return cb
]=]
sources["elements/Dropdown"] = [=[
local ba=...local ca=ba("core/class")
local da=ba("elements/Collection")local _b=ba("core/itemview")local ab=ca.create("Dropdown",da)
ca.property(ab,"text","Select...")ca.property(ab,"dropHeight",6)
ca.property(ab,"offset",0)ca.property(ab,"background",colors.gray)
ca.property(ab,"dropBackground",colors.black)ca.property(ab,"width",14)
ca.property(ab,"scrollbar","auto")ca.property(ab,"scrollbarColor",colors.gray)
ca.property(ab,"scrollbarThumbColor",colors.lightGray)
ca.property(ab,"height",function(cb)if cb.open then
return 1 +math.min(#cb.items,cb.dropHeight)end;return 1 end)
ca.property(ab,"open",false,{onChange=function(cb,db)
if db then rawset(cb,"_zBefore",cb.z)cb.z=999
local _c=cb.selected or(
#cb.items>0 and 1 or false)rawset(cb,"_highlighted",_c)
cb.offset=_b.ensureVisible(cb.offset,_c,#cb.items,math.min(
#cb.items,cb.dropHeight))else cb.z=rawget(cb,"_zBefore")or cb.z
rawset(cb,"_itemScrollDrag",nil)end end})local function bb(cb)
return math.min(#cb.items,math.max(0,cb.dropHeight))end
function ab:getScrollInfo()return
_b.geometry(#self.items,bb(self),self.offset,self.scrollbar)end;function ab:setOffset(cb)
self.offset=_b.clampOffset(cb,#self.items,bb(self))return self end;function ab:scrollToItem(cb)
self.offset=_b.ensureVisible(self.offset,cb,
#self.items,bb(self))return self end
function ab:select(cb,db)if not cb or
self.items[cb]==nil then return self end
da.select(self,cb,db)rawset(self,"_highlighted",cb)
self:scrollToItem(cb)self.open=false;return self end
function ab:setup()da.setup(self)
self:on("click",function(cb,db,_c,ac)
if ac==1 then cb.open=not cb.open else
local bc=cb:getScrollInfo()
if bc.show and _c==cb.width then local dc,_d=_b.pointerDown(ac-1,bc)
cb:setOffset(dc)
if _d~=nil then rawset(cb,"_itemScrollDrag",_d)end;return end;local cc=cb.offset+ac-1
if cb.items[cc]~=nil then cb:select(cc)end end end)
self:on("drag",function(cb,db,_c,ac)local bc=rawget(cb,"_itemScrollDrag")if bc~=nil then
cb:setOffset(_b.drag(ac-1,bc,cb:getScrollInfo()))end end)
self:on("clickUp",function(cb)rawset(cb,"_itemScrollDrag",nil)end)
self:on("blur",function(cb)cb.open=false end)end
function ab:clear()da.clear(self)self.open=false;self.offset=0
rawset(self,"_highlighted",nil)self:markDirty()return self end
function ab:removeItem(cb)da.removeItem(self,cb)
self:setOffset(self.offset)self:markDirty()return self end
function ab:handleMouse(cb,db,_c,ac)
if cb=="mouse_scroll"and not self.open then return nil end
if cb=="mouse_scroll"then if self.disabled then return nil end;local bc=self.offset;self:setOffset(
bc+db)local cc=self:fire("scroll",db,_c,ac)if
self.offset~=bc or cc then return self end;return nil end;return da.handleMouse(self,cb,db,_c,ac)end
function ab:handleKey(cb,db,_c)
if cb=="key"then
if not self.open then if
db==keys.enter or db==keys.space or db==
keys.down or db==keys.up then self.open=true end else
local ac=#self.items;local bc=rawget(self,"_highlighted")or 0
if
db==keys.escape then self.open=false elseif db==keys.enter or db==keys.space then if bc>0 then
self:select(bc)end elseif ac>0 then
if db==keys.up then
bc=math.max(1,bc>0 and bc-1 or 1)elseif db==keys.down then
bc=math.min(ac,bc>0 and bc+1 or 1)elseif db==keys.home then bc=1 elseif db==keys["end"]then bc=ac elseif db==keys.pageUp then
bc=math.max(1,bc-bb(self))elseif db==keys.pageDown then bc=math.min(ac,bc+bb(self))end;rawset(self,"_highlighted",bc)
self:scrollToItem(bc)self:markDirty()end end end;da.handleKey(self,cb,db,_c)end
function ab:render(cb)local db=self.width;local _c,ac=self.foreground,self.background
local bc,cc=self.items,self.selected;local dc=_b.clampOffset(self.offset,#bc,bb(self))
rawget(self,"_p").offset=dc;cb:fill(1,1,db,1," ",_c,ac)
local _d=(cc and bc[cc]~=nil)and
tostring(bc[cc])or tostring(self.text)cb:blit(1,1,_d:sub(1,db-2),_c,ac)cb:blit(db,1,
self.open and"\30"or"\31",_c,ac)
if self.open then
local ad=self:getScrollInfo()local bd=rawget(self,"_highlighted")
local cd=math.max(0,db- (ad.show and 1 or 0))
for row=1,self.height-1 do local dd=dc+row;local __a=bc[dd]
local a_a=bd==dd or(not bd and cc==dd)
local b_a=
a_a and(__a and __a.selectedFg or self.selectionForeground)or(__a and __a.fg or _c)
local c_a=
a_a and(__a and __a.selectedBg or self.selectionBackground)or(__a and __a.bg or self.dropBackground)cb:fill(1,1 +row,cd,1," ",b_a,c_a)
cb:blit(1,1 +row,tostring(__a or""):sub(1,cd),b_a,c_a)end
_b.draw(cb,db,2,ad,_c,self.scrollbarColor,self.scrollbarThumbColor)end end;return ab
]=]
sources["elements/Flex"] = [=[
local ca=...local da=ca("core/class")local _b=ca("core/layout")
local ab=ca("core/container")local bb=da.create("Flex",ab)
da.property(bb,"direction","row")da.property(bb,"gap",0)da.property(bb,"padding",0)
da.property(bb,"align","start")da.property(bb,"justify","start")
da.property(bb,"overflow","clip")da.property(bb,"background",false)local function cb(_c)
local ac=math.max(0,math.floor(
tonumber(_c.padding)or 0))
return ac,math.max(0,_c.width-ac*2),math.max(0,_c.height-ac*2)end
local function db(_c,ac,bc,cc,dc)if
_b.is(bc)and(bc.kind=="auto"or bc.kind=="fill")then
local _d,ad=_b.measure(_c,cc,dc)
return _b.constrain(_c,ac,ac=="width"and _d or ad)end;return
_b.resolveSize(_c,ac,bc,cc,dc)end
function bb:measure(_c,ac)_c=_c or 1;ac=ac or 1;local bc=self.direction;local cc=bc=="row"if not cc and
bc~="column"then
error("Basalt layout: direction must be 'row' or 'column'",2)end
local dc=math.max(0,math.floor(
tonumber(self.padding)or 0))
local _d=math.max(0,math.floor(tonumber(self.gap)or 0))local ad,bd,cd=0,0,0;local dd=self:getChildren()
for i=1,#dd do local __a=dd[i]
if __a.visible and __a.position~=
"absolute"then local a_a=_b.spec(__a,"width")
local b_a=_b.spec(__a,"height")local c_a=db(__a,"width",a_a,_c,ac)
local d_a=db(__a,"height",b_a,_c,ac)ad=ad+ (cc and c_a or d_a)
bd=math.max(bd,cc and d_a or c_a)cd=cd+1 end end;if cd>1 then ad=ad+_d* (cd-1)end;ad,bd=ad+dc*2,bd+dc*2;return
cc and ad or bd,cc and bd or ad end
function bb:layoutChildren()local _c=self.direction;local ac=_c=="row"if not ac and _c~="column"then
error("Basalt layout: direction must be 'row' or 'column'",2)end;local bc,cc,dc=cb(self)
local _d=ac and cc or dc;local ad=ac and dc or cc
local bd=math.max(0,math.floor(tonumber(self.gap)or 0))local cd={}local dd,__a,a_a=0,0,nil;local b_a=self:getChildren()
for i=1,#b_a do local cba=b_a[i]
if
cba.position=="absolute"then _b.resolveFreeChild(self,cba)elseif cba.visible then local dba=
ac and"width"or"height"
local _ca=ac and"height"or"width"local aca=_b.spec(cba,dba)local bca=_b.spec(cba,_ca)
local cca={child=cba,mainSpec=aca,crossSpec=bca,fill=_b.is(aca)and
aca.kind=="fill",weight=
_b.is(aca)and aca.kind=="fill"and aca.value or 0}local dca=cba.shrink
if dca==false then
cca.shrink=_b.is(aca)and 1 or 0 else cca.shrink=math.max(0,tonumber(dca)or 0)end;if cca.fill then dd=dd+cca.weight;a_a=#cd+1 else
cca.main=db(cba,dba,aca,cc,dc)__a=__a+cca.main end
cca.cross=_b.resolveSize(cba,_ca,bca,cc,dc)cd[#cd+1]=cca else rawset(cba,"_layoutBox",nil)end end;local c_a=bd*math.max(0,#cd-1)
local d_a=math.max(0,_d-__a-c_a)local _aa=0
for i=1,#cd do local cba=cd[i]
if cba.fill then local dba;if i==a_a then dba=d_a-_aa else
dba=math.floor(d_a*cba.weight/dd)_aa=_aa+dba end
local _ca=ac and"width"or"height"cba.main=_b.constrain(cba.child,_ca,dba)end end;local aaa=c_a;for i=1,#cd do aaa=aaa+cd[i].main end
local baa=math.max(0,aaa-_d)
while baa>0 do local cba=0
for i=1,#cd do local _ca=cd[i]
local aca=ac and"minWidth"or"minHeight"local bca=_ca.child[aca]if bca==false then bca=0 end;_ca.minimum=math.max(0,
tonumber(bca)or 0)
if _ca.shrink>0 and
_ca.main>_ca.minimum then cba=cba+_ca.shrink end end;if cba==0 then break end;local dba=0
for i=1,#cd do local _ca=cd[i]
if _ca.shrink>0 and
_ca.main>_ca.minimum then
local aca=math.max(1,math.floor(baa*_ca.shrink/cba))
local bca=math.min(aca,_ca.main-_ca.minimum,baa-dba)_ca.main=_ca.main-bca;dba=dba+bca;if dba>=baa then break end end end;if dba==0 then break end;baa=baa-dba end;aaa=c_a;for i=1,#cd do aaa=aaa+cd[i].main end
local caa=math.max(0,_d-aaa)local daa,_ba,aba=self.justify,0,bd;if self.overflow~="clip"then
error("Basalt layout: only overflow='clip' is currently supported",2)end
if daa=="center"then
_ba=math.floor(caa/2)elseif daa=="end"then _ba=caa elseif daa=="spaceBetween"and#cd>1 then aba=bd+
math.floor(caa/ (#cd-1))elseif daa~="start"then
error("Basalt layout: invalid justify '"..
tostring(daa).."'",2)end;local bba=bc+_ba+1
for i=1,#cd do local cba,dba=cd[i],cd[i].child
local _ca=dba.alignSelf~=false and
dba.alignSelf or self.align;local aca=cba.cross
if _ca=="stretch"and _b.is(cba.crossSpec)and
cba.crossSpec.kind=="auto"then aca=ad end;local bca=0
if _ca=="center"then bca=math.floor((ad-aca)/2)elseif _ca=="end"then bca=ad-
aca elseif _ca~="start"and _ca~="stretch"then
error("Basalt layout: invalid align '"..
tostring(_ca).."'",2)end;bca=math.max(0,bca)
if ac then
_b.setBox(dba,bba,bc+bca+1,cba.main,aca)else _b.setBox(dba,bc+bca+1,bba,aca,cba.main)end;bba=bba+cba.main+aba end end;return bb
]=]
sources["elements/Frame"] = [=[
local aa=...local ba=aa("core/class")local ca=aa("core/container")
local da=ba.create("Frame",ca)ba.property(da,"background",colors.gray)
ba.property(da,"width",20)ba.property(da,"height",8)
ba.property(da,"draggable",false)
ba.property(da,"draggingMap",false,{visual=false})
local function _b(ab,bb,cb)local db=ab.draggingMap;if not db then
db={{x=1,y=1,width="full",height=1}}end
for i=1,#db do local _c=db[i]local ac=
_c.width=="full"and ab.width or(_c.width or 1)
local bc=
_c.height=="full"and ab.height or(_c.height or 1)if
bb>=_c.x and bb<_c.x+ac and cb>=_c.y and cb<_c.y+bc then return true end end;return false end
function da:setup()ca.setup(self)
self:on("click",function(ab,bb,cb,db)if ab.draggable and _b(ab,cb,db)then
rawset(ab,"_dragFrom",{x=cb,y=db})end end)
self:on("drag",function(ab,bb,cb,db)local _c=rawget(ab,"_dragFrom")if _c then ab.x=ab.x+cb-_c.x;ab.y=
ab.y+db-_c.y end end)
self:on("clickUp",function(ab)rawset(ab,"_dragFrom",nil)end)end
function da:toFront()local ab=rawget(self,"parent")if not ab then return self end
local bb=self.z
for cb,db in ipairs(ab:getChildren())do if db.z>bb then bb=db.z end end;if bb>=self.z then self.z=bb+1 end;return self end;return da
]=]
sources["elements/Input"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("Input",ba)
aa.property(ca,"text","",{rawString=true,onChange=function(da,_b)local ab=rawget(da,"_cursor")if ab and ab>#_b+1 then rawset(da,"_cursor",
#_b+1)
rawset(da,"_scroll",math.max(0,#_b+1 -da.width))end end})aa.property(ca,"placeholder","")
aa.property(ca,"placeholderColor",colors.gray)aa.property(ca,"maxLength",false)
aa.property(ca,"replaceChar",false)aa.property(ca,"pattern",false)
aa.property(ca,"width",12)aa.property(ca,"height",1)
aa.property(ca,"background",colors.lightGray)aa.property(ca,"foreground",colors.black)
aa.event(ca,"change")aa.event(ca,"enter")
function ca:setup()ba.setup(self)
rawset(self,"_cursor",1)rawset(self,"_scroll",0)
self:on("click",function(da,_b,ab,bb)if bb~=1 then return end;da:_moveCursor(
da._scroll+ab)end)
self:on("focus",function(da)da:markDirty()end)
self:on("blur",function(da)da:markDirty()end)end
function ca:_moveCursor(da)local _b=#self.text;if da<1 then da=1 end
if da>_b+1 then da=_b+1 end;rawset(self,"_cursor",da)local ab,bb=self.width,self._scroll;if
da-bb>ab then bb=da-ab end;if da-bb<1 then bb=da-1 end
rawset(self,"_scroll",bb)self:markDirty()end
function ca:_insert(da)local _b=self.pattern;if _b then
da=da:gsub(".",function(db)
return db:match(_b)and db or""end)if#da==0 then return end end
local ab=self.text;local bb=self.maxLength;if bb and#ab+#da>bb then return end
local cb=self._cursor;self.text=ab:sub(1,cb-1)..da..ab:sub(cb)self:_moveCursor(
cb+#da)
self:fire("change",self.text)end
function ca:handleKey(da,_b,ab)
if da=="char"or da=="paste"then self:_insert(_b)elseif da=="key"then
local bb=self._cursor;local cb=self.text
if _b==keys.backspace then if bb>1 then
self.text=cb:sub(1,bb-2)..cb:sub(bb)self:_moveCursor(bb-1)
self:fire("change",self.text)end elseif _b==keys.delete then if bb<=#cb then self.text=cb:sub(1,
bb-1)..cb:sub(bb+1)
self:fire("change",self.text)end elseif _b==keys.left then
self:_moveCursor(bb-1)elseif _b==keys.right then self:_moveCursor(bb+1)elseif _b==keys.home then
self:_moveCursor(1)elseif _b==keys["end"]then self:_moveCursor(#cb+1)elseif _b==keys.enter then
self:fire("enter",cb)end end;ba.handleKey(self,da,_b,ab)end
function ca:render(da)ba.render(self,da)local _b=self:getRoot()local ab=_b.getFocused and
_b:getFocused()==self;local bb=self.text
local cb=self.width
if#bb==0 and not ab then
da:blit(1,1,self.placeholder:sub(1,cb),self.placeholderColor,nil)else
local db=bb:sub(self._scroll+1,self._scroll+cb)local _c=self.replaceChar;if _c then
db=tostring(_c):sub(1,1):rep(#db)end
da:blit(1,1,db,self.foreground,nil)end;if ab then
self:setCursor(self._cursor-self._scroll,1,true,self.foreground)end end
function ca:measure()return
math.max(1,#tostring(self.text),#tostring(self.placeholder)),1 end;return ca
]=]
sources["elements/Label"] = [=[
local ba=...local ca=ba("core/class")local da=ba("core/element")
local _b=ba("core/text")local ab=ca.create("Label",da)
local function bb(cb)local db=rawget(cb,"_p")
if
rawget(cb,"_autoSize")then if type(db.width)~="function"then
db.width=math.max(#tostring(cb.text),1)end;return end
if
rawget(cb,"_autoHeight")and type(db.height)~="function"and type(db.width)~="function"then db.height=
#_b.wrap(cb.text,cb.width)end end
ca.property(ab,"text","",{onChange=function(cb)bb(cb)end})
ca.property(ab,"width",1,{onChange=function(cb)rawset(cb,"_autoSize",false)bb(cb)end})
ca.property(ab,"height",1,{onChange=function(cb)rawset(cb,"_autoHeight",false)end})function ab:setup()da.setup(self)rawset(self,"_autoSize",true)
rawset(self,"_autoHeight",true)end
function ab:render(cb)
da.render(self,cb)local db=tostring(self.text)
if
rawget(self,"_autoSize")or self.height==1 then cb:blit(1,1,db,self.foreground,nil)else
local _c=_b.wrap(db,self.width)for i=1,math.min(#_c,self.height)do
cb:blit(1,i,_c[i],self.foreground,nil)end end end;function ab:measure()
return math.max(1,#tostring(self.text)),1 end;return ab
]=]
sources["elements/List"] = [=[
local ba=...local ca=ba("core/class")
local da=ba("elements/Collection")local _b=ba("core/itemview")local ab=ca.create("List",da)
ca.property(ab,"offset",0)ca.property(ab,"emptyText","")
ca.property(ab,"emptyTextColor",colors.gray)ca.property(ab,"background",colors.black)
ca.property(ab,"width",16)ca.property(ab,"height",8)
ca.property(ab,"scrollbar","auto")ca.property(ab,"scrollbarColor",colors.gray)
ca.property(ab,"scrollbarThumbColor",colors.lightGray)
local function bb(cb)return _b.maxOffset(#cb.items,cb.height)end
function ab:getScrollInfo()return
_b.geometry(#self.items,self.height,self.offset,self.scrollbar)end;function ab:setOffset(cb)
self.offset=_b.clampOffset(cb,#self.items,self.height)return self end;function ab:scrollToItem(cb)
self.offset=_b.ensureVisible(self.offset,cb,
#self.items,self.height)return self end
function ab:selectItem(cb,db)
da.selectItem(self,cb,db)
local _c=self:indexOfItem(cb)or self:getSelectedIndex()if _c then self:scrollToItem(_c)end;return self end
function ab:setup()da.setup(self)
self:on("click",function(cb,db,_c,ac)local bc=cb:getScrollInfo()
if bc.show and _c==
cb.width then local dc,_d=_b.pointerDown(ac,bc)
cb:setOffset(dc)
if _d~=nil then rawset(cb,"_itemScrollDrag",_d)end;return end;local cc=cb.offset+ac
if cb.items[cc]~=nil then cb:select(cc)end end)
self:on("drag",function(cb,db,_c,ac)local bc=rawget(cb,"_itemScrollDrag")if bc~=nil then
cb:setOffset(_b.drag(ac,bc,cb:getScrollInfo()))end end)
self:on("clickUp",function(cb)rawset(cb,"_itemScrollDrag",nil)end)end
function ab:handleMouse(cb,db,_c,ac)
if cb=="mouse_scroll"then if self.disabled then return nil end
local bc=self.offset;self:setOffset(bc+db)
local cc=self:fire("scroll",db,_c,ac)if self.offset~=bc or cc then return self end;return nil end;return da.handleMouse(self,cb,db,_c,ac)end
function ab:removeItem(cb)da.removeItem(self,cb)if self.offset>bb(self)then
self.offset=bb(self)end;self:markDirty()return self end
function ab:handleKey(cb,db,_c)
if cb=="key"and#self.items>0 then
local ac=self.selected or 0
if db==keys.up then
self:selectItem(ac>1 and ac-1 or 1)elseif db==keys.down then
self:selectItem(
ac>0 and math.min(#self.items,ac+1)or 1)elseif db==keys.home then self:selectItem(1)elseif db==keys["end"]then self:selectItem(#
self.items)elseif db==keys.pageUp then
self:selectItem(math.max(1,(
ac>0 and ac or 1)-self.height))elseif db==keys.pageDown then
self:selectItem(math.min(#self.items,(ac>0 and ac or 1)+self.height))elseif db==keys.enter and ac>0 then self:activateItem(ac)end end;da.handleKey(self,cb,db,_c)end
function ab:clear()da.clear(self)self.offset=0;return self end
function ab:render(cb)da.render(self,cb)local db=self.items
local _c,ac=self.width,self.height
if
#db==0 and#tostring(self.emptyText)>0 then
local ad=tostring(self.emptyText):sub(1,_c)
cb:blit(math.floor((_c-#ad)/2)+1,math.floor((ac-1)/2)+1,ad,self.emptyTextColor,
nil)return end;local bc=_b.clampOffset(self.offset,#db,ac)
rawget(self,"_p").offset=bc;local cc=self:getScrollInfo()
local dc=math.max(0,_c- (cc.show and 1 or 0))
local function _d(ad,bd,cd,dd)local __a=ad.iconChar
if type(__a)=="number"then __a=string.char(__a)end;if type(__a)~="string"or#__a==0 then return end;local a_a=math.floor(
tonumber(ad.iconX)or 1)
if a_a<1 or a_a>dc then return end
local b_a=cd and ad.selectedIconForeground or ad.iconForeground or dd
local c_a=cd and ad.selectedIconBackground or ad.iconBackground;cb:blit(a_a,bd,__a:sub(1,1),b_a,c_a)end
for row=1,ac do local ad=bc+row;local bd=db[ad]if bd==nil then break end;local cd=tostring(bd)
if
bd.separator then local dd=cd~=""and cd:sub(1,1)or"-"
cb:blit(1,row,dd:rep(dc),
bd.fg or self.foreground,bd.bg)elseif self:isSelected(ad)then
local dd=bd.selectedFg or self.selectionForeground;local __a=bd.selectedBg or self.selectionBackground
cb:fill(1,row,dc,1," ",dd,__a)cb:blit(1,row,cd:sub(1,dc),dd,__a)
_d(bd,row,true,__a)else local dd=bd.fg or self.foreground;local __a=bd.bg;if __a then
cb:fill(1,row,dc,1," ",dd,__a)end
cb:blit(1,row,cd:sub(1,dc),dd,__a)_d(bd,row,false,__a or self.background)end end
_b.draw(cb,_c,1,cc,self.foreground,self.scrollbarColor,self.scrollbarThumbColor)end;return ab
]=]
sources["elements/Menu"] = [=[
local bb=...local cb=bb("core/class")
local db=bb("elements/Collection")local _c=cb.create("Menu",db)
local function ac(cd)if type(cd)=="table"then
if cd.separator then return"\149"end;return tostring(cd.text)end;return
tostring(cd)end;local function bc(cd)
return type(cd)=="table"and cd.separator==true end;local function cc(cd)
return type(cd)=="table"and
(cd.items or cd.dropdown)or nil end
local function dc(cd)local dd={}local __a=1;for a_a,b_a in ipairs(cd.items)do
local c_a=
bc(b_a)and ac(b_a)or(" "..ac(b_a).." ")dd[a_a]={__a,__a+#c_a-1,c_a}
__a=__a+#c_a+cd.spacing end;return dd,math.max(1,
__a-cd.spacing-1)end
local function _d(cd)local dd=rawget(cd,"_openIndex")if not dd then return nil end
local __a=cd.items[dd]local a_a=cc(__a)if not a_a then return nil end;local b_a=dc(cd)local c_a=1
for _aa,aaa in ipairs(a_a)do c_a=math.max(c_a,
#tostring(aaa)+2)end
local d_a=math.min(b_a[dd][1],math.max(1,cd.width-c_a+1))return{x=d_a,width=c_a,items=a_a,parent=dd}end;cb.property(_c,"spacing",1)
cb.property(_c,"background",colors.gray)
cb.property(_c,"separatorColor",colors.lightGray)cb.property(_c,"dropBackground",colors.black)
cb.property(_c,"width",function(cd)
local dd,__a=dc(cd)return __a end)
cb.property(_c,"height",function(cd)local dd=_d(cd)
return dd and(1 +#dd.items)or 1 end)local function ad(cd)
if rawget(cd,"_openIndex")then rawset(cd,"_openIndex",nil)cd.z=
rawget(cd,"_zBefore")or cd.z;cd:markDirty()end end
local function bd(cd,dd)
rawset(cd,"_zBefore",cd.z)rawset(cd,"_openIndex",dd)cd.z=999;cd:markDirty()end
function _c:select(cd,dd)local __a=self.items[cd]
if __a==nil or bc(__a)then return self end;if cc(__a)then
if rawget(self,"_openIndex")==cd then ad(self)else bd(self,cd)end;return self end;ad(self)
db.select(self,cd,dd)return self end
function _c:setup()db.setup(self)
self:on("click",function(cd,dd,__a,a_a)
if a_a==1 then
for b_a,c_a in ipairs(dc(cd))do if __a>=c_a[1]and
__a<=c_a[2]then cd:select(b_a)return end end;ad(cd)else local b_a=_d(cd)
if
b_a and __a>=b_a.x and __a<b_a.x+b_a.width and b_a.items[a_a-1]~=nil then
local c_a=a_a-1;local d_a=b_a.items[c_a]ad(cd)
if type(d_a)=="table"and type(d_a.callback)==
"function"then d_a.callback(cd,d_a)end;cd:fire("select",c_a,tostring(d_a),b_a.parent)else
ad(cd)end end end)self:on("blur",function(cd)ad(cd)end)end
function _c:handleKey(cd,dd,__a)
if cd=="key"and#self.items>0 then
local a_a=self.selected or 0
if dd==keys.left then
self:select(math.max(1,a_a>0 and a_a-1 or 1),false)elseif dd==keys.right then
self:select(
a_a>0 and math.min(#self.items,a_a+1)or 1,false)elseif dd==keys.escape then ad(self)elseif dd==keys.enter and a_a>0 then
self:select(a_a)end end;db.handleKey(self,cd,dd,__a)end
function _c:clear()db.clear(self)ad(self)self:markDirty()return self end;function _c:measure()local cd,dd=dc(self)return dd,1 end
function _c:render(cd)
local dd,__a=self.foreground,self.background;cd:fill(1,1,self.width,1," ",dd,__a)local a_a=self.selected
local b_a=rawget(self,"_openIndex")
for d_a,_aa in ipairs(dc(self))do local aaa=self.items[d_a]
if bc(aaa)then
cd:blit(_aa[1],1,_aa[3],self.separatorColor,__a)elseif d_a==a_a or d_a==b_a then
cd:blit(_aa[1],1,_aa[3],self.selectionForeground,self.selectionBackground)else cd:blit(_aa[1],1,_aa[3],dd,__a)end end;local c_a=_d(self)
if c_a then
for d_a,_aa in ipairs(c_a.items)do
cd:fill(c_a.x,1 +d_a,c_a.width,1," ",dd,self.dropBackground)
cd:blit(c_a.x+1,1 +d_a,tostring(_aa):sub(1,c_a.width-2),dd,self.dropBackground)end end end;return _c
]=]
sources["elements/Program"] = [=[
local _c=...local ac=_c("core/class")local bc=_c("core/element")
local cc=_c("core/errors")local dc=_c("core/palette")local _d=ac.create("Program",bc)
local ad={mouse_click=true,mouse_up=true,mouse_drag=true,mouse_scroll=true,mouse_move=true,key=true,key_up=true,char=true,paste=true}local bd
local function cd(d_a,_aa,aaa)if not _aa or not _aa.window then return false end
local baa=math.max(1,math.floor(
tonumber(d_a.width)or 1))
local caa=math.max(1,math.floor(tonumber(d_a.height)or 1))local daa,_ba=_aa.window.getSize()if daa==baa and _ba==caa then
return false end
_aa.window.reposition(1,1,baa,caa)if aaa and bd then bd(d_a,_aa,"term_resize")end;return true end
local function dd(d_a)local _aa=rawget(d_a,"_proc")if _aa then cd(d_a,_aa,true)end end;ac.property(_d,"path","",{visual=false})
ac.property(_d,"running",false,{visual=false,styleable=false})ac.property(_d,"env",false,{visual=false})
ac.property(_d,"background",colors.black)ac.property(_d,"width",30,{onChange=dd})
ac.property(_d,"height",12,{onChange=dd})ac.event(_d,"done")ac.event(_d,"error")
local function __a(d_a,_aa,aaa,baa)if rawget(d_a,"_proc")==
_aa then rawset(d_a,"_proc",nil)end
d_a.running=false;d_a:fire("done",aaa,baa)end
local function a_a(d_a)local _aa=tostring(d_a or"")return _aa=="Terminated"or
_aa:match(": Terminated$")~=nil end
local function b_a(d_a,_aa,aaa,baa,caa)
if not aaa then
if caa and a_a(baa)then __a(d_a,_aa,true,nil)return end;local daa=debug.traceback(_aa.co)or""
__a(d_a,_aa,false,baa)if d_a._handlers.error then d_a:fire("error",baa,daa)else
error(cc.wrap(baa,daa),0)end;return end;_aa.filter=baa;if coroutine.status(_aa.co)=="dead"then
__a(d_a,_aa,true,baa)end;d_a:markDirty()end
bd=function(d_a,_aa,aaa,...)local baa=_aa.co;if
not baa or coroutine.status(baa)=="dead"then return end
if aaa~="term_resize"then cd(d_a,_aa,true)if

rawget(d_a,"_proc")~=_aa or coroutine.status(baa)=="dead"then return end end;if
_aa.filter~=nil and aaa~=_aa.filter and aaa~="terminate"then return end;_aa.filter=nil
local caa=term.redirect(_aa.term)local daa,_ba=coroutine.resume(baa,aaa,...)
_aa.term=term.current()term.redirect(caa)
b_a(d_a,_aa,daa,_ba,aaa=="terminate")end
local function c_a(d_a,_aa,aaa)aaa.native=function()return aaa end;aaa.current=term.current
aaa.redirect=term.redirect;local baa=setmetatable({},{__index=_ENV})baa.term=aaa;if shell then
baa.shell,baa.multishell=shell,multishell end
if fs.exists("rom/modules/main/cc/require.lua")then
local daa=dofile("rom/modules/main/cc/require.lua").make;baa.require,baa.package=daa(baa,fs.getDir(_aa))end;local caa=d_a.env;if type(caa)=="table"then
for daa,_ba in pairs(caa)do baa[daa]=_ba end end;return baa end
function _d:execute(d_a,...)self:stop()local _aa
if
fs.exists(d_a)and not fs.isDir(d_a)then _aa=d_a elseif shell then _aa=shell.resolveProgram(d_a)end;if not _aa then
error("Basalt Program: program not found: "..tostring(d_a),2)end;local aaa=self:getRoot()
local baa=rawget(aaa,"term")if not baa then
error("Basalt Program: element must be inside a frame before execute()",2)end;local caa=fs.open(_aa,"r")
local daa=caa.readAll()caa.close()
local _ba=window.create(baa,1,1,self.width,self.height,false)
local aba,bba=load(daa,"@/".._aa,nil,c_a(self,_aa,_ba))if not aba then
error("Basalt Program: failed to load ".._aa..": "..tostring(bba),2)end
local cba={window=_ba,term=_ba,args=table.pack(...),filter=nil}cba.co=coroutine.create(aba)
rawset(self,"_proc",cba)self.path=_aa;self.running=true;local dba=term.redirect(_ba)
local _ca,aca=coroutine.resume(cba.co,table.unpack(cba.args,1,cba.args.n))cba.term=term.current()term.redirect(dba)
b_a(self,cba,_ca,aca)
if rawget(self,"_proc")==cba then local bca=_c("main")
bca.schedule(function()
while

rawget(self,"_proc")==cba and coroutine.status(cba.co)~="dead"do local cca=table.pack(os.pullEventRaw())
if
not ad[cca[1]]then bd(self,cba,table.unpack(cca,1,cca.n))end end end)end;return self end
function _d:stop()local d_a=rawget(self,"_proc")if not d_a then return self end
rawset(self,"_proc",nil)
if d_a.co and coroutine.close and
coroutine.status(d_a.co)~="dead"then coroutine.close(d_a.co)end;self.running=false;return self end
function _d:terminate()local d_a=rawget(self,"_proc")if not d_a then return self end
bd(self,d_a,"terminate")if rawget(self,"_proc")==d_a then self:stop()end;return
self end;function _d:sendEvent(d_a,...)local _aa=rawget(self,"_proc")
if _aa then bd(self,_aa,d_a,...)end;return self end
function _d:setup()
bc.setup(self)
self:on("click",function(d_a,_aa,aaa,baa)local caa=rawget(d_a,"_proc")if caa then
bd(d_a,caa,"mouse_click",_aa,aaa,baa)end end)
self:on("clickUp",function(d_a,_aa,aaa,baa)local caa=rawget(d_a,"_proc")if caa then
bd(d_a,caa,"mouse_up",_aa,aaa,baa)end end)
self:on("drag",function(d_a,_aa,aaa,baa)local caa=rawget(d_a,"_proc")if caa then
bd(d_a,caa,"mouse_drag",_aa,aaa,baa)end end)
self:on("scroll",function(d_a,_aa,aaa,baa)local caa=rawget(d_a,"_proc")if caa then
bd(d_a,caa,"mouse_scroll",_aa,aaa,baa)end end)end
function _d:handleKey(d_a,_aa,aaa)local baa=rawget(self,"_proc")
if baa then bd(self,baa,d_a,_aa,aaa)end;bc.handleKey(self,d_a,_aa,aaa)end
function _d:destroy()self:terminate()return bc.destroy(self)end
function _d:render(d_a)bc.render(self,d_a)local _aa=rawget(self,"_proc")
if not _aa then return end;cd(self,_aa,true)
if rawget(self,"_proc")~=_aa then return end;local aaa=_aa.window;local baa,caa=aaa.getSize()
local daa=dc.windowTranslation(aaa)
for y=1,caa do local aba,bba,cba=aaa.getLine(y)if aba then
if daa then
d_a:rawBlit(1,y,aba,(bba:gsub(".",daa)),(cba:gsub(".",daa)))else d_a:drawBlit(1,y,aba,bba,cba)end end end;local _ba=self:getRoot()if
_ba.getFocused and _ba:getFocused()==self then local aba,bba=aaa.getCursorPos()
self:setCursor(aba,bba,aaa.getCursorBlink(),aaa.getTextColor())end end;return _d
]=]
sources["elements/ProgressBar"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("ProgressBar",ba)
aa.property(ca,"progress",0,{onChange=function(da,_b)local ab=rawget(da,"_p")if _b<0 then ab.progress=0 elseif _b>100 then
ab.progress=100 end end})aa.property(ca,"barColor",colors.lime)
aa.property(ca,"background",colors.gray)aa.property(ca,"width",16)
aa.property(ca,"direction","right")aa.property(ca,"showPercentage",false)
function ca:render(da)
ba.render(self,da)local _b,ab=self.width,self.height
local bb=math.min(100,math.max(0,self.progress))local cb=self.direction
if cb=="up"or cb=="down"then
local db=math.floor(ab*bb/100 +0.5)if db>0 then
da:fill(1,cb=="up"and(ab-db+1)or 1,_b,db," ",self.foreground,self.barColor)end else
local db=math.floor(_b*bb/100 +0.5)if db>0 then
da:fill(cb=="left"and(_b-db+1)or 1,1,db,ab," ",self.foreground,self.barColor)end end;if self.showPercentage then local db=math.floor(bb+0.5).."%"
da:drawText(math.floor((
_b-#db)/2)+1,math.floor((ab-1)/2)+1,db)end end;return ca
]=]
sources["elements/Row"] = [=[
local aa=...local ba=aa("core/class")local ca=aa("core/layout")
local da=aa("elements/Flex")local _b=ba.create("Row",da)
ba.property(_b,"direction","row")ba.property(_b,"width",ca.fill())
ba.property(_b,"height",ca.auto())return _b
]=]
sources["elements/Slider"] = [=[
local ba=...local ca=ba("core/class")local da=ba("core/element")
local _b=ca.create("Slider",da)ca.property(_b,"min",0)ca.property(_b,"max",100)
ca.property(_b,"step",1)ca.property(_b,"value",0)
ca.property(_b,"horizontal",true)ca.property(_b,"barColor",colors.gray)
ca.property(_b,"knobColor",colors.blue)ca.property(_b,"width",10)ca.event(_b,"change")
local function ab(cb)return
cb.horizontal and cb.width or cb.height end
local function bb(cb,db,_c)local ac=ab(cb)local bc=cb.horizontal and db or _c
local cc,dc,_d=cb.min,cb.max,cb.step;if dc<=cc or ac<2 then return end;local ad=(bc-1)/ (ac-1)if ad<0 then ad=0 elseif ad>1 then
ad=1 end;local bd=cc+ad* (dc-cc)bd=cc+
math.floor((bd-cc)/_d+0.5)*_d
if bd<cc then bd=cc elseif bd>dc then bd=dc end
if bd~=cb.value then cb.value=bd;cb:fire("change",bd)end end;function _b:setup()da.setup(self)
self:on("click",function(cb,db,_c,ac)bb(cb,_c,ac)end)
self:on("drag",function(cb,db,_c,ac)bb(cb,_c,ac)end)end
function _b:handleMouse(cb,db,_c,ac)
if
cb=="mouse_scroll"then if self.disabled then return nil end
local bc=self.value+db*self.step
if bc<self.min then bc=self.min elseif bc>self.max then bc=self.max end
if bc~=self.value then self.value=bc;self:fire("change",bc)end;return self end;return da.handleMouse(self,cb,db,_c,ac)end
function _b:render(cb)da.render(self,cb)local db=ab(self)local _c,ac=self.min,self.max
local bc=1
if ac>_c then bc=1 +
math.floor((self.value-_c)/ (ac-_c)* (db-1)+0.5)end
if self.horizontal then
cb:blit(1,1,string.rep("\140",db),self.barColor,nil)
cb:fill(bc,1,1,1," ",self.foreground,self.knobColor)else
for row=1,db do cb:blit(1,row,"\149",self.barColor,nil)end
cb:fill(1,bc,1,1," ",self.foreground,self.knobColor)end end;return _b
]=]
sources["elements/Switch"] = [=[
local _a=...local aa=_a("core/class")local ba=_a("core/element")
local ca=aa.create("Switch",ba)
aa.property(ca,"checked",false,{state="checked",styleable=false})aa.property(ca,"onColor",colors.green)
aa.property(ca,"offColor",colors.gray)aa.property(ca,"knobColor",colors.white)
aa.property(ca,"width",4)aa.event(ca,"change")function ca:setup()ba.setup(self)
self:on("click",function(da)da.checked=not
da.checked;da:fire("change",da.checked)end)end
function ca:render(da)
local _b,ab=self.width,self.height;local bb=self.checked
da:fill(1,1,_b,ab," ",self.foreground,bb and self.onColor or self.offColor)local cb=math.max(1,math.floor(_b/2))
da:fill(
bb and(_b-cb+1)or 1,1,cb,ab," ",self.foreground,self.knobColor)end;return ca
]=]
sources["elements/TabControl"] = [=[
local ba=...local ca=ba("core/class")local da=ba("core/container")
local _b=ba("elements/Frame")local ab=ca.create("TabControl",da)
ca.property(ab,"active",0,{onChange=function(cb)
local db=rawget(cb,"_tabs")if not db then return end;local _c=cb.active
for i=1,#db do db[i].frame.visible=(i==_c)end end})ca.property(ab,"headerBackground",colors.gray)
ca.property(ab,"activeBackground",colors.blue)ca.property(ab,"activeForeground",colors.white)
ca.property(ab,"background",colors.black)ca.property(ab,"width",24)
ca.property(ab,"height",10)ca.event(ab,"change")
local function bb(cb)local db={}local _c=1;for ac,bc in
ipairs(rawget(cb,"_tabs"))do local cc=" "..bc.title.." "db[ac]={_c,_c+#cc-1,cc}_c=
_c+#cc end;return db end
function ab:setup()da.setup(self)rawset(self,"_tabs",{})
self:on("click",function(cb,db,_c,ac)
if ac~=1 then return end
for bc,cc in ipairs(bb(cb))do if _c>=cc[1]and _c<=cc[2]then cb:setActiveTab(bc)
return end end end)end
function ab:addTab(cb)
local db=_b.new({x=1,y=2,width=function(ac)local bc=rawget(ac,"parent")
return bc and bc.width or 1 end,height=function(ac)local bc=rawget(ac,"parent")return bc and math.max(1,
bc.height-1)or 1 end,background=false,visible=false})self:addChild(db)local _c=rawget(self,"_tabs")
_c[#_c+1]={title=tostring(cb),frame=db}if self.active==0 then self.active=#_c end
self:markDirty()return db end
function ab:setActiveTab(cb,db)local _c=rawget(self,"_tabs")if
not _c[cb]or self.active==cb then return self end;self.active=cb;if db~=false then
self:fire("change",cb,_c[cb].title)end;return self end;function ab:getTab(cb)local db=rawget(self,"_tabs")[cb]return
db and db.frame or nil end;function ab:getTabCount()return#
rawget(self,"_tabs")end
function ab:handleKey(cb,db,_c)
if cb=="key"then local ac=#
rawget(self,"_tabs")
if ac>0 then if db==keys.left then
self:setActiveTab(math.max(1,self.active-1))elseif db==keys.right then
self:setActiveTab(math.min(ac,self.active+1))end end end;da.handleKey(self,cb,db,_c)end
function ab:render(cb)da.render(self,cb)
cb:fill(1,1,self.width,1," ",self.foreground,self.headerBackground)local db=self.active
for _c,ac in ipairs(bb(self))do if _c==db then
cb:blit(ac[1],1,ac[3],self.activeForeground,self.activeBackground)else
cb:blit(ac[1],1,ac[3],self.foreground,self.headerBackground)end end end;return ab
]=]
sources["elements/Table"] = [=[
local bb=...local cb=bb("core/class")local db=bb("core/element")
local _c=bb("core/itemview")local ac=cb.create("Table",db)
local function bc(cd)rawset(cd,"_viewOrder",nil)end
local function cc(cd)if type(cd)~="table"then
error("Basalt Table: columns must be a table",3)end;local dd={}
for __a,a_a in ipairs(cd)do
if type(a_a)=="string"then dd[__a]={title=a_a,name=a_a,width=
#a_a+1}elseif type(a_a)=="table"then local b_a=a_a.title or
a_a.name or""
dd[__a]={title=b_a,name=a_a.name or b_a,width=a_a.width,minWidth=
a_a.minWidth or 1,maxWidth=a_a.maxWidth}else
error("Basalt Table: column "..__a.." must be a string or table",3)end end;return dd end
cb.property(ac,"columns",false,{onChange=function(cd,dd)rawget(cd,"_p").columns=cc(dd)bc(cd)end})cb.property(ac,"data",false,{onChange=bc})
cb.property(ac,"selected",false,{state="selected",stateWhen=function(cd)return
cd~=false and cd~=nil end,styleable=false})cb.property(ac,"offset",0)
cb.property(ac,"sortable",true)
cb.property(ac,"sortColumn",false,{styleable=false})
cb.property(ac,"sortDirection","asc",{styleable=false})cb.property(ac,"background",colors.black)
cb.property(ac,"headerBackground",colors.gray)cb.property(ac,"gridColor",colors.gray)
cb.property(ac,"selectionBackground",colors.blue)
cb.property(ac,"selectionForeground",colors.white)cb.property(ac,"width",26)
cb.property(ac,"height",8)cb.property(ac,"scrollbar","auto")
cb.property(ac,"scrollbarColor",colors.gray)
cb.property(ac,"scrollbarThumbColor",colors.lightGray)cb.property(ac,"scrollBarSymbol"," ")
cb.property(ac,"scrollBarBackground","\127")cb.event(ac,"select")cb.event(ac,"rowSelect")
cb.event(ac,"change")cb.event(ac,"sort")
local function dc(cd)return math.max(0,cd.height-1)end;local function _d(cd)
return _c.geometry(#cd.data,dc(cd),cd.offset,cd.scrollbar)end
local function ad(cd)local dd=cd.data
local __a=rawget(cd,"_viewOrder")if __a and#__a==#dd then return __a end;__a={}
for i=1,#dd do __a[i]=i end;local a_a=rawget(cd,"_sortCol")
if a_a then local b_a=rawget(cd,"_sortAsc")
local c_a=rawget(cd,"_columnSorters")[a_a]
table.sort(__a,function(d_a,_aa)local aaa=rawget(cd,"_sortValues")
local baa=aaa[dd[d_a]]and
aaa[dd[d_a]][a_a]or dd[d_a][a_a]
local caa=aaa[dd[_aa]]and aaa[dd[_aa]][a_a]or dd[_aa][a_a]
if c_a then return c_a(baa,caa,b_a,dd[d_a],dd[_aa])end
if type(baa)=="number"and type(caa)=="number"then if b_a then
return baa<caa end;return baa>caa end;baa,caa=tostring(baa),tostring(caa)if b_a then return baa<caa end;return
baa>caa end)end;rawset(cd,"_viewOrder",__a)return __a end
local function bd(cd,dd)local __a=cd.columns;local a_a=math.max(0,#__a-1)
local b_a=math.max(0,dd-a_a)local c_a,d_a=0,{}local _aa={}
for i=1,#__a do local daa=__a[i].width;local _ba
if type(daa)=="number"then
_ba=daa elseif type(daa)=="string"then
local aba=tonumber(daa:match("^(%-?[%d%.]+)%%$"))if aba then _ba=math.floor(b_a*aba/100)end end
if _ba then
_ba=math.max(__a[i].minWidth or 1,math.floor(_ba))
if __a[i].maxWidth then _ba=math.min(_ba,__a[i].maxWidth)end;_aa[i],c_a=_ba,c_a+_ba else d_a[#d_a+1]=i end end;local aaa=math.max(0,b_a-c_a)
for daa,_ba in ipairs(d_a)do local aba=math.floor(aaa/
math.max(1,#d_a-daa+1))aba=math.max(
__a[_ba].minWidth or 1,aba)if __a[_ba].maxWidth then
aba=math.min(aba,__a[_ba].maxWidth)end
_aa[_ba],aaa=aba,math.max(0,aaa-aba)end;local baa={}local caa=1
for i=1,#__a do
local daa=math.max(0,math.min(_aa[i]or 0,dd-caa+1))baa[i]={x=caa,width=daa}caa=caa+daa+1 end;return baa end
function ac:sortBy(cd,dd)if self.columns[cd]==nil then return self end;if dd==nil then
dd=
rawget(self,"_sortCol")~=cd or not rawget(self,"_sortAsc")end
rawset(self,"_sortCol",cd)rawset(self,"_sortAsc",dd and true or false)
rawget(self,"_p").sortColumn=cd
rawget(self,"_p").sortDirection=dd and"asc"or"desc"bc(self)self:fire("sort",cd,dd)self:markDirty()
return self end
function ac:select(cd,dd)local __a=self.selected
local a_a=__a and self.data[__a]or nil
if cd==false or cd==nil then self.selected=false;if __a then
self:fire("change",false,nil,__a,a_a)end;return self end;if self.data[cd]==nil then return self end;self.selected=cd
local b_a=ad(self)
for viewIndex=1,#b_a do if b_a[viewIndex]==cd then
self.offset=_c.ensureVisible(self.offset,viewIndex,#b_a,dc(self))break end end;if __a~=cd then
self:fire("change",cd,self.data[cd],__a or false,a_a)end
if dd~=false then
self:fire("select",cd,self.data[cd])self:fire("rowSelect",cd,self.data[cd])end;return self end
function ac:addRow(...)local cd=select("#",...)local dd=cd==1 and type((...))=="table"and
(...)or{...}
local __a=self.data;__a[#__a+1]=dd
rawget(self,"_sortValues")[dd]=dd;bc(self)self:markDirty()return self end
function ac:removeRow(cd)local dd=self.data;if dd[cd]==nil then return self end
local __a=self.selected;local a_a=__a and dd[__a]or nil
local b_a=table.remove(dd,cd)rawget(self,"_sortValues")[b_a]=nil
if
self.selected==cd then self.selected=false;self:fire("change",false,nil,__a,a_a)elseif
self.selected and self.selected>cd then self.selected=self.selected-1
self:fire("change",self.selected,self.data[self.selected],__a,a_a)end;bc(self)self:markDirty()return self end;function ac:getRow(cd)return self.data[cd]end
function ac:updateCell(cd,dd,__a)
local a_a=self.data[cd]if a_a==nil then return self end;a_a[dd]=__a
local b_a=rawget(self,"_sortValues")if b_a[a_a]then b_a[a_a][dd]=__a end;bc(self)
self:markDirty()return self end
function ac:setColumnSort(cd,dd)local __a=rawget(self,"_columnSorters")__a[cd]=dd
bc(self)self:markDirty()return self end
function ac:setColumnSortFunction(cd,dd)
if dd==nil then return self:setColumnSort(cd,nil)end;return
self:setColumnSort(cd,function(__a,a_a,b_a,c_a,d_a)return dd(c_a,d_a,b_a and"asc"or"desc")end)end;function ac:sortByColumn(cd,dd)
if dd then self:setColumnSortFunction(cd,dd)end
return self:sortBy(cd,self.sortDirection~="desc")end
function ac:setSortColumn(cd)
if
cd==false or cd==nil then rawset(self,"_sortCol",nil)
rawget(self,"_p").sortColumn=false;bc(self)self:markDirty()return self end
return self:sortBy(cd,self.sortDirection~="desc")end
function ac:setSortDirection(cd)if cd~="asc"and cd~="desc"then
error("Basalt Table: sortDirection must be 'asc' or 'desc'",2)end
rawget(self,"_p").sortDirection=cd
if self.sortColumn then self:sortBy(self.sortColumn,cd=="asc")end;return self end;function ac:getSelectedRow()return
self.selected and self.data[self.selected]or nil end;function ac:clearData()return
self:clear()end
function ac:addColumn(cd,dd)local __a={}for a_a,b_a in ipairs(self.columns)do
__a[a_a]=b_a end
__a[#__a+1]={name=cd,title=cd,width=dd}self.columns=__a;return self end
function ac:setData(cd,dd)if type(cd)~="table"then
error("Basalt Table: data must be a table",2)end;self:clear()
local __a,a_a={},rawget(self,"_sortValues")
for b_a,c_a in ipairs(cd)do local d_a,_aa={},{}
for aaa,baa in ipairs(c_a)do _aa[aaa]=baa;d_a[aaa]=dd and dd[aaa]and
dd[aaa](baa)or baa end;__a[b_a],a_a[d_a]=d_a,_aa end;rawget(self,"_p").data=__a;bc(self)
self:markDirty()return self end
function ac:calculateColumnWidths(cd,dd)local __a=self.columns
rawget(self,"_p").columns=cc(cd)local a_a=bd(self,dd)rawget(self,"_p").columns=__a;local b_a={}
for c_a,d_a in
ipairs(cd)do
b_a[c_a]={name=type(d_a)=="table"and(d_a.name or d_a.title)or d_a,width=
type(d_a)=="table"and d_a.width or nil,visibleWidth=a_a[c_a].width}end;return b_a end
function ac:setHeaderColor(cd)self.headerBackground=cd;return self end;function ac:getHeaderColor()return self.headerBackground end;function ac:setSelectedForeground(cd)
self.selectionForeground=cd;return self end;function ac:getSelectedForeground()
return self.selectionForeground end;function ac:setSelectedBackground(cd)
self.selectionBackground=cd;return self end;function ac:getSelectedBackground()
return self.selectionBackground end;function ac:setSelectionColor(cd,dd)
self.selectionForeground,self.selectionBackground=cd,dd;return self end
function ac:getSelectionColor()return
self.selectionForeground,self.selectionBackground end
function ac:setShowScrollBar(cd)self.scrollbar=cd and"auto"or"hidden"return self end
function ac:getShowScrollBar()return self.scrollbar~="hidden"end
function ac:setScrollBarColor(cd)self.scrollbarThumbColor=cd;return self end;function ac:getScrollBarColor()return self.scrollbarThumbColor end;function ac:setScrollBarBackgroundColor(cd)
self.scrollbarColor=cd;return self end;function ac:getScrollBarBackgroundColor()return
self.scrollbarColor end
function ac:clear()local cd=self.selected;local dd=cd and
self.data[cd]or nil
rawget(self,"_p").data={}
rawset(self,"_sortValues",setmetatable({},{__mode="k"}))self.selected=false;self.offset=0;bc(self)self:markDirty()if cd then self:fire("change",false,
nil,cd,dd)end;return self end
function ac:setup()db.setup(self)local cd=rawget(self,"_p")cd.columns={}
cd.data={}rawset(self,"_columnSorters",{})
rawset(self,"_sortValues",setmetatable({},{__mode="k"}))
self:on("click",function(dd,__a,a_a,b_a)local c_a=_d(dd)
if b_a==1 then if not dd.sortable then return end;local _aa=dd.width- (
c_a.show and 1 or 0)for aaa,baa in ipairs(bd(dd,_aa))do
if
a_a>=baa.x and a_a<baa.x+baa.width then dd:sortBy(aaa)return end end;return end
if c_a.show and a_a==dd.width then
local _aa,aaa=_c.pointerDown(b_a-1,c_a)dd.offset=_aa
if aaa~=nil then rawset(dd,"_itemScrollDrag",aaa)end;return end;local d_a=ad(dd)[c_a.offset+b_a-1]if d_a then
dd:select(d_a)end end)
self:on("drag",function(dd,__a,a_a,b_a)local c_a=rawget(dd,"_itemScrollDrag")if c_a~=nil then
dd.offset=_c.drag(b_a-1,c_a,_d(dd))end end)
self:on("clickUp",function(dd)rawset(dd,"_itemScrollDrag",nil)end)end
function ac:handleMouse(cd,dd,__a,a_a)
if cd=="mouse_scroll"then if self.disabled then return nil end
local b_a=self.offset
self.offset=_c.clampOffset(b_a+dd,#self.data,dc(self))local c_a=self:fire("scroll",dd,__a,a_a)if
self.offset~=b_a or c_a then return self end;return nil end;return db.handleMouse(self,cd,dd,__a,a_a)end
function ac:handleKey(cd,dd,__a)
if cd=="key"and#self.data>0 then local a_a=ad(self)local b_a=0
for viewIndex=1,#a_a do if
a_a[viewIndex]==self.selected then b_a=viewIndex;break end end
if dd==keys.up then
self:select(a_a[math.max(1,b_a>0 and b_a-1 or 1)],false)elseif dd==keys.down then
self:select(a_a[b_a>0 and math.min(#a_a,b_a+1)or 1],false)elseif dd==keys.home then self:select(a_a[1],false)elseif dd==keys["end"]then self:select(a_a[
#a_a],false)elseif dd==keys.enter and b_a>0 then
self:fire("select",self.selected,self.data[self.selected])
self:fire("rowSelect",self.selected,self.data[self.selected])end end;db.handleKey(self,cd,dd,__a)end
function ac:measure()local cd=0;for i=1,#self.columns do cd=
cd+ (self.columns[i].width or 8)+1 end;return math.max(1,
cd-1),math.max(2,#self.data+1)end
function ac:render(cd)db.render(self,cd)local dd=self.width;local __a=_d(self)
rawget(self,"_p").offset=__a.offset;local a_a=dd- (__a.show and 1 or 0)
local b_a=bd(self,a_a)local c_a,d_a=rawget(self,"_sortCol"),rawget(self,"_sortAsc")
cd:fill(1,1,dd,1," ",self.foreground,self.headerBackground)
for caa,daa in ipairs(b_a)do
local _ba=tostring(
self.columns[caa].title or self.columns[caa].name or"")
if caa==c_a then _ba=_ba:sub(1,math.max(0,daa.width-1))..
(d_a and"\30"or"\31")end
cd:blit(daa.x,1,_ba:sub(1,daa.width),self.foreground,self.headerBackground)end;local _aa,aaa,baa=self.data,ad(self),self.selected
for row=1,dc(self)do
local caa=aaa[__a.offset+row]if not caa then break end;local daa=_aa[caa]local _ba=caa==baa;local aba=
_ba and self.selectionForeground or self.foreground;local bba=_ba and
self.selectionBackground or nil;if _ba then
cd:fill(1,row+1,a_a,1," ",aba,bba)end
for cba,dba in ipairs(b_a)do local _ca=daa[cba]if _ca~=nil then
cd:blit(dba.x,row+1,tostring(_ca):sub(1,dba.width),aba,bba)end end end
_c.draw(cd,dd,2,__a,self.foreground,self.scrollbarColor,self.scrollbarThumbColor)end;return ac
]=]
sources["elements/TextBox"] = [=[
local dc=...local _d=dc("core/class")local ad=dc("core/element")
local bd=dc("core/itemview")local cd=_d.create("TextBox",ad)local dd=""
_d.property(cd,"text","",{rawString=true,onChange=function(bba,cba)if
rawget(bba,"_syncing")then return end;local dba={}for aca in(cba.."\n"):gmatch("(.-)\n")do
dba[#dba+1]=aca end;if#dba==0 then dba={""}end
rawset(bba,"_lines",dba)
local _ca=math.min(rawget(bba,"_curLine")or 1,#dba)rawset(bba,"_curLine",_ca)
rawset(bba,"_curCol",math.min(rawget(bba,"_curCol")or 1,
#dba[_ca]+1))rawset(bba,"_selLine",nil)rawset(bba,"_selCol",nil)end})_d.property(cd,"background",colors.black)
_d.property(cd,"width",20)_d.property(cd,"height",8)
_d.property(cd,"scrollbar","auto")_d.property(cd,"scrollbarColor",colors.gray)
_d.property(cd,"scrollbarThumbColor",colors.lightGray)
_d.property(cd,"selectionBackground",colors.blue)
_d.property(cd,"selectionForeground",colors.white)_d.event(cd,"change")
local function __a(bba)return
bd.geometry(#bba._lines,bba.height,bba._viewY,bba.scrollbar)end;local function a_a(bba)return
math.max(1,bba.width- (__a(bba).show and 1 or 0))end
local function b_a(bba)
rawset(bba,"_viewY",bd.ensureVisible(bba._viewY,bba._curLine,
#bba._lines,bba.height))local cba=a_a(bba)local dba,_ca=bba._viewX,bba._curCol
if _ca-dba>cba then dba=_ca-cba end;if _ca-dba<1 then dba=_ca-1 end;rawset(bba,"_viewX",dba)end
local function c_a(bba)rawset(bba,"_syncing",true)
bba.text=table.concat(bba._lines,"\n")rawset(bba,"_syncing",false)b_a(bba)
bba:fire("change",bba.text)end
local function d_a(bba)local cba,dba=rawget(bba,"_selLine"),rawget(bba,"_selCol")if not cba then return
nil end;local _ca,aca=bba._curLine,bba._curCol;if
cba==_ca and dba==aca then return nil end;if
_ca<cba or(_ca==cba and aca<dba)then return _ca,aca,cba,dba end;return cba,dba,_ca,aca end
local function _aa(bba)if rawget(bba,"_selLine")then rawset(bba,"_selLine",nil)
rawset(bba,"_selCol",nil)bba:markDirty()end end;local function aaa(bba)
if not rawget(bba,"_selLine")then
rawset(bba,"_selLine",bba._curLine)rawset(bba,"_selCol",bba._curCol)end end
local function baa(bba,cba,dba)
local _ca=bba._lines;cba=math.max(1,math.min(#_ca,cba))dba=math.max(1,math.min(#
_ca[cba]+1,dba))
rawset(bba,"_curLine",cba)rawset(bba,"_curCol",dba)b_a(bba)bba:markDirty()end
function cd:getSelection()local bba,cba,dba,_ca=d_a(self)if not bba then return nil end
local aca=self._lines
if bba==dba then return aca[bba]:sub(cba,_ca-1)end;local bca={aca[bba]:sub(cba)}for i=bba+1,dba-1 do
bca[#bca+1]=aca[i]end
bca[#bca+1]=aca[dba]:sub(1,_ca-1)return table.concat(bca,"\n")end
function cd:deleteSelection()local bba,cba,dba,_ca=d_a(self)if not bba then return false end
local aca=self._lines
aca[bba]=aca[bba]:sub(1,cba-1)..aca[dba]:sub(_ca)for i=dba,bba+1,-1 do table.remove(aca,i)end
rawset(self,"_curLine",bba)rawset(self,"_curCol",cba)_aa(self)c_a(self)return true end;function cd:selectAll()rawset(self,"_selLine",1)
rawset(self,"_selCol",1)local bba=self._lines;baa(self,#bba,#bba[#bba]+1)
return self end;function cd:copy()
local bba=self:getSelection()if bba then dd=bba end;return bba end
function cd:cut()
local bba=self:copy()if bba then self:deleteSelection()end;return bba end;function cd:getClipboard()return dd end
local function caa(bba,cba)bba:deleteSelection()
local dba=bba._lines;local _ca,aca=bba._curLine,bba._curCol;local bca=dba[_ca]dba[_ca]=bca:sub(1,aca-1)..
cba..bca:sub(aca)rawset(bba,"_curCol",aca+
#cba)c_a(bba)end
local function daa(bba,cba,dba)local _ca=__a(bba)
local aca=math.max(1,math.min(#bba._lines,_ca.offset+dba))
local bca=math.max(1,math.min(#bba._lines[aca]+1,bba._viewX+cba))return aca,bca end
function cd:setup()ad.setup(self)rawset(self,"_lines",{""})
rawset(self,"_curLine",1)rawset(self,"_curCol",1)rawset(self,"_viewX",0)
rawset(self,"_viewY",0)
self:on("click",function(bba,cba,dba,_ca)local aca=__a(bba)
if aca.show and dba==bba.width then
local dca,_da=bd.pointerDown(_ca,aca)rawset(bba,"_viewY",dca)if _da~=nil then
rawset(bba,"_itemScrollDrag",_da)end;bba:markDirty()return end;_aa(bba)local bca,cca=daa(bba,dba,_ca)
rawset(bba,"_mouseAnchor",{line=bca,col=cca})baa(bba,bca,cca)end)
self:on("drag",function(bba,cba,dba,_ca)local aca=rawget(bba,"_itemScrollDrag")if aca~=nil then
rawset(bba,"_viewY",bd.drag(_ca,aca,__a(bba)))bba:markDirty()return end
local bca=rawget(bba,"_mouseAnchor")
if bca then rawset(bba,"_selLine",bca.line)
rawset(bba,"_selCol",bca.col)baa(bba,daa(bba,dba,_ca))end end)
self:on("clickUp",function(bba)rawset(bba,"_itemScrollDrag",nil)
rawset(bba,"_mouseAnchor",nil)end)
self:on("blur",function(bba)rawset(bba,"_shift",false)
rawset(bba,"_ctrl",false)end)end
function cd:handleMouse(bba,cba,dba,_ca)
if bba=="mouse_scroll"then if self.disabled then return nil end
local aca=self._viewY
rawset(self,"_viewY",bd.clampOffset(aca+cba,#self._lines,self.height))local bca=self:fire("scroll",cba,dba,_ca)if
self._viewY~=aca or bca then self:markDirty()return self end;return nil end;return ad.handleMouse(self,bba,cba,dba,_ca)end;local _ba
local function aba()
_ba={[keys.left]=function(bba,cba,dba)if dba>1 then return cba,dba-1 end;if cba>1 then return cba-1,#
bba._lines[cba-1]+1 end;return cba,dba end,[keys.right]=function(bba,cba,dba,_ca)if
dba<=#_ca then return cba,dba+1 end
if cba<#bba._lines then return cba+1,1 end;return cba,dba end,[keys.up]=function(bba,cba,dba)return
cba-1,dba end,[keys.down]=function(bba,cba,dba)return cba+1,dba end,[keys.home]=function(bba,cba)return
cba,1 end,[keys["end"]]=function(bba,cba,dba,_ca)return cba,#_ca+1 end,[keys.pageUp]=function(bba,cba,dba)return
cba-bba.height,dba end,[keys.pageDown]=function(bba,cba,dba)return
cba+bba.height,dba end}end
function cd:handleKey(bba,cba,dba)
if bba=="char"or bba=="paste"then caa(self,cba)elseif bba=="key_up"then
if cba==
keys.leftShift or cba==keys.rightShift then
rawset(self,"_shift",false)elseif cba==keys.leftCtrl or cba==keys.rightCtrl then
rawset(self,"_ctrl",false)end elseif bba=="key"then if not _ba then aba()end;local _ca=self._lines
local aca,bca=self._curLine,self._curCol;local cca=_ca[aca]
if
cba==keys.leftShift or cba==keys.rightShift then rawset(self,"_shift",true)elseif cba==keys.leftCtrl or
cba==keys.rightCtrl then rawset(self,"_ctrl",true)elseif rawget(self,"_ctrl")and
cba==keys.a then self:selectAll()elseif rawget(self,"_ctrl")and cba==
keys.c then self:copy()elseif
rawget(self,"_ctrl")and cba==keys.x then self:cut()elseif _ba[cba]then
if rawget(self,"_shift")then aaa(self)else _aa(self)end;baa(self,_ba[cba](self,aca,bca,cca))elseif
cba==keys.escape then _aa(self)elseif cba==keys.enter then if self:deleteSelection()then _ca=self._lines
aca,bca=self._curLine,self._curCol;cca=_ca[aca]end;_ca[aca]=cca:sub(1,
bca-1)
table.insert(_ca,aca+1,cca:sub(bca))rawset(self,"_curLine",aca+1)
rawset(self,"_curCol",1)c_a(self)elseif cba==keys.backspace then
if self:deleteSelection()then elseif bca>1 then _ca[aca]=
cca:sub(1,bca-2)..cca:sub(bca)
rawset(self,"_curCol",bca-1)c_a(self)elseif aca>1 then local dca=_ca[aca-1]
rawset(self,"_curLine",aca-1)rawset(self,"_curCol",#dca+1)_ca[aca-1]=dca..cca
table.remove(_ca,aca)c_a(self)end elseif cba==keys.delete then
if self:deleteSelection()then elseif bca<=#cca then _ca[aca]=cca:sub(1,bca-1)..cca:sub(
bca+1)c_a(self)elseif aca<#_ca then _ca[aca]=
cca.._ca[aca+1]table.remove(_ca,aca+1)
c_a(self)end end end;ad.handleKey(self,bba,cba,dba)end
function cd:measure()local bba=1
for cba,dba in ipairs(self._lines)do bba=math.max(bba,#dba)end;return bba+1,math.max(1,#self._lines)end
function cd:render(bba)ad.render(self,bba)local cba=self._lines;local dba=__a(self)
rawset(self,"_viewY",dba.offset)
local _ca=math.max(0,self.width- (dba.show and 1 or 0))local aca=self._viewX;for row=1,self.height do local bda=cba[dba.offset+row]
if not bda then break end
bba:blit(1,row,bda:sub(aca+1,aca+_ca),self.foreground,nil)end
local bca,cca,dca,_da=d_a(self)
if bca then
for row=1,self.height do local bda=dba.offset+row;local cda=cba[bda]
if cda and bda>=bca and
bda<=dca then local dda=(bda==bca)and cca or 1;local __b=
(bda==dca)and(_da-1)or(#cda+1)
local a_b=math.max(dda,aca+1)local b_b=math.min(__b,aca+_ca)
if b_b>=a_b then
local c_b=cda:sub(a_b,b_b)
c_b=c_b..string.rep(" ",(b_b-a_b+1)-#c_b)
bba:blit(a_b-aca,row,c_b,self.selectionForeground,self.selectionBackground)end end end end
bd.draw(bba,self.width,1,dba,self.foreground,self.scrollbarColor,self.scrollbarThumbColor)local ada=self:getRoot()if
ada.getFocused and ada:getFocused()==self then
self:setCursor(self._curCol-aca,self._curLine-dba.offset,true,self.foreground)end end;return cd
]=]
sources["elements/Toast"] = [=[
local aa=...local ba=aa("core/class")local ca=aa("core/element")
local da=aa("core/text")local _b=ba.create("Toast",ca)
ba.property(_b,"message","")ba.property(_b,"duration",3)
ba.property(_b,"maxWidth",24)ba.property(_b,"visible",false)
ba.property(_b,"toastColors",false)
ba.property(_b,"width",function(ab)local bb=1;for cb,db in ipairs(rawget(ab,"_lines")or{""})do bb=math.max(bb,
#db)end;return bb+2 end)
ba.property(_b,"height",function(ab)return
math.max(1,# (rawget(ab,"_lines")or{""}))end)
ba.property(_b,"x",function(ab)local bb=rawget(ab,"parent")return bb and
math.max(1,bb.width-ab.width)or 1 end)ba.property(_b,"y",2)ba.event(_b,"hide")
function _b:setup()
ca.setup(self)self.z=900
rawget(self,"_p").toastColors={default={bg=colors.gray,fg=colors.white},success={bg=colors.green,fg=colors.white},error={bg=colors.red,fg=colors.white},warning={bg=colors.orange,fg=colors.black},info={bg=colors.blue,fg=colors.white}}
self:on("click",function(ab)ab:hide()end)end
function _b:show(ab,bb,cb)self.message=tostring(ab)
rawset(self,"_lines",da.wrap(self.message,self.maxWidth-2))
local db=self.toastColors[bb or"default"]or self.toastColors.default;self.background=db.bg;self.foreground=db.fg;self.visible=true
self:markDirty()cb=cb or self.duration
local _c=(rawget(self,"_showToken")or 0)+1;rawset(self,"_showToken",_c)if cb and cb>0 then local ac=aa("main")
ac.schedule(function()
sleep(cb)
if rawget(self,"_showToken")==_c then self:hide()end end)end;return self end;function _b:hide()if not self.visible then return self end;self.visible=false
self:fire("hide")return self end;function _b:success(ab,bb)return
self:show(ab,"success",bb)end;function _b:error(ab,bb)return
self:show(ab,"error",bb)end;function _b:warning(ab,bb)return
self:show(ab,"warning",bb)end;function _b:info(ab,bb)
return self:show(ab,"info",bb)end
function _b:render(ab)ca.render(self,ab)local bb=
rawget(self,"_lines")or{""}for i=1,#bb do
ab:blit(2,i,bb[i],self.foreground,self.background)end end;return _b
]=]
sources["elements/Tree"] = [=[
local da=...local _b=da("core/class")local ab=da("core/element")
local bb=da("core/itemview")local cb=_b.create("Tree",ab)
_b.property(cb,"nodes",false,{onChange=function(bc,cc)if type(cc)~="table"then
error("Basalt Tree: nodes must be a table",3)end;local dc=bc.selected;bc.offset=0
bc.horizontalOffset=0;bc.selected=false
if dc then bc:fire("change",false,dc)end;if cc[1]and cc[1].children and cc[1].expanded==nil then
cc[1].expanded=true end end})
_b.property(cb,"selected",false,{state="selected",stateWhen=function(bc)return bc~=false and bc~=nil end,styleable=false})_b.property(cb,"offset",0)
_b.property(cb,"horizontalOffset",0)_b.property(cb,"background",colors.black)
_b.property(cb,"selectionBackground",colors.blue)
_b.property(cb,"selectionForeground",colors.white)_b.property(cb,"width",16)
_b.property(cb,"height",8)_b.property(cb,"scrollbar","auto")
_b.property(cb,"scrollbarColor",colors.gray)
_b.property(cb,"scrollbarThumbColor",colors.lightGray)_b.property(cb,"scrollBarSymbol"," ")
_b.property(cb,"scrollBarBackground","\127")_b.event(cb,"select")_b.event(cb,"change")
_b.event(cb,"toggle")
local function db(bc)local cc={}
local function dc(_d,ad,bd)for i=1,#_d do local cd=_d[i]cc[#cc+1]={node=cd,depth=ad,parent=bd}
if cd.children and
cd.expanded then dc(cd.children,ad+1,cd)end end end;dc(bc.nodes,0,nil)return cc end;local function _c(bc,cc)for i=1,#bc do if bc[i].node==cc then return i end end
return nil end;local function ac(bc,cc)return
bb.geometry(#cc,bc.height,bc.offset,bc.scrollbar)end
function cb:toggle(bc,cc)if not
bc or not bc.children then return self end;if cc==nil then
cc=not bc.expanded end;bc.expanded=cc and true or false
local dc=db(self)
self.offset=bb.clampOffset(self.offset,#dc,self.height)self:fire("toggle",bc,bc.expanded)
self:markDirty()return self end
function cb:select(bc,cc)local dc=self.selected
if bc==false or bc==nil then self.selected=false;if dc then
self:fire("change",false,dc)end;return self end;self.selected=bc;local _d=db(self)local ad=_c(_d,bc)
if ad then self.offset=bb.ensureVisible(self.offset,ad,
#_d,self.height)end
if dc~=bc then self:fire("change",bc,dc or false)end;if cc~=false then self:fire("select",bc)end;return self end;function cb:expandNode(bc)return self:toggle(bc,true)end;function cb:collapseNode(bc)return
self:toggle(bc,false)end;function cb:toggleNode(bc)
return self:toggle(bc)end
function cb:setSelectedNode(bc)return self:select(bc,false)end;function cb:getSelectedNode()return self.selected or nil end
function cb:getExpandedNodes()
local bc={}
local function cc(dc)for _d,ad in ipairs(dc)do if ad.expanded then bc[ad]=true end
if ad.children then cc(ad.children)end end end;cc(self.nodes)return bc end
function cb:setExpandedNodes(bc)if type(bc)~="table"then
error("Basalt Tree: expandedNodes must be a table",2)end;local function cc(dc)
for _d,ad in ipairs(dc)do if ad.children then
ad.expanded=bc[ad]==true;cc(ad.children)end end end
cc(self.nodes)
self.offset=bb.clampOffset(self.offset,#db(self),self.height)self:markDirty()return self end
function cb:getNodeSize()local bc=db(self)local cc=1;for dc,_d in ipairs(bc)do
cc=math.max(cc,_d.depth+2 +#
tostring(_d.node.text or"Node"))end;return cc,#bc end
function cb:setHorizontalOffset(bc)local cc=self:getNodeSize()
rawget(self,"_p").horizontalOffset=math.max(0,math.min(math.floor(
bc or 0),math.max(0,cc-self.width)))self:markDirty()return self end
function cb:setSelectedForegroundColor(bc)self.selectionForeground=bc;return self end
function cb:getSelectedForegroundColor()return self.selectionForeground end
function cb:setSelectedBackgroundColor(bc)self.selectionBackground=bc;return self end
function cb:getSelectedBackgroundColor()return self.selectionBackground end;function cb:setSelectionColor(bc,cc)self.selectionForeground,self.selectionBackground=bc,cc
return self end
function cb:getSelectionColor()return
self.selectionForeground,self.selectionBackground end
function cb:setShowScrollBar(bc)self.scrollbar=bc and"auto"or"hidden"return self end
function cb:getShowScrollBar()return self.scrollbar~="hidden"end
function cb:setScrollBarColor(bc)self.scrollbarThumbColor=bc;return self end;function cb:getScrollBarColor()return self.scrollbarThumbColor end;function cb:setScrollBarBackgroundColor(bc)
self.scrollbarColor=bc;return self end;function cb:getScrollBarBackgroundColor()return
self.scrollbarColor end
function cb:expandAll()local function bc(cc)
for i=1,#cc do if cc[i].children then
cc[i].expanded=true;bc(cc[i].children)end end end
bc(self.nodes)self:markDirty()return self end
function cb:collapseAll()
local function bc(cc)for i=1,#cc do if cc[i].children then cc[i].expanded=false
bc(cc[i].children)end end end;bc(self.nodes)self:markDirty()return self end
function cb:setup()ab.setup(self)rawget(self,"_p").nodes={}
self:on("click",function(bc,cc,dc,_d)
local ad=db(bc)local bd=ac(bc,ad)if bd.show and dc==bc.width then
local dd,__a=bb.pointerDown(_d,bd)bc.offset=dd
if __a~=nil then rawset(bc,"_itemScrollDrag",__a)end;return end;local cd=ad[
bd.offset+_d]if not cd then return end
if cd.node.children and
dc>=cd.depth+1 and dc<=cd.depth+2 then
bc:toggle(cd.node)else bc:select(cd.node)end end)
self:on("drag",function(bc,cc,dc,_d)local ad=rawget(bc,"_itemScrollDrag")if ad~=nil then
bc.offset=bb.drag(_d,ad,ac(bc,db(bc)))end end)
self:on("clickUp",function(bc)rawset(bc,"_itemScrollDrag",nil)end)end
function cb:handleMouse(bc,cc,dc,_d)
if bc=="mouse_scroll"then if self.disabled then return nil end;local ad=db(self)
local bd=self.offset;self.offset=bb.clampOffset(bd+cc,#ad,self.height)
local cd=self:fire("scroll",cc,dc,_d)if self.offset~=bd or cd then return self end;return nil end;return ab.handleMouse(self,bc,cc,dc,_d)end
function cb:handleKey(bc,cc,dc)
if bc=="key"then local _d=db(self)
if#_d>0 then
local ad=_c(_d,self.selected)or 0
if cc==keys.up then
self:select(_d[math.max(1,ad>0 and ad-1 or 1)].node,false)elseif cc==keys.down then
self:select(_d[ad>0 and math.min(#_d,ad+1)or 1].node,false)elseif cc==keys.right and ad>0 then local bd=_d[ad].node
if
bd.children and not bd.expanded then self:toggle(bd,true)elseif
bd.children and bd.expanded and bd.children[1]then self:select(bd.children[1],false)end elseif cc==keys.left and ad>0 then local bd=_d[ad]if
bd.node.children and bd.node.expanded then self:toggle(bd.node,false)elseif bd.parent then
self:select(bd.parent,false)end elseif
cc==keys.enter and ad>0 then self:fire("select",_d[ad].node)end end end;ab.handleKey(self,bc,cc,dc)end
function cb:measure()local bc=db(self)local cc=1;for i=1,#bc do
cc=math.max(cc,bc[i].depth+3 +#
tostring(bc[i].node.text))end;return cc,math.max(1,#bc)end
function cb:render(bc)ab.render(self,bc)local cc=db(self)local dc=ac(self,cc)
rawget(self,"_p").offset=dc.offset
local _d=math.max(0,self.width- (dc.show and 1 or 0))local ad=self.selected
for row=1,self.height do local bd=cc[dc.offset+row]
if not bd then break end;local cd=bd.node;local dd=cd.children and(cd.expanded and"- "or"+ ")or
"  "
local __a=
string.rep(" ",bd.depth)..dd..tostring(cd.text)
__a=__a:sub(self.horizontalOffset+1,self.horizontalOffset+_d)
if cd==ad then
bc:fill(1,row,_d,1," ",self.selectionForeground,self.selectionBackground)
bc:blit(1,row,__a:sub(1,_d),self.selectionForeground,self.selectionBackground)else
bc:blit(1,row,__a:sub(1,_d),self.foreground,nil)end end
bb.draw(bc,self.width,1,dc,self.foreground,self.scrollbarColor,self.scrollbarThumbColor)end;return cb
]=]
sources["modules/animation"] = [=[
local da=...local _b=da("main")local ab=da("core/element")local bb={}
local cb={linear=function(bc)return bc end,easeIn=function(bc)return
bc*bc end,easeOut=function(bc)return bc* (2 -bc)end,easeInOut=function(bc)if bc<0.5 then return
2 *bc*bc end;return-1 + (4 -2 *bc)*bc end}bb.easings=cb;local db={}local _c=false
local function ac()if _c then return end;_c=true
_b.schedule(function()
while#db>0 do
sleep(0.05)local bc=os.clock()
for i=#db,1,-1 do local cc=db[i]
local dc=(bc-cc.start)/cc.duration
if dc>=1 then for _d,ad in pairs(cc.to)do cc.el[_d]=ad end
table.remove(db,i)if cc.onDone then cc.onDone(cc.el)end else local _d=cc.easing(dc)for ad,bd in
pairs(cc.to)do local cd=cc.from[ad]
cc.el[ad]=math.floor(cd+ (bd-cd)*_d+0.5)end end end end;_c=false end)end
function bb.to(bc,cc,dc,_d,ad)
local bd={el=bc,to=cc,from={},start=os.clock(),duration=dc or 0.3,easing=cb[_d or"easeInOut"]or error("Basalt animation: unknown easing '"..
tostring(_d).."'",2),onDone=ad}
for cd in pairs(cc)do local dd=bc[cd]if type(dd)~="number"then
error("Basalt animation: property '"..
cd.."' is not a number",2)end;bd.from[cd]=dd end;db[#db+1]=bd;ac()return
{cancel=function()for i=1,#db do
if db[i]==bd then table.remove(db,i)break end end end}end;function ab:animate(bc,cc,dc,_d)return bb.to(self,bc,cc,dc,_d)end;return
bb
]=]
sources["modules/bigfont"] = [=[
local cb=...local db=cb("core/class")local _c=cb("core/element")
local ac=cb("core/container")local bc=cb("core/palette")local cc=bc.charOf
local dc={{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147","\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132","\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131","\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132","\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32","\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129","\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32","\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32","\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148","\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32","\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32","\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148","\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149","\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32","\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32","\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32","\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132","\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32","\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149","\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32","\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148","\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32","\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32","\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32","\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32","\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129","\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32","\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32","\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32","\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148","\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32","\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32","\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32","\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132","\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149","\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32","\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32","\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32","\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32","\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144","\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149","\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129"},{"000110000110110000110010101000000010000000100101","000000110110000000000010101000000010000000100101","000000000000000000000000000000000000000000000000","100010110100000010000110110000010100000100000110","000000110000000010110110000110000000000000110000","000000000000000000000000000000000000000000000000","000000110110000010000000100000100000000000000010","000000000110110100010000000010000000000000000100","000000000000000000000000000000000000000000000000","010000000000100110000000000000000000000110010000","000000000000000000000000000010000000010110000000","000000000000000000000000000000000000000000000000","011110110000000100100010110000000100000000000000","000000000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110000110110000000000000000000010100100010000000","000010000000000000110110000000000100010010000000","000000000000000000000000000000000000000000000000","010110010110100110110110010000000100000110110110","000000000000000000000110000000000110000000000000","000000000000000000000000000000000000000000000000","010100010110110000000000000000110000000010000000","110110000000000000110000110110100000000010000000","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","000000000000000000000000000000000000000000000000","000100011111000100011111000100011111000100011111","000000000000100100100100011011011011111111111111","100100100100100100100100100100100100100100100100","000000110100110110000010000011110000000000011000","000000000100000000000010000011000110000000001000","000000000000000000000000000000000000000000000000","010000100100000000000000000100000000010010110000","000000000000000000000000000000110110110110110000","000000000000000000000000000000000000000000000000","110110110110110110000000110110110110110110110110","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","000000000000110110000110010000000000000000010010","000010000000000000000000000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110110110110000000000000","000000000000000000000110000000000000000000000000","000000000000000000000000000000000000000000000000","110110110110110110110000110000000000000000010000","000000000000000000000000100000000000000110000110","000000000000000000000000000000000000000000000000"}}local _d={}local ad={}
do local __a=0;local a_a=#dc[1]local b_a=#dc[1][1]
for i=1,a_a,3 do
for j=1,b_a,3 do
local c_a=string.char(__a)local d_a={}d_a[1]=dc[1][i]:sub(j,j+2)d_a[2]=dc[1][i+1]:sub(j,
j+2)
d_a[3]=dc[1][i+2]:sub(j,j+2)local _aa={}_aa[1]=dc[2][i]:sub(j,j+2)_aa[2]=dc[2][i+1]:sub(j,
j+2)
_aa[3]=dc[2][i+2]:sub(j,j+2)ad[c_a]={d_a,_aa}__a=__a+1 end end;_d[1]=ad end
local function bd(__a,a_a)local b_a={["0"]="1",["1"]="0"}if __a<=#_d then return true end
for f=#_d+1,__a do
local c_a={}local d_a=_d[f-1]
for char=0,255 do local _aa=string.char(char)local aaa={}local baa={}
local caa=d_a[_aa][1]local daa=d_a[_aa][2]
for i=1,#caa do local _ba,aba,bba,cba,dba,_ca={},{},{},{},{},{}
for j=1,#caa[1]do
local aca=ad[caa[i]:sub(j,j)][1]table.insert(_ba,aca[1])
table.insert(aba,aca[2])table.insert(bba,aca[3])
local bca=ad[caa[i]:sub(j,j)][2]
if daa[i]:sub(j,j)=="1"then
table.insert(cba,(bca[1]:gsub("[01]",b_a)))
table.insert(dba,(bca[2]:gsub("[01]",b_a)))
table.insert(_ca,(bca[3]:gsub("[01]",b_a)))else table.insert(cba,bca[1])
table.insert(dba,bca[2])table.insert(_ca,bca[3])end end;table.insert(aaa,table.concat(_ba))
table.insert(aaa,table.concat(aba))table.insert(aaa,table.concat(bba))
table.insert(baa,table.concat(cba))table.insert(baa,table.concat(dba))
table.insert(baa,table.concat(_ca))end;c_a[_aa]={aaa,baa}if a_a then a_a="Font"..f.."Yeld"..char
os.queueEvent(a_a)os.pullEvent(a_a)end end;_d[f]=c_a end;return true end
local function cd(__a,a_a,b_a,c_a,d_a)
if not type(a_a)=="string"then error("Not a String",3)end
local _aa=
type(b_a)=="string"and b_a:sub(1,1)or cc[b_a]or error("Wrong Front Color",3)
local aaa=
type(c_a)=="string"and c_a:sub(1,1)or cc[c_a]or error("Wrong Back Color",3)if(_d[__a]==nil)then bd(3,false)end;local baa=_d[__a]or
error("Wrong font size selected",3)if a_a==""then
return{{""},{""},{""}}end;local caa={}
for _ca in a_a:gmatch('.')do table.insert(caa,_ca)end;local daa={}local _ba=#baa[caa[1]][1]
for nLine=1,_ba do local _ca={}for i=1,#caa do
_ca[i]=
baa[caa[i]]and baa[caa[i]][1][nLine]or""end;daa[nLine]=table.concat(_ca)end;local aba={}local bba={}local cba={["0"]=_aa,["1"]=aaa}
local dba={["0"]=aaa,["1"]=_aa}
for nLine=1,_ba do local _ca={}local aca={}
for i=1,#caa do local bca=
baa[caa[i]]and baa[caa[i]][2][nLine]or""
_ca[i]=bca:gsub("[01]",d_a and
{["0"]=b_a:sub(i,i),["1"]=c_a:sub(i,i)}or cba)
aca[i]=bca:gsub("[01]",
d_a and{["0"]=c_a:sub(i,i),["1"]=b_a:sub(i,i)}or dba)end;aba[nLine]=table.concat(_ca)
bba[nLine]=table.concat(aca)end;return{daa,aba,bba}end;local dd=db.create("BigFont",_c)
db.property(dd,"text","BigFont")
db.property(dd,"fontSize",1,{onChange=function(__a,a_a)if a_a<1 or a_a>3 or a_a%1 ~=0 then
error("Basalt bigfont: fontSize must be 1, 2 or 3",3)end end})
db.property(dd,"width",function(__a)local a_a=__a:getBigText()[1]return
math.max(1,# (a_a[1]or""))end)
db.property(dd,"height",function(__a)
return math.max(1,#__a:getBigText()[1])end)
function dd:getBigText()local __a=self.foreground
local a_a=self.background or colors.black
local b_a=self.fontSize..
"\0"..tostring(self.text).."\0"..
tostring(__a).."\0"..tostring(a_a)local c_a=rawget(self,"_big")
if c_a and c_a.key==b_a then return c_a.data end
bd(math.min(3,math.max(1,self.fontSize)),false)
local d_a=cd(self.fontSize,tostring(self.text),__a,a_a)rawset(self,"_big",{key=b_a,data=d_a})return d_a end
function dd:measure()local __a=self:getBigText()return
math.max(1,# (__a[1][1]or"")),math.max(1,#__a[1])end
function dd:render(__a)local a_a=self:getBigText()for i=1,#a_a[1]do
__a:rawBlit(1,i,a_a[1][i],a_a[2][i],a_a[3][i])end end;ac.register("BigFont",dd)return{BigFont=dd}
]=]
sources["modules/charts"] = [=[
local _c=...local ac=_c("core/class")local bc=_c("core/element")
local cc=_c("core/container")local dc=_c("core/palette")local _d={}local function ad(d_a)if d_a<0 then return 0 end
if d_a>1 then return 1 end;return d_a end
local function bd(d_a,_aa,aaa,baa)local caa=aaa>_aa and
ad((d_a-_aa)/ (aaa-_aa))or 0;return baa-math.floor(caa* (baa-
1)+0.5)end;local cd=ac.create("Graph",bc)
ac.property(cd,"minValue",0)ac.property(cd,"maxValue",100)
ac.property(cd,"background",colors.black)ac.property(cd,"width",20)
ac.property(cd,"height",8)
function cd:setup()bc.setup(self)rawset(self,"_series",{})end
function cd:addSeries(d_a,_aa)_aa=_aa or{}local aaa=rawget(self,"_series")
aaa[#aaa+1]={name=d_a,symbol=(
_aa.symbol or" "):sub(1,1),fg=_aa.fg or colors.white,bg=_aa.bg or
colors.white,pointCount=_aa.pointCount or self.width,visible=_aa.visible~=false,points={}}self:markDirty()return self end
function cd:getSeries(d_a)for _aa,aaa in ipairs(rawget(self,"_series"))do
if aaa.name==d_a then return aaa end end;return nil end
function cd:removeSeries(d_a)local _aa=rawget(self,"_series")for i=1,#_aa do if _aa[i].name==d_a then
table.remove(_aa,i)break end end
self:markDirty()return self end
function cd:setSeriesVisible(d_a,_aa)local aaa=self:getSeries(d_a)if aaa then aaa.visible=_aa~=false
self:markDirty()end;return self end
function cd:addPoint(d_a,_aa)local aaa=self:getSeries(d_a)if not aaa then
error("Basalt charts: unknown series '"..
tostring(d_a).."'",2)end;local baa=aaa.points
baa[#baa+1]=_aa
while#baa>aaa.pointCount do table.remove(baa,1)end;self:markDirty()return self end
function cd:clear(d_a)
if d_a then local _aa=self:getSeries(d_a)if _aa then _aa.points={}end else for _aa,aaa in
ipairs(rawget(self,"_series"))do aaa.points={}end end;self:markDirty()return self end
function cd:render(d_a)bc.render(self,d_a)local _aa,aaa=self.width,self.height
local baa,caa=self.minValue,self.maxValue
for daa,_ba in ipairs(rawget(self,"_series"))do
if _ba.visible then local aba=_ba.points
local bba=math.max(_ba.pointCount,2)
for i=1,#aba do local cba=1 +
math.floor((i-1)/ (bba-1)* (_aa-1)+0.5)
local dba=bd(aba[i],baa,caa,aaa)d_a:blit(cba,dba,_ba.symbol,_ba.fg,_ba.bg)end end end end;local dd=ac.create("BarChart",bc)
ac.property(dd,"data",false)ac.property(dd,"barColor",colors.lime)
ac.property(dd,"minValue",0)ac.property(dd,"maxValue",false)
ac.property(dd,"background",colors.black)ac.property(dd,"width",20)
ac.property(dd,"height",8)
function dd:setup()bc.setup(self)rawget(self,"_p").data={}end
function dd:render(d_a)bc.render(self,d_a)local _aa=self.data;local aaa=#_aa
if aaa==0 then return end;local baa,caa=self.width,self.height;local daa=self.maxValue
if not daa then
daa=-math.huge;for i=1,aaa do daa=math.max(daa,_aa[i])end end;local _ba=self.minValue
local aba=math.max(1,math.floor((baa- (aaa-1))/aaa))local bba=1
for i=1,aaa do if bba>baa then break end;local cba=bd(_aa[i],_ba,daa,caa)
d_a:fill(bba,cba,math.min(aba,
baa-bba+1),caa-cba+1," ",self.foreground,self.barColor)bba=bba+aba+1 end end;local __a=ac.create("LineChart",bc)
ac.property(__a,"data",false)ac.property(__a,"lineColor",colors.lime)
ac.property(__a,"minValue",0)ac.property(__a,"maxValue",100)
ac.property(__a,"background",colors.black)ac.property(__a,"width",20)
ac.property(__a,"height",8)
function __a:setup()bc.setup(self)rawget(self,"_p").data={}end
function __a:render(d_a)bc.render(self,d_a)local _aa=self.data;local aaa=#_aa
if aaa==0 then return end;local baa,caa=self.width,self.height;local daa,_ba=self.minValue,self.maxValue
for col=1,baa do
local aba=
aaa>1 and( (col-1)/ (baa-1)* (aaa-1)+1)or 1;local bba=math.floor(aba)local cba=math.min(aaa,bba+1)
local dba=_aa[bba]+ (
_aa[cba]-_aa[bba])* (aba-bba)local _ca=bd(dba,daa,_ba,caa)
d_a:fill(col,_ca,1,1," ",self.foreground,self.lineColor)end end
local function a_a(d_a,_aa,aaa,baa,caa,daa)
if baa<1 or baa>_aa or caa<1 or caa>aaa then return end;d_a[caa][baa]=daa end
local function b_a(d_a,_aa,aaa,baa,caa,daa,_ba,aba)
local bba,cba=math.abs(daa-baa),-math.abs(_ba-caa)local dba=baa<daa and 1 or-1
local _ca=caa<_ba and 1 or-1;local aca=bba+cba;local bca,cca=baa,caa
while true do a_a(d_a,_aa,aaa,bca,cca,aba)if
bca==daa and cca==_ba then break end;local dca=2 *aca;if dca>=cba then
aca,bca=aca+cba,bca+dba end
if dca<=bba then aca,cca=aca+bba,cca+_ca end end end;local c_a=ac.create("PixelGraph",bc)
ac.property(c_a,"minValue",0)ac.property(c_a,"maxValue",100)
ac.property(c_a,"background",colors.black)ac.property(c_a,"width",20)
ac.property(c_a,"height",8)
function c_a:setup()bc.setup(self)rawset(self,"_series",{})end
function c_a:addSeries(d_a,_aa)_aa=_aa or{}local aaa=rawget(self,"_series")
aaa[#aaa+1]={name=d_a,color=
_aa.color or colors.white,pointCount=_aa.pointCount or self.width*2,visible=_aa.visible~=false,points={}}self:markDirty()return self end
function c_a:getSeries(d_a)for _aa,aaa in ipairs(rawget(self,"_series"))do
if aaa.name==d_a then return aaa end end;return nil end
function c_a:removeSeries(d_a)local _aa=rawget(self,"_series")for i=1,#_aa do if _aa[i].name==d_a then
table.remove(_aa,i)break end end
self:markDirty()return self end
function c_a:setSeriesVisible(d_a,_aa)local aaa=self:getSeries(d_a)if aaa then aaa.visible=_aa~=false
self:markDirty()end;return self end
function c_a:addPoint(d_a,_aa)local aaa=self:getSeries(d_a)if not aaa then
error("Basalt charts: unknown series '"..
tostring(d_a).."'",2)end;local baa=aaa.points
baa[#baa+1]=_aa
while#baa>aaa.pointCount do table.remove(baa,1)end;self:markDirty()return self end
function c_a:clear(d_a)
if d_a then local _aa=self:getSeries(d_a)if _aa then _aa.points={}end else for _aa,aaa in
ipairs(rawget(self,"_series"))do aaa.points={}end end;self:markDirty()return self end
function c_a:render(d_a)bc.render(self,d_a)
local _aa,aaa=self.width*2,self.height*3;local baa,caa=self.minValue,self.maxValue;local daa={}for y=1,aaa do daa[y]={}end
local _ba,aba,bba,cba={},{},1,false
for _ca,aca in ipairs(rawget(self,"_series"))do
if
aca.visible and#aca.points>0 then local bca=aba[aca.color]if not bca then bca=bba;bba=bba+1;aba[aca.color]=bca
_ba[bca]=dc.charOf[aca.color]end;local cca=aca.points
local dca=math.max(aca.pointCount,2)local _da,ada
for i=1,#cca do local bda=1 +
math.floor((i-1)/ (dca-1)* (_aa-1)+0.5)
local cda=bd(cca[i],baa,caa,aaa)if _da then b_a(daa,_aa,aaa,_da,ada,bda,cda,bca)else
a_a(daa,_aa,aaa,bda,cda,bca)end;_da,ada=bda,cda end;cba=true end end;if not cba then return end;local dba={}
for y=1,aaa do local _ca,aca={},daa[y]for x=1,_aa do
_ca[x]=string.char(aca[x]or 0)end;dba[y]=table.concat(_ca)end;d_a:drawPixels(1,1,_aa,aaa,dba,_ba)end;cc.register("Graph",cd)cc.register("BarChart",dd)
cc.register("LineChart",__a)cc.register("PixelGraph",c_a)_d.Graph=cd;_d.BarChart=dd
_d.LineChart=__a;_d.PixelGraph=c_a;return _d
]=]
sources["modules/debug"] = [=[
local cb=...local db=cb("main")local _c={}local ac=8;local bc={}local cc=40;local dc,_d,ad;local bd=keys.f12
local function cd()if
not dc or not dc.visible then return end;local __a=ac-1
local a_a=math.max(0,#bc-__a)for i=1,__a do ad[i].text=bc[a_a+i]or""end end
local function dd()if dc then return end;local __a=db.getMainFrame()
dc=__a:addFrame({x=1,y="{parent.height - ".. (ac-1).."}",width="{parent.width}",height=ac,z=1000,visible=false,background=colors.black,name="basalt_debug_overlay"})
_d=dc:addLabel({x=2,y=1,text="Basalt Debug",foreground=colors.orange})ad={}for i=1,ac-1 do
ad[i]=dc:addLabel({x=2,y=i+1,text="",foreground=colors.lime})end end
function _c.log(...)local __a={}
for i=1,select("#",...)do __a[i]=tostring((select(i,...)))end;bc[#bc+1]=table.concat(__a," ")if#bc>cc then
table.remove(bc,1)end;cd()end;function _c.show(__a)dd()if __a==nil then __a=not dc.visible end;dc.visible=__a
cd()end
function _c.setToggleKey(__a)bd=__a end;function _c.getOverlay()dd()return dc end;function _c.clear()bc={}cd()end;dd()
db.schedule(function()
while
true do local __a,a_a=os.pullEvent("key")if a_a==bd then _c.show()end end end)db.debug=_c.log;return _c
]=]
sources["modules/image"] = [=[
local bc,cc=...local dc=bc("core/class")local _d=bc("core/element")
local ad=bc("core/container")local bd=bc("core/palette")
local cd=fs.combine(fs.getDir(cc),"flimg.lua")local dd,__a=loadfile(cd)if not dd then
error("Basalt image: cannot load FLIMG codec: "..tostring(__a),0)end;local a_a=dd()local b_a={}
local function c_a(caa)
if caa and
caa.format=="FLIMG"then if caa.mode=="pixel"then return math.ceil(caa.width/2),
math.ceil(caa.height/3)end;return caa.width,
caa.height end;if not caa or not caa[1]then return 0,0 end
return#caa[1][1],#caa end;local function d_a(caa)
return caa and caa.format=="FLIMG"and#caa.frames or(
caa and#caa or 0)end
local function _aa(caa)
if caa._basaltPalette then return caa end;local daa={}for i=1,#caa.palette do local _ba=bd.rgb(caa.palette[i])
daa[i]=bd.charOf[_ba]end;caa._basaltPalette=daa;caa._composedFrames=
caa._composedFrames or{}return caa end;local aaa=dc.create("Image",_d)
dc.property(aaa,"bimg",false,{onChange=function(caa,daa)
rawget(caa,"_p").currentFrame=1;rawset(caa,"_frameDirection",1)
if caa.autoSize and daa and(daa[1]or daa.format==
"FLIMG")then
local _ba,aba=c_a(daa.format=="FLIMG"and
daa or daa[1])local bba=rawget(caa,"_p")
bba.width,bba.height=math.max(1,_ba),math.max(1,aba)end end})dc.property(aaa,"currentFrame",1)
dc.property(aaa,"autoSize",true)dc.property(aaa,"width",8)
dc.property(aaa,"height",4)function aaa:getFrameCount()return d_a(self.bimg)end
local function baa(caa)
local daa=caa:getFrameCount()if daa<=0 then return false end;local _ba,aba=caa.bimg,caa.currentFrame
if
_ba.format=="FLIMG"and _ba.pingPong and daa>1 then local bba=
rawget(caa,"_frameDirection")or 1
if bba>0 and aba>=daa then bba=-1 elseif bba<0 and
aba<=1 then if _ba.loop==false then return false end;bba=1 end;rawset(caa,"_frameDirection",bba)
caa.currentFrame=aba+bba;return true end
if aba<daa then caa.currentFrame=aba+1 elseif
_ba.format=="FLIMG"and _ba.loop==false then return false else caa.currentFrame=1 end;return true end;function aaa:nextFrame()baa(self)return self end
function aaa:play(caa)local daa=self.bimg;if
not daa or d_a(daa)<2 then return self end;local _ba=(
rawget(self,"_playToken")or 0)+1
rawset(self,"_playToken",_ba)local aba=bc("main")
aba.schedule(function()
while rawget(self,"_playToken")==_ba do local bba
if caa then bba=1 /
caa elseif daa.format=="FLIMG"then
local cba=daa.frames[self.currentFrame]bba=(cba and cba.duration or 200)/1000 else bba=
daa.secondsPerFrame or 0.2 end;sleep(bba)
if rawget(self,"_playToken")==_ba then if not baa(self)then rawset(self,"_playToken",
_ba+1)break end end end end)return self end;function aaa:stop()
rawset(self,"_playToken",(rawget(self,"_playToken")or 0)+1)return self end
function aaa:measure()
local caa=self.bimg
local daa,_ba=c_a(caa and caa.format=="FLIMG"and caa or caa and caa[1])return math.max(1,daa),math.max(1,_ba)end
function aaa:render(caa)_d.render(self,caa)local daa=self.bimg;if not daa then return end
if
daa.format=="FLIMG"then _aa(daa)
local aba=math.max(1,math.min(#daa.frames,self.currentFrame))local bba=daa._composedFrames[aba]
if not bba then
bba=a_a.compose(daa,aba)daa._composedFrames[aba]=bba end
if daa.mode=="pixel"then
caa:drawPixels(1,1,daa.width,daa.height,bba,daa._basaltPalette)else
for y=1,math.min(#bba,self.height)do local cba=bba[y]local dba,_ca={},{}
for x=1,#cba[1]do
local aca,bca=cba[2]:byte(x),cba[3]:byte(x)
dba[x]=aca==0 and"\0"or daa._basaltPalette[aca]
_ca[x]=bca==0 and"\0"or daa._basaltPalette[bca]end
caa:maskedBlit(1,y,cba[1],table.concat(dba),table.concat(_ca),cba[1],cba[2],cba[3])end end;return end
local _ba=daa[math.max(1,math.min(#daa,self.currentFrame))]if not _ba then return end;for y=1,math.min(#_ba,self.height)do local aba=_ba[y]
caa:drawBlit(1,y,aba[1],aba[2],aba[3])end end
function b_a.load(caa)
local daa=fs.open(caa,"rb")or fs.open(caa,"r")if not daa then
error("Basalt image: cannot open "..tostring(caa),2)end;local _ba=daa.readAll()
daa.close()
if _ba:sub(1,4)==a_a.MAGIC then return _aa(a_a.decode(_ba))end;local aba=textutils.unserialize(_ba)if type(aba)~="table"then
error(
"Basalt image: "..caa.." is not a valid bimg file",2)end;return aba end
function b_a.saveFlimg(caa,daa,_ba)return a_a.save(caa,daa,_ba)end;ad.register("Image",aaa)b_a.Image=aaa;b_a.flimg=a_a;return b_a
]=]
sources["modules/responsive"] = [=[
local ab=...local bb=ab("core/element")local cb={}local db={}db.__index=db
local _c={"<=",">=","==","~=","<",">"}local function ac(ad)return ad:match("^%s*(.-)%s*$")end
local function bc(ad,bd)
local cd=tonumber(ad)if cd~=nil then return cd end
local dd,__a=ad:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")if dd~="self"and dd~="parent"then
error("Basalt responsive: unsupported operand '"..ad.."'",3)end;if
__a~="width"and __a~="height"then
error("Basalt responsive: only width and height can be read",3)end;local a_a=dd=="self"and bd or
rawget(bd,"parent")
return a_a and a_a[__a]or nil end
local function cc(ad,bd,cd)if ad==nil or cd==nil then return false end
if bd=="<"then return ad<cd end;if bd==">"then return ad>cd end;if bd=="<="then return ad<=cd end;if bd==">="then return ad>=
cd end;if bd=="=="then return ad==cd end;return ad~=cd end
local function dc(ad)if type(ad)=="function"then return ad end;if type(ad)~="string"or
ac(ad)==""then
error("Basalt responsive: condition must be a non-empty string or function",3)end;ad=ac(ad)
local bd,cd,dd;for i=1,#_c do local a_a=_c[i]local b_a=ad:find(a_a,1,true)
if b_a then
bd=ac(ad:sub(1,b_a-1))cd=a_a;dd=ac(ad:sub(b_a+#a_a))break end end;if not cd or
bd==""or dd==""then
error("Basalt responsive: expected '<operand> <operator> <operand>'",3)end
local function __a(a_a)if
tonumber(a_a)~=nil then return end
local b_a,c_a=a_a:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")if(b_a~="self"and b_a~="parent")or
(c_a~="width"and c_a~="height")then
error("Basalt responsive: unsupported operand '"..a_a.."'",4)end end;__a(bd)__a(dd)return
function(a_a)return cc(bc(bd,a_a),cd,bc(dd,a_a))end end
local function _d(ad,bd,cd,dd)if ad.minWidth and cd<ad.minWidth then return false end;if
ad.maxWidth and cd>ad.maxWidth then return false end;if ad.minHeight and dd<
ad.minHeight then return false end;if ad.maxHeight and dd>
ad.maxHeight then return false end;if ad.when and not
ad.when(bd,cd,dd)then return false end;return true end
function cb.apply(ad,bd,cd)if type(bd)~="table"then
error("Basalt responsive: rules must be a table",2)end;if not ad.getChildren then
error("Basalt responsive: target must be a container",2)end
local dd=rawget(ad,"_responsiveController")if dd then dd:destroy()end;local __a,a_a={},{}
for i=1,#bd do local c_a=bd[i]if
type(c_a)~="table"then
error("Basalt responsive: rule "..i.." must be a table",2)end;if c_a.when~=nil and type(c_a.when)~=
"function"then
error("Basalt responsive: rule.when must be a function",2)end;if c_a.props~=nil and
type(c_a.props)~="table"then
error("Basalt responsive: rule.props must be a table",2)end
if c_a.name then if type(c_a.name)~=
"string"or c_a.name==""then
error("Basalt responsive: rule.name must be a non-empty string",2)end;if a_a[c_a.name]then
error(
"Basalt responsive: duplicate state name '"..c_a.name.."'",2)end;a_a[c_a.name]=true end;local d_a="__responsive_"..i
ad:setStateStyle(d_a,c_a.props or{},-1000 +i)__a[i]={rule=c_a,internalState=d_a,active=false}end
local b_a={element=ad,rules=__a,exclusive=cd and cd.exclusive==true}
function b_a:refresh()local c_a=self.element;local d_a,_aa=c_a.width,c_a.height;local aaa=false
for i=1,#self.rules
do local baa=self.rules[i]local caa=(not self.exclusive or not aaa)and
_d(baa.rule,c_a,d_a,_aa)
if caa then aaa=true end;baa.active=caa;c_a:setState(baa.internalState,caa)
if
baa.rule.name then c_a:setState(baa.rule.name,caa)end end;return self end
function b_a:destroy()local c_a=self.element;if not c_a then return end;if self.handler then
c_a:off("layout",self.handler)end;for i=1,#self.rules do local d_a=self.rules[i]
c_a:setState(d_a.internalState,false)
if d_a.rule.name then c_a:setState(d_a.rule.name,false)end end;if
rawget(c_a,"_responsiveController")==self then
rawset(c_a,"_responsiveController",nil)end;self.element=nil end;b_a.handler=function()b_a:refresh()end
ad:on("layout",b_a.handler)rawset(ad,"_responsiveController",b_a)b_a:refresh()return
b_a end;function db:_sync()
cb.apply(self.element,self.rules,{exclusive=true})return self end
function db:when(ad)if self.finished then
error("Basalt responsive: otherwise() must be the final rule",2)end;if self.pending then
error("Basalt responsive: call apply() before the next when()",2)end
self.pending={when=dc(ad)}return self end
function db:apply(ad)if not self.pending then
error("Basalt responsive: apply() requires a preceding when()",2)end;if type(ad)~="table"then
error("Basalt responsive: apply() expects a property table",2)end;self.pending.props=ad;self.rules[
#self.rules+1]=self.pending
self.pending=nil;return self:_sync()end
function db:otherwise(ad)if self.pending then
error("Basalt responsive: call apply() before otherwise()",2)end;if self.finished then
error("Basalt responsive: otherwise() can only be used once",2)end;if type(ad)~="table"then
error("Basalt responsive: otherwise() expects a property table",2)end
self.rules[#self.rules+1]={props=ad}self.finished=true;self:_sync()return self.element end;function db:done()if self.pending then
error("Basalt responsive: call apply() before done()",2)end;self:_sync()
return self.element end
function cb.builder(ad)if not
ad.getChildren then
error("Basalt responsive: target must be a container",2)end;return
setmetatable({element=ad,rules={}},db)end
function cb.get(ad)return rawget(ad,"_responsiveController")end;function bb:setResponsive(ad)cb.apply(self,ad)return self end;function bb:responsive()return
cb.builder(self)end
function bb:clearResponsive()
local ad=rawget(self,"_responsiveController")if ad then ad:destroy()end;return self end;return cb
]=]
sources["modules/theme"] = [=[
local ca=...local da=ca("core/palette")local _b={}
local function ab(db,_c,ac,bc)if type(bc)~="table"then
error(
"Basalt theme: state '"..ac.."' for ".._c.." must be a table",3)end
for cc,dc in pairs(bc)do
local _d=db.__props[cc]if not _d then
error("Basalt theme: unknown property '"..
cc.."' for ".._c.." state "..ac,3)end;if not _d.styleable then
error(
"Basalt theme: property '"..cc.."' cannot be state-styled",3)end
if type(dc)=="string"and
dc:sub(1,1)=="{"then
error("Basalt theme: reactive strings are not allowed in set() "..
"state styles; use a function instead",3)end end end
_b.classes={Element=ca("core/element"),Container=ca("core/container"),BaseFrame=ca("core/baseframe"),Label=ca("elements/Label"),Button=ca("elements/Button"),Frame=ca("elements/Frame"),Input=ca("elements/Input"),Checkbox=ca("elements/Checkbox"),Switch=ca("elements/Switch"),ProgressBar=ca("elements/ProgressBar"),Slider=ca("elements/Slider"),Collection=ca("elements/Collection"),List=ca("elements/List"),Dropdown=ca("elements/Dropdown"),Flex=ca("elements/Flex"),Row=ca("elements/Row"),Column=ca("elements/Column"),TextBox=ca("elements/TextBox"),Menu=ca("elements/Menu"),TabControl=ca("elements/TabControl"),Tree=ca("elements/Tree"),Table=ca("elements/Table"),Program=ca("elements/Program"),ComboBox=ca("elements/ComboBox"),ContextMenu=ca("elements/ContextMenu"),Dialog=ca("elements/Dialog"),Toast=ca("elements/Toast")}
function _b.set(db)
for _c,ac in pairs(db)do local bc=_b.classes[_c]if not bc then
error("Basalt theme: unknown element type '".._c.."'",2)end
for cc,dc in pairs(ac)do
if cc=="states"then if type(dc)~="table"then
error(
"Basalt theme: states for ".._c.." must be a table",2)end;for _d,ad in pairs(dc)do ab(bc,_c,_d,ad)
bc.__stateStyles[_d]=ad end elseif bc.__props[cc]==nil then
error(
"Basalt theme: unknown property '"..cc.."' for ".._c,2)elseif type(dc)=="string"and dc:sub(1,1)=="{"then
error(
"Basalt theme: reactive strings are not allowed in ".."set() (defaults are shared); use a function instead",2)else bc.__defaults[cc]=dc end end end end
local bb={bg=da.rgb("#14161B"),surface=da.rgb("#22262E"),raised=da.rgb("#2E333D"),border=da.rgb("#3D434F"),text=da.rgb("#E8E6E1"),muted=da.rgb("#9AA0AB"),lava=da.rgb("#E8703A"),ember=da.rgb("#F49058"),selection=da.rgb("#3E5F82"),success=da.rgb("#8FBB56"),warning=da.rgb("#E5B95C"),danger=da.rgb("#D9534F"),info=da.rgb("#5E9BD6")}
_b.presets={basalt={colors=bb,styles={Element={foreground=bb.text},BaseFrame={background=bb.bg},Frame={background=bb.surface},Button={background=bb.raised,states={hover={background=bb.border}}},Input={background=bb.raised,foreground=bb.text,placeholderColor=bb.muted},Switch={onColor=bb.success,offColor=bb.border,knobColor=bb.text},ProgressBar={background=bb.border,barColor=bb.lava},Slider={barColor=bb.border,knobColor=bb.lava},List={background=bb.surface,selectionBackground=bb.lava,selectionForeground=bb.bg,emptyTextColor=bb.muted,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},Dropdown={background=bb.raised,dropBackground=bb.surface,selectionBackground=bb.lava,selectionForeground=bb.bg,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},ComboBox={background=bb.raised,foreground=bb.text,placeholderColor=bb.muted,dropBackground=bb.surface,dropForeground=bb.text,selectionBackground=bb.lava,selectionForeground=bb.bg,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},Menu={background=bb.surface,selectionBackground=bb.lava,selectionForeground=bb.bg,separatorColor=bb.muted,dropBackground=bb.raised},TabControl={background=bb.bg,headerBackground=bb.surface,activeBackground=bb.lava,activeForeground=bb.bg},Tree={background=bb.surface,selectionBackground=bb.lava,selectionForeground=bb.bg,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},Table={background=bb.surface,headerBackground=bb.raised,selectionBackground=bb.lava,selectionForeground=bb.bg,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},TextBox={background=bb.surface,selectionBackground=bb.selection,selectionForeground=bb.text,scrollbarColor=bb.raised,scrollbarThumbColor=bb.border},ContextMenu={background=bb.raised,selectionBackground=bb.lava,selectionForeground=bb.bg,separatorColor=bb.muted},Dialog={boxBackground=bb.surface,boxForeground=bb.text,titleBackground=bb.lava,titleForeground=bb.bg},Program={background=bb.bg}}}}
function _b.applyPreset(db)
local _c=type(db)=="table"and db or _b.presets[db]if not _c then
error("Basalt theme: unknown preset '"..tostring(db).."'",2)end;_b.set(_c.styles)
return _c.colors end
local function cb(db,_c)if type(db)~="string"then return db end
if db:sub(1,1)=="$"then
local ac=_c[db:sub(2)]if ac==nil then
error("Basalt theme: unknown color token '"..db.."'",0)end;return ac end;if db:sub(1,1)=="#"then return da.rgb(db)end;if
type(colors[db])=="number"then return colors[db]end;return db end
function _b.load(db)local _c=fs.open(db,"r")if not _c then
error("Basalt theme: cannot open "..tostring(db),2)end;local ac=_c.readAll()_c.close()
local bc
if db:match("%.json$")then
local cd=textutils.unserialiseJSON or textutils.unserializeJSON;bc=cd(ac)else bc=textutils.unserialize(ac)end;if type(bc)~="table"then
error("Basalt theme: "..db.." is not a valid theme file",2)end;local cc={}local dc=bc.colors or{}
for cd,dd in
pairs(dc)do if
not(type(dd)=="string"and dd:sub(1,1)=="$")then cc[cd]=cb(dd,cc)end end
for cd,dd in pairs(dc)do if type(dd)=="string"and dd:sub(1,1)=="$"then
cc[cd]=cb(dd,cc)end end;local _d={}
for cd,dd in pairs(bc.styles or{})do local __a={}
for a_a,b_a in pairs(dd)do
if a_a=="states"then local c_a={}for d_a,_aa in
pairs(b_a)do local aaa={}for baa,caa in pairs(_aa)do aaa[baa]=cb(caa,cc)end
c_a[d_a]=aaa end;__a.states=c_a else
__a[a_a]=cb(b_a,cc)end end;_d[cd]=__a end
local ad=bc.name or fs.getName(db):gsub("%.%w+$","")local bd={colors=cc,styles=_d}_b.presets[ad]=bd;return ad,bd end
function _b.apply(db,_c)local ac=_c[db.__name]
if ac then for bc,cc in pairs(ac)do
if bc=="states"then for dc,_d in pairs(cc)do
db:setStateStyle(dc,_d)end else db[bc]=cc end end end;if db.getChildren then local bc=db:getChildren()
for i=1,#bc do _b.apply(bc[i],_c)end end end;return _b
]=]
sources["modules/xml"] = [==[
local ba=...local ca=ba("core/palette")local da={}local function _b(cb)
return cb:match("^%s*(.-)%s*$")end
function da.parse(cb)local db={tag=nil,children={}}local _c={db}
local ac=1
while true do local bc=cb:find("<",ac,true)if not bc then break end
local cc=_b(cb:sub(ac,bc-1))if#cc>0 then local dc=_c[#_c]
dc.text=dc.text and(dc.text.." "..cc)or cc end
if cb:sub(bc+1,bc+3)=="!--"then local dc=cb:find("-->",
bc+4,true)if not dc then
error("Basalt XML: unclosed comment",2)end;ac=dc+3 elseif cb:sub(bc+1,bc+1)=="/"then
local dc=cb:find(">",bc,true)
if not dc then error("Basalt XML: malformed closing tag",2)end;local _d=_b(cb:sub(bc+2,dc-1))local ad=_c[#_c]if ad.tag~=_d then
error(
"Basalt XML: unexpected </".._d..">"..
(ad.tag and(", open tag is <"..ad.tag..">")or""),2)end;_c[#_c]=nil;ac=
dc+1 else local dc=cb:find(">",bc,true)if not dc then
error("Basalt XML: unclosed tag",2)end;local _d=cb:sub(bc+1,dc-1)
local ad=_d:sub(-1)=="/"if ad then _d=_d:sub(1,-2)end;local bd=_d:match("^([%w_]+)")if
not bd then
error("Basalt XML: malformed tag near pos "..bc,2)end;local cd={tag=bd,attrs={},children={}}for __a,a_a,b_a in
_d:gmatch([=[([%w_]+)%s*=%s*(["'])(.-)%2]=])do cd.attrs[__a]=b_a end
local dd=_c[#_c]dd.children[#dd.children+1]=cd;if not ad then
_c[#_c+1]=cd end;ac=dc+1 end end;if#_c~=1 then
error("Basalt XML: unclosed <".._c[#_c].tag..">",2)end;return db.children end
local function ab(cb)local db=tonumber(cb)if db then return db end;if cb=="true"then return true end;if cb==
"false"then return false end
if cb:sub(1,1)=="#"then return ca.rgb(cb)end;return cb end
local function bb(cb,db,_c)local ac={}
for bc,cc in ipairs(db)do local dc="add"..
cc.tag:sub(1,1):upper()..cc.tag:sub(2)local _d=cb[dc]if not _d then
error(
"Basalt XML: unknown element <"..cc.tag..">",2)end;local ad=_d(cb)
for bd,cd in pairs(cc.attrs)do
if
bd:find("^on%u")then local dd=_c and _c[cd]if type(dd)~="function"then
error("Basalt XML: scope has no handler '"..cd.."' for "..bd..
" on <"..cc.tag..">",2)end
ad[bd](ad,dd)else ad[bd]=ab(cd)end end;if cc.text and ad.text~=nil and cc.attrs.text==nil then
ad.text=cc.text end;if#cc.children>0 then
bb(ad,cc.children,_c)end;ac[#ac+1]=ad end;return ac end;function da.load(cb,db,_c)return bb(cb,da.parse(db),_c)end
function da.loadFile(cb,db,_c)
local ac=fs.open(db,"r")
if not ac then error("Basalt XML: cannot open "..db,2)end;local bc=ac.readAll()ac.close()return da.load(cb,bc,_c)end;return da
]==]
local loaded = {}
local function loader(name)
    local cached = loaded[name]
    if cached ~= nil then return cached end

    local source = sources[name]
        or error("Basalt: module not bundled: " .. tostring(name), 0)
    local chunk = assert(load(source, "@basalt/" .. name .. ".lua"))
    local result = chunk(loader, "basalt")
    loaded[name] = result == nil and true or result
    return loaded[name]
end
return loader("main")