Config = {}

Config.framework = "redemrp" --"redemrp" or "vorp"

Config.Prompts = {
    Prompt1 = 0x05CA7C52,
}

Config.Texts = {
    Prompt1 = "Register",
    HorseTaming = "Horse Taming",
    Tamed = "Horse was tamed successfully! Take it to the closes Stable to register!",
    AddName = "Add Name for Horse",
    NoJob = "You dont have the required job to register!",
}

Config.Textures = {
    cross = {"scoretimer_textures", "scoretimer_generic_cross"},
    locked = {"menu_textures","stamp_locked_rank"},
    tick = {"scoretimer_textures","scoretimer_generic_tick"},
    money = {"inventory_items", "money_moneystack"},
    alert = {"menu_textures", "menu_icon_alert"},
    horse = {"satchel_textures", "animal_horse"},
}

Config.RegisterJob = {"horsetrainer"} --for no job: Config.RegisterJob = false

Config.RegisterHorseStables = {
    { name = 'Register Wild Horse', sprite = -1103135225, x=-860.012, y=-1381.414, z=43.57}, --
    { name = 'Register Wild Horse', sprite = -1103135225, x=-5522.55, y=-3029.57, z=-2.215}, --
    { name = 'Register Wild Horse', sprite = -1103135225, x=-384.74,y= 783.82, z= 115.86}, --
    { name = 'Register Wild Horse', sprite = -1103135225, x=972.66, y=-1842.48, z=46.60}, --
}