local Embed = {}
Embed.__index = Embed


function Embed:SetTitle(title: string)
    self.embedData.title = title
    return self
end

function Embed:SetDescription(description: string)
    self.embedData.description = description
    return self
end

function Embed:SetColor(color: string)
    self.embedData.color = tonumber(color, 16)
    return self
end

function Embed:AddField(name: string, value: string, inline: boolean)
    table.insert(self.embedData.fields, {name = name, value = value, inline = inline})
    return self
end

function Embed:SetTimestamp()
    self.embedData.timestamp = DateTime.now():ToIsoDate()
    return self
end

function Embed:SetThumbnail(url: string)
    self.embedData.thumbnail = {url = url}
    return self
end

function Embed:SetFooter(text: string, iconUrl: string)
    self.embedData.footer = {text = text, icon_url = iconUrl}
    return self
end

function Embed:Send(): boolean
    return self.WebhookUtil:Send({
        embeds = {self.embedData}
    }, true)
end

function Embed.new(webhookUtil)
    local self = setmetatable({}, Embed)

    self.WebhookUtil = webhookUtil
    self.embedData = {
        title = nil,
        description = nil,
        fields = {},
        color = nil
    }

    return self
end

return Embed
