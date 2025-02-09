<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<head>
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
<br/>
<h1>Basalt2</h1>



<h2>Contents</h2>
<ul>
<li><a href="#Class_Basalt">Class Basalt </a></li>
</ul>


<h2>Modules</h2>
<ul class="nowrap">
  <li><strong>basalt</strong></li>
</ul>

</div>

<div id="content">

<h1>Module <code>basalt</code></h1>
<p>Basalt UI Framework main module.</p>
<p> This is the main entry point for the Basalt UI Framework.
 It provides functions for creating and managing UI elements and handling events.</p>
    <h3>Usage:</h3>
    <ul>
        <pre class="example">local basalt = require(&quot;basalt&quot;)
local mainFrame = basalt.createFrame()
mainFrame:show()
basalt.run()
</pre>
    </ul>


<h2><a href="#Class_Basalt">Class Basalt </a></h2>
<table class="function_list">
	<tr>
	<td class="name" nowrap><a href="#basalt:create">basalt:create (type, id)</a></td>
	<td class="summary">Creates and returns a new UI element of the specified type</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:createFrame">basalt:createFrame ()</a></td>
	<td class="summary">Creates and returns a new frame</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:getElementManager">basalt:getElementManager ()</a></td>
	<td class="summary">Returns the element manager instance</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:getMainFrame">basalt:getMainFrame ()</a></td>
	<td class="summary">Gets or creates the main frame</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:setActiveFrame">basalt:setActiveFrame (frame)</a></td>
	<td class="summary">Sets the active frame</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:scheduleUpdate">basalt:scheduleUpdate (func)</a></td>
	<td class="summary">Schedules a function to be updated</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:removeSchedule">basalt:removeSchedule (id)</a></td>
	<td class="summary">Removes a scheduled update</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt.updateEvent">basalt.updateEvent (event, ...)</a></td>
	<td class="summary">Internal event handler</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt.renderFrames">basalt.renderFrames ()</a></td>
	<td class="summary">Internal render function</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:update">basalt:update ()</a></td>
	<td class="summary">Updates all scheduled functions</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:stop">basalt:stop ()</a></td>
	<td class="summary">Stops the Basalt runtime</td>
	</tr>
	<tr>
	<td class="name" nowrap><a href="#basalt:run">basalt:run (isActive)</a></td>
	<td class="summary">Starts the Basalt runtime</td>
	</tr>
</table>

<br/>
<br/>


    <h2 class="section-header has-description"><a name="Class_Basalt"></a>Class Basalt </h2>

          <div class="section-description">
          The main Basalt instance
 Contains all core functionality and management functions
          </div>
    <dl class="function">
    <dt>
    <a name = "basalt:create"></a>
    <strong>basalt:create (type, id)</strong>
    </dt>
    <dd>
    Creates and returns a new UI element of the specified type


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">type</span>
         string The type of element to create (e.g. "Button", "Label", "BaseFrame")
        </li>
        <li><span class="parameter">id</span>
        ? string Optional unique identifier for the element
        </li>
    </ul>

    <h3>Returns:</h3>
    <ol>

        table element The created element instance
    </ol>



    <h3>Usage:</h3>
    <ul>
        <pre class="example"><span class="keyword">local</span> button = basalt.<span class="function-name">create</span>(<span class="string">"Button"</span>)</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:createFrame"></a>
    <strong>basalt:createFrame ()</strong>
    </dt>
    <dd>
    Creates and returns a new frame



    <h3>Returns:</h3>
    <ol>

        table BaseFrame The created frame instance
    </ol>



    <h3>Usage:</h3>
    <ul>
        <pre class="example"><span class="keyword">local</span> mainFrame = basalt.<span class="function-name">createFrame</span>()</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:getElementManager"></a>
    <strong>basalt:getElementManager ()</strong>
    </dt>
    <dd>
    Returns the element manager instance



    <h3>Returns:</h3>
    <ol>

        table ElementManager The element manager
    </ol>



    <h3>Usage:</h3>
    <ul>
        <pre class="example"><span class="keyword">local</span> manager = basalt.<span class="function-name">getElementManager</span>()</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:getMainFrame"></a>
    <strong>basalt:getMainFrame ()</strong>
    </dt>
    <dd>
    Gets or creates the main frame



    <h3>Returns:</h3>
    <ol>

        BaseFrame table The main frame instance
    </ol>



    <h3>Usage:</h3>
    <ul>
        <pre class="example"><span class="keyword">local</span> frame = basalt.<span class="function-name">getMainFrame</span>()</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:setActiveFrame"></a>
    <strong>basalt:setActiveFrame (frame)</strong>
    </dt>
    <dd>
    Sets the active frame


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">frame</span>
         table The frame to set as active
        </li>
    </ul>




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.<span class="function-name">setActiveFrame</span>(myFrame)</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:scheduleUpdate"></a>
    <strong>basalt:scheduleUpdate (func)</strong>
    </dt>
    <dd>
    Schedules a function to be updated


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">func</span>
         function The function to schedule
        </li>
    </ul>

    <h3>Returns:</h3>
    <ol>

        number Id The schedule ID
    </ol>



    <h3>Usage:</h3>
    <ul>
        <pre class="example"><span class="keyword">local</span> id = basalt.<span class="function-name">scheduleUpdate</span>(myFunction)</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:removeSchedule"></a>
    <strong>basalt:removeSchedule (id)</strong>
    </dt>
    <dd>
    Removes a scheduled update


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">id</span>
         number The schedule ID to remove
        </li>
    </ul>




    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.<span class="function-name">removeSchedule</span>(scheduleId)</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt.updateEvent"></a>
    <strong>basalt.updateEvent (event, ...)</strong>
    </dt>
    <dd>
    Internal event handler


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">event</span>



        </li>
        <li><span class="parameter">...</span>



        </li>
    </ul>





</dd>
    <dt>
    <a name = "basalt.renderFrames"></a>
    <strong>basalt.renderFrames ()</strong>
    </dt>
    <dd>
    Internal render function







</dd>
    <dt>
    <a name = "basalt:update"></a>
    <strong>basalt:update ()</strong>
    </dt>
    <dd>
    Updates all scheduled functions






    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.<span class="function-name">update</span>()</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:stop"></a>
    <strong>basalt:stop ()</strong>
    </dt>
    <dd>
    Stops the Basalt runtime






    <h3>Usage:</h3>
    <ul>
        <pre class="example">basalt.<span class="function-name">stop</span>()</pre>
    </ul>

</dd>
    <dt>
    <a name = "basalt:run"></a>
    <strong>basalt:run (isActive)</strong>
    </dt>
    <dd>
    Starts the Basalt runtime


    <h3>Parameters:</h3>
    <ul>
        <li><span class="parameter">isActive</span>
         boolean Whether to start active (default: true)
        </li>
    </ul>




    <h3>Usage:</h3>
    <ul>
        <li><pre class="example">basalt.<span class="function-name">run</span>()</pre></li>
        <li><pre class="example">basalt.<span class="function-name">run</span>(<span class="keyword">false</span>)</pre></li>
    </ul>

</dd>
</dl>


</div> <!-- id="content" -->
</div> <!-- id="main" -->
<div id="about">
<i>generated by <a href="http://github.com/lunarmodules/LDoc">LDoc 1.5.0</a></i>
<i style="float:right;">Last updated 2025-02-09 18:10:07 </i>
</div> <!-- id="about" -->
</div> <!-- id="container" -->
</body>
</html>
