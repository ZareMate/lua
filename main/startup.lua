--[[Local Variables]]--
local termWidth, termHeight = term.getSize()
local selectedItem = 1
local inMainMenu = true
local ActiveColor = 0
local inLightsMenu = false
local CableSite = "top"
os.pullEvent = os.pullEventRaw

--[[Menu Methods]]--
function Who()
  term.clear()
  term.setCursorPos(1,1)
  term.write("chuj")
  sleep(3)
end

function LightSystem()
  selectedItem = 1
  inLightsMenu=true
  while inLightsMenu do
    term.clear()
    term.setCursorPos(1,1)
    printMenu(lightsMenu)
    event,key=os.pullEvent("key")
    onKeyPressed(key,lightsMenu)
  end
end

function LightOn()
  lightSystem("on", colors.white)
end
function LightOff()
  lightSystem("off", colors.white)
end
function OrangeOn()
  lightSystem("on", colors.orange)
end
function OrangeOff()
  lightSystem("off", colors.orange)
end
function AlarmOn()
  lightSystem("on", colors.red)
end
function AlarmOff()
  lightSystem("off", colors.red)
end
function AllOff()
  lightSystem("off", 65535)
end
function LightsBack()
  inLightsMenu = false
  selectedItem = 1
end

function Snake()
  shell.run("worm")
end

function Edit()
  inMainMenu = false
  shell.run("edit "..shell.getRunningProgram())
  os.reboot()
end

function Console()
  term.clear()
  term.setCursorPos(1,1)
  inMainMenu = false
end

function Reboot()
  print("Rebooting...")
  sleep(1)
  os.reboot()
end

function Exit()
  os.shutdown()
end

--[[Menu Definitions]]--
mainMenu = {
  [1] = { text = "Who amI?",handler=Who },
  [2] = { text = "Light Controls",handler=LightSystem },
  [3] = { text = "Snake",handler=Snake },
  [4] = { text = "Edit program",handler=Edit },
  [5] = { text = "Console",handler=Console },
  [6] = { text = "Reboot",handler=Reboot },
  [7] = { text = "Exit",handler=Exit }
}
lightsMenu={
  [1]= { text="Lights On", handler=LightOn },
  [2]= { text="Lights Off", handler=LightOff },
  [3]= { text="Orange On", handler=OrangeOn },
  [4]= { text="Orange Off", handler=OrangeOff },
  [5]= { text="Alarm On", handler=AlarmOn },
  [6]= { text="Alarm Off", handler=AlarmOff },
  [7]= { text="All Off", handler=AllOff },
  [8]= { text="Back", handler=LightsBack }
}

--[[Printing Methods]]--
function printMenu(menu)
  for i=1,#menu do
    if i== selectedItem then
      print("[*]"..menu[i].text)
    else
      print("[ ]"..menu[i].text)
    end
  end
end

--[[Handler Method]]--
function onKeyPressed( key, menu )
  if key == keys.enter then
    onItemSelected( menu )
  elseif key == keys.up then
    if selectedItem > 1 then
      selectedItem = selectedItem - 1
    else
      selectedItem = #menu
    end
  elseif key == keys.down then
    if selectedItem < #menu then
	    selectedItem = selectedItem + 1
    else
      selectedItem = 1 
	  end
  end
end

function onItemSelected( menu )
  menu[selectedItem].handler(args)
end

--[[Light System]]--
function lightSystem( op, SetColors )
--[[Color Conversion]]--
  ConvertColors = SetColors
--[[Color Change]]--
  if op == "on" then
    ActiveColor = colors.combine(ActiveColor, ConvertColors)
    rs.setBundledOutput(CableSite ,ActiveColor)
  elseif op == "off" then
    ActiveColor = colors.subtract(ActiveColor, ConvertColors)
    rs.setBundledOutput(CableSite, ActiveColor)
  else error("Light system error you tried to: Turn " .. op .. " Color: " .. SetColors .. " when the state of color in memory is: " .. ActiveColor)
  end
  inLightsMenu = false
  selectedItem = 1
end

--[[Main function]]--
function main()
  while inMainMenu do
    term.clear()
    term.setCursorPos(1,1)
    printMenu(mainMenu)
    event,key = os.pullEvent("key")
    onKeyPressed(key,mainMenu)
  end
end

--[[Login system]]--
function login()
  term.clear()
  term.setCursorPos(1,1)
  print("Login:")
  local username = read()
  term.clear()
  term.setCursorPos(1,1)
  print("Password:")
  local password = read("*")
  if username == "ZareMate" and password == "nigga" then
    main()
  elseif username == "zaremate" and password == "nigga" then
    main()
  elseif username == "Querdus" and password == "kebab" then
    main()
  elseif username == "querdus" and password == "kebab" then
    main()
  else
    print("Wrong Password!")
    sleep(3)
    os.reboot()
  end
end

login()
