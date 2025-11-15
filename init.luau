--[[
@baysights
@WebhookUtil.luau
NOV. 2025
A simple utility for sending messages and embeds to Discord webhooks.
--]]

local HttpService = game:GetService("HttpService")

--//
local WebhookUtil = {}
WebhookUtil.__index = WebhookUtil

local Embed = require(script.Embed)

function WebhookUtil:CreateEmbed()
	return Embed.new(self)
end

function WebhookUtil:Send(data, custom: boolean?): boolean
	if not custom then
		if typeof(data) == "string" then
			data = { content = data }
		elseif typeof(data) == "number" or typeof(data) == "boolean" then
			data = { content = tostring(data) }
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

function WebhookUtil.new(webhookUrls: any)
	local self = setmetatable({}, WebhookUtil)

	if typeof(webhookUrls) == "string" then
		self.WebhookUrls = { webhookUrls }
	elseif typeof(webhookUrls) == "table" then
		self.WebhookUrls = webhookUrls
	else
		self.WebhookUrls = {}
	end

	return self
end

return WebhookUtil
