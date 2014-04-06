function love.conf(t)
    t.title = "Lova lova"        -- The title of the window the game is in (string)
    t.author = "Ophir LOJKINE"        -- The author of the game (string)
    t.url = "https://lovasoa.github.io/lovalova"                 -- The website of the game (string)
    t.identity = nil            -- The name of the save directory (string)
    -- t.version = "0.8.0"      -- Works with 0.8 and 0.9
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.screen.width = 800        -- The window width (number)
    t.screen.height = 600       -- The window height (number)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = false      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = false      -- Enable the sound module (boolean)
    t.modules.physics = false    -- Enable the physics module (boolean)
end
