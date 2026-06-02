local LightGauge, super = HookSystem.hookScript(LightGauge)

function LightGauge:isSmoothGauge()
    return Kristal.getLibConfig("mgr-deltatraveler", "enemy_gauge_smoothness")
end

return LightGauge
