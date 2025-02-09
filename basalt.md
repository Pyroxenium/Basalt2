## The main Basalt instance
 Contains all core functionality and management functions

### basalt:create (type, id)

Creates and returns a new UI element of the specified type

### basalt:createFrame ()

Creates and returns a new frame

### basalt:getElementManager ()

Returns the element manager instance

### basalt:getMainFrame ()

Gets or creates the main frame

### basalt:setActiveFrame (frame)

Sets the active frame

### basalt:scheduleUpdate (func)

Schedules a function to be updated

### basalt:removeSchedule (id)

Removes a scheduled update

### basalt.updateEvent (event, ...)

Internal event handler

### basalt.renderFrames ()

Internal render function

### basalt:update ()

Updates all scheduled functions

### basalt:stop ()

Stops the Basalt runtime

### basalt:run (isActive)

Starts the Basalt runtime

