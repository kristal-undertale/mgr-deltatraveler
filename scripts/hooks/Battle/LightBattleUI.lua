local LightBattleUI, super = HookSystem.hookScript(LightBattleUI)

function LightBattleUI:drawCustomGaugeLabels(arena_ox, arena_oy)
    if self.style ~= "deltatraveler" then
        return super.drawCustomGaugeLabels(self, arena_ox, arena_oy)
    end
    
    local font_main = Assets.getFont("main")
    love.graphics.setFont(font_main)
    if Game.battle.state_reason ~= "XACT" then
        love.graphics.print("HP", arena_ox + 412, arena_oy - 15, 0, 1, 0.75)
    end
    love.graphics.print("MERCY", arena_ox + 502, arena_oy - 15, 0, 1, 0.75)
end

function LightBattleUI:drawCustomEnemyGauge(enemy, y_offset, hp_percent, arena_ox, arena_oy)
    if self.style ~= "deltatraveler" then
        return super.drawCustomEnemyGauge(self, enemy, y_offset, hp_percent, arena_ox, arena_oy)
    end

    local font_status = Assets.getFont("battlehud")
    local hp_x = self.draw_mercy and 400 or 500
    if enemy.selectable and Game.battle.state_reason ~= "XACT" then
        if Game:isLight() then
            Draw.setColor(MG_PALETTE["action_health_bg"])
        else
            Draw.setColor(PALETTE["action_health_bg"])
        end
        love.graphics.rectangle("fill", arena_ox + hp_x + 12, arena_oy + 11 + y_offset, 75, 17)

        if Game:isLight() then
            Draw.setColor(MG_PALETTE["action_health"])
        else
            Draw.setColor(PALETTE["action_health"])
        end
        love.graphics.rectangle("fill", arena_ox + hp_x + 12, arena_oy + 11 + y_offset, math.max(0, math.ceil(hp_percent), math.floor(hp_percent * 75)), 17)

        if self.draw_percents then
            love.graphics.setFont(font_status)
            local shadow_offset = 1

            Draw.setColor(COLORS.black)
            Draw.printAlign(enemy:getHealthDisplay(), arena_ox + (hp_x + 52) + shadow_offset, arena_oy + (10 + y_offset) + shadow_offset, "center")

            if Game:isLight() then
                Draw.setColor(MG_PALETTE["action_health_text"])
            else
                Draw.setColor(PALETTE["action_health_text"])
            end
            Draw.printAlign(enemy:getHealthDisplay(), arena_ox + hp_x + 52, arena_oy + 10 + y_offset, "center")
        end
    end

    if self.draw_mercy then
        love.graphics.setFont(font_status)
        local shadow_offset = 1

        if enemy.selectable then
            if Game:isLight() then
                Draw.setColor(MG_PALETTE["battle_mercy_bg"])
            else
                Draw.setColor(PALETTE["battle_mercy_bg"])
            end
        else
            Draw.setColor(127 / 255, 127 / 255, 127 / 255, 1)
        end

        love.graphics.rectangle("fill", arena_ox + 502, arena_oy + 11 + y_offset, 75, 17)

        if enemy.disable_mercy then
            if Game:isLight() then
                Draw.setColor(MG_PALETTE["battle_mercy_text"])
            else
                Draw.setColor(PALETTE["battle_mercy_text"])
            end
            love.graphics.setLineWidth(2)
            love.graphics.line(arena_ox + 502, arena_oy + 12 + y_offset, arena_ox + 502 + 75, arena_oy + 12 + y_offset + 16 - 1)
            love.graphics.line(arena_ox + 502, arena_oy + 12 + y_offset + 16 - 1, arena_ox + 502 + 75, arena_oy + 12 + y_offset)
        else
            Draw.setColor(COLORS.yellow)
            love.graphics.rectangle("fill", arena_ox + 502, arena_oy + 11 + y_offset, ((enemy.mercy / 100) * 75), 17)

            if self.draw_percents and enemy.selectable then
                Draw.setColor(COLORS.black)
                Draw.printAlign(enemy:getMercyDisplay(), arena_ox + 541 + shadow_offset, arena_oy + (10 + y_offset) + shadow_offset, "center")

                if Game:isLight() then
                    Draw.setColor(MG_PALETTE["battle_mercy_text"])
                else
                    Draw.setColor(PALETTE["battle_mercy_text"])
                end
                Draw.printAlign(enemy:getMercyDisplay(), arena_ox + 541, arena_oy + 10 + y_offset, "center")
            end
        end
    end
end

return LightBattleUI
