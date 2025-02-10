# Download

Basalt is available in two project versions: the source version, ideal for debugging errors and featuring annotations with a LLS for a proper code editor, and the packaged version, which is more compact.

:::tip
The domain link will change once the new version of basalt is fully released!
:::

## Downloading Basalt

To download the Basalt UI using a CC shell command, use the following:

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua
```

This method provides a convenient way to modify Basalt according to your specific needs by utilizing a UI.

## Download Basalt without UI

If you want to skip the UI and just download the essentials, here are some other commands:

- ### Source Default

This is the default source version of Basalt, containing essential files for a UI framework.

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua source default
```

- ### Source Full

This is the full source version of Basalt, containing all available files.

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua source full
```

- ### Bundle Default

This is the default bundle version of Basalt, containing essential files for a UI framework.

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua bundle default
```

- ### Bundle Full

This is the full bundle version of Basalt, containing all available files.

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua bundle full
```

## Update Basalt

The update command is used to ensure that your Basalt installation is up to date with the latest version available on GitHub. When you run this command, Basalt will perform the following actions:

- Basalt will first check the settings to determine the location of the Basalt installation (i.e., the file path).
- Next, Basalt will iterate through each file in the installation directory.
- For each file, Basalt will compare its version with the corresponding version on GitHub.
- If a file needs to be updated to match the latest version, Basalt will automatically perform the update.

::: info
This [config](https://github.com/Pyroxenium/basalt-docs/config.json) file is used to check if a update needs to be done.
:::

To execute the update command, use the following:

```
wget run https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/install.lua update
```