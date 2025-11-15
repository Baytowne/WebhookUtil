local Embed = {}
Embed.__index = Embed

type Embed = {
	embedData: {
		title: string?,
		description: string?,
		fields: {[number]: {name: string, value: string, inline: boolean?}},
		color: number?
	},
	WebhookUtil: any
}

function Embed:SetTitle(title: string): Embed
	assert(type(title) == "string", "Title must be a string")
	self.embedData.title = title
	return self
end

function Embed:SetDescription(description: string): Embed
	assert(type(description) == "string", "Description must be a string")
	self.embedData.description = description
	return self
end

function Embed:SetColor(color: number | string): Embed
	assert(type(color) == "number" or type(color) == "string", "Color must be a number or string")
	local colorValue = tonumber(color) or tonumber(color, 16)
	self.embedData.color = math.clamp(colorValue, 0, 0xFFFFFF)
	return self
end

function Embed:AddField(name: string, value: string, inline: boolean?): Embed
	assert(type(name) == "string", "Field name must be a string")
	assert(type(value) == "string", "Field value must be a string")
	assert(inline == nil or type(inline) == "boolean", "Inline must be a boolean or nil")
	table.insert(self.embedData.fields, {name = name, value = value, inline = inline})
	return self
end

function Embed:SetTimestamp(): Embed
	self.embedData.timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
	return self
end

function Embed:SetThumbnail(url: string): Embed
	assert(type(url) == "string", "Thumbnail URL must be a string")
	self.embedData.thumbnail = {url = url}
	return self
end

function Embed:SetAuthor(name: string, iconUrl: string?): Embed
	assert(type(name) == "string", "Author name must be a string")
	assert(iconUrl == nil or type(iconUrl) == "string", "Icon URL must be a string or nil")
	self.embedData.author = {name = name, icon_url = iconUrl}
	return self
end

function Embed:SetFooter(text: string, iconUrl: string?): Embed
	assert(type(text) == "string", "Footer text must be a string")
	assert(iconUrl == nil or type(iconUrl) == "string", "Icon URL must be a string or nil")
	self.embedData.footer = {text = text, icon_url = iconUrl}
	return self
end

function Embed:Send(): ()
	
	return self.WebhookUtil:Send({
		embeds = {self.embedData}
	}, true)
end

function Embed.new(webhookUtil: any): Embed
	local self = setmetatable({}, Embed)

	self.WebhookUtil = webhookUtil
	self.embedData = {
		title = nil :: string?,
		description = nil :: string?,
		fields = {} :: {[number]: {name: string, value: string, inline: boolean?}},
		color = nil :: number?
	}

	return self
end

return Embed
