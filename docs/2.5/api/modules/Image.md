# Image

*extends Element*

Image module: registers the Image element (BIMG and FLIMG formats).

  local image = basalt.use("image")
  local img = frame:addImage({ x = 2, y = 2 })
  img.bimg = image.load("logo.bimg")
  img:play()          -- animate multi-frame images

A bimg is a list of frames; every frame is a list of {text, fgHex, bgHex}
blit triples. FLIMG stores RGB palette indices and either terminal cells or
unbaked 2x3 pixels. Both render through the retained Render buffer.

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| bimg | `boolean` | `false` | The bimg image table (list of blit-line frames) |
| currentFrame | `number` | `1` | 1-based frame index of multi-frame images |
| autoSize | `boolean` | `true` | Resize the element to the image size on assignment |
| width | `number` | `8` | Width in terminal cells |
| height | `number` | `4` | Height in terminal cells |

## Methods

### Image:getFrameCount()

Returns the number of frames in the current bimg.

- **returns** **count** (`integer`) 

### Image:nextFrame()

### Image:play(fps)

Plays multi-frame images through the scheduler. fps defaults to the
bimg's secondsPerFrame metadata (or 5 fps).

- **fps** (`number|nil`) Playback frames per second

- **returns** (`self`) 

### Image:stop()

Stops scheduled image playback.

- **returns** (`self`) 

### Image:measure()

Intrinsic size for basalt.auto().

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height

### Image:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

### image.load(path)

Loads a BIMG serialized table or FLIMG binary file.

- **path** (`string`) File path

- **returns** **bimg** (`table`) 

### image.saveFlimg(path, source, options)
