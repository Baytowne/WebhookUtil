local HttpService = game:GetService("HttpService")

--//
local WebhookUtil = {}
WebhookUtil.__index = WebhookUtil

function WebhookUtil:CreateEmbed()
    return require(script.Embed).new(self)
end

function WebhookUtil:Send(data, custom: boolean?)
    if not custom then
        if typeof(data) == "string" then
            data = {content = data}
        elseif typeof(data) == "number" or typeof(data) == "boolean" then
            data = {content = tostring(data)}
        end
    end
    for _, url in self.WebhookUrls do
        local succ, result = pcall(function()
            return HttpService:PostAsync(url, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
        end)

        if not succ then
            warn("Failed to send webhook: " .. result)
        end
    end

    return true
end

function WebhookUtil.new(webhookUrls: table)
    local self = setmetatable({}, WebhookUtil)
    self.WebhookUrls = typeof(webhookUrls) == "table" and webhookUrls or {}

    return self
end

return WebhookUtil