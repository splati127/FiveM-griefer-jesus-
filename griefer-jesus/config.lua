Config = {}

Config.PEDModel = "JesusChrist"
Config.Intervall = 900000  --the time intervall to check if jesus may spawn when being lucky in ms (900000ms = 15min)
Config.Chance = 15  --for example if you want the chance for jesus to appear in the chosen intervall to be 1:15 set this to 15, 1:30 -> 30
Config.NormalPED = "mp_g_m_pros_01"  --PED to become after being griefer jesus when esx = false (modify client l.115 to use your own system (qb-core folks ;) ))

Config.AlwaysAggressive = false  --when this is true jesus always instantly tries to kill the player, otherwise he has to get mad by the player

Config.UseESX = false  --set to true if using esx
Config.UseCommands = true  --set true if you want the commands for admins to trigger/be griefer jesus
Config.aggrMsgType = "scale"  --how to show that jesus is aggressive ("news" or "scale")


--Locales
Config.CommandSuccess = " got Griefer Jesus. Dont forget to pray."
Config.CommandNoAccess = "Youre not allowed to use this command."
Config.JesusText = "You became ~y~griefer Jesus~w~. ~p~Grief the griefers~w~, ~g~saint~w~!"
Config.NotJesusText = "You became ~r~Normal~w~"
Config.aggressiveMsg1 = "Attention"  --for scaleform message type large
Config.aggressiveMsg2 = "Griefer Jesus knows your sins. DIE!"  --for scaleform message type small
Config.aggressiveMsg3 = "BREAKING NEWS: SERIAL KILLER ON THE LOOSE"  --for news message type
