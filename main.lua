local discordia = require('discordia')
local json = require('json')
local client = discordia.Client()
local prefix = "!"

-- Set the game your bot is playing!

client:on('ready', function()
    client:setGame("Playing with @gutoso on GitHub!")
end)

client:on('messageCreate', function(message)
    if message.content:sub(1, 12) == prefix .. "addCurrency" then

        local addedCurrency = math.random(1, 20)

        local file = io.open('./currency.json', 'r')
        local parse = json.parse(file:read('*a'))
        local dataKey = message.author.id
        file:close()

        if parse[dataKey] then
            parse[dataKey] = parse[dataKey] + addedCurrency
        else
            parse[dataKey] = addedCurrency
        end

        message:reply("Currency added: " .. addedCurrency .. "\nTotalCurrency: " .. parse[dataKey])

        local file = io.open('./currency.json', 'w')
        file:write(json.stringify(parse))
        file:close()
    end
end)
 
local file = io.open('./token.txt')
local token = file:read('*a')
file:close()
 
client:run('Bot '.. token)