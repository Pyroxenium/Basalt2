return {
    entry = "main.lua",
    output = "../bundle/basalt.compressed.lua",

    minify = true,
    rename = true,
    compress = true,
    treeShake = true,
    chain = 128,

    -- Basalt loads optional modules from a computed name at runtime.
    keep = {
        "modules/**",
    },
}
