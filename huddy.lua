-- huddy.lua
-- Main entry point for Huddy

if SMODS and SMODS.current_mod then
    local mod = SMODS.current_mod
    mod.config = mod.config or {
        show_fool = true,
        show_mail = true,
        show_idol = true,
        show_ancient = true,
        show_obs = true,
        show_lucky = true,
        show_lucky_hits = true,
        show_seals = true,
        show_planets = true
    }
    
    local orig_prob = SMODS.pseudorandom_probability
    SMODS.pseudorandom_probability = function(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
        local result = orig_prob(trigger_obj, seed, base_numerator, base_denominator, identifier, no_mod)
        if G and G.GAME then
            if seed == 'lucky_mult' then
                G.GAME.huddy_lucky_triggers = (G.GAME.huddy_lucky_triggers or 0) + 1
                if result then
                    G.GAME.huddy_lucky_mult = (G.GAME.huddy_lucky_mult or 0) + 1
                end
            elseif seed == 'lucky_money' then
                if result then
                    G.GAME.huddy_lucky_money = (G.GAME.huddy_lucky_money or 0) + 1
                end
            end
        end
        return result
    end

    mod.config_tab = function()
        return {n=G.UIT.ROOT, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={align = "cl"}, nodes={
                create_toggle({label = 'Show Fool', ref_table = mod.config, ref_value = 'show_fool'}),
                create_toggle({label = 'Show Mail Rebate', ref_table = mod.config, ref_value = 'show_mail'}),
                create_toggle({label = 'Show The Idol', ref_table = mod.config, ref_value = 'show_idol'}),
                create_toggle({label = 'Show Ancient Joker', ref_table = mod.config, ref_value = 'show_ancient'}),
                create_toggle({label = 'Show Observatory', ref_table = mod.config, ref_value = 'show_obs'}),
                create_toggle({label = 'Show Lucky Cards', ref_table = mod.config, ref_value = 'show_lucky'}),
                create_toggle({label = 'Show Lucky Hits', ref_table = mod.config, ref_value = 'show_lucky_hits'}),
                create_toggle({label = 'Show Seals', ref_table = mod.config, ref_value = 'show_seals'}),
                create_toggle({label = 'Show Top Planets', ref_table = mod.config, ref_value = 'show_planets'})
            }}
        }}
    end
end
