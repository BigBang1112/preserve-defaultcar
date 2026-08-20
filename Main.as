bool hookInstalled = false;
bool callingOriginal = false;

void Main() {
    InstallHook();
}

void OnEnabled() {
    InstallHook();
}

void OnDisabled() {
    RemoveHook();
}

void OnDestroyed() {
    RemoveHook();
}

void InstallHook() {
    if (hookInstalled) return;
    Dev::InterceptProc("CGameManiaTitleControlScriptAPI", "EditMap5", InterceptEditMap5);
    hookInstalled = true;
}

void RemoveHook() {
    if (!hookInstalled) return;
    Dev::ResetInterceptProc("CGameManiaTitleControlScriptAPI", "EditMap5", InterceptEditMap5);
    hookInstalled = false;
}

bool InterceptEditMap5(CMwStack &in stack, CMwNod@ nod) {
    if (callingOriginal) return true;

    bool onlyForced = stack.CurrentBool(0);
    bool upgradeAdv = stack.CurrentBool(1);
    auto pluginArgs = stack.CurrentBufferWString(2);
    auto pluginScripts = stack.CurrentBufferWString(3);
    string playerModel = stack.CurrentWString(4);
    string modNameOrUrl = stack.CurrentWString(5);
    string decoration = stack.CurrentString(6);
    string map = stack.CurrentWString(7);
    auto titleApi = cast<CGameManiaTitleControlScriptAPI>(nod);

    if (playerModel == "CarSport") {
        playerModel = "";
    }

    callingOriginal = true;
    titleApi.EditMap5(map, decoration, modNameOrUrl, playerModel, pluginScripts, pluginArgs, upgradeAdv, onlyForced);
    callingOriginal = false;
    return false;
}