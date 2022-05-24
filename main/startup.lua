--[[Local Variables]]--
local termWidth, termHeight = term.getSize()
local selectedItem = 1
local inMainMenu = true
local inLightsMenu = false

--[[Menu Methods]]--
function Choice1()
  term.clear()
  term.setCursorPos(1,1)
  term.write("chuj")
  sleep(3)
end

function Choice2()
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
function LightsOn()
  redstone.setBundledOutput("top", colors.white)
  inLightsMenu = false
  selectedItem = 1
end
function AlarmOn()
  redstone.setBundledOutput("top", colors.orange)
  inLightsMenu = false
  selectedItem = 1
end
function Off()
  redstone.setBundledOutput("top", 0)
  inLightsMenu = false
  selectedItem = 1
end
function Reboot()
  print("Rebooting...")
  sleep(1)
  os.reboot()
end
function Exit()
  os.shutdown()
end
function Edit()
  inMainMenu = false
end

--[[Menu Definitions]]--
mainMenu = {
  [1] = { text = "Who amI?",handler=Choice1 },
  [2] = { text = "Light Controls",handler=Choice2 },
  [3] = { text = "Reboot",handler=Reboot },
  [4] = { text = "Exit",handler=Exit },
  [5] = { text = "Edit mode",handler=Edit }
}
lightsMenu={
  [1]= { text="Lights On", handler=LightsOn},
  [2]= { text="Alarm On", handler=AlarmOn},
  [3]= { text="All Off", handler=Off}
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
	  end
  elseif key == keys.down then
    if selectedItem < #menu then
	    selectedItem = selectedItem + 1 
	  end
  end
end

function onItemSelected( menu )
  menu[selectedItem].handler()
end

--[[Main Method]]--
function main()
  while inMainMenu do
    term.clear()
    term.setCursorPos(1,1)
    printMenu(mainMenu)
    event,key = os.pullEvent("key")
    onKeyPressed(key,mainMenu)
  end
end

--[[Login]]--
function login()
  os.pullEvent = os.pullEventRaw
  term.clear()
  term.setCursorPos(1,1)
  print("2137_OS_v1.4 Login Screen")
  write("Password: ")
  function pass()
  t = io.read()
  if t == "nigga" then
  print ("Access Granted.")
  sleep(2)
  term.clear()
  term.setCursorPos(1,1)
  else
  print ("Incorrect Login Details.")
  sleep(1)
  term.clear()
  term.setCursorPos(1,1)
  print("2137_OS_v1.3 Login Screen")
  write("Password: ")
  pass()
  end
  end
  pass()
end
login()
main()
