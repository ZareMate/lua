--[[Local Variables]]
--
local termWidth, termHeight = term.getSize()
local selectedItem = 1
local inMainMenu = true
local inLightsMenu = false
local CableSite = "top"
local ActiveColor = rs.getBundledOutput(CableSite)
os.pullEvent = os.pullEventRaw

--[[Menu Methods]]
--
function Who()
  term.clear()
  term.setCursorPos(1, 1)
  term.write("chuj")
  sleep(3)
end

function LightSystem()
  selectedItem = 1
  inLightsMenu = true
  while inLightsMenu do
    term.clear()
    term.setCursorPos(1, 1)
    printMenu(lightsMenu)
    event, key = os.pullEvent("key")
    onKeyPressed(key, lightsMenu)
  end
end

function First()
  lightSystem(colors.white)
end

function SecondOn()
  lightSystem(colors.orange)
end

function Third()
  lightSystem(colors.magenta)
end

function Fourth()
  lightSystem(colors.yellow)
end

function Fifth()
  lightSystem(colors.lime)
end

function Sixth()
  lightSystem(colors.pink)
end

function Alarm()
  lightSystem(colors.red)
end

function All()
  lightSystem(65407)
end

function LightsBack()
  inLightsMenu = false
  selectedItem = 1
end

function Snake()
  shell.run("worm")
end

function Calculator()
  shell.run("calculator.lua")
end

function Edit()
  inMainMenu = false
  shell.run("edit " .. shell.getRunningProgram())
  os.reboot()
end

function Console()
  term.clear()
  term.setCursorPos(1, 1)
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

--[[Menu Definitions]]
--
mainMenu = {
  [1] = { text = "Who amI?", handler = Who },
  [2] = { text = "Light Controls", handler = LightSystem },
  [3] = { text = "Snake", handler = Snake },
  [4] = { text = "Calculator", handler = Calculator },
  [5] = { text = "Edit", handler = Edit },
  [6] = { text = "Console", handler = Console },
  [7] = { text = "Reboot", handler = Reboot },
  [8] = { text = "Exit", handler = Exit }
}
lightsMenu = {
  [1] = { text = "First", handler = First },
  [2] = { text = "Second", handler = SecondOn },
  [3] = { text = "Third", handler = Third },
  [4] = { text = "Fourth", handler = Fourth },
  [5] = { text = "Fifth", handler = Fifth },
  [6] = { text = "Sixth", handler = Sixth },
  [7] = { text = "Alarm", handler = Alarm },
  [8] = { text = "All (Off)", handler = All },
  [9] = { text = "Back", handler = LightsBack }
}

--[[Printing Methods]]
--
function printMenu(menu)
  for i = 1, #menu do
    if i == selectedItem then
      print("[*]" .. menu[i].text)
    else
      print("[ ]" .. menu[i].text)
    end
  end
end

--[[Handler Method]]
--
function onKeyPressed(key, menu)
  if key == keys.enter then
    onItemSelected(menu)
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

function onItemSelected(menu)
  menu[selectedItem].handler(args)
end

--[[Light System]]
--
function lightSystem(SetColors)
  if SetColors == 65407 then
    ActiveColor = 0
    rs.setBundledOutput(CableSite, 0)
  elseif colors.test(ActiveColor, SetColors) then
    ActiveColor = colors.subtract(ActiveColor, SetColors)
    rs.setBundledOutput(CableSite, ActiveColor)
  else
    ActiveColor = colors.combine(ActiveColor, SetColors)
    rs.setBundledOutput(CableSite, ActiveColor)
  end
  SaveColors = ActiveColor
  local file = io.open("lights", "w")
  file:write(SaveColors)
  file:close()
end

--[[Restore Light System]]
--
function RestoreLightSystem()
  local Restore = io.open("lights", "r")
  RestoredColors = tonumber(Restore:read())
  rs.setBundledOutput(CableSite, RestoredColors)
  ActiveColor = rs.getBundledOutput(CableSite)
  Restore:close()
end

--[[Main function]]
--
function main()
  while inMainMenu do
    term.clear()
    term.setCursorPos(1, 1)
    printMenu(mainMenu)
    event, key = os.pullEvent("key")
    onKeyPressed(key, mainMenu)
  end
end

--[[Login system]]
--
function login()
  term.clear()
  term.setCursorPos(1, 1)
  print("Login:")
  local username = read()
  term.clear()
  term.setCursorPos(1, 1)
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

RestoreLightSystem()
login()
