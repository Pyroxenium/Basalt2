# ldoc-markdown-parser

## Overview
`ldoc-markdown-parser` is a simple and extensible Lua documentation parser that converts Lua documentation comments into Markdown format. It supports both single-line and multi-line comments, making it easy to document your Lua code in a structured way.

## Features
- Extracts single-line and multi-line comments from Lua files.
- Parses custom tags such as `@property`, `@shortDescription`, `@param`, and `@return`.
- Converts extracted comments and parsed tags into Markdown format.
- Easy to extend and customize for additional tags or formatting options.

## Installation
To install the `ldoc-markdown-parser`, clone the repository and navigate to the project directory:

```bash
git clone <repository-url>
cd ldoc-markdown-parser
```

## Usage
To use the parser, run the `main.lua` file with the Lua interpreter, providing the path to the Lua file you want to parse:

```bash
lua src/main.lua path/to/your/lua_file.lua
```

The output will be generated in Markdown format and can be found in the specified output directory.

## Example
An example Lua file can be found in the `examples/input/example.lua`, and the expected output Markdown file is located in `examples/output/example.md`.

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.