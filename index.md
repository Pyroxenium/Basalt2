<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Basalt Documentation</title>
    <link rel="stylesheet" href="ldoc.css" type="text/css" />
</head>
<body>

<div id="container">

<div id="product">
	<div id="product_logo"></div>
	<div id="product_name"><big><b></b></big></div>
	<div id="product_description"></div>
</div> <!-- id="product" -->

<div id="main">


<!-- Menu -->



<div id="navigation">
<h1>Basalt 2</h1>
<p>A UI Framework for ComputerCraft</p>

<hr/>
<ul>
    <li><a href="#basalt:create">basalt:create&nbsp;(type, id)</a></li>
    <li><a href="#basalt:createFrame">basalt:createFrame&nbsp;()</a></li>
    <li><a href="#basalt:getElementManager">basalt:getElementManager&nbsp;()</a></li>
    <li><a href="#basalt:getMainFrame">basalt:getMainFrame&nbsp;()</a></li>
    <li><a href="#basalt:setActiveFrame">basalt:setActiveFrame&nbsp;(frame)</a></li>
    <li><a href="#basalt:scheduleUpdate">basalt:scheduleUpdate&nbsp;(func)</a></li>
    <li><a href="#basalt:removeSchedule">basalt:removeSchedule&nbsp;(id)</a></li>
    <li><a href="#basalt.updateEvent">basalt.updateEvent</a></li>
    <li><a href="#basalt.renderFrames">basalt.renderFrames</a></li>
    <li><a href="#basalt:update">basalt:update&nbsp;()</a></li>
    <li><a href="#basalt:stop">basalt:stop&nbsp;()</a></li>
    <li><a href="#basalt:run">basalt:run&nbsp;(isActive)</a></li>
</ul>

</div>

<div id="content">


<h1>Module <code>basalt</code></h1>

<p>Basalt UI Framework main module.</p>
<p> This is the main entry point for the Basalt UI Framework.
 It provides functions for creating and managing UI elements and handling events.</p>

<br/>
<br/>

    <dl class="function">
    <dt>
    <a name = "basalt:create"></a>
    <strong>basalt:create&nbsp;(type, id)</strong>
    </dt>
    <dd>
    Creates and returns a new UI element of the specified type




    <h3>Usage:</h3>
    <ul>
        <pre class="example">local button = basalt.create("Button")
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:createFrame"></a>
    <strong>basalt:createFrame&nbsp;()</strong>
    </dt>
    <dd>
    Creates and returns a new frame




    <h3>Usage:</h3>
    <ul>
        <pre class="example">local mainFrame = basalt.createFrame()
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:getElementManager"></a>
    <strong>basalt:getElementManager&nbsp;()</strong>
    </dt>
    <dd>
    Returns the element manager instance




    <h3>Usage:</h3>
    <ul>
        <pre class="example">local manager = basalt.getElementManager()
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:getMainFrame"></a>
    <strong>basalt:getMainFrame&nbsp;()</strong>
    </dt>
    <dd>
    Gets or creates the main frame




    <h3>Usage:</h3>
    <ul>
        <pre class="example">local frame = basalt.getMainFrame()
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:setActiveFrame"></a>
    <strong>basalt:setActiveFrame&nbsp;(frame)</strong>
    </dt>
    <dd>
    Sets the active frame




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.setActiveFrame(myFrame)
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:scheduleUpdate"></a>
    <strong>basalt:scheduleUpdate&nbsp;(func)</strong>
    </dt>
    <dd>
    Schedules a function to be updated




    <h3>Usage:</h3>
    <ul>
        <pre class="example">local id = basalt.scheduleUpdate(myFunction)
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:removeSchedule"></a>
    <strong>basalt:removeSchedule&nbsp;(id)</strong>
    </dt>
    <dd>
    Removes a scheduled update




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.removeSchedule(scheduleId)
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt.updateEvent"></a>
    <strong>basalt.updateEvent</strong>
    </dt>
    <dd>
    Internal event handler





</dd>
    <dt>
    <a name = "basalt.renderFrames"></a>
    <strong>basalt.renderFrames</strong>
    </dt>
    <dd>
    Internal render function





</dd>
    <dt>
    <a name = "basalt:update"></a>
    <strong>basalt:update&nbsp;()</strong>
    </dt>
    <dd>
    Updates all scheduled functions




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.update()
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:stop"></a>
    <strong>basalt:stop&nbsp;()</strong>
    </dt>
    <dd>
    Stops the Basalt runtime




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.stop()
</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:run"></a>
    <strong>basalt:run&nbsp;(isActive)</strong>
    </dt>
    <dd>
    Starts the Basalt runtime




    <h3>Usage:</h3>
    <ul>
        <li><pre class="example">basalt.run()
</pre></li>
        <li><pre class="example">basalt.run(false)
</pre></li>
    </ul>

</dd>
</dl>


</div> <!-- id="content" -->
</div> <!-- id="main" -->
<div id="about">
</div> <!-- id="about" -->
</div> <!-- id="container" -->
</body>
</html>
