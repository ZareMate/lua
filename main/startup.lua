--[[Local Variables]]--
local termWidth, termHeight = term.getSize()
local selectedItem = 1
local inMainMenu = true
local inLightsMenu = false
local color = "off"
local cableSite = "top"
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
  lightSystem("on", "white")
end
function LightOff()
  lightSystem("off", "white")
end
function AlarmOn()
  lightSystem("on", "red")
end
function AlarmOff()
  lightSystem("off", "red")
end
function AllOff()
  lightSystem("off", "both")
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
  [3]= { text="Alarm On", handler=AlarmOn },
  [4]= { text="Alarm Off", handler=AlarmOff },
  [5]= { text="All Off", handler=AllOff },
  [6]= { text="Back", handler=LightsBack }
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
--[[On functions]]--
  if op == "on" then
    if SetColors == "white" then
      if color == "off" then
        rs.setBundledOutput(cableSite, colors.white)
        color = "white"
      elseif color == "white" then
        rs.setBundledOutput(cableSite, colors.white)
        color = "white"
      elseif color == "red" then
        redstone.setBundledOutput(cableSite, colors.white + colors.red)
        color = "both"
      elseif color == "both" then
        redstone.setBundledOutput(cableSite, colors.white + colors.red)
        color = "both"
      end
    elseif SetColors == "red" then
      if color == "off" then
        rs.setBundledOutput(cableSite, colors.red)
        color = "red"
      elseif color == "red" then
        rs.setBundledOutput(cableSite, colors.red)
        color = "red"
      elseif color == "white" then
        redstone.setBundledOutput(cableSite, colors.white + colors.red)
        color = "both"
      elseif color == "both" then
        redstone.setBundledOutput(cableSite, colors.white + colors.red)
        color = "both"
      end
    end
  elseif op == "off" then
    if SetColors == "white" then
      if color == "white" then
        rs.setBundledOutput(cableSite, 0)
        color = "off"
      elseif color == "red" then
        redstone.setBundledOutput(cableSite, colors.red)
        color = "red"
      elseif color == "both" then
        redstone.setBundledOutput(cableSite, colors.red)
        color = "red"
      end
    elseif SetColors == "red" then
      if color == "red" then
        rs.setBundledOutput(cableSite, 0)
        color = "off"
      elseif color == "white" then
        redstone.setBundledOutput(cableSite, colors.white)
        color = "white"
      elseif color == "both" then
        redstone.setBundledOutput(cableSite, colors.white)
        color = "white"
      end
    elseif SetColors == "both" then
      rs.setBundledOutput(cableSite, 0)
      color = "off"
    end
  else error("Light system error you tried to: Turn " .. op .. " color " .. SetColors .. " when the state of color in memory is: " .. color)
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
