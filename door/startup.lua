--[[Local Variables]]--
local termWidth, termHeight = term.getSize()
local selectedItem = 1
local inMainMenu = true
local inLightsMenu = false

--[[Menu Methods]]--
function Choice1()
  term.clear()
  term.setCursorPos(1,1)
  term.write("Hello,my name is "..os.getComputerLabel())
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
function Open()
  rs.setOutput("left",true)
  inLightsMenu = false
  selectedItem = 1
  sleep(3)
  os.reboot()
end
function Close()
  rs.setOutput("left",false)
  inLightsMenu = false
  selectedItem = 1
  sleep(3)
  os.reboot()
end
function Exit()
  inMainMenu = false
end

--[[Menu Definitions]]--
mainMenu = {
  [1] = { text = "Door Control",handler=Choice2 },
  [2] = { text = "Exit",handler=Exit }
}
lightsMenu={
  [1]= { text="Open Door", handler=Open},
  [2]= { text="Close Door", handler=Close}
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
  print("2137_OS_v1.3 Login Screen")
  print("UserName: ZareMate")
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
  print("UserName: ZareMate")
  write("Password: ")
  pass()
  end
  end
  pass()
end
login()
main()