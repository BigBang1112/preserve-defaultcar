# Preserve Default Car

Preserve Default Car is an OpenPlanet plugin that removes the unreasonable feature of the map browser to reset the default car to the Stadium car.

This questionable change was introduced in the Summer 2024 update and hasn't been addressed to this day.

## How it works

It intercepts all `EditMap` requests and removes the `CarSport` value from the `PlayerModel` parameter.

This is occurring multiple times in the official `Scripts/Libs/Nadeo/Trackmania/MainMenu/Pages/MapEditorSettings.Script.txt` script in such format:

```php
if (State.LaunchParams.MapToEdit.Uid != "") {
  declare Text FileName = State.LaunchParams.MapToEdit.LocalFileName;
  if (FileName == "") FileName = State.LaunchParams.MapToEdit.DownloadUrl;
  TitleControl::EditMap(
    TitleControl,
    FileName,
    "",
    "",
    EnvironmentInfo::C_PlayerModel_CarSport, // ... CarSport value here
    EditorPluginScripts,
    EditorPluginSettings,
    State.LaunchParams.Difficulty != C_Difficulty_Simple,
    OnlyUseForcedPlugins
  );
}
```

This plugin basically turns this into:

```php
if (State.LaunchParams.MapToEdit.Uid != "") {
  declare Text FileName = State.LaunchParams.MapToEdit.LocalFileName;
  if (FileName == "") FileName = State.LaunchParams.MapToEdit.DownloadUrl;
  TitleControl::EditMap(
    TitleControl,
    FileName,
    "",
    "",
    "", // ... lets the default car enjoy their time
    EditorPluginScripts,
    EditorPluginSettings,
    State.LaunchParams.Difficulty != C_Difficulty_Simple,
    OnlyUseForcedPlugins
  );
}
```

## Why not keep it just for Editor++?

Editor++ is quite a big mapping package, while in different scenarios, you just want to validate the map you're given (with the correct car) and don't need any of the mapping tools.

Editor++ also automatically disables itself on each new update, which brings more confusion to the table.

## Special thanks

To XetroV, who originally found the solution.
