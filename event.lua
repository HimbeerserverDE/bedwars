bedwars.events = {3, 3, 3, 3, 6, 6, 6, 6}
bedwars.event_list = {"dia2", "mese2", "dia3", "mese3", "bed", "game_end"}
bedwars.event_msg = {
	"Diamond generators have been upgraded to Tier 2",
	"Mese generators have been upgraded to Tier 2",
	"Diamond generators have been upgraded to Tier 3",
	"Mese generators have been upgraded to Tier 3",
	"All beds have been destroyed",
	"Game has ended",
}
bedwars.next_event_msg = {
	"Diamond upgrade",
	"Mese upgrade",
	"Diamond maxed",
	"Mese maxed",
	"Bed destruction",
	"Game ends",
}
bedwars.event = 0

bedwars.event_timer_start = function()
	bedwars.timer = 0
	minetest.register_globalstep(function(dtime)
		bedwars.timer = bedwars.timer + dtime
		if bedwars.timer >= bedwars.events[bedwars.event + 1] then
			bedwars.event = bedwars.event + 1
			minetest.chat_send_all(bedwars.event_msg[bedwars.event])
			bedwars.timer = 0
		end
	end)
	bedwars.ui_update()
end
